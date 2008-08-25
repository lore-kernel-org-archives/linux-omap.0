From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [RFC 0/2] McBSP and ASoC OMAP update patches for 2430 and 34xx
Date: Tue, 26 Aug 2008 00:35:13 +0300
Message-ID: <20080825213510.GC14939@frodo>
References: <1219319718-1750-1-git-send-email-jarkko.nikula@nokia.com> <5e088bd90808211451y2ebc4522mb511a9cda7dcdd68@mail.gmail.com> <20080822105757.1c2d0c5c.jarkko.nikula@nokia.com> <5e088bd90808251219t4e0f6562x5837afe727de126@mail.gmail.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:52678 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752176AbYHYVfb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Aug 2008 17:35:31 -0400
Content-Disposition: inline
In-Reply-To: <5e088bd90808251219t4e0f6562x5837afe727de126@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Aug 25, 2008 at 12:19:16PM -0700, Steve Sakoman wrote:
> ALSA sound/core/pcm_native.c:2573: BUG? (substream != ((void *)0))

Hmmm... this looks odd.

Jarkko, shouldn't that snd_assert() in pcm_native.c check if substream
_is_ NULL instead of !is NULL ?

I mean:

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index c49b9d9..db86090 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -2570,7 +2570,7 @@ static int snd_pcm_playback_ioctl1(struct file *file,
                                   struct snd_pcm_substream *substream,
                                   unsigned int cmd, void __user *arg)
 {
-       snd_assert(substream != NULL, return -ENXIO);
+       snd_assert(substream == NULL, return -ENXIO);
        snd_assert(substream->stream == SNDRV_PCM_STREAM_PLAYBACK, return -EINVAL);
        switch (cmd) {
        case SNDRV_PCM_IOCTL_WRITEI_FRAMES:

If you follow up the function calls, we can see that substream is
initialized in pcm_native.c:snd_pcm_open_file():

2080         err = snd_pcm_open_substream(pcm, stream, file, &substream);
2081         if (err < 0)
2082                 return err;

and that initialized pointer is added to pcm_file in the same function
a few lines later:

2089         pcm_file->substream = substream;

Am I misreading something ? :-s

-- 
balbi
