const copyButton = document.querySelector('#copyCitation');
const citation = document.querySelector('#bibtex code').textContent;

document.querySelectorAll('video').forEach((video) => {
  video.addEventListener('playing', () => {
    video.parentElement.classList.add('is-playing');
  });
});

copyButton.addEventListener('click', async () => {
  try {
    await navigator.clipboard.writeText(citation);
    copyButton.textContent = 'Copied';
  } catch {
    copyButton.textContent = 'Failed';
  }

  window.setTimeout(() => {
    copyButton.textContent = 'Copy';
  }, 1600);
});
