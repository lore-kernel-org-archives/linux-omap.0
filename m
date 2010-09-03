From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2 08/11] OMAP: DMA: Convert DMA library into DMA platform Driver
Date: Fri, 03 Sep 2010 15:34:19 -0700
Message-ID: <878w3iv4lw.fsf@deeprootsystems.com>
References: <1282647866-6918-1-git-send-email-manjugk@ti.com>
	<1282647866-6918-9-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:37917 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752362Ab0ICWeY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Sep 2010 18:34:24 -0400
Received: by gyd8 with SMTP id 8so1003219gyd.19
        for <linux-omap@vger.kernel.org>; Fri, 03 Sep 2010 15:34:23 -0700 (PDT)
In-Reply-To: <1282647866-6918-9-git-send-email-manjugk@ti.com> (Manjunatha
	GK's message of "Tue, 24 Aug 2010 16:34:23 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Manjunatha GK <manjugk@ti.com>
Cc: linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

Manjunatha GK <manjugk@ti.com> writes:

> This patch converts DMA library into DMA platform driver and make use
> of platform data provided by HWMOD data base for OMAP2PLUS onwards.
> For OMAP1 processors, the DMA driver in mach-omap uses resource structures
> for getting platform data.
>
> Also, it enables and uses run time PM API's
>
> Signed-off-by: Manjunatha GK <manjugk@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/mach-omap1/Makefile           |    2 +-
>  arch/arm/mach-omap1/include/mach/dma.h |   66 +++++++++
>  arch/arm/mach-omap2/Makefile           |    2 +-
>  arch/arm/mach-omap2/include/mach/dma.h |   83 +++++++++++
>  arch/arm/plat-omap/dma.c               |  244 +++++++++++++++++---------------
>  arch/arm/plat-omap/include/plat/dma.h  |  157 ++-------------------
>  6 files changed, 290 insertions(+), 264 deletions(-)
>
> diff --git a/arch/arm/mach-omap1/Makefile b/arch/arm/mach-omap1/Makefile
> index 9a304d8..b7dfc54 100644
> --- a/arch/arm/mach-omap1/Makefile
> +++ b/arch/arm/mach-omap1/Makefile
> @@ -3,7 +3,7 @@
>  #
>  
>  # Common support
> -obj-y := io.o id.o sram.o irq.o mux.o flash.o serial.o devices.o
> +obj-y := io.o id.o sram.o irq.o mux.o flash.o serial.o devices.o dma.o
>  obj-y += clock.o clock_data.o opp_data.o
>  
>  obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
> diff --git a/arch/arm/mach-omap1/include/mach/dma.h b/arch/arm/mach-omap1/include/mach/dma.h
> index d446cdd..1eb0d31 100644
> --- a/arch/arm/mach-omap1/include/mach/dma.h
> +++ b/arch/arm/mach-omap1/include/mach/dma.h
> @@ -77,4 +77,70 @@
>  #define OMAP1_DMA_CCR2(n)		(0x40 * (n) + 0x24)
>  #define OMAP1_DMA_LCH_CTRL(n)		(0x40 * (n) + 0x2a)
>  
> +/* Dummy defines to support multi omap code */

These should not be needed anymore as this is now an OMAP1-specific
header.

> +/* Channel specific registers */
> +#define OMAP_DMA4_CCR(n)		0
> +#define OMAP_DMA4_CSDP(n)		0
> +#define OMAP_DMA4_CEN(n)		0
> +#define OMAP_DMA4_CFN(n)		0
> +#define OMAP_DMA4_COLOR(n)		0
> +#define OMAP_DMA4_CSSA(n)		0
> +#define OMAP_DMA4_CSEI(n)		0
> +#define OMAP_DMA4_CSFI(n)		0
> +#define OMAP_DMA4_CDSA(n)		0
> +#define OMAP_DMA4_CDEI(n)		0
> +#define OMAP_DMA4_CDFI(n)		0
> +#define OMAP_DMA4_CSR(n)		0
> +#define OMAP_DMA4_CICR(n)		0
> +#define OMAP_DMA4_CLNK_CTRL(n)		0
> +#define OMAP_DMA4_CH_BASE(n)		0
> +#define OMAP_DMA4_CDAC(n)		0
> +#define OMAP_DMA4_CSAC(n)		0
> +
> +/* Common registers */
> +#define OMAP_DMA4_IRQENABLE_L0		0
> +#define OMAP_DMA4_OCP_SYSCONFIG		0
> +#define OMAP_DMA4_GCR			0
> +#define OMAP_DMA4_IRQSTATUS_L0		0
> +#define OMAP_DMA4_CAPS_2		0
> +#define OMAP_DMA4_CAPS_3		0
> +#define OMAP_DMA4_CAPS_4		0
> +#define OMAP_DMA4_REVISION		0
> +
> +#define OMAP_DMA4_CCR2(n)		0
> +#define OMAP_DMA4_LCH_CTRL(n)		0
> +#define OMAP_DMA4_COLOR_L(n)		0
> +#define OMAP_DMA4_COLOR_U(n)		0
> +#define OMAP1_DMA_COLOR(n)		0
> +#define OMAP_DMA4_CSSA_U(n)		0
> +#define OMAP_DMA4_CSSA_L(n)		0
> +#define OMAP1_DMA_CSSA(n)		0
> +#define OMAP_DMA4_CDSA_U(n)		0
> +#define OMAP_DMA4_CDSA_L(n)		0
> +#define OMAP1_DMA_CDSA(n)		0
> +#define OMAP_DMA4_CPC(n)		0
> +
> +#define OMAP1_DMA_IRQENABLE_L0		0
> +#define OMAP1_DMA_IRQENABLE_L0		0
> +#define OMAP1_DMA_IRQSTATUS_L0		0
> +#define OMAP1_DMA_OCP_SYSCONFIG		0
> +#define OMAP_DMA4_HW_ID			0
> +#define OMAP_DMA4_CAPS_0_U		0
> +#define OMAP_DMA4_CAPS_0_L		0
> +#define OMAP_DMA4_CAPS_1_U		0
> +#define OMAP_DMA4_CAPS_1_L		0
> +#define OMAP_DMA4_GSCR			0
> +#define OMAP1_DMA_REVISION		0
> +
> +struct omap_dma_lch {
> +	int next_lch;
> +	int dev_id;
> +	u16 saved_csr;
> +	u16 enabled_irqs;
> +	const char *dev_name;
> +	void (*callback)(int lch, u16 ch_status, void *data);
> +	void *data;
> +	long flags;
> +};
> +
>  #endif /* __ASM_ARCH_OMAP1_DMA_H */
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index 9b44773..6a8b231 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -3,7 +3,7 @@
>  #
>  
>  # Common support
> -obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer-gp.o pm.o
> +obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer-gp.o pm.o dma.o
>  
>  omap-2-3-common				= irq.o sdrc.o
>  hwmod-common				= omap_hwmod.o \
> diff --git a/arch/arm/mach-omap2/include/mach/dma.h b/arch/arm/mach-omap2/include/mach/dma.h
> index 3eca7d8..22f4b41 100644
> --- a/arch/arm/mach-omap2/include/mach/dma.h
> +++ b/arch/arm/mach-omap2/include/mach/dma.h
> @@ -77,4 +77,87 @@
>  #define OMAP_DMA4_CNDP(n)		(0x60 * (n) + 0xd4)
>  #define OMAP_DMA4_CCDN(n)		(0x60 * (n) + 0xd8)
>  
> +
> +/* Dummy defines for support multi omap code */

Why exactly are these here?

> +/* Common registers */
> +#define OMAP1_DMA_GCR				0
> +#define OMAP1_DMA_HW_ID				0
> +#define OMAP1_DMA_CAPS_0_U			0
> +#define OMAP1_DMA_CAPS_0_L			0
> +#define OMAP1_DMA_CAPS_1_U			0
> +#define OMAP1_DMA_CAPS_1_L			0
> +#define OMAP1_DMA_CAPS_2			0
> +#define OMAP1_DMA_CAPS_3			0
> +#define OMAP1_DMA_CAPS_4			0
> +#define OMAP1_DMA_GSCR				0
> +
> +/* Channel specific registers */
> +#define OMAP1_DMA_CH_BASE(n)			0
> +#define OMAP1_DMA_CCR(n)			0
> +#define OMAP1_DMA_CSDP(n)			0
> +#define OMAP1_DMA_CCR2(n)			0
> +#define OMAP1_DMA_CEN(n)			0
> +#define OMAP1_DMA_CFN(n)			0
> +#define OMAP1_DMA_LCH_CTRL(n)			0
> +#define OMAP1_DMA_COLOR_L(n)			0
> +#define OMAP1_DMA_COLOR_U(n)			0
> +#define OMAP1_DMA_CSSA_U(n)			0
> +#define OMAP1_DMA_CSSA_L(n)			0
> +#define OMAP1_DMA_CSEI(n)			0
> +#define OMAP1_DMA_CSFI(n)			0
> +#define OMAP1_DMA_CDSA_U(n)			0
> +#define OMAP1_DMA_CDSA_L(n)			0
> +#define OMAP1_DMA_CDEI(n)			0
> +#define OMAP1_DMA_CDFI(n)			0
> +#define OMAP1_DMA_CSR(n)			0
> +#define OMAP1_DMA_CICR(n)			0
> +#define OMAP1_DMA_CLNK_CTRL(n)			0
> +#define OMAP1_DMA_CPC(n)			0
> +#define OMAP1_DMA_CDAC(n)			0
> +#define OMAP1_DMA_CSAC(n)			0
> +#define OMAP1_DMA_CCEN(n)			0
> +#define OMAP1_DMA_CCFN(n)			0
> +
> +#define OMAP_DMA4_CCR2(n)			0
> +#define OMAP_DMA4_LCH_CTRL(n)			0
> +#define OMAP_DMA4_COLOR_L(n)			0
> +#define OMAP_DMA4_COLOR_U(n)			0
> +#define OMAP1_DMA_COLOR(n)			0
> +#define OMAP_DMA4_CSSA_U(n)			0
> +#define OMAP_DMA4_CSSA_L(n)			0
> +#define OMAP1_DMA_CSSA(n)			0
> +#define OMAP_DMA4_CDSA_U(n)			0
> +#define OMAP_DMA4_CDSA_L(n)			0
> +#define OMAP1_DMA_CDSA(n)			0
> +#define OMAP_DMA4_CPC(n)			0
> +
> +#define OMAP1_DMA_IRQENABLE_L0			0
> +#define OMAP1_DMA_IRQSTATUS_L0			0
> +#define OMAP1_DMA_OCP_SYSCONFIG			0
> +#define OMAP1_DMA_OCP_SYSCONFIG			0
> +#define OMAP_DMA4_HW_ID				0
> +#define OMAP_DMA4_CAPS_0_U			0
> +#define OMAP_DMA4_CAPS_0_L			0
> +#define OMAP_DMA4_CAPS_1_U			0
> +#define OMAP_DMA4_CAPS_1_L			0
> +#define OMAP_DMA4_GSCR				0
> +#define OMAP1_DMA_REVISION			0
> +
> +struct omap_dma_lch {
> +	int next_lch;
> +	int dev_id;
> +	u16 saved_csr;
> +	u16 enabled_irqs;
> +	const char *dev_name;
> +	void (*callback)(int lch, u16 ch_status, void *data);
> +	void *data;
> +	long flags;
> +	/* required for Dynamic chaining */
> +	int prev_linked_ch;
> +	int next_linked_ch;
> +	int state;
> +	int chain_id;
> +	int status;
> +};

Seems like this struct should stay common, as it's basically the same
across all OMAPs.  Only chaining fields are different, and they can just
be unused on OMAP1.

Also, this breaks multi-OMAP as this struct is used in plat-omap/dma.c
(OMAP1 and OMAP2+) but defined differently for OMAP1 and OMAP2+.

[...]

Kevin
