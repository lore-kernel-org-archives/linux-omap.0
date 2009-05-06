From: Paul Walmsley <paul@pwsan.com>
Subject: Re: Beagleboard rev C memory timings & suspend/resume
Date: Wed, 6 May 2009 17:39:02 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0905060009100.17514@utopia.booyaka.com>
References: <200904291553.49378.jpihet@mvista.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45017 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750935AbZEFXjD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 May 2009 19:39:03 -0400
In-Reply-To: <200904291553.49378.jpihet@mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jpihet@mvista.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Hello Jean,

sorry about the delay,

On Wed, 29 Apr 2009, Jean Pihet wrote:

> The suspend/resume on Beagleboard has some problem due to bad memory timings.
> Suspending for more than 5 to 10 seconds shows memory corruption.
> 
> The new chips on rev Cx boards are using 2 DDR chip selects and it looks like 
> the 2nd memory part is not correctly put into self refresh. As an 
> experimentation I tried the same kernel with 'mem=128M' and it resumes 
> correctly after 1 min in suspend.

Nice work, this seems likely to be the cause.

> I could not find the latest DDR detailed specs from Micron. The part number is 
> MT29C2G48MAKLCJI-6 IT. Are those available? Is this part identical to 2 1Gb 
> parts?

The combined part's web page is:

http://www.micron.com/products/partdetail?part=MT29C2G48MAKLCJI-6%20IT

The SDRAM datasheet is the same that is used for all the other Micron 
parts that we've run across so far:

http://download.micron.com/pdf/datasheets/dram/mobile/1gb_ddr_mobile_sdram_t48m.pdf

> Now for the code in the kernel, there are some changes needed to support 2 
> CS'es:
> - the SDRC parameters need to be updated for the new memory part
> - the SDRC parameters need to include the ACTIM_CTRL_A_0, ACTIM_CTRL_A_1, 
> ACTIM_CTRL_B_0, ACTIM_CTRL_B_1, RFR_CTRL_0 and RFR_CTRL_1 registers. Since 
> the parameters for the 2nd CS are the same, this can be avoided by writing 
> the same values to the 2 sets of registers
> - is there a need to differentiate between 1Gb and 2Gb chips, or can we just 
> write the same params for both CS'es even if only one is being used?
> - the 'configure_sdrc' function in arch/arm/mach-omap2/sram34xx.S needs to 
> program the 2 sets of registers. Here is a patch excerpt below. This patch 
> only does not help the suspend/resume though.
> 
> Any idea or suggestion?

Looks like a good start.  Since the two SDRC chip-selects can technically 
address parts with different timings, we should not assume that the two 
chip selects will be the same.  Admittedly this seems like an unlikely 
situation, but it's not impossible for non-POP OMAPs.

Re: suspend/resume, if you're talking about the code in sleep34xx.S, it 
looks like this is already in good shape.

Re: board & SDRC changes: would suggest modifying omap2_sdrc_init() to 
take either two struct omap_sdrc_params pointers, or one struct with two 
pointers.  omap2_init_common_hw() will also need to be updated for that, 
and all of the board-*.c files also.

Sound reasonable?

>         ldr     r11, omap3_sdrc_mr_0
>         str     r6, [r11]
>         ldr     r6, [r11]               @ posted-write barrier for SDRC
> +       ldr     r11, omap3_sdrc_mr_1
> +       str     r6, [r11]
> +       ldr     r6, [r11]               @ posted-write barrier for SDRC
>         bx      lr

By the way, there's no need to duplicate the posted-write barrier.  There 
should only be one, appearing right before the 'bx lr'.

regards,

- Paul
