From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v3 10/13] OMAP: DMA: Convert DMA library into DMA platform Driver
Date: Tue, 09 Nov 2010 14:26:08 -0800
Message-ID: <8739rakubj.fsf@deeprootsystems.com>
References: <1288099513-1854-1-git-send-email-manjugk@ti.com>
	<1288099513-1854-11-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:36829 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755063Ab0KIW0L (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Nov 2010 17:26:11 -0500
Received: by pva4 with SMTP id 4so399311pva.19
        for <linux-omap@vger.kernel.org>; Tue, 09 Nov 2010 14:26:10 -0800 (PST)
In-Reply-To: <1288099513-1854-11-git-send-email-manjugk@ti.com> (Manjunath
	Kondaiah G.'s message of "Tue, 26 Oct 2010 18:55:10 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

"G, Manjunath Kondaiah" <manjugk@ti.com> writes:

> Convert DMA library into DMA platform driver and make use
> of platform data provided by HWMOD data base for OMAP2PLUS onwards.
> For OMAP1 processors, the DMA driver in mach-omap uses resource
> structures for getting platform data.
>
> Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>

[...]

> diff --git a/arch/arm/mach-omap2/include/mach/dma.h b/arch/arm/mach-omap2/include/mach/dma.h
> index d0a7d5b..d13c5c0 100644
> --- a/arch/arm/mach-omap2/include/mach/dma.h
> +++ b/arch/arm/mach-omap2/include/mach/dma.h
> @@ -29,4 +29,7 @@
>  #ifndef __ASM_ARCH_OMAP2_DMA_H
>  #define __ASM_ARCH_OMAP2_DMA_H
>  
> +/* Should be part of hwmod data base ? */
> +#define OMAP_DMA4_LOGICAL_DMA_CH_COUNT	32	/* REVISIT: Is this 32 + 2? */
> +

There are no users of this in this patch, all users are removed.

Kevin
