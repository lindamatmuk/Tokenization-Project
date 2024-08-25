document.getElementById('upload-form').addEventListener('submit', function(event) {
    event.preventDefault();
    const fileInput = document.getElementById('fileInput');
    if (fileInput.files.length === 0) {
        alert("Please select a CSV file.");
        return;
    }

    const file = fileInput.files[0];
    const reader = new FileReader();
    reader.onload = function(event) {
        const csvData = event.target.result;
        const serialNumbers = parseCSV(csvData);
        mintTokens(serialNumbers);
    };
    reader.readAsText(file);
});

function parseCSV(data) {
    const serialNumbers = [];
    const rows = data.split('\n');
    for (const row of rows) {
        const columns = row.split(',');
        if (columns[0]) {
            serialNumbers.push(columns[0].trim());
        }
    }
    return serialNumbers;
}

function mintTokens(serialNumbers) {
    fetch('http://127.0.0.1:5000/mint', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ serialNumbers })
    })
    .then(response => response.json())
    .then(data => {
        const resultDiv = document.getElementById('result');
        if (data.status === 'success') {
            resultDiv.innerHTML = 'Tokens minted successfully!';
        } else {
            resultDiv.innerHTML = 'Error minting tokens.';
        }
    })
    .catch(error => {
        console.error('Error:', error);
        const resultDiv = document.getElementById('result');
        resultDiv.innerHTML = 'Error minting tokens.';
    });
}
