From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH-V4 3/3] arm:omap:am33xx: Add low level debugging support
Date: Thu, 1 Dec 2011 10:52:52 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A80474A5@DBDE01.ent.ti.com>
References: <1320946837-32507-1-git-send-email-hvaibhav@ti.com>
	<1320946837-32507-4-git-send-email-hvaibhav@ti.com> <87r50pxk1i.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53408 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751352Ab1LAKxG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Dec 2011 05:53:06 -0500
In-Reply-To: <87r50pxk1i.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "paul@pwsan.com" <paul@pwsan.com>, "Mohammed, Afzal" <afzal@ti.com>

> -----Original Message-----
> From: Hilman, Kevin
> Sent: Thursday, December 01, 2011 5:03 AM
> To: Hiremath, Vaibhav
> Cc: linux-omap@vger.kernel.org; tony@atomide.com; linux-arm-
> kernel@lists.infradead.org; paul@pwsan.com; Mohammed, Afzal
> Subject: Re: [PATCH-V4 3/3] arm:omap:am33xx: Add low level debugging
> support
> 
> Hi Vaibhav,
> 
> Vaibhav Hiremath <hvaibhav@ti.com> writes:
> 
> > From: Afzal Mohammed <afzal@ti.com>
> >
> > Add support for low level debugging on AM335X EVM (AM33XX family).
> > Currently only support for UART1 console, which is used on AM335X EVM
> > is added.
> >
> > Signed-off-by: Afzal Mohammed <afzal@ti.com>
> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> 
> One minor comment below...
> 
> > ---
> >  arch/arm/mach-omap2/include/mach/debug-macro.S |   17 ++++++++++++++++-
> >  arch/arm/plat-omap/include/plat/serial.h       |    4 ++++
> >  arch/arm/plat-omap/include/plat/uncompress.h   |    6 ++++++
> >  3 files changed, 26 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/include/mach/debug-macro.S
> b/arch/arm/mach-omap2/include/mach/debug-macro.S
> > index 13f98e5..ce543ae 100644
> > --- a/arch/arm/mach-omap2/include/mach/debug-macro.S
> > +++ b/arch/arm/mach-omap2/include/mach/debug-macro.S
> > @@ -72,6 +72,8 @@ omap_uart_lsr:	.word	0
> >  		beq	82f			@ configure UART2
> >  		cmp	\rp, #TI816XUART3	@ ti816x UART offsets different
> >  		beq	83f			@ configure UART3
> > +		cmp	\rp, #AM33XXUART1	@ AM33XX UART offsets different
> > +		beq	84f			@ configure UART1
> >  		cmp	\rp, #ZOOM_UART		@ only on zoom2/3
> >  		beq	95f			@ configure ZOOM_UART
> >
> > @@ -100,7 +102,9 @@ omap_uart_lsr:	.word	0
> >  		b	98f
> >  83:		mov	\rp, #UART_OFFSET(TI816X_UART3_BASE)
> >  		b	98f
> > -
> > +84:		ldr	\rp, =AM33XX_UART1_BASE
> > +		and	\rp, \rp, #0x00ffffff
> > +		b	97f
> >  95:		ldr	\rp, =ZOOM_UART_BASE
> >  		str	\rp, [\tmp, #0]		@ omap_uart_phys
> >  		ldr	\rp, =ZOOM_UART_VIRT
> > @@ -110,6 +114,17 @@ omap_uart_lsr:	.word	0
> >  		b	10b
> >
> >  		/* Store both phys and virt address for the uart */
> 
> Please update this comment to clarify that this block is for AM33xx
> only, and update the following one as the catch all.
> 
Ok, will update.

> > +97:		add	\rp, \rp, #0x44000000	@ phys base
> > +		str	\rp, [\tmp, #0]		@ omap_uart_phys
> > +		sub	\rp, \rp, #0x44000000	@ phys base
> > +		add	\rp, \rp, #0xf9000000	@ virt base
> > +		str	\rp, [\tmp, #4]		@ omap_uart_virt
> > +		mov	\rp, #(UART_LSR << OMAP_PORT_SHIFT)
> > +		str	\rp, [\tmp, #8]		@ omap_uart_lsr
> 
> The last 3 lines are unnecessarily duplicated.  They can be shared with
> the common block that follows.  IOW, only the base addresses are
> different, the rest of the operations are shared.
> 
I thought about this, but then code looks complex & ugly, just to save
duplication of 3 lines. So I added separate code for AM33xx devices.

If you still think it should be done, then How about below change -


-               /* Store both phys and virt address for the uart */
-98:            add     \rp, \rp, #0x48000000   @ phys base
+               /* AM33XX: Store both phys and virt address for the uart */
+96:            add     \rp, \rp, #0x44000000   @ phys base
                str     \rp, [\tmp, #0]         @ omap_uart_phys
-               sub     \rp, \rp, #0x48000000   @ phys base
-               add     \rp, \rp, #0xfa000000   @ virt base
-               str     \rp, [\tmp, #4]         @ omap_uart_virt
+               sub     \rp, \rp, #0x44000000   @ phys base
+               add     \rp, \rp, #0xf9000000   @ virt base
+97:            str     \rp, [\tmp, #4]         @ omap_uart_virt
                mov     \rp, #(UART_LSR << OMAP_PORT_SHIFT)
                str     \rp, [\tmp, #8]         @ omap_uart_lsr

                b       10b

+               /* Store both phys and virt address for the uart */
+98:            add     \rp, \rp, #0x48000000   @ phys base
+               str     \rp, [\tmp, #0]         @ omap_uart_phys
+               sub     \rp, \rp, #0x48000000   @ phys base
+               add     \rp, \rp, #0xfa000000   @ virt base
+               b       97b
+


Thanks,
Vaibhav

> > +		b	10b
> > +
> > +		/* Store both phys and virt address for the uart */
> >  98:		add	\rp, \rp, #0x48000000	@ phys base
> >  		str	\rp, [\tmp, #0]		@ omap_uart_phys
> >  		sub	\rp, \rp, #0x48000000	@ phys base
> 
> Kevin
