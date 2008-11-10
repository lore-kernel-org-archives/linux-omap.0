From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: ASOC and the Beagle
Date: Mon, 10 Nov 2008 12:38:32 -0800
Message-ID: <5e088bd90811101238l16057159ua0c3dbe88ebcb158@mail.gmail.com>
References: <49184EDF.9050600@balister.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rn-out-0910.google.com ([64.233.170.187]:9887 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754686AbYKJUsg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Nov 2008 15:48:36 -0500
Received: by rn-out-0910.google.com with SMTP id k40so1573687rnd.17
        for <linux-omap@vger.kernel.org>; Mon, 10 Nov 2008 12:48:35 -0800 (PST)
In-Reply-To: <49184EDF.9050600@balister.org>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Philip Balister <philip@balister.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

On Mon, Nov 10, 2008 at 7:10 AM, Philip Balister <philip@balister.org> wrote:
> A few weeks ago kernels built from git would detect the sound hardware and
> actually work.
>
> Yesterday I build a kernel and the sound hardware is no longer detected. Is
> there an easy way to fix this?
>
> Sorry I'm so vague, I don't have all the revision data handy ....

I just noticed this too.

It seems that the Kconfig for soc/omap got damaged in the merge.

The fix is simple, patch below.

Tony, this should trickle in from the alsa folks since they have
merged my ASoC drivers, but you might want to merge this patch locally
in the meantime.

Steve

diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index 8b7766b..0daeee4 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -14,6 +14,14 @@ config SND_OMAP_SOC_N810
 	help
 	  Say Y if you want to add support for SoC audio on Nokia N810.

+config SND_OMAP_SOC_OMAP3_BEAGLE
+	tristate "SoC Audio support for OMAP3 Beagle"
+	depends on SND_OMAP_SOC && MACH_OMAP3_BEAGLE
+	select SND_OMAP_SOC_MCBSP
+	select SND_SOC_TWL4030
+	help
+	  Say Y if you want to add support for SoC audio on the Beagleboard.
+
 config SND_OMAP_SOC_OSK5912
 	tristate "SoC Audio support for omap osk5912"
 	depends on SND_OMAP_SOC && MACH_OMAP_OSK
@@ -21,3 +29,13 @@ config SND_OMAP_SOC_OSK5912
 	select SND_SOC_TLV320AIC23
 	help
 	  Say Y if you want to add support for SoC audio on osk5912.
+
+config SND_OMAP_SOC_OVERO
+	tristate "SoC Audio support for Gumstix Overo"
+	depends on SND_OMAP_SOC && MACH_OVERO
+	select SND_OMAP_SOC_MCBSP
+	select SND_SOC_TWL4030
+	help
+	  Say Y if you want to add support for SoC audio on the Gumstix Overo.
+
+
