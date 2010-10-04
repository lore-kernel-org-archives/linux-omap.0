From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH 08/10] OMAP: split plat-omap/common.c
Date: Mon, 4 Oct 2010 00:03:28 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1010032359220.13816@utopia.booyaka.com>
References: <20101001213119.1408.65395.stgit@twilight.localdomain> <20101001213532.1408.55832.stgit@twilight.localdomain> <EAF47CD23C76F840A9E7FCE10091EFAB030CDFE3D3@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:34331 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752366Ab0JDGD3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Oct 2010 02:03:29 -0400
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB030CDFE3D3@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, 4 Oct 2010, Varadarajan, Charulatha wrote:

> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org 
> > [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Paul Walmsley
> > Sent: Saturday, October 02, 2010 3:06 AM
> > To: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> > Subject: [PATCH 08/10] OMAP: split plat-omap/common.c
> > 
> > Split plat-omap/common.c into three pieces:

...

> > +#if defined(CONFIG_ARCH_OMAP2430)
> > +
> > +static struct omap_globals omap243x_globals = {
> > +	.class	= OMAP243X_CLASS,
> > +	.tap	= OMAP2_L4_IO_ADDRESS(0x4900a000),
> > +	.sdrc	= OMAP243X_SDRC_BASE,
> > +	.sms	= OMAP243X_SMS_BASE,
> > +	.ctrl	= OMAP243X_CTRL_BASE,
> > +	.prm	= OMAP2430_PRM_BASE,
> > +	.cm	= OMAP2430_CM_BASE,
> > +	.uart1_phys	= OMAP2_UART1_BASE,
> > +	.uart2_phys	= OMAP2_UART2_BASE,
> > +	.uart3_phys	= OMAP2_UART3_BASE,
> > +};
> > +
> > +void __init omap2_set_globals_243x(void)
> > +{
> > +	__omap2_set_globals(&omap243x_globals);
> > +}
> > +#endif
> > +
> > +#if defined(CONFIG_ARCH_OMAP3)
> 
> Do you really need these #ifdefs?
> It would be better to avoid these #ifdefs and use cpu_is* checks.
> Same comment holds good across this patch.

If you think you can do it better, please create a patch for the 2.6.38 
time frame.  I personally am not interested in changing any of this code 
(which was not added by this patch; the patch just splits the existing 
code) for the .37 merge window.

> > +static int __init omap_init_clocksource_32k(void)
> > +{
> > +	static char err[] __initdata = KERN_ERR
> > +			"%s: can't register clocksource!\n";
> > +
> > +	if (cpu_is_omap16xx() || cpu_class_is_omap2()) {
> > +		struct clk *sync_32k_ick;
> > +
> > +		if (cpu_is_omap16xx())
> 
> Avoid cpu_is* checks in plat-omap.

OK, I'll bite.  Why?


- Paul
