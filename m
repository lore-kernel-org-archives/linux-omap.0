From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/4] omap: Make uncompress code and DEBUG_LL code
	generic
Date: Sat, 16 Jan 2010 09:35:55 +0000
Message-ID: <20100116093555.GA13596@n2100.arm.linux.org.uk>
References: <20100116013205.10065.95921.stgit@baageli.muru.com> <20100116013515.10065.30649.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:55201 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752445Ab0APJgL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 Jan 2010 04:36:11 -0500
Content-Disposition: inline
In-Reply-To: <20100116013515.10065.30649.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Fri, Jan 15, 2010 at 05:35:15PM -0800, Tony Lindgren wrote:
> diff --git a/arch/arm/mach-omap1/include/mach/debug-macro.S b/arch/arm/mach-omap1/include/mach/debug-macro.S
> index 23e4724..0174858 100644
> --- a/arch/arm/mach-omap1/include/mach/debug-macro.S
> +++ b/arch/arm/mach-omap1/include/mach/debug-macro.S
> @@ -15,18 +15,71 @@
>  
>  #include <plat/serial.h>
>  
> +omap_uart_phys:	.word	0x0
> +omap_uart_virt:	.word	0x0

I assume that you have no plans for XIP kernel support on OMAP, since
these will be placed in the .text section, and is therefore read-only
on XIP kernels.
