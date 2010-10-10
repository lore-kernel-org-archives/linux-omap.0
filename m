From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/3] arm: mm: allow boards to fiddle with meminfo
Date: Sun, 10 Oct 2010 20:03:08 +0100
Message-ID: <20101010190308.GA15906@n2100.arm.linux.org.uk>
References: <1286732440-28644-1-git-send-email-felipe.contreras@gmail.com> <1286732440-28644-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:49900 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751709Ab0JJTDZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 10 Oct 2010 15:03:25 -0400
Content-Disposition: inline
In-Reply-To: <1286732440-28644-2-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, Greg KH <greg@kroah.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

On Sun, Oct 10, 2010 at 08:40:38PM +0300, Felipe Contreras wrote:
> So that they can reserve some memory.
> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  arch/arm/include/asm/mach/arch.h |    2 +-
>  arch/arm/mm/init.c               |    7 ++++---
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
> index 8a0dd18..408e4d5 100644
> --- a/arch/arm/include/asm/mach/arch.h
> +++ b/arch/arm/include/asm/mach/arch.h
> @@ -38,7 +38,7 @@ struct machine_desc {
>  	void			(*fixup)(struct machine_desc *,
>  					 struct tag *, char **,
>  					 struct meminfo *);
> -	void			(*reserve)(void);/* reserve mem blocks	*/
> +	void			(*reserve)(struct meminfo *);/* reserve mem blocks	*/
>  	void			(*map_io)(void);/* IO mapping function	*/
>  	void			(*init_irq)(void);
>  	struct sys_timer	*timer;		/* system tick timer	*/
> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> index 7185b00..4b5c117 100644
> --- a/arch/arm/mm/init.c
> +++ b/arch/arm/mm/init.c
> @@ -272,8 +272,6 @@ void __init arm_memblock_init(struct meminfo *mi, struct machine_desc *mdesc)
>  	int i;
>  
>  	memblock_init();
> -	for (i = 0; i < mi->nr_banks; i++)
> -		memblock_add(mi->bank[i].start, mi->bank[i].size);
>  
>  	/* Register the kernel text, kernel data and initrd with memblock. */
>  #ifdef CONFIG_XIP_KERNEL
> @@ -295,7 +293,10 @@ void __init arm_memblock_init(struct meminfo *mi, struct machine_desc *mdesc)
>  
>  	/* reserve any platform specific memblock areas */
>  	if (mdesc->reserve)
> -		mdesc->reserve();
> +		mdesc->reserve(mi);
> +
> +	for (i = 0; i < mi->nr_banks; i++)
> +		memblock_add(mi->bank[i].start, mi->bank[i].size);

It is not a good idea to change the ordering here, as we'll now be
adding the memory blocks _after_ we've started to make reservations
into memblock.

At least the omapfb code wants there to be memory present in memblock
when ->reserve is called.
