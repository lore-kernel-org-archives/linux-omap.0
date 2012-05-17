From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv2 18/19] ARM: OMAP4460: wakeupgen: set GIC_CPU0 backup status flag always
Date: Wed, 16 May 2012 17:33:25 -0700
Message-ID: <87sjez1wa2.fsf@ti.com>
References: <1336990730-26892-1-git-send-email-t-kristo@ti.com>
	<1336990730-26892-19-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:59049 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752139Ab2EQAd2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 May 2012 20:33:28 -0400
Received: by dajt11 with SMTP id t11so1510516daj.10
        for <linux-omap@vger.kernel.org>; Wed, 16 May 2012 17:33:26 -0700 (PDT)
In-Reply-To: <1336990730-26892-19-git-send-email-t-kristo@ti.com> (Tero
	Kristo's message of "Mon, 14 May 2012 13:18:49 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

Tero Kristo <t-kristo@ti.com> writes:

> Without this, CPU0 will crash in the ROM code during wakeup from
> device off. This patch also clears the GIC save area, to prevent
> ROM code from writing garbage to the GIC registers during wakeup.
> The actual GIC restore is done by kernel.
>
> This bug fix applies only to OMAP4460, it is fixed on OMAP4470.
>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

Please create/use PM_ERRATUM flag.

Kevin

> ---
>  arch/arm/mach-omap2/omap-wakeupgen.c   |   14 ++++++++++++++
>  arch/arm/mach-omap2/omap4-sar-layout.h |    1 +
>  2 files changed, 15 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap-wakeupgen.c b/arch/arm/mach-omap2/omap-wakeupgen.c
> index c7c4db4..30da299 100644
> --- a/arch/arm/mach-omap2/omap-wakeupgen.c
> +++ b/arch/arm/mach-omap2/omap-wakeupgen.c
> @@ -447,10 +447,24 @@ int __init omap_wakeupgen_init(void)
>  
>  	if (omap_type() == OMAP2_DEVICE_TYPE_GP) {
>  		sar_base = ioremap(OMAP44XX_SAR_RAM_BASE, SZ_16K);
> +		/* Clean GIC SAR area */
> +		for (i = SAR_BACKUP_STATUS_OFFSET; i < WAKEUPGENENB_OFFSET_CPU0;
> +			i += 4)
> +			sar_writel(0, i, 0);
> +
>  		sar_writel(GIC_ISR_NON_SECURE, ICDISR_CPU0_OFFSET, 0);
>  		sar_writel(GIC_ISR_NON_SECURE, ICDISR_CPU1_OFFSET, 0);
>  		for (i = 0; i < max_spi_reg; i++)
>  			sar_writel(GIC_ISR_NON_SECURE, ICDISR_SPI_OFFSET, i);
> +
> +		/*
> +		 * Set CPU0 GIC backup flag permanently for omap4460,
> +		 * this is needed because of the ROM code bug that breaks
> +		 * GIC during wakeup from device off
> +		 */
> +		if (cpu_is_omap446x())
> +			__raw_writel(SAR_BACKUP_STATUS_GIC_CPU0,
> +				     sar_base + SAR_BACKUP_STATUS_OFFSET);
>  		iounmap(sar_base);
>  		sar_base = NULL;
>  	} else {
> diff --git a/arch/arm/mach-omap2/omap4-sar-layout.h b/arch/arm/mach-omap2/omap4-sar-layout.h
> index 0056667..e621c51 100644
> --- a/arch/arm/mach-omap2/omap4-sar-layout.h
> +++ b/arch/arm/mach-omap2/omap4-sar-layout.h
> @@ -88,6 +88,7 @@
>  #define ICDISR_CPU0_OFFSET			(SAR_BANK3_OFFSET + 0x50c)
>  #define ICDISR_CPU1_OFFSET			(SAR_BANK3_OFFSET + 0x510)
>  #define ICDISR_SPI_OFFSET			(SAR_BANK3_OFFSET + 0x514)
> +#define SAR_BACKUP_STATUS_GIC_CPU0		0x1
>  
>  /* WakeUpGen save restore offset from OMAP44XX_SAR_RAM_BASE */
>  #define WAKEUPGENENB_OFFSET_CPU0		(SAR_BANK3_OFFSET + 0x684)
