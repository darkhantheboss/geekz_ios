

walk(document.body);

function walk(node) {
    // http://is.gd/mwZp7E
    var child, next;
    
    switch (node.nodeType) {
        case 1:  // Element
        case 9:  // Document
        case 11: // Document fragment
            child = node.firstChild;
            while (child) {
                next = child.nextSibling;
                walk(child);
                child = next;
            }
            break;
        case 3: // Text node
            handleText(node);
            break;
    }
}

function handleText(textNode)  {
    var v = textNode.nodeValue;
    
    v = v.replace(/\bThe Terrorism\b/g, "<profanity>");
    v = v.replace(/\bThe terrorism\b/g, "<profanity>");
    v = v.replace(/\bthe Terrorism\b/g, "<profanity>");
    v = v.replace(/\bthe terrorism\b/g, "<profanity>");
    v = v.replace(/\bterrorism\b/g, "<profanity>");
    v = v.replace(/\bTerrorism\b/g, "<profanity>");
    v = v.replace(/\bterrorism\b/g, "<profanity>");
    v = v.replace(/\bTerrorism\b/g, "<profanity>");
    
    v = v.replace(/\bSuicide\b/g, "<profanity>");
    v = v.replace(/\bsuicide\b/g,  "<profanity>");
    v = v.replace(/\bthe Suicide\b/g, "<profanity>");
    v = v.replace(/\bthe suicide\b/g, "<profanity>");
    v = v.replace(/\bsuicide\b/g, "<profanity>");
    v = v.replace(/\bSuicide\b/g, "<profanity>");
    v = v.replace(/\bsuicide\b/g, "<profanity>");
    v = v.replace(/\bSuicide\b/g, "<profanity>");
    
    textNode.nodeValue = v;
}
