From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 02/11] omap2/3: Fix DEBUG_LL for omap zoom2/3
Date: Fri, 30 Apr 2010 13:55:23 -0700
Message-ID: <87sk6cirt0.fsf@deeprootsystems.com>
References: <20100430202603.25812.41834.stgit@baageli.muru.com>
	<20100430203349.25812.64659.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:33879 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753524Ab0D3Uz1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Apr 2010 16:55:27 -0400
Received: by pvg7 with SMTP id 7so386713pvg.19
        for <linux-omap@vger.kernel.org>; Fri, 30 Apr 2010 13:55:26 -0700 (PDT)
In-Reply-To: <20100430203349.25812.64659.stgit@baageli.muru.com> (Tony Lindgren's message of "Fri\, 30 Apr 2010 13\:33\:50 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, Vikram Pandita <vikram.pandita@ti.com>, linux-omap@vger.kernel.org, Allen Pais <allen.pais@ti.com>

Tony Lindgren <tony@atomide.com> writes:

> Zoom2 and 3 have UARTs only on the external debug board.
> GPMC needs to be mapped early to use it for DEBUG_LL.
>
> Additionally, 0xfb000000 overlaps with other areas, so
> use 0xfa400000 for the virtual address instead.
>
> Note that with the pending serial.c patches you need to
> set console=ttyS0,115200n8 as it will be the only UART
> mapped. To use DEBUG_LL, you need to pass also earlyprintk
> in cmdline.
>
> Cc: Allen Pais <allen.pais@ti.com>
> Cc: Vikram Pandita <vikram.pandita@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/kernel/head.S                         |   10 ++++++++++
>  arch/arm/mach-omap2/board-zoom-debugboard.c    |    2 +-
>  arch/arm/mach-omap2/include/mach/debug-macro.S |    4 ++--
>  arch/arm/mach-omap2/io.c                       |    9 +++++++++
>  arch/arm/plat-omap/include/plat/serial.h       |    2 +-
>  5 files changed, 23 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
> index eb62bf9..fd870e1 100644
> --- a/arch/arm/kernel/head.S
> +++ b/arch/arm/kernel/head.S
> @@ -328,6 +328,16 @@ __create_page_tables:
>  	add	r0, r4, #0xd8000000 >> 18
>  	str	r3, [r0]
>  #endif
> +#if defined(CONFIG_MACH_OMAP_ZOOM2) || defined(CONFIG_MACH_OMAP_ZOOM3)
> +	/*
> +	 * Zoom2 and Zoom3 have UARTs only on the debug board.
> +	 * The debug board is connected to the GPMC.
> +	 */
> +	add	r0, r4, #0xfa000000 >> 18
> +	orr	r0, r0, #0x00400000 >> 18	@ ZOOM_UART_VIRT
> +	orr	r3, r7, #0x10000000		@ ZOOM_UART_BASE
> +	str	r3, [r0]
> +#endif

I don't see why this part is needed.  The same mapping is done using
the .io_pg_offset in the machine description which is done just before
this in head.S

Kevin
