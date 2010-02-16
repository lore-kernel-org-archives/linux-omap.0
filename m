From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 05/24] omap4: Add needed IRQ line into irqs.h
Date: Tue, 16 Feb 2010 15:08:32 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1002161506030.10478@utopia.booyaka.com>
References: <1266335895-32741-1-git-send-email-santosh.shilimkar@ti.com> <1266335895-32741-2-git-send-email-santosh.shilimkar@ti.com> <1266335895-32741-3-git-send-email-santosh.shilimkar@ti.com> <1266335895-32741-4-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-5-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:37397 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933434Ab0BPWId (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Feb 2010 17:08:33 -0500
In-Reply-To: <1266335895-32741-5-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, ben@fluff.org.uk, sameo@linux.intel.com, lrg@slimlogic.co.uk

Hello Santosh,

On Tue, 16 Feb 2010, Santosh Shilimkar wrote:

> This patch adds DSS, keyboard and ducati irq
> entries in irqs.h
> 
> Ones omap4 hwmod is pushed on mainlie, all the
> irqs lines data would be availabe.

Instead of this patch, why not just replace the current file with the one 
from the OMAP4 autogeneration scripts?  I don't see why the IRQ macros 
should depend on hwmod availability, and it would be better to have the 
correct IRQ data appear in one patch, rather than having to review and 
approve several smaller incremental patches over time.

The same reasoning should apply the DMA data also, I'd think.


- Paul

> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/plat-omap/include/plat/irqs.h |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/plat/irqs.h b/arch/arm/plat-omap/include/plat/irqs.h
> index e8205c1..e2fbd74 100644
> --- a/arch/arm/plat-omap/include/plat/irqs.h
> +++ b/arch/arm/plat-omap/include/plat/irqs.h
> @@ -385,6 +385,7 @@
>  #define INT_44XX_GPTIMER11	(47 + IRQ_GIC_START)
>  #define INT_44XX_GPTIMER12	(95 + IRQ_GIC_START)
>  #define INT_44XX_SHA1MD5	(51 + IRQ_GIC_START)
> +#define INT_44XX_DSS_DSI1	(53 + IRQ_GIC_START)
>  #define INT_44XX_I2C1_IRQ	(56 + IRQ_GIC_START)
>  #define INT_44XX_I2C2_IRQ	(57 + IRQ_GIC_START)
>  #define INT_44XX_HDQ_IRQ	(58 + IRQ_GIC_START)
> @@ -405,6 +406,7 @@
>  #define INT_44XX_MCBSP4_IRQ_TX	(81 + IRQ_GIC_START)
>  #define INT_44XX_MCBSP4_IRQ_RX	(82 + IRQ_GIC_START)
>  #define INT_44XX_MMC_IRQ	(83 + IRQ_GIC_START)
> +#define INT_44XX_DSS_DSI2	(84 + IRQ_GIC_START)
>  #define INT_44XX_MMC2_IRQ	(86 + IRQ_GIC_START)
>  #define INT_44XX_MCBSP2_IRQ_TX	(89 + IRQ_GIC_START)
>  #define INT_44XX_MCBSP2_IRQ_RX	(90 + IRQ_GIC_START)
> @@ -442,7 +444,10 @@
>  #define INT_44XX_PARTHASH_IRQ	(79 + IRQ_GIC_START)
>  #define INT_44XX_MMC3_IRQ	(94 + IRQ_GIC_START)
>  #define INT_44XX_MMC4_IRQ	(96 + IRQ_GIC_START)
> +#define INT_44XX_DUCATI_MMU_IRQ	(100 + IRQ_GIC_START)
>  #define INT_44XX_MCPDM_IRQ	(112 + IRQ_GIC_START)
> +#define INT_4XX_DSS_HDMI	(101 + IRQ_GIC_START)
> +#define INT_44XX_KBD_CTL	(120 + IRQ_GIC_START)
>  
>  /* Max. 128 level 2 IRQs (OMAP1610), 192 GPIOs (OMAP730/850) and
>   * 16 MPUIO lines */
> -- 
> 1.6.0.4
> 


- Paul
