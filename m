From: Tony Lindgren <tony@atomide.com>
Subject: Re: [Linux-fbdev-devel] [PATCHv2 1/4] OMAP 2/3 DSS Library
Date: Fri, 24 Oct 2008 12:13:25 -0700
Message-ID: <20081024191325.GF16354@atomide.com>
References: <1224841964-24576-1-git-send-email-hardik.shah@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:50863 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751865AbYJXTN2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Oct 2008 15:13:28 -0400
Content-Disposition: inline
In-Reply-To: <1224841964-24576-1-git-send-email-hardik.shah@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hardik Shah <hardik.shah@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, video4linux-list@redhat.com

Hi,

* Hardik Shah <hardik.shah@ti.com> [081024 03:16]:
> Cleaned up the DSS Library according to open source comments
> 
> Removed unused #ifdefs
> Removed unused #defines
> Minor cleanups done
> Removed Architecture specific #ifdefs
> 
> Signed-off-by: Brijesh Jadav <brijesh.j@ti.com>
> 		Hari Nagalla <hnagalla@ti.com>
> 		Hardik Shah <hardik.shah@ti.com>
> 		Manjunath Hadli <mrh@ti.com>
> 		R Sivaraj <sivaraj@ti.com>
> 		Vaibhav Hiremath <hvaibhav@ti.com>
> 
> ---
>  arch/arm/plat-omap/Kconfig                 |    7 +
>  arch/arm/plat-omap/Makefile                |    2 +-
>  arch/arm/plat-omap/include/mach/io.h       |    2 +-
>  arch/arm/plat-omap/include/mach/omap-dss.h |  921 ++++++++++++
>  arch/arm/plat-omap/omap-dss.c              | 2248 ++++++++++++++++++++++++++++
>  5 files changed, 3178 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm/plat-omap/include/mach/omap-dss.h
>  create mode 100644 arch/arm/plat-omap/omap-dss.c
> 
> diff --git a/arch/arm/plat-omap/include/mach/io.h b/arch/arm/plat-omap/include/mach/io.h
> index ea55267..2495656 100644
> --- a/arch/arm/plat-omap/include/mach/io.h
> +++ b/arch/arm/plat-omap/include/mach/io.h
> @@ -142,11 +142,11 @@
>  #define OMAP343X_SDRC_VIRT	0xFD000000
>  #define OMAP343X_SDRC_SIZE	SZ_1M
> 
> -
>  #define IO_OFFSET		0x90000000
>  #define __IO_ADDRESS(pa)	((pa) + IO_OFFSET)/* Works for L3 and L4 */
>  #define __OMAP2_IO_ADDRESS(pa)	((pa) + IO_OFFSET)/* Works for L3 and L4 */
>  #define io_v2p(va)		((va) - IO_OFFSET)/* Works for L3 and L4 */
> +#define io_p2v(pa)		__IO_ADDRESS(pa)/* Works for L3 and L4 */
> 
>  /* DSP */
>  #define DSP_MEM_34XX_PHYS	OMAP34XX_DSP_MEM_BASE	/* 0x58000000 */

NAK for adding back io_p2v(). See below.


> diff --git a/arch/arm/plat-omap/include/mach/omap-dss.h b/arch/arm/plat-omap/include/mach/omap-dss.h
> new file mode 100644
> index 0000000..d9a33bd
> --- /dev/null
> +++ b/arch/arm/plat-omap/include/mach/omap-dss.h
> @@ -0,0 +1,921 @@
> +/*
> + * arch/arm/plat-omap/include/mach/omap-dss.h
> + *
> + * Copyright (C) 2004-2005 Texas Instruments.
> + * Copyright (C) 2006 Texas Instruments.
> + *
> + * This file is licensed under the terms of the GNU General Public License
> + * version 2. This program is licensed "as is" without any warranty of any
> + * kind, whether express or implied.
> +
> + * Leveraged from original Linux 2.6 framebuffer driver for OMAP24xx
> + * Author: Andy Lowe (source@mvista.com)
> + * Copyright (C) 2004 MontaVista Software, Inc.
> + *
> + */
> +
> +#ifndef	__ASM_ARCH_OMAP_DISP_H
> +#define	__ASM_ARCH_OMAP_DISP_H
> +
> +/* 16 bit uses LDRH/STRH, base +/- offset_8 */
> +typedef struct {
> +	volatile u16 offset[256];
> +} __regbase16;
> +#define __REGV16(vaddr)		(((__regbase16 *)((vaddr)&~0xff)) \
> +					->offset[((vaddr)&0xff)>>1])
> +#define __REG16(paddr)		 __REGV16(io_p2v(paddr))
> +
> +/* 8/32 bit uses LDR/STR, base +/- offset_12 */
> +typedef struct {
> +	volatile u8 offset[4096];
> +} __regbase8;
> +#define __REGV8(vaddr)		(((__regbase8  *)((vaddr)&~4095)) \
> +					->offset[((vaddr)&4095)>>0])
> +#define __REG8(paddr)		 __REGV8(io_p2v(paddr))
> +
> +typedef struct {
> +	volatile u32 offset[4096];
> +} __regbase32;
> +#define __REGV32(vaddr)		(((__regbase32 *)((vaddr)&~4095)) \
> +					->offset[((vaddr)&4095)>>2])
> +#define __REG32(paddr)		__REGV32(io_p2v(paddr))
> +

NAK for adding back the __REG stuff. We've just spent quite a bit of
effort to remove these. The __REG stuff is not portable.

Please use ioremap and then __raw_read/write instead.

Regards,

Tony
