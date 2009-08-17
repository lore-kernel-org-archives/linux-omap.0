From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv4 02/20] OMAP: McBSP: Add IRQEN, IRQSTATUS, THRESHOLD2
	and THRESHOLD1 registers.
Date: Mon, 17 Aug 2009 16:53:02 +0300
Message-ID: <20090817135301.GV7278@atomide.com>
References: <1250509879-6703-1-git-send-email-eduardo.valentin@nokia.com> <1250509879-6703-3-git-send-email-eduardo.valentin@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:61950 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752363AbZHQNxG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Aug 2009 09:53:06 -0400
Content-Disposition: inline
In-Reply-To: <1250509879-6703-3-git-send-email-eduardo.valentin@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@nokia.com>
Cc: Takashi Iwai <tiwai@suse.de>, Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>, Jarkko Nikula <jhnikula@gmail.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>

* Eduardo Valentin <eduardo.valentin@nokia.com> [090817 15:06]:
> From: Eduardo Valentin <eduardo.valentin@nokia.com>

Needs a description.

Tony
 
> Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
> ---
>  arch/arm/plat-omap/include/mach/mcbsp.h |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/mach/mcbsp.h b/arch/arm/plat-omap/include/mach/mcbsp.h
> index b85e6e6..ceaf9ee 100644
> --- a/arch/arm/plat-omap/include/mach/mcbsp.h
> +++ b/arch/arm/plat-omap/include/mach/mcbsp.h
> @@ -134,6 +134,10 @@
>  #define OMAP_MCBSP_REG_XCERG	0x74
>  #define OMAP_MCBSP_REG_XCERH	0x78
>  #define OMAP_MCBSP_REG_SYSCON	0x8C
> +#define OMAP_MCBSP_REG_THRSH2	0x90
> +#define OMAP_MCBSP_REG_THRSH1	0x94
> +#define OMAP_MCBSP_REG_IRQST	0xA0
> +#define OMAP_MCBSP_REG_IRQEN	0xA4
>  #define OMAP_MCBSP_REG_XCCR	0xAC
>  #define OMAP_MCBSP_REG_RCCR	0xB0
>  
> -- 
> 1.6.2.GIT
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
