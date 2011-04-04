From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] OMAP4: SRAM: Fix warning: format '%08lx' expects type
	'long unsigned int'
Date: Mon, 4 Apr 2011 10:12:23 +0100
Message-ID: <20110404091223.GA19854@n2100.arm.linux.org.uk>
References: <1301907896-30954-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:50447 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754009Ab1DDJMc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Apr 2011 05:12:32 -0400
Content-Disposition: inline
In-Reply-To: <1301907896-30954-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Apr 04, 2011 at 02:34:56PM +0530, Santosh Shilimkar wrote:
> diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
> index a3f50b3..7857146 100644
> --- a/arch/arm/plat-omap/sram.c
> +++ b/arch/arm/plat-omap/sram.c
> @@ -166,7 +166,7 @@ static void __init omap_detect_sram(void)
>  		else if (cpu_is_omap1611())
>  			omap_sram_size = SZ_256K;
>  		else {
> -			printk(KERN_ERR "Could not detect SRAM size\n");
> +			pr_err("Could not detect SRAM size\n");
>  			omap_sram_size = 0x4000;
>  		}
>  	}
> @@ -221,7 +221,7 @@ static void __init omap_map_sram(void)
>  	omap_sram_io_desc[0].length = ROUND_DOWN(omap_sram_size, PAGE_SIZE);
>  	iotable_init(omap_sram_io_desc, ARRAY_SIZE(omap_sram_io_desc));
>  
> -	printk(KERN_INFO "SRAM: Mapped pa 0x%08lx to va 0x%08lx size: 0x%lx\n",
> +	pr_info("SRAM: Mapped pa 0x%08x to va 0x%08lx size: 0x%lx\n",
>  	__pfn_to_phys(omap_sram_io_desc[0].pfn),
>  	omap_sram_io_desc[0].virtual,
>  	       omap_sram_io_desc[0].length);

This is wrong.

I guess this is a consequence of using phys_addr_t rather than explicitly
'unsigned long' for physical addresses, which ends up as u32, which in
turn is 'unsigned int' not 'unsigned long'.

In any case, these warnings are telling us what needs to be fixed for
large physical addresses.  The way that we've sorted this in the generic
ARM code is to use 0x%08llx, and casting the physical address to
'unsigned long long'.  That gives consistent arguments without printing
excessive zeros at the start of an address.
