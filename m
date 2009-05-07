From: Jean Pihet <jpihet@mvista.com>
Subject: Re: Beagleboard rev C memory timings & suspend/resume
Date: Thu, 7 May 2009 18:44:20 +0200
Message-ID: <200905071844.20939.jpihet@mvista.com>
References: <200904291553.49378.jpihet@mvista.com> <alpine.DEB.2.00.0905060009100.17514@utopia.booyaka.com> <200905071318.30501.jpihet@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:11472 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753837AbZEGQom convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 May 2009 12:44:42 -0400
In-Reply-To: <200905071318.30501.jpihet@mvista.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>Paul Walmsley <paul@pwsan.com>, "Syed Mohammed, Khasim" <khasim@ti.com>, "Kridner, Jason" <jdk@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Hi,

FYI I tried to relax the DDR timings (mainly tRC, tWTR, tXP, tXSR, ARCV) but 
that did not help.

>From the OMAP datasheet it looks like the ARCV setting is off: shouldn't it be 
(tREFI/tCK)+50=(7800/6)+50=0x546?

Is there a way to know if the self refresh works on both parts?

Regards,
Jean

On Thursday 07 May 2009 13:18:30 Jean Pihet wrote:
> Hi Paul,
>
> On Thursday 07 May 2009 01:39:02 Paul Walmsley wrote:
> > Hello Jean,
> >
> > sorry about the delay,
>
> Thanks for replying!
>
> > On Wed, 29 Apr 2009, Jean Pihet wrote:
> > > The suspend/resume on Beagleboard has some problem due to bad memory
> > > timings. Suspending for more than 5 to 10 seconds shows memory
> > > corruption.
> > >
> > > The new chips on rev Cx boards are using 2 DDR chip selects and it
> > > looks like the 2nd memory part is not correctly put into self refresh.
> > > As an experimentation I tried the same kernel with 'mem=128M' and it
> > > resumes correctly after 1 min in suspend.
> >
> > Nice work, this seems likely to be the cause.
> >
> > > I could not find the latest DDR detailed specs from Micron. The part
> > > number is MT29C2G48MAKLCJI-6 IT. Are those available? Is this part
> > > identical to 2 1Gb parts?
> >
> > The combined part's web page is:
> >
> > http://www.micron.com/products/partdetail?part=MT29C2G48MAKLCJI-6%20IT
> >
> > The SDRAM datasheet is the same that is used for all the other Micron
> > parts that we've run across so far:
> >
> > http://download.micron.com/pdf/datasheets/dram/mobile/1gb_ddr_mobile_sdra
> >m_ t48m.pdf
>
> Ok so we have 2 DDRs combined.
> That does not explain why the self-refresh is ok with only 1 part while it
> fails with the 2 parts.
> Could it be that the timings are too tight? Is there something special for
> the SDRC to support the 2 CSes correctly?
>
> We already have used the self refresh with 2 parts hooked on a 3430, not
> Micron parts though, so the code looks correct.
>
> I think we need help from the HW vendors here to identify the root cause:
> SDRC, DDR parts, connections?
>
> > > Now for the code in the kernel, there are some changes needed to
> > > support 2 CS'es:
> > > - the SDRC parameters need to be updated for the new memory part
> > > - the SDRC parameters need to include the ACTIM_CTRL_A_0,
> > > ACTIM_CTRL_A_1, ACTIM_CTRL_B_0, ACTIM_CTRL_B_1, RFR_CTRL_0 and
> > > RFR_CTRL_1 registers. Since the parameters for the 2nd CS are the same,
> > > this can be avoided by writing the same values to the 2 sets of
> > > registers
> > > - is there a need to differentiate between 1Gb and 2Gb chips, or can we
> > > just write the same params for both CS'es even if only one is being
> > > used? - the 'configure_sdrc' function in arch/arm/mach-omap2/sram34xx.S
> > > needs to program the 2 sets of registers. Here is a patch excerpt
> > > below. This patch only does not help the suspend/resume though.
> > >
> > > Any idea or suggestion?
> >
> > Looks like a good start.  Since the two SDRC chip-selects can technically
> > address parts with different timings, we should not assume that the two
> > chip selects will be the same.  Admittedly this seems like an unlikely
> > situation, but it's not impossible for non-POP OMAPs.
>
> Makes sense. It is better to have correct and generic code.
>
> > Re: suspend/resume, if you're talking about the code in sleep34xx.S, it
> > looks like this is already in good shape.
> >
> > Re: board & SDRC changes: would suggest modifying omap2_sdrc_init() to
> > take either two struct omap_sdrc_params pointers, or one struct with two
> > pointers.  omap2_init_common_hw() will also need to be updated for that,
> > and all of the board-*.c files also.
> >
> > Sound reasonable?
>
> Sure. I can write the new code, but I prefer to have the self refresh
> working first.
>
> > >         ldr     r11, omap3_sdrc_mr_0
> > >         str     r6, [r11]
> > >         ldr     r6, [r11]               @ posted-write barrier for SDRC
> > > +       ldr     r11, omap3_sdrc_mr_1
> > > +       str     r6, [r11]
> > > +       ldr     r6, [r11]               @ posted-write barrier for SDRC
> > >         bx      lr
> >
> > By the way, there's no need to duplicate the posted-write barrier.  There
> > should only be one, appearing right before the 'bx lr'.
>
> Ok I will take it into account.
>
> > regards,
> >
> > - Paul
>
> Regards,
> Jean
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


