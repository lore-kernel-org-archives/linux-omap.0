From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v4 1/4] TI816X: Update common omap platform files
Date: Fri, 21 Jan 2011 14:31:09 -0800
Message-ID: <87oc79evo2.fsf@ti.com>
References: <1294677465-18658-1-git-send-email-hemantp@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:34436 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752163Ab1AUWbN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 21 Jan 2011 17:31:13 -0500
Received: by mail-iy0-f178.google.com with SMTP id 42so2565130iyi.37
        for <linux-omap@vger.kernel.org>; Fri, 21 Jan 2011 14:31:13 -0800 (PST)
In-Reply-To: <1294677465-18658-1-git-send-email-hemantp@ti.com> (Hemant
	Pedanekar's message of "Mon, 10 Jan 2011 22:07:45 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hemant Pedanekar <hemantp@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com

Hi Hemant,

Hemant Pedanekar <hemantp@ti.com> writes:

> This patch updates the common platform files with TI816X support. Also adds new
> files for TI816X module base addresses and irq definitions.
>
> The approach taken in this patch is to add TI816X as part of OMAP3 variant where
> the cpu class is considered as OMAP34XX and the type is TI816X. This means, both
> cpu_is_omap34xx() and cpu_is_ti816x() checks return success on TI816X.
>
> In addition, a kernel config option CONFIG_SOC_OMAPTI816X is also added under
> OMAP3 to allow TI816X only build. This option leads to following main
> possibilities:
>
>  1) Multi-OMAP build with CONFIG_SOC_OMAPTI816X: The kernel built only for
>  TI816X OMAP3 SoCs along with any other OMAP2/4 (e.g., OMAP4s). May not boot
>  on other OMAP3 SoCs.
>
>  2) OMAP3 only build with CONFIG_SOC_OMAPTI816X: This will build TI816X
>  optimized kernel. May not boot on other OMAP3 SoCs.
>
>  3) OMAP3 only, no CONFIG_SOC_OMAPTI816X: This will build kernel for all OMAP3s
>  except TI816X. Note that cpu_is_ti816x checks will return fail.
>
> Note that OMAP3 only build with support for OMAP3 SoCs as well as TI816X is not
> possible.
>
> Signed-off-by: Hemant Pedanekar <hemantp@ti.com>

[...]

