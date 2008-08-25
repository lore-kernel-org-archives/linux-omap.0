From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [RFC 0/2] McBSP and ASoC OMAP update patches for 2430 and 34xx
Date: Tue, 26 Aug 2008 01:40:06 +0300
Message-ID: <20080825224003.GH14939@frodo>
References: <1219319718-1750-1-git-send-email-jarkko.nikula@nokia.com> <5e088bd90808211451y2ebc4522mb511a9cda7dcdd68@mail.gmail.com> <20080822105757.1c2d0c5c.jarkko.nikula@nokia.com> <5e088bd90808251219t4e0f6562x5837afe727de126@mail.gmail.com> <20080825213510.GC14939@frodo> <5e088bd90808251450p25bca40bpf810f135ddf91a73@mail.gmail.com> <20080825215258.GF14939@frodo> <5e088bd90808251530n1fb59656p6e994f944add7109@mail.gmail.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:35384 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753531AbYHYWkf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Aug 2008 18:40:35 -0400
Content-Disposition: inline
In-Reply-To: <5e088bd90808251530n1fb59656p6e994f944add7109@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: me@felipebalbi.com, Jarkko Nikula <jarkko.nikula@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Aug 25, 2008 at 03:30:13PM -0700, Steve Sakoman wrote:
> > Hmm, so the crash is actually somewhere else. Could you disable debug
> > and get the NULL pointer dereference at the right point ?
> 
> The output is below.  The crash seems to occur at the substream
> pointer dereference in the second line of snd_pcm_info (in
> pcm_native.c):
> 
> 	struct snd_pcm *pcm = substream->pcm;

yeah, at that point substream was NULL. I'm trying to trace the function
call to see why substream is getting NULLed.

I think the following patch is anyway a good thing to apply:

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index c49b9d9..c7c15cf 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -92,10 +92,11 @@ static inline void snd_leave_user(mm_segment_t fs)
 int snd_pcm_info(struct snd_pcm_substream *substream, struct snd_pcm_info *info)
 {
        struct snd_pcm_runtime *runtime;
-       struct snd_pcm *pcm = substream->pcm;
+       struct snd_pcm *pcm;
        struct snd_pcm_str *pstr = substream->pstr;
 
        snd_assert(substream != NULL, return -ENXIO);
+       pcm = substream->pcm;
        memset(info, 0, sizeof(*info));
        info->card = pcm->card->number;
        info->device = pcm->device;

-- 
balbi
