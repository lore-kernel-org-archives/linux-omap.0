From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/5] ASoC: DMIC: Adding OMAP DMIC driver to build
Date: Tue, 28 Dec 2010 11:40:00 +0000
Message-ID: <20101228114000.GD31292@opensource.wolfsonmicro.com>
References: <1293509826-23253-1-git-send-email-dlambert@ti.com>
 <1293509826-23253-4-git-send-email-dlambert@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:37761 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753128Ab0L1Ljt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Dec 2010 06:39:49 -0500
Content-Disposition: inline
In-Reply-To: <1293509826-23253-4-git-send-email-dlambert@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Lambert <dlambert@ti.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>

On Mon, Dec 27, 2010 at 10:17:04PM -0600, David Lambert wrote:
> Adds the OMAP DMIC driver and codec to the build.
> 
> Signed-off-by: David Lambert <dlambert@ti.com>
> ---
>  sound/soc/codecs/Kconfig  |    3 +++
>  sound/soc/codecs/Makefile |    2 ++
>  sound/soc/omap/Kconfig    |    5 +++++
>  sound/soc/omap/Makefile   |    2 ++

This should be one of the last patches in the series, but given the sort
of drivers you're introducing I'd expect the drivers to just directly
add the build system stuff in the patch.

>  4 files changed, 12 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> index 0f33db2..f6c6d31 100644
> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -166,6 +166,9 @@ config SND_SOC_L3
>  config SND_SOC_DA7210
>          tristate
>  
> +config SND_SOC_DMIC
> +	tristate
> +
>  config SND_SOC_MAX98088
>         tristate
>  
> diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
> index 10e5e09..9139cf9 100644
> --- a/sound/soc/codecs/Makefile
> +++ b/sound/soc/codecs/Makefile
> @@ -14,6 +14,7 @@ snd-soc-cs42l51-objs := cs42l51.o
>  snd-soc-cs4270-objs := cs4270.o
>  snd-soc-cx20442-objs := cx20442.o
>  snd-soc-da7210-objs := da7210.o
> +snd-soc-dmic-objs := dmic.o
>  snd-soc-l3-objs := l3.o
>  snd-soc-max98088-objs := max98088.o
>  snd-soc-pcm3008-objs := pcm3008.o
> @@ -91,6 +92,7 @@ obj-$(CONFIG_SND_SOC_CS42L51)	+= snd-soc-cs42l51.o
>  obj-$(CONFIG_SND_SOC_CS4270)	+= snd-soc-cs4270.o
>  obj-$(CONFIG_SND_SOC_CX20442)	+= snd-soc-cx20442.o
>  obj-$(CONFIG_SND_SOC_DA7210)	+= snd-soc-da7210.o
> +obj-$(CONFIG_SND_SOC_DMIC)	+= snd-soc-dmic.o
>  obj-$(CONFIG_SND_SOC_L3)	+= snd-soc-l3.o
>  obj-$(CONFIG_SND_SOC_JZ4740_CODEC)	+= snd-soc-jz4740-codec.o
>  obj-$(CONFIG_SND_SOC_MAX98088)	+= snd-soc-max98088.o
> diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
> index a088db6..548b13c 100644
> --- a/sound/soc/omap/Kconfig
> +++ b/sound/soc/omap/Kconfig
> @@ -9,6 +9,9 @@ config SND_OMAP_SOC_MCBSP
>  config SND_OMAP_SOC_MCPDM
>  	tristate
>  
> +config SND_OMAP_SOC_DMIC
> +	tristate
> +
>  config SND_OMAP_SOC_N810
>  	tristate "SoC Audio support for Nokia N810"
>  	depends on SND_OMAP_SOC && MACH_NOKIA_N810 && I2C
> @@ -103,6 +106,8 @@ config SND_OMAP_SOC_SDP4430
>  	depends on TWL4030_CORE && SND_OMAP_SOC && MACH_OMAP_4430SDP
>  	select SND_OMAP_SOC_MCPDM
>  	select SND_SOC_TWL6040
> +	select SND_SOC_DMIC
> +	select SND_OMAP_SOC_DMIC
>  	help
>  	  Say Y if you want to add support for SoC audio on Texas Instruments
>  	  SDP4430.
> diff --git a/sound/soc/omap/Makefile b/sound/soc/omap/Makefile
> index ba9fc65..6ff27f5 100644
> --- a/sound/soc/omap/Makefile
> +++ b/sound/soc/omap/Makefile
> @@ -1,9 +1,11 @@
>  # OMAP Platform Support
>  snd-soc-omap-objs := omap-pcm.o
> +snd-soc-omap-dmic-objs := omap-dmic.o
>  snd-soc-omap-mcbsp-objs := omap-mcbsp.o
>  snd-soc-omap-mcpdm-objs := omap-mcpdm.o mcpdm.o
>  
>  obj-$(CONFIG_SND_OMAP_SOC) += snd-soc-omap.o
> +obj-$(CONFIG_SND_OMAP_SOC_DMIC) += snd-soc-omap-dmic.o
>  obj-$(CONFIG_SND_OMAP_SOC_MCBSP) += snd-soc-omap-mcbsp.o
>  obj-$(CONFIG_SND_OMAP_SOC_MCPDM) += snd-soc-omap-mcpdm.o
>  
> -- 
> 1.7.0.4
> 