> diff --git a/arch/arm/plat-omap/include/plat/irqs-ti816x.h b/arch/arm/plat-omap/include/plat/irqs-ti816x.h
> new file mode 100644
> index 0000000..3ec5d1b
> --- /dev/null
> +++ b/arch/arm/plat-omap/include/plat/irqs-ti816x.h
> @@ -0,0 +1,131 @@
> +/*
> + * arch/arm/plat-omap/include/plat/irqs-ti816x.h
> + *
> + * ti816x family interrupts.
> + *
> + * Copyright (C) 2010 Texas Instruments, Inc. - http://www.ti.com/
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation version 2.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#ifndef __ARCH_ARM_MACH_OMAP2_TI816X_IRQS_H
> +#define __ARCH_ARM_MACH_OMAP2_TI816X_IRQS_H
> +
> +/*
> + * TI816X Interrupts
> + */
> +#define TI816X_IRQ_EMU		0
> +#define TI816X_IRQ_COMMTX	1
> +#define TI816X_IRQ_COMMRX	2
> +#define TI816X_IRQ_BENCH	3
> +#define TI816X_IRQ_ELM		4
> +#define TI816X_IRQ_SSM_WFI	5
> +#define TI816X_IRQ_SSM		6
> +#define TI816X_IRQ_NMI		7
> +#define TI816X_IRQ_SEC_EVNT	8
> +#define TI816X_IRQ_L3_DEBUG	9
> +#define TI816X_IRQ_L3_APP	10
> +#define TI816X_IRQ_EDMA_COMP	12
> +#define TI816X_IRQ_EDMA_MPERR	13
> +#define TI816X_IRQ_EDMA_ERR	14
> +#define TI816X_IRQ_SATA		16
> +#define TI816X_IRQ_USBSS	17
> +#define TI816X_IRQ_USB0		18
> +#define TI816X_IRQ_USB1		19
> +#define TI816X_IRQ_TPPSS_ERR	20
> +#define TI816X_IRQ_TPPSS_MBOX	21
> +#define TI816X_IRQ_TPPSS_STC0	22
> +#define TI816X_IRQ_TPPSS_STC1	23
> +#define TI816X_IRQ_TPPSS_DMAPC0	24
> +#define TI816X_IRQ_TPPSS_DMABS0	25
> +#define TI816X_IRQ_TPPSS_ERR0	26
> +#define TI816X_IRQ_TPPSS_ERR1	27
> +#define TI816X_IRQ_TPPSS_ERR2	28
> +#define TI816X_IRQ_TPPSS_ERR3	29
> +#define TI816X_IRQ_MCARD_TX	30
> +#define TI816X_IRQ_MCARD_RX	31
> +#define TI816X_IRQ_USB_WKUP	34
> +#define TI816X_IRQ_PCIE_WKUP	35
> +#define TI816X_IRQ_DSSINT	36
> +#define TI816X_IRQ_GFXINT	37
> +#define TI816X_IRQ_HDMIINT	38
> +#define TI816X_IRQ_VLYNQ	39
> +#define TI816X_IRQ_MACRXTHR0	40
> +#define TI816X_IRQ_MACRXINT0	41
> +#define TI816X_IRQ_MACTXINT0	42
> +#define TI816X_IRQ_MACMISC0	43
> +#define TI816X_IRQ_MACRXTHR1	44
> +#define TI816X_IRQ_MACRXINT1	45
> +#define TI816X_IRQ_MACTXINT1	46
> +#define TI816X_IRQ_MACMISC1	47
> +#define TI816X_IRQ_PCIINT0	48
> +#define TI816X_IRQ_PCIINT1	49
> +#define TI816X_IRQ_PCIINT2	50
> +#define TI816X_IRQ_PCIINT3	51
> +#define TI816X_IRQ_SD		64
> +#define TI816X_IRQ_SPI		65
> +#define TI816X_IRQ_GPT1		66
> +#define TI816X_IRQ_GPT2		67
> +#define TI816X_IRQ_GPT3		68
> +#define TI816X_IRQ_GPT4		69
> +#define TI816X_IRQ_I2C0		70
> +#define TI816X_IRQ_I2C1		71
> +#define TI816X_IRQ_UART0	72
> +#define TI816X_IRQ_UART1	73
> +#define TI816X_IRQ_UART2	74
> +#define TI816X_IRQ_RTC		75
> +#define TI816X_IRQ_RTC_ALARM	76
> +#define TI816X_IRQ_MBOX		77
> +#define TI816X_IRQ_MCASP0_TX	80
> +#define TI816X_IRQ_MCASP0_RX	81
> +#define TI816X_IRQ_MCASP1_TX	82
> +#define TI816X_IRQ_MCASP1_RX	83
> +#define TI816X_IRQ_MCASP2_TX	84
> +#define TI816X_IRQ_MCASP2_RX	85
> +#define TI816X_IRQ_MCBSP	86
> +#define TI816X_IRQ_SMCD0	87
> +#define TI816X_IRQ_SMCD1	88
> +#define TI816X_IRQ_WDT1		91
> +#define TI816X_IRQ_GPT5		92
> +#define TI816X_IRQ_GPT6		93
> +#define TI816X_IRQ_GPT7		94
> +#define TI816X_IRQ_GPT8		95
> +#define TI816X_IRQ_GPIO_0A	96
> +#define TI816X_IRQ_GPIO_0B	97
> +#define TI816X_IRQ_GPIO_1A	98
> +#define TI816X_IRQ_GPIO_1B	99
> +#define TI816X_IRQ_GPMC		100
> +#define TI816X_IRQ_DDR_ERR0	101
> +#define TI816X_IRQ_DDR_ERR1	102
> +#define TI816X_IRQ_IVA0CONT1SYNC	103
> +#define TI816X_IRQ_IVA0CONT2SYNC	104
> +#define TI816X_IRQ_IVA1CONT1SYNC	105
> +#define TI816X_IRQ_IVA1CONT2SYNC	106
> +#define TI816X_IRQ_IVA0MBOX	107
> +#define TI816X_IRQ_IVA1MBOX	108
> +#define TI816X_IRQ_IVA2MBOX	109
> +#define TI816X_IRQ_IVA2CONT1SYNC	110
> +#define TI816X_IRQ_IVA2CONT2SYNC	111
> +#define TI816X_IRQ_TPTC0	112
> +#define TI816X_IRQ_TPTC1	113
> +#define TI816X_IRQ_TPTC2	114
> +#define TI816X_IRQ_TPTC3	115
> +#define TI816X_IRQ_SECPUBINT	116
> +#define TI816X_IRQ_SECSECINT	117
> +#define TI816X_IRQ_SECPUBSWINT	118
> +#define TI816X_IRQ_SECSECSWINT	119
> +#define TI816X_IRQ_SMRFLX0	120
> +#define TI816X_IRQ_SMRFLX1	121
> +#define TI816X_IRQ_SYS_MMU	122
> +#define TI816X_IRQ_MC_MMU	123
> +#define TI816X_IRQ_DMM		124
> +
> +
> +#endif

