document.addEventListener('DOMContentLoaded', () => {
    const chatInput = document.getElementById('chat-input');
    const sendBtn = document.getElementById('send-btn');
    const welcomeScreen = document.getElementById('welcome-screen');
    const messagesArea = document.getElementById('messages-area');
    const chatContainer = document.getElementById('chat-container');
    const suggestionCards = document.querySelectorAll('.card');
    const newChatBtn = document.querySelector('.new-chat-btn');

    // Toggle send button active state
    chatInput.addEventListener('input', () => {
        if (chatInput.value.trim().length > 0) {
            sendBtn.classList.add('active');
        } else {
            sendBtn.classList.remove('active');
        }
    });

    // Handle send message
    const sendMessage = () => {
        const text = chatInput.value.trim();
        if (!text) return;

        // Hide welcome screen and show messages area
        if (welcomeScreen.style.display !== 'none') {
            welcomeScreen.style.display = 'none';
            messagesArea.style.display = 'block';
        }

        // Add user message
        appendMessage('user', text);
        chatInput.value = '';
        sendBtn.classList.remove('active');
        scrollToBottom();

        // Simulate AI thinking and responding
        simulateAIResponse(text);
    };

    // Press enter to send
    chatInput.addEventListener('keypress', (e) => {
        if (e.key === 'Enter') {
            sendMessage();
        }
    });

    sendBtn.addEventListener('click', sendMessage);

    // Suggestion cards click handler
    suggestionCards.forEach(card => {
        card.addEventListener('click', () => {
            const text = card.querySelector('p').textContent;
            chatInput.value = text;
            sendMessage();
        });
    });

    // Reset chat
    newChatBtn.addEventListener('click', () => {
        messagesArea.innerHTML = '';
        messagesArea.style.display = 'none';
        welcomeScreen.style.display = 'block';
        chatInput.value = '';
        sendBtn.classList.remove('active');
    });

    function appendMessage(role, content) {
        const messageDiv = document.createElement('div');
        messageDiv.className = `message ${role}`;

        const avatarHTML = role === 'user' 
            ? `<div class="message-avatar"><img src="https://api.dicebear.com/7.x/avataaars/svg?seed=Felix" alt="User"></div>`
            : `<div class="message-avatar"><i class="ph-fill ph-sparkle"></i></div>`;

        messageDiv.innerHTML = `
            ${avatarHTML}
            <div class="message-content">${content}</div>
        `;

        messagesArea.appendChild(messageDiv);
    }

    function simulateAIResponse(userText) {
        // Add typing indicator
        const typingDiv = document.createElement('div');
        typingDiv.className = 'message ai typing-message';
        typingDiv.innerHTML = `
            <div class="message-avatar"><i class="ph-fill ph-sparkle"></i></div>
            <div class="message-content">
                <div class="typing-indicator">
                    <div class="typing-dot"></div>
                    <div class="typing-dot"></div>
                    <div class="typing-dot"></div>
                </div>
            </div>
        `;
        messagesArea.appendChild(typingDiv);
        scrollToBottom();

        // Simulate network delay
        setTimeout(() => {
            // Remove typing indicator
            messagesArea.removeChild(typingDiv);

            // Simple demo responses based on input length or keywords
            let response = '';
            
            if (userText.toLowerCase().includes('olá') || userText.toLowerCase().includes('oi')) {
                response = 'Olá! Como posso ajudar você com seus projetos hoje?';
            } else if (userText.toLowerCase().includes('interface') || userText.toLowerCase().includes('html')) {
                response = 'Para criar uma interface web moderna, recomendo o uso de HTML5 semântico e CSS3 puro (Vanilla CSS) para ter máximo controle. Podemos utilizar variáveis CSS para temas (como o Dark Mode), Flexbox ou CSS Grid para layouts responsivos, e animações sutis para dar vida à interface. Gostaria que eu criasse um exemplo estrutural para você?';
            } else {
                response = 'Entendi! Como esta é uma demonstração de interface visual, eu não estou conectado a um modelo de linguagem real no momento. Mas essa seria a área onde minha resposta completa apareceria, formatada com boa tipografia e espaçamento para facilitar a leitura. <br><br>Você pode notar as animações suaves quando as mensagens aparecem e os efeitos de hover nos elementos da interface!';
            }

            appendMessage('ai', response);
            scrollToBottom();
        }, 1500); // 1.5s delay
    }

    function scrollToBottom() {
        chatContainer.scrollTo({
            top: chatContainer.scrollHeight,
            behavior: 'smooth'
        });
    }
});
