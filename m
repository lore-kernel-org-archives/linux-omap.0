From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCHv2 0/2] McBSP: OMAP3: Add sidetone feature
Date: Thu, 18 Feb 2010 15:06:21 +0200
Message-ID: <20100218150621.b88387a7.jhnikula@gmail.com>
References: <1266417960-22787-1-git-send-email-ilkka.koskinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:62504 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751243Ab0BRNBI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Feb 2010 08:01:08 -0500
Received: by ewy19 with SMTP id 19so6806044ewy.21
        for <linux-omap@vger.kernel.org>; Thu, 18 Feb 2010 05:01:06 -0800 (PST)
In-Reply-To: <1266417960-22787-1-git-send-email-ilkka.koskinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ilkka Koskinen <ilkka.koskinen@nokia.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, peter.ujfalusi@nokia.com, broonie@opensource.wolfsonmicro.com, tony@atomide.com, eduardo.valentin@nokia.com, ext-eero.nurkkala@nokia.com

On Wed, 17 Feb 2010 16:45:58 +0200
Ilkka Koskinen <ilkka.koskinen@nokia.com> wrote:

> The first patch implements McBSP sidetone feature on OMAP3 while the second one
> provides ALSA interface for using it.
> 
Do I have something wrong since I cannot adjust the controls? Both
"McBSP2 Sidetone Channel [0|1]" show 50%.

I used line wrapped diff below.

-- 
Jarkko

diff --git a/sound/soc/omap/omap3beagle.c b/sound/soc/omap/omap3beagle.c
index d88ad5c..ac4f287 100644
--- a/sound/soc/omap/omap3beagle.c
+++ b/sound/soc/omap/omap3beagle.c
@@ -84,6 +84,11 @@ static int omap3beagle_hw_params(struct
snd_pcm_substream *substream, return 0;
 }
 
+static int omap3beagle_init(struct snd_soc_codec *codec)
+{
+	return omap_mcbsp_st_add_controls(codec, 2);
+}
+
 static struct snd_soc_ops omap3beagle_ops = {
 	.hw_params = omap3beagle_hw_params,
 };
@@ -95,6 +100,7 @@ static struct snd_soc_dai_link omap3beagle_dai = {
 	.cpu_dai = &omap_mcbsp_dai[0],
 	.codec_dai = &twl4030_dai[TWL4030_DAI_HIFI],
 	.ops = &omap3beagle_ops,
+	.init = omap3beagle_init,
 };
 
 /* Audio machine driver */