For new platforms, We don't need to have a list of all the IRQ numbers.

Driver code should always be getting IRQ numbers (and base addresses
etc.) from struct resource/platform_data, which is populated from omap_hwmod.

> diff --git a/arch/arm/plat-omap/include/plat/irqs.h b/arch/arm/plat-omap/include/plat/irqs.h
> index 2910de9..21a5b87 100644
> --- a/arch/arm/plat-omap/include/plat/irqs.h
> +++ b/arch/arm/plat-omap/include/plat/irqs.h
> @@ -31,6 +31,9 @@
>  /* All OMAP4 specific defines are moved to irqs-44xx.h */
>  #include "irqs-44xx.h"
>  
> +/* All TI816X specific defines are in irqs-ti816x.h */
> +#include "irqs-ti816x.h"
> +
>  /*
>   * IRQ numbers for interrupt handler 1
>   *
> diff --git a/arch/arm/plat-omap/include/plat/serial.h b/arch/arm/plat-omap/include/plat/serial.h
> index cec5d56..3c3c319 100644
> --- a/arch/arm/plat-omap/include/plat/serial.h
> +++ b/arch/arm/plat-omap/include/plat/serial.h
> @@ -51,6 +51,11 @@
>  #define OMAP4_UART3_BASE	0x48020000
>  #define OMAP4_UART4_BASE	0x4806e000
>  
> +/* TI816X serial ports */
> +#define TI816X_UART1_BASE	0x48020000
> +#define TI816X_UART2_BASE	0x48022000
> +#define TI816X_UART3_BASE	0x48024000

>  /* External port on Zoom2/3 */
>  #define ZOOM_UART_BASE		0x10000000
>  #define ZOOM_UART_VIRT		0xfa400000
> diff --git a/arch/arm/plat-omap/include/plat/ti816x.h b/arch/arm/plat-omap/include/plat/ti816x.h
> new file mode 100644
> index 0000000..f1729f7
> --- /dev/null
> +++ b/arch/arm/plat-omap/include/plat/ti816x.h
> @@ -0,0 +1,31 @@
> +/*
> + * This file contains the address data for various ti816x modules.
> + *
> + * Copyright (C) 2010 Texas Instruments, Inc. - http://www.ti.com/
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation version 2.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#ifndef __ASM_ARCH_TI816X_H
> +#define __ASM_ARCH_TI816X_H
> +
> +#define L3_TI816X_BASE		0x44000000
> +#define L4_FAST_TI816X_BASE	0x4a000000
> +#define L4_SLOW_TI816X_BASE	0x48000000
> +
> +#define TI816X_SCM_BASE		0x48140000
> +#define TI816X_CTRL_BASE	TI816X_SCM_BASE
> +#define TI816X_PRCM_BASE	0x48180000
> +
> +#define TI816X_ARM_INTC_BASE	0x48200000
> +
> +#define TI816X_GPMC_BASE	0x50000000
> +
> +#endif /* __ASM_ARCH_TI816X_H */

All of these fall into the "not used in this patch" category.

It is best to add these defines in the patches where they are used so
reviewers can see the usage and/or the need.

With all of these defines, the subject for this patch should probably
just be about adding the SoC detection infrastructure.

Thanks,

Kevin
