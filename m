From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: RE: [PATCH 08/14] omap: Use ioremap for omap4 L4 code
Date: Mon, 19 Oct 2009 13:07:59 -0500
Message-ID: <A24693684029E5489D1D202277BE89444CFD9450@dlee02.ent.ti.com>
References: <20091016233624.2463.26653.stgit@localhost>
 <20091016234138.2463.38350.stgit@localhost>
 <20091016234622.GH12576@atomide.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02BB37D7AA@dbde02.ent.ti.com>
 <20091017161947.GK12576@atomide.com> <20091019002416.GM12576@atomide.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02BB37D82D@dbde02.ent.ti.com>
 <20091019171204.GP12576@atomide.com>
 <A24693684029E5489D1D202277BE89444CFD9382@dlee02.ent.ti.com>
 <20091019173831.GS12576@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51727 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757182AbZJSSIE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Oct 2009 14:08:04 -0400
In-Reply-To: <20091019173831.GS12576@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

 

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com] 
> Sent: Monday, October 19, 2009 12:39 PM
> To: Aguirre Rodriguez, Sergio Alberto
> Cc: Shilimkar, Santosh; linux-arm-kernel@lists.infradead.org; 
> linux-omap@vger.kernel.org
> Subject: Re: [PATCH 08/14] omap: Use ioremap for omap4 L4 code
> 
> * Aguirre Rodriguez, Sergio Alberto <saaguirre@ti.com> [091019 10:21]:
> > Tony, 
> > 
> > > -----Original Message-----
> > > From: linux-omap-owner@vger.kernel.org 
> > > [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of 
> Tony Lindgren
> > > Sent: Monday, October 19, 2009 12:12 PM
> > > To: Shilimkar, Santosh
> > > Cc: linux-arm-kernel@lists.infradead.org; 
> linux-omap@vger.kernel.org
> > > Subject: Re: [PATCH 08/14] omap: Use ioremap for omap4 L4 code
> > > 
> > > * Shilimkar, Santosh <santosh.shilimkar@ti.com> [091019 00:27]:
> > > > Tony,
> > > > > -----Original Message-----
> > > > > From: Tony Lindgren [mailto:tony@atomide.com]
> > > > > Sent: Monday, October 19, 2009 5:54 AM
> > > > > To: Shilimkar, Santosh
> > > > > Cc: linux-arm-kernel@lists.infradead.org; 
> > > linux-omap@vger.kernel.org
> > > > > Subject: Re: [PATCH 08/14] omap: Use ioremap for omap4 L4 code
> > > > > 
> > > > > * Tony Lindgren <tony@atomide.com> [091017 09:19]:
> > > > > > * Shilimkar, Santosh <santosh.shilimkar@ti.com> 
> [091017 03:49]:
> > > > > > > Thanks Tony for this ioremap series!!
> > > > > > >
> > > > > > > > -----Original Message-----
> > > > > > > > From: Tony Lindgren [mailto:tony@atomide.com]
> > > > > > > > Sent: Saturday, October 17, 2009 5:16 AM
> > > > > > > > To: linux-arm-kernel@lists.infradead.org
> > > > > > > > Cc: linux-omap@vger.kernel.org; Shilimkar, Santosh
> > > > > > > > Subject: Re: [PATCH 08/14] omap: Use ioremap for 
> > > omap4 L4 code
> > > > > > > >
> > > > > > > > * Tony Lindgren <tony@atomide.com> [091016 16:42]:
> > > > > > > > > Use ioremap for omap4 L4 code
> > > > > > > >
> > > > > > > > Santosh, can you please check and ack this patch?
> > > > > > > >
> > > > > > > > Especially some of the ioremap sizes may be wrong. 
> > > Also, this one
> > > > > > > > I cannot boot test, so it's just compile tested.
> > > > > > >
> > > > > > > I have checked the patch and it looks all right 
> > > except few typo. Also
> > > > > the scu_base is needed bit earlier.
> > > > > 
> > > > > <snip>
> > > > > 
> > > > > > > Here is the patch on top of ioremap series which 
> > > should fix above
> > > > > mentioned things. With below patch + two serial related 
> > > patches the kernel
> > > > > boots on OMAP4430.
> > > > > >
> > > > > > Great, will update. Thanks for taking the time to fix it!
> > > > > 
> > > > > Here's this one updated with Santosh's fix merged in.
> > > > V2 has one typo which I think I also missed in my patch.
> > > > >+	/* Static mapping, never released */
> > > > >+	gic_cpu_base_addr = 
> ioremap(OMAP44XX_GIC_CPU_BASE, SZ_512);
> > > > >+	BUG_ON(!base);
> > > > Should be BUG_ON(!gic_cpu_base_addr);
> > > 
> > > OK, here's V3 of the patch.
> > 
> > Tony,
> > 
> > > diff --git 
> a/arch/arm/plat-omap/include/mach/entry-macro.S 
> b/arch/arm/plat-omap/include/mach/entry-macro.S
> > > index abe0864..3bad928 100644
> > > --- a/arch/arm/plat-omap/include/mach/entry-macro.S
> > > +++ b/arch/arm/plat-omap/include/mach/entry-macro.S
> > > @@ -104,6 +104,8 @@
> > >  
> > >  		.endm
> > >  #else
> > > +#define OMAP44XX_VA_GIC_CPU_BASE	
> OMAP2_IO_ADDRESS(OMAP44XX_GIC_CPU_BASE)
> > > +
> > 
> > Shouldn't this define go with the ioremap aproach?
> 
> That's still needed for the get_irqnr_and_base assembly macro.
> But at least it's now defined locally for the macro.

Oh ok, I didn't catch that one.

Thanks for clarifying.

Regards,
Sergio
> 
> Tony
> 
> 