From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH v2 13/13] OMAP: hwmod: Removal of macros for data that
 is obtained from hwmod database
Date: Tue, 1 Feb 2011 20:07:13 +0200
Message-ID: <20110201200713.34fdb4fc.jhnikula@gmail.com>
References: <1296485437-12806-1-git-send-email-kishon@ti.com>
	<1296485437-12806-14-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48105 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752235Ab1BASHS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Feb 2011 13:07:18 -0500
Received: by fxm20 with SMTP id 20so7084148fxm.19
        for <linux-omap@vger.kernel.org>; Tue, 01 Feb 2011 10:07:17 -0800 (PST)
In-Reply-To: <1296485437-12806-14-git-send-email-kishon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com, paul@pwsan.com, charu@ti.com, shubhrajyoti@ti.com, b-cousson@ti.com, khilman@deeprootsystems.com, p-basak2@ti.com

On Mon, 31 Jan 2011 20:20:37 +0530
Kishon Vijay Abraham I <kishon@ti.com> wrote:

> Information like base address and DMA channel nubers should no longer
> be obtained using macros. These information should be obtained from
> hwmod database. Hence the macros that define the base address are removed.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Charulatha V <charu@ti.com>
> ---
>  arch/arm/mach-omap1/mcbsp.c             |   64 +++++++++++++++---------------
>  arch/arm/plat-omap/include/plat/mcbsp.h |   50 +-----------------------
>  2 files changed, 33 insertions(+), 81 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/mcbsp.c b/arch/arm/mach-omap1/mcbsp.c
> index 2b89ebd..d90f649 100644
> --- a/arch/arm/mach-omap1/mcbsp.c
> +++ b/arch/arm/mach-omap1/mcbsp.c
> @@ -83,14 +83,14 @@ struct resource omap7xx_mcbsp_res[][6] = {
>  	{
>  		{
>  			.name  = "mpu",
> -			.start = OMAP7XX_MCBSP1_BASE,
> -			.end   = OMAP7XX_MCBSP1_BASE + SZ_256,
> +			.start = 0xfffb1000,
> +			.end   = 0xfffb10ff,

For these changes I don't see immediate reason as they reduce
readability. Is this better to do outside of this set together with a
patch that adds these into hwmod database etc?

> -#define AUDIO_MCBSP_DATAWRITE	(OMAP1510_MCBSP1_BASE + OMAP_MCBSP_REG_DXR1)
> -#define AUDIO_MCBSP_DATAREAD	(OMAP1510_MCBSP1_BASE + OMAP_MCBSP_REG_DRR1)
> -
> -#define AUDIO_MCBSP		OMAP_MCBSP1
> -#define AUDIO_DMA_TX		OMAP_DMA_MCBSP1_TX
> -#define AUDIO_DMA_RX		OMAP_DMA_MCBSP1_RX
> -
>  #else
>  
>  #define OMAP_MCBSP_REG_DRR2	0x00
> @@ -177,13 +136,6 @@ static struct platform_device omap_mcbsp##port_nr = {	\
>  #define OMAP_ST_REG_SFIRCR	0x28
>  #define OMAP_ST_REG_SSELCR	0x2C
>  
> -#define AUDIO_MCBSP_DATAWRITE	(OMAP24XX_MCBSP2_BASE + OMAP_MCBSP_REG_DXR1)
> -#define AUDIO_MCBSP_DATAREAD	(OMAP24XX_MCBSP2_BASE + OMAP_MCBSP_REG_DRR1)
> -
> -#define AUDIO_MCBSP		OMAP_MCBSP2
> -#define AUDIO_DMA_TX		OMAP24XX_DMA_MCBSP2_TX
> -#define AUDIO_DMA_RX		OMAP24XX_DMA_MCBSP2_RX
> -
These looks things that can be removed immediately and independently
from this set.

-- 
Jarkko
