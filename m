From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v3 01/13] OMAP: DMA: Replace read/write macros with functions
Date: Tue, 09 Nov 2010 13:37:53 -0800
Message-ID: <87y692mb4e.fsf@deeprootsystems.com>
References: <1288099513-1854-1-git-send-email-manjugk@ti.com>
	<1288099513-1854-2-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:39499 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754847Ab0KIVh6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Nov 2010 16:37:58 -0500
Received: by gxk23 with SMTP id 23so4694177gxk.19
        for <linux-omap@vger.kernel.org>; Tue, 09 Nov 2010 13:37:56 -0800 (PST)
In-Reply-To: <1288099513-1854-2-git-send-email-manjugk@ti.com> (Manjunath
	Kondaiah G.'s message of "Tue, 26 Oct 2010 18:55:01 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

"G, Manjunath Kondaiah" <manjugk@ti.com> writes:

> The low level read/write macros are replaced with static inline functions
> and register offsets are handled through static register offset tables
> mapped through enumeration constants.
>
> The objective of this patch is to prepare for omap dma driver cleanup
> and dma hwmod implementation. The code optimization and moving machine
> specific code to respective mach-omapx dma file will be handled in the
> rest of this patch series.

[...]

> -#define dma_write(val, reg)						\
> -({									\
> -	if (cpu_class_is_omap1())					\
> -		__raw_writew((u16)(val), omap_dma_base + OMAP1_DMA_##reg); \
> -	else								\
> -		__raw_writel((val), omap_dma_base + OMAP_DMA4_##reg);	\
> -})
> +static inline void dma_write(u32 val, int reg, int lch)
> +{
> +	if (cpu_class_is_omap1()) {

Reminder: any use of cpu_is_* checks outside of init code will be NAK'd.

cpu_is_* check do not belong at runtime, especially in a crucial path
like this.  

> +		if (reg > OMAP1_CH_COMMON_START)
> +			__raw_writew(val, dma_base +
> +				(reg_map_omap1[reg] + 0x40 * lch));
> +		else
> +			__raw_writew(val, dma_base + reg_map_omap1[reg]);
> +	} else {
> +		if (reg > OMAP2_CH_COMMON_START)
> +			__raw_writel(val, dma_base +
> +				(reg_map_omap2[reg] + 0x60 * lch));
> +		else
> +			__raw_writel(val, dma_base + reg_map_omap2[reg]);
> +	}
> +}

The register base offset, register array and the stride (offset between
instances: 0x40 or 0x60) are detectable at init time, and there's no
reason to have conditional code for them.  IOW, they should be init time
constants.  Doing so would greatly simply these functions.  In fact the
CH_COMMON_START could also be an init time constant as well.  So, given
the following init_time constants: dma_ch_common_start, dma_stride,
reg_map, the above would be reduced to something actually worth
inlining, for example (not actually tested):

static inline void dma_write(u32 val, int reg, int lch)
{
        u8 stride = (reg > dma_ch_common_start) ? dma_stride : 0;

        __raw_writel(val, dma_base + (reg_map[reg] + stride * lch));
}

Same applies to dma_read().

Kevin
