# Global Claude Code Preferences

## Document Reading Commands

When reading Office documents, use these extraction methods:

```bash
# DOCX - Extract text content
unzip -p file.docx word/document.xml | sed 's/<[^>]*>//g' | tr -s ' \n'

# PPTX - Extract slide text content
unzip -p file.pptx ppt/slides/slide*.xml | sed 's/<[^>]*>//g' | tr -s ' \n'

# PDF - Use Read tool directly (poppler installed)
```

## Language Preferences

- **Conversation**: Korean (한국어)
- **All artifacts**: English (unless specifically requested otherwise)
  - Code comments: English
  - Variable/function names: English
  - File names: English
  - Documentation: English
  - Commit messages: English
  - Error messages: English
