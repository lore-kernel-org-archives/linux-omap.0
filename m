From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/4] omap: Make uncompress code and DEBUG_LL code
 generic, v2
Date: Sat, 23 Jan 2010 09:13:17 -0800
Message-ID: <20100123171317.GA6836@atomide.com>
References: <20100116191820.GI10318@atomide.com>
 <20100116193313.GA23092@n2100.arm.linux.org.uk>
 <20100116200003.GL10318@atomide.com>
 <FCCFB4CDC6E5564B9182F639FC356087030070F296@dbde02.ent.ti.com>
 <20100122030711.GP23467@atomide.com>
 <FCCFB4CDC6E5564B9182F639FC35608703007F2289@dbde02.ent.ti.com>
 <20100122205511.GB11835@atomide.com>
 <FCCFB4CDC6E5564B9182F639FC35608703007F232B@dbde02.ent.ti.com>
 <20100122211052.GE11835@atomide.com>
 <FCCFB4CDC6E5564B9182F639FC35608703007F2340@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:53682 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752457Ab0AWRNR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 23 Jan 2010 12:13:17 -0500
Content-Disposition: inline
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608703007F2340@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Pandita, Vikram <vikram.pandita@ti.com> [100122 15:08]:
> Tony
> 
> >-----Original Message-----
> >From: Tony Lindgren [mailto:tony@atomide.com]
> >Sent: Friday, January 22, 2010 3:11 PM
> >To: Pandita, Vikram
> >Cc: Russell King - ARM Linux; linux-arm-kernel@lists.infradead.org; linux-omap@vger.kernel.org
> >Subject: Re: [PATCH 2/4] omap: Make uncompress code and DEBUG_LL code generic, v2
> >
> >* Pandita, Vikram <vikram.pandita@ti.com> [100122 12:56]:
> >>
> >>
> >> >-----Original Message-----
> >> >From: Tony Lindgren [mailto:tony@atomide.com]
> >> >Sent: Friday, January 22, 2010 2:55 PM
> >> >To: Pandita, Vikram
> >> >Cc: Russell King - ARM Linux; linux-arm-kernel@lists.infradead.org; linux-omap@vger.kernel.org
> >> >Subject: Re: [PATCH 2/4] omap: Make uncompress code and DEBUG_LL code generic, v2
> >> >
> >> >* Pandita, Vikram <vikram.pandita@ti.com> [100122 06:46]:
> >> >> >
> >> >> >OK, I've added that too, but for mach-omap2 only. I've also
> >> >> >added an experimental zoom2/3 support.
> >> >> >
> >> >> >Care to take try it out and see what happens on a zoom?
> >> >>
> >> >> Test on zoom3 failed with multi-omap branch.
> >> >> Debugging the same, should have a zoom correction patch out today.
> >> >
> >> >Heh OK. I just pushed more updates into the multi-omap branch
> >> >if you want to try to boot zoom2/zoom3 using the same .config.
> >>
> >> Refreshed my tree and I don't see your patches yet.
> >
> >Takes a few minutes to get mirrored from master.kernel.org..
> 
> Yes I tried with new branch and zoom2/3 does not work.
> Root cause: 
> There is a very basic issue in low level code.
> 
> We are allowed to create only one Physical to Virtual mapping using MACHINE_START() phys_io and io_pg_offst of size 0x100000(1MB).
> 
> Now for zoom2/3 we need to do following:
> MACHINE_START(OMAP_ZOOM3, "OMAP Zoom3 board")
> -       .phys_io        = 0x48000000,
> -       .io_pg_offst    = ((0xfa000000) >> 18) & 0xfffc,
> +       .phys_io        = 0x1000000, /*ZOOM_UART_BASE*/
> +       .io_pg_offst    = ((0xfb000000) >> 18) & 0xfffc, /*ZOOM_UART_VIRT*/
>         .boot_params    = 0x80000100,
>         .map_io         = omap_zoom_map_io,
>         .init_irq       = omap_zoom_init_irq,
> 
> This will create mapping:
> 0x1000000 <-> 0xfb000000 of 1MB
> 
> Now that leaves the phy address 0x4800000 omap register mapping, unmapped.

Right, we really need 0x48000000 mapped :)
 
> So the code to get scratchpad contents will abort:
> arch/arm/mach-omap2/include/mach/debug-macro.S
> 	moveq   \rx, #0x48000000        @ physical base address
> 	movne   \rx, #0xfa000000        @ virtual base
> 	orr     \rx, \rx, #0x0006a000   @ uart1 on omap2/3/4
> 
> 
> This seems to be a basic limitation of low level code and I have not clue how to circumvent this.
> Thoughts?

Please take a look at arch/arm/kernel/head.S where you can add
the extra mapping early on.

Hmm, I wonder if we cand nowadays do the extra mapping for zoom
external uart in arch/arm/kernel/early_printk.c?

Are you getting anything out of the zoom uart before MMU is
enabled?

To test this you can temporarily break your kernel by commenting
out the start_kernel line in head-common.S. Then the code falls
through to __error_p and prints out a processor error..

Regards,

Tony
