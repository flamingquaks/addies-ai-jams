# Addie's AI Jams — Claude Instructions

This is a GitHub Pages music site that showcases AI-generated songs.
Live site: https://flamingquaks.github.io/addies-ai-jams

## Project Structure

```
addies-ai-jams/
├── index.html        # The website (dark music player UI)
├── songs.json        # Song data — THIS is what the site reads
├── audio/            # MP3 files live here
│   └── *.mp3
└── CLAUDE.md         # You are here
```

## songs.json Format

The site reads `songs.json` directly. Each song is an object in the `songs` array.
**Order in the array = order on the site.**

```json
{
  "songs": [
    {
      "title": "Song Name Here",
      "video": "audio/filename.mp4",
      "audio": "audio/filename.mp3",
      "lyrics": "https://docs.google.com/document/d/...",
      "original": "https://drive.google.com/file/d/..."
    }
  ]
}
```

- `title` — display name shown on the site
- `video` — path to mp4 in the `audio/` folder (e.g. `audio/my-song.mp4`). If set, the site renders a video player. Takes precedence over `audio`.
- `audio` — path to mp3 in the `audio/` folder (e.g. `audio/my-song.mp3`). Used when there is no video. Can be empty string `""`.
- `lyrics` — link to a Google Doc with the lyrics (can be empty string `""`)
- `original` — link to original recording on Google Drive or Dropbox (can be empty string `""`)

## How to Add a New Song

When Addie says "add a song" or "add [song name]":

1. Ask for the mp4/mp3 file if not already in `audio/` — Addie will drop it into `~/projects/addies-ai-jams/audio/`
2. Ask for the song title, lyrics link (optional), and original recording link (optional)
   - For Suno songs: use the `video` field for mp4 files, `audio` field for mp3-only songs
3. Add the song to the END of the `songs` array in `songs.json`
4. Commit and push:
   ```bash
   cd ~/projects/addies-ai-jams
   git add -A
   git commit -m "🎵 Add: [Song Title]"
   git push
   ```
5. The site updates automatically within ~60 seconds via GitHub Pages

## How to Reorder Songs

When Addie wants to change the order:
- Reorder the objects in the `songs` array in `songs.json`
- Commit and push

## How to Remove a Song

- Remove the song object from `songs.json`
- Optionally delete the mp3 from `audio/`
- Commit and push

## How to Edit a Song

- Update the relevant fields in `songs.json`
- Commit and push

## Naming Convention for Audio Files

Use lowercase, hyphen-separated names. No spaces.
- Good: `audio/my-first-song.mp3`
- Good: `audio/rainy-day-vibes.mp3`
- Bad: `audio/My First Song.mp3`

## Google Drive Links (for original recordings)

Addie stores original recordings in Google Drive. Share links look like:
`https://drive.google.com/file/d/FILE_ID/view?usp=sharing`

Use them as-is in the `original` field — the site shows them as a button that opens in a new tab.

## Lyrics Links

Addie writes lyrics in Google Docs. The doc must be shared as "Anyone with the link can view."
Use the standard Google Docs URL in the `lyrics` field.

## GitHub Pages

- Site deploys from `main` branch automatically
- After a `git push`, the site refreshes within ~60 seconds
- URL: https://flamingquaks.github.io/addies-ai-jams
