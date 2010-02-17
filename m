From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 02/24] omap2/3/4: ioremap omap_globals module
Date: Wed, 17 Feb 2010 11:00:10 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C3CF82D0@dbde02.ent.ti.com>
References: <1266335895-32741-1-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-2-git-send-email-santosh.shilimkar@ti.com>
 <alpine.DEB.2.00.1002161500180.10478@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54519 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751133Ab0BQFaY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Feb 2010 00:30:24 -0500
In-Reply-To: <alpine.DEB.2.00.1002161500180.10478@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "ben@fluff.org.uk" <ben@fluff.org.uk>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>, Kevin Hilman <khilman@deeprootsystems.com>

< snip>

> >  /**
> > diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
> > index 4f29e8c..ee9499e 100644
> > --- a/arch/arm/plat-omap/common.c
> > +++ b/arch/arm/plat-omap/common.c
> > @@ -256,11 +256,11 @@ static void __init __omap2_set_globals(struct omap_globals *omap2_globals)
> >  static struct omap_globals omap242x_globals = {
> >  	.class	= OMAP242X_CLASS,
> >  	.tap	= OMAP2_L4_IO_ADDRESS(0x48014000),
> > -	.sdrc	= OMAP2_L3_IO_ADDRESS(OMAP2420_SDRC_BASE),
> > -	.sms	= OMAP2_L3_IO_ADDRESS(OMAP2420_SMS_BASE),
> > -	.ctrl	= OMAP2_L4_IO_ADDRESS(OMAP2420_CTRL_BASE),
> > -	.prm	= OMAP2_L4_IO_ADDRESS(OMAP2420_PRM_BASE),
> > -	.cm	= OMAP2_L4_IO_ADDRESS(OMAP2420_CM_BASE),
> > +	.sdrc	= OMAP2420_SDRC_BASE,
> > +	.sms	= OMAP2420_SMS_BASE,
> > +	.ctrl	= OMAP2420_CTRL_BASE,
> > +	.prm	= OMAP2420_PRM_BASE,
> > +	.cm	= OMAP2420_CM_BASE,
> >  	.uart1_phys	= OMAP2_UART1_BASE,
> >  	.uart2_phys	= OMAP2_UART2_BASE,
> >  	.uart3_phys	= OMAP2_UART3_BASE,
> > @@ -277,11 +277,11 @@ void __init omap2_set_globals_242x(void)
> >  static struct omap_globals omap243x_globals = {
> >  	.class	= OMAP243X_CLASS,
> >  	.tap	= OMAP2_L4_IO_ADDRESS(0x4900a000),
> > -	.sdrc	= OMAP2_L3_IO_ADDRESS(OMAP243X_SDRC_BASE),
> > -	.sms	= OMAP2_L3_IO_ADDRESS(OMAP243X_SMS_BASE),
> > -	.ctrl	= OMAP2_L4_IO_ADDRESS(OMAP243X_CTRL_BASE),
> > -	.prm	= OMAP2_L4_IO_ADDRESS(OMAP2430_PRM_BASE),
> > -	.cm	= OMAP2_L4_IO_ADDRESS(OMAP2430_CM_BASE),
> > +	.sdrc	= OMAP243X_SDRC_BASE,
> > +	.sms	= (OMAP243X_SMS_BASE),
> > +	.ctrl	= (OMAP243X_CTRL_BASE),
> > +	.prm	= (OMAP2430_PRM_BASE),
> > +	.cm	= (OMAP2430_CM_BASE),
> 
> Please drop the unnecessary parentheses above and elsewhere in this file.
> If the parentheses are nececessary because the macro is a composite
> expression and parentheses are missing around the expression, then the
> parentheses should be added around the macro contents itself.
> 
No need of paran's. They just left out while cleaning it up.
> >  	.uart1_phys	= OMAP2_UART1_BASE,
> >  	.uart2_phys	= OMAP2_UART2_BASE,
> >  	.uart3_phys	= OMAP2_UART3_BASE,
> > @@ -298,11 +298,11 @@ void __init omap2_set_globals_243x(void)
> >  static struct omap_globals omap3_globals = {
> >  	.class	= OMAP343X_CLASS,
> >  	.tap	= OMAP2_L4_IO_ADDRESS(0x4830A000),
> > -	.sdrc	= OMAP2_L3_IO_ADDRESS(OMAP343X_SDRC_BASE),
> > -	.sms	= OMAP2_L3_IO_ADDRESS(OMAP343X_SMS_BASE),
> > -	.ctrl	= OMAP2_L4_IO_ADDRESS(OMAP343X_CTRL_BASE),
> > -	.prm	= OMAP2_L4_IO_ADDRESS(OMAP3430_PRM_BASE),
> > -	.cm	= OMAP2_L4_IO_ADDRESS(OMAP3430_CM_BASE),
> > +	.sdrc	= (OMAP343X_SDRC_BASE),
> > +	.sms	= (OMAP343X_SMS_BASE),
> > +	.ctrl	= (OMAP343X_CTRL_BASE),
> > +	.prm	= (OMAP3430_PRM_BASE),
> > +	.cm	= (OMAP3430_CM_BASE),
> 
> As above.
> 
> >  	.uart1_phys	= OMAP3_UART1_BASE,
> >  	.uart2_phys	= OMAP3_UART2_BASE,
> >  	.uart3_phys	= OMAP3_UART3_BASE,
> > @@ -325,10 +325,10 @@ void __init omap2_set_globals_36xx(void)
> >  static struct omap_globals omap4_globals = {
> >  	.class	= OMAP443X_CLASS,
> >  	.tap	= OMAP2_L4_IO_ADDRESS(OMAP443X_SCM_BASE),
> > -	.ctrl	= OMAP2_L4_IO_ADDRESS(OMAP443X_CTRL_BASE),
> > -	.prm	= OMAP2_L4_IO_ADDRESS(OMAP4430_PRM_BASE),
> > -	.cm	= OMAP2_L4_IO_ADDRESS(OMAP4430_CM_BASE),
> > -	.cm2	= OMAP2_L4_IO_ADDRESS(OMAP4430_CM2_BASE),
> > +	.ctrl	= (OMAP443X_CTRL_BASE),
> > +	.prm	= (OMAP4430_PRM_BASE),
> > +	.cm	= (OMAP4430_CM_BASE),
> > +	.cm2	= (OMAP4430_CM2_BASE),
> 
> As above.
> 
> >  	.uart1_phys	= OMAP4_UART1_BASE,
> >  	.uart2_phys	= OMAP4_UART2_BASE,
> >  	.uart3_phys	= OMAP4_UART3_BASE,
> > diff --git a/arch/arm/plat-omap/include/plat/common.h b/arch/arm/plat-omap/include/plat/common.h
> > index e04a58e..dc8a897 100644
> > --- a/arch/arm/plat-omap/include/plat/common.h
> > +++ b/arch/arm/plat-omap/include/plat/common.h
> > @@ -41,12 +41,12 @@ extern struct sys_timer omap_timer;
> >  struct omap_globals {
> >  	u32		class;		/* OMAP class to detect */
> >  	void __iomem	*tap;		/* Control module ID code */
> > -	void __iomem	*sdrc;		/* SDRAM Controller */
> > -	void __iomem	*sms;		/* SDRAM Memory Scheduler */
> > -	void __iomem	*ctrl;		/* System Control Module */
> > -	void __iomem	*prm;		/* Power and Reset Management */
> > -	void __iomem	*cm;		/* Clock Management */
> > -	void __iomem	*cm2;
> > +	unsigned long   sdrc;           /* SDRAM Controller */
> > +	unsigned long   sms;            /* SDRAM Memory Scheduler */
> > +	unsigned long   ctrl;           /* System Control Module */
> > +	unsigned long   prm;            /* Power and Reset Management */
> > +	unsigned long   cm;             /* Clock Management */
> > +	unsigned long   cm2;
> 
> Please add comments above struct omap_globals to reinforce that these are
> now physical addresses.
>
ok
 
> >  	unsigned long	uart1_phys;
> >  	unsigned long	uart2_phys;
> >  	unsigned long	uart3_phys;
> > --
> > 1.6.0.4
> >
> 
> 
> - Paul
