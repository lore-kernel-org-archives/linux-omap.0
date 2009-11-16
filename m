From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [alsa-devel] [PATCH] ASoC: OMAP: enable Overo driver for CM-T35
Date: Mon, 16 Nov 2009 14:00:19 +0000
Message-ID: <1258380019.3570.113.camel@odin>
References: <1258379603-29089-1-git-send-email-mike@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:19994 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752555AbZKPOAY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Nov 2009 09:00:24 -0500
Received: by fg-out-1718.google.com with SMTP id e12so2419067fga.1
        for <linux-omap@vger.kernel.org>; Mon, 16 Nov 2009 06:00:30 -0800 (PST)
In-Reply-To: <1258379603-29089-1-git-send-email-mike@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Rapoport <mike@compulab.co.il>
Cc: broonie@opensource.wolfsonmicro.com, linux-omap@vger.kernel.org, steve@sakoman.com, alsa-devel@alsa-project.org

On Mon, 2009-11-16 at 15:53 +0200, Mike Rapoport wrote:
> Signed-off-by: Mike Rapoport <mike@compulab.co.il>
> ---
>  sound/soc/omap/Kconfig |    7 ++++---
>  sound/soc/omap/overo.c |    2 +-
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
> index 653a362..bb42681 100644
> --- a/sound/soc/omap/Kconfig
> +++ b/sound/soc/omap/Kconfig
> @@ -43,12 +43,13 @@ config SND_OMAP_SOC_OSK5912
>  	  Say Y if you want to add support for SoC audio on osk5912.
>  
>  config SND_OMAP_SOC_OVERO
> -	tristate "SoC Audio support for Gumstix Overo"
> -	depends on TWL4030_CORE && SND_OMAP_SOC && MACH_OVERO
> +	tristate "SoC Audio support for Gumstix Overo and CompuLab CM-T35"
> +	depends on TWL4030_CORE && SND_OMAP_SOC && (MACH_OVERO || MACH_CM_T35)
>  	select SND_OMAP_SOC_MCBSP
>  	select SND_SOC_TWL4030
>  	help
> -	  Say Y if you want to add support for SoC audio on the Gumstix Overo.
> +	  Say Y if you want to add support for SoC audio on the
> +	  Gumstix Overo or CompuLab CM-T35
>  
>  config SND_OMAP_SOC_OMAP2EVM
>  	tristate "SoC Audio support for OMAP2EVM board"
> diff --git a/sound/soc/omap/overo.c b/sound/soc/omap/overo.c
> index 624f40e..1bf440b 100644
> --- a/sound/soc/omap/overo.c
> +++ b/sound/soc/omap/overo.c
> @@ -107,7 +107,7 @@ static int __init overo_soc_init(void)
>  {
>  	int ret;
>  
> -	if (!machine_is_overo()) {
> +	if (!(machine_is_overo() || machine_is_cm_t35())) {
>  		pr_debug("Not Overo!\n");

Its probably best to update the pr_debug message too.

Liam

