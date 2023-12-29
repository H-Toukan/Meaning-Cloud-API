#!/bin/bash

# Replace 'YOUR_API_KEY' with your actual MeaningCloud API key
API_KEY="YOUR_API_KEY"

echo "Choose the API:"
echo "1. Document Structure"
echo "2. Summarization"
echo "3. Language Identification"

read -p "Enter the number corresponding to the API you want to use: " CHOICE

case "$CHOICE" in
    1)
        API_NAME="documentstructure"
        ;;
    2)
        API_NAME="summarization"
        ;;
    3)
        API_NAME="lang-identification"
        ;;
    *)
        echo "Invalid choice. Exiting."
        exit 1
        ;;
esac

case "$API_NAME" in
    "documentstructure")
        read -p "Choose input type: (1) Text or (2) URL: " INPUT_TYPE
        if [ "$INPUT_TYPE" == "1" ]; then
            read -p "Enter the text: " USER_TEXT
            DATA_PARAM="--form \"txt=$USER_TEXT\""
        elif [ "$INPUT_TYPE" == "2" ]; then
            read -p "Enter the URL: " USER_TEXT
            DATA_PARAM="--form \"url=$USER_TEXT\""
        else
            echo "Invalid input type. Exiting."
            exit 1
        fi
        eval curl 'https://api.meaningcloud.com/documentstructure-1.0' \
            --form "key=$API_KEY" \
            $DATA_PARAM
        ;;
    "summarization")
        read -p "Choose input type: (1) Text or (2) URL: " INPUT_TYPE
        if [ "$INPUT_TYPE" == "1" ]; then
            read -p "Enter the text: " USER_TEXT
            DATA_PARAM="--form \"txt=$USER_TEXT\""
        elif [ "$INPUT_TYPE" == "2" ]; then
            read -p "Enter the URL: " USER_TEXT
            DATA_PARAM="--form \"url=$USER_TEXT\""
        else
            echo "Invalid input type. Exiting."
            exit 1
        fi
        read -p "Enter the number of sentences: " NUM_SENTENCES
        eval curl 'https://api.meaningcloud.com/summarization-1.0' \
            --form "key=$API_KEY" \
            $DATA_PARAM \
            --form "sentences=$NUM_SENTENCES"
        ;;
    "lang-identification")
        read -p "Enter the text: " USER_TEXT
        eval curl 'https://api.meaningcloud.com/lang-4.0/identification' \
            --form "key=$API_KEY" \
            --form "txt=$USER_TEXT"
        ;;
esac

