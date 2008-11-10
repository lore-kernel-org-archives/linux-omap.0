From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: ASOC and the Beagle
Date: Mon, 10 Nov 2008 14:36:32 -0800
Message-ID: <5e088bd90811101436g38882b0bsacb931b4f6bbd5a8@mail.gmail.com>
References: <49184EDF.9050600@balister.org>
	 <5e088bd90811101238l16057159ua0c3dbe88ebcb158@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.30]:51001 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752540AbYKJWgf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Nov 2008 17:36:35 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1041399yxm.1
        for <linux-omap@vger.kernel.org>; Mon, 10 Nov 2008 14:36:34 -0800 (PST)
In-Reply-To: <5e088bd90811101238l16057159ua0c3dbe88ebcb158@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Philip Balister <philip@balister.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

On Mon, Nov 10, 2008 at 12:38 PM, Steve Sakoman <sakoman@gmail.com> wrote:
> On Mon, Nov 10, 2008 at 7:10 AM, Philip Balister <philip@balister.org> wrote:
>> A few weeks ago kernels built from git would detect the sound hardware and
>> actually work.
>>
>> Yesterday I build a kernel and the sound hardware is no longer detected. Is
>> there an easy way to fix this?
>>
>> Sorry I'm so vague, I don't have all the revision data handy ....
>
> I just noticed this too.
>
> It seems that the Kconfig for soc/omap got damaged in the merge.
>
> The fix is simple, patch below.

Next time I should build test before posting :-)

Turns out that the Makefile for soc/omap and the Kconfig and Makefile
for soc/codec also got screwed up in the merge, so those need to be
fixed.

The complete fix is:

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 38a0e3b..5df7402 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -10,6 +10,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_TLV320AIC23
 	select SND_SOC_TLV320AIC26
 	select SND_SOC_TLV320AIC3X
+	select SND_SOC_TWL4030
 	select SND_SOC_UDA1380
 	select SND_SOC_WM8510
 	select SND_SOC_WM8580
@@ -75,6 +76,10 @@ config SND_SOC_TLV320AIC3X
 	tristate
 	depends on I2C

+config SND_SOC_TWL4030
+	tristate
+	depends on TWL4030_CORE
+
 config SND_SOC_UDA1380
         tristate

diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 90f0a58..3b9b58a 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -7,6 +7,7 @@ snd-soc-ssm2602-objs := ssm2602.o
 snd-soc-tlv320aic23-objs := tlv320aic23.o
 snd-soc-tlv320aic26-objs := tlv320aic26.o
 snd-soc-tlv320aic3x-objs := tlv320aic3x.o
+snd-soc-twl4030-objs := twl4030.o
 snd-soc-uda1380-objs := uda1380.o
 snd-soc-wm8510-objs := wm8510.o
 snd-soc-wm8580-objs := wm8580.o
@@ -29,6 +30,7 @@ obj-$(CONFIG_SND_SOC_SSM2602)	+= snd-soc-ssm2602.o
 obj-$(CONFIG_SND_SOC_TLV320AIC23)	+= snd-soc-tlv320aic23.o
 obj-$(CONFIG_SND_SOC_TLV320AIC26)	+= snd-soc-tlv320aic26.o
 obj-$(CONFIG_SND_SOC_TLV320AIC3X)	+= snd-soc-tlv320aic3x.o
+obj-$(CONFIG_SND_SOC_TWL4030)	+= snd-soc-twl4030.o
 obj-$(CONFIG_SND_SOC_UDA1380)	+= snd-soc-uda1380.o
 obj-$(CONFIG_SND_SOC_WM8510)	+= snd-soc-wm8510.o
 obj-$(CONFIG_SND_SOC_WM8580)	+= snd-soc-wm8580.o
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
diff --git a/sound/soc/omap/Makefile b/sound/soc/omap/Makefile
index e09d1f2..4bae404 100644
--- a/sound/soc/omap/Makefile
+++ b/sound/soc/omap/Makefile
@@ -7,7 +7,12 @@ obj-$(CONFIG_SND_OMAP_SOC_MCBSP) += snd-soc-omap-mcbsp.o

 # OMAP Machine Support
 snd-soc-n810-objs := n810.o
+snd-soc-omap3beagle-objs := omap3beagle.o
 snd-soc-osk5912-objs := osk5912.o
+snd-soc-overo-objs := overo.o

 obj-$(CONFIG_SND_OMAP_SOC_N810) += snd-soc-n810.o
+obj-$(CONFIG_SND_OMAP_SOC_OMAP3_BEAGLE) += snd-soc-omap3beagle.o
 obj-$(CONFIG_SND_OMAP_SOC_OSK5912) += snd-soc-osk5912.o
+obj-$(CONFIG_SND_OMAP_SOC_OVERO) += snd-soc-overo.o
+
