From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 1/6 v2] OMAP4: Fix cpu detection
Date: Fri, 11 Dec 2009 10:13:55 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BC1415B4@dbde02.ent.ti.com>
References: <1260426156-1820-1-git-send-email-santosh.shilimkar@ti.com>
 <4B2156B6.8090403@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49763 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762282AbZLKEoN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Dec 2009 23:44:13 -0500
In-Reply-To: <4B2156B6.8090403@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>

> >
> > +void __init omap4_check_revision(void)
> > +{
> > +	u32 idcode;
> > +	u16 hawkeye;
> > +	u8 rev;
> > +	char *rev_name = "ES1.0";
> should'nt you decide this inside the rev check path?

This is initialized value by default. Since the chip is ES1.0 additionaly I am not doing it.
e.g. for ES2.0, it would be done inside. > > +
> > +	/*
> > +	 * The IC rev detection is done with hawkeye and rev.
> > +	 * Note that rev does not map directly to defined processor
> > +	 * revision numbers as ES1.0 uses value 0.
> > +	 */
> > +	idcode = read_tap_reg(OMAP_TAP_IDCODE);
> > +	hawkeye = (idcode >> 12) & 0xffff;
> > +	rev = (idcode >> 28) & 0xff;
> > +
> > +	if ((hawkeye == 0xb852) && (rev == 0x0)) {
> > +		omap_revision = OMAP4430_REV_ES1_0;
> > +		pr_info("OMAP%04x %s\n", omap_rev() >> 16, rev_name);
> wondering about the >>16 part.
Why ?
> > +		return;
> > +	}
> > +
> > +	pr_err("Unknown OMAP4 CPU id\n");
> > +}
> > +
> >  #define OMAP3_SHOW_FEATURE(feat)		\
> >  	if (omap3_has_ ##feat())		\
> >  		printk(#feat" ");
> > @@ -336,7 +361,7 @@ void __init omap2_check_revision(void)
> >  		omap3_check_features();
> >  		omap3_cpuinfo();
> >  	} else if (cpu_is_omap44xx()) {
> > -		printk(KERN_INFO "FIXME: CPU revision = OMAP4430\n");
> > +		omap4_check_revision();
> >  		return;
> >  	} else {
> >  		pr_err("OMAP revision unknown, please fix!\n");
> > diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
> > index cc050b3..3473a80 100644
> > --- a/arch/arm/plat-omap/common.c
> > +++ b/arch/arm/plat-omap/common.c
> > @@ -280,7 +280,7 @@ void __init omap2_set_globals_343x(void)
> >  #if defined(CONFIG_ARCH_OMAP4)
> >  static struct omap_globals omap4_globals = {
> >  	.class	= OMAP443X_CLASS,
> > -	.tap	= OMAP2_L4_IO_ADDRESS(0x4830a000),
> > +	.tap	= OMAP2_L4_IO_ADDRESS(OMAP443X_SCM_BASE),
> >  	.ctrl	= OMAP2_L4_IO_ADDRESS(OMAP443X_CTRL_BASE),
> >  	.prm	= OMAP2_L4_IO_ADDRESS(OMAP4430_PRM_BASE),
> >  	.cm	= OMAP2_L4_IO_ADDRESS(OMAP4430_CM_BASE),
> > diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
> > index 2e17890..9359785 100644
> > --- a/arch/arm/plat-omap/include/plat/cpu.h
> > +++ b/arch/arm/plat-omap/include/plat/cpu.h
> > @@ -176,11 +176,13 @@ IS_OMAP_CLASS(15xx, 0x15)
> >  IS_OMAP_CLASS(16xx, 0x16)
> >  IS_OMAP_CLASS(24xx, 0x24)
> >  IS_OMAP_CLASS(34xx, 0x34)
> > +IS_OMAP_CLASS(44xx, 0x44)
> >
> >  IS_OMAP_SUBCLASS(242x, 0x242)
> >  IS_OMAP_SUBCLASS(243x, 0x243)
> >  IS_OMAP_SUBCLASS(343x, 0x343)
> >  IS_OMAP_SUBCLASS(363x, 0x363)
> > +IS_OMAP_SUBCLASS(443x, 0x443)
> >
> >  #define cpu_is_omap7xx()		0
> >  #define cpu_is_omap15xx()		0
> > @@ -408,8 +410,8 @@ IS_OMAP_TYPE(3517, 0x3517)
> >  # if defined(CONFIG_ARCH_OMAP4)
> >  # undef cpu_is_omap44xx
> >  # undef cpu_is_omap443x
> > -# define cpu_is_omap44xx()		1
> > -# define cpu_is_omap443x()		1
> > +# define cpu_is_omap44xx()		is_omap44xx()
> > +# define cpu_is_omap443x()		is_omap443x()
> >  # endif
> >
> >  /* Macros to detect if we have OMAP1 or OMAP2 */
> > @@ -443,7 +445,8 @@ IS_OMAP_TYPE(3517, 0x3517)
> >  #define OMAP3505_REV(v)		(OMAP35XX_CLASS | (0x3505 << 16) | (v << 12))
> >  #define OMAP3517_REV(v)		(OMAP35XX_CLASS | (0x3517 << 16) | (v << 12))
> >
> > -#define OMAP443X_CLASS		0x44300034
> > +#define OMAP443X_CLASS		0x44300044
> > +#define OMAP4430_REV_ES1_0	0x44300044
> >
> >  /*
> >   * omap_chip bits
> neat.. thanks..
> 
> --
> Regards,
> Nishanth Menon
