From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [RESUBMIT][PATCH 4/7] OMAP4: Update common omap platform	common
 sources.
Date: Sun, 17 May 2009 01:34:21 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02B49042A1@dbde02.ent.ti.com>
References: <1241677756-28756-1-git-send-email-santosh.shilimkar@ti.com>
 <1241677756-28756-2-git-send-email-santosh.shilimkar@ti.com>
 <1241677756-28756-3-git-send-email-santosh.shilimkar@ti.com>
 <1241677756-28756-4-git-send-email-santosh.shilimkar@ti.com>
 <20090516095332.GH15328@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34426 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753526AbZEPUEn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 May 2009 16:04:43 -0400
In-Reply-To: <20090516095332.GH15328@n2100.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>
Cc: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Thanks Russell for scanning all the patches minutely !!

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk] 
> Sent: Saturday, May 16, 2009 3:24 PM
> To: Shilimkar, Santosh
> Cc: linux-arm-kernel@lists.arm.linux.org.uk; 
> linux-omap@vger.kernel.org
> Subject: Re: [RESUBMIT][PATCH 4/7] OMAP4: Update common omap 
> platform common sources.
> 
> On Thu, May 07, 2009 at 11:59:13AM +0530, Santosh Shilimkar wrote:
> > @@ -309,3 +313,26 @@ void __init omap2_set_globals_343x(void)
> >  }
> >  #endif
> >  
> > +#if defined(CONFIG_ARCH_OMAP4)
> > +static struct omap_globals *omap4_globals;
> > +
> > +static void __init __omap4_set_globals(void)
> > +{
> > +	omap2_set_globals_tap(omap4_globals);
> > +	omap2_set_globals_control(omap4_globals);
> > +}
> > +static struct omap_globals omap443x_globals = {
> > +	.class	= OMAP443X_CLASS,
> > +	.tap	= OMAP2_IO_ADDRESS(0x4830A000),
> > +	.ctrl	= OMAP2_IO_ADDRESS(OMAP443X_CTRL_BASE),
> > +	.prm	= OMAP2_IO_ADDRESS(OMAP4430_PRM_BASE),
> > +	.cm	= OMAP2_IO_ADDRESS(OMAP4430_CM_BASE),
> > +};
> > +
> > +void __init omap2_set_globals_443x(void)
> > +{
> > +	omap4_globals = &omap443x_globals;
> > +	__omap4_set_globals();
> 
> Hmm, confused.  omap4_globals is a static variable, and 
> __omap4_set_globals
> is a static function.  The only user of omap4_globals is 
> __omap4_set_globals.
> It looks to me like the only purpose of omap4_globals is to pass a
> structure to __omap4_set_globals.  Why not use a function 
> argument instead?
Indeed. Actually I just more or less followed what is done for OMAP2/OMAP3 here. I will clean this for OMAP4.

Tony,
We may want to clean up this for OMAP2/OMAP3 as well. Can we add this to the clean up patches planned if any. I can create the patch.

> > +};
> > +static const char *omap4_dm_source_names[] __initdata = {
> > +	"sys_ck",
> > +	"omap_32k_fck",
> > +	NULL
> > +};
> > +static struct clk **omap4_dm_source_clocks[2];
> 
> Umm.  struct clk **[2].
> 
> > +static const int dm_timer_count = ARRAY_SIZE(omap4_dm_timers);
> > +
> >  #else
> >  
> >  #error OMAP architecture not supported!
> > @@ -461,7 +508,8 @@ __u32 
> omap_dm_timer_modify_idlect_mask(__u32 inputmask)
> >  }
> >  EXPORT_SYMBOL_GPL(omap_dm_timer_modify_idlect_mask);
> >  
> > -#elif defined(CONFIG_ARCH_OMAP2) || defined (CONFIG_ARCH_OMAP3)
> > +#elif defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
> > +				defined(CONFIG_ARCH_OMAP4)
> >  
> >  struct clk *omap_dm_timer_get_fclk(struct omap_dm_timer *timer)
> >  {
> > @@ -705,6 +753,10 @@ int __init omap_dm_timer_init(void)
> >  		dm_timers = omap3_dm_timers;
> >  		dm_source_names = (char **)omap3_dm_source_names;
> >  		dm_source_clocks = (struct clk 
> **)omap3_dm_source_clocks;
> > +	} else if (cpu_is_omap44xx()) {
> > +		dm_timers = omap4_dm_timers;
> > +		dm_source_names = (char **)omap4_dm_source_names;
> > +		dm_source_clocks = (struct clk 
> **)omap4_dm_source_clocks;
> 
> which then gets casted to a struct clk **.  These are two different
> objects.  I don't think someone quite understood what they were
> doing here and threw a cast in to shut up the compiler warning:
> 
> 	warning: assignment from incompatible pointer type
> 
> This is *very* wrong and is a prime example of why casts are _bad_
> news.  This cast is saying "THERE IS A BUG HERE" in 100ft 
> high letters.
> 
> What you want is:
> 
> static struct clk *omap4_dm_source_clocks[2];
> ...
> 
> 		dm_source_clocks = omap4_dm_source_clocks;
> 
> This is because struct clk *[] is equivalent to struct clk **.
> (remember that arrays are handled in C as a pointer to the first
> array element.)
> 
> As for the pointer to the array of names, why can't this be declared
> const and therefore that cast be removed?
> 
> TTOTD: Casts are bad news.  It's far better to have stuff correctly
> typed in the first place.

Here again, I followed what is being done for OMAP3 without much thought.

Tony if you agree this can be cleaned up for OMAP1/OMAP2/OMAP3 as well.

> > diff --git a/arch/arm/plat-omap/io.c b/arch/arm/plat-omap/io.c
> > index af326ef..fbd7b3c 100644
> > --- a/arch/arm/plat-omap/io.c
> > +++ b/arch/arm/plat-omap/io.c
> > @@ -1,3 +1,15 @@
> > +/*
> > + * Common io.c file
> > + *
> > + * Copyright (C) 2009 Texas Instruments
> > + * Added OMAP4 support - Santosh Shilimkar 
> <santosh.shilimkar@ti.com>
> > + *
> > + * Based on mach-omap2/board-3430sdp.c
Sure it's not based on board-3430sdp.c
> 
> Err, this is a rubbish header.  It is not based upon board-3430sdp.c.
> The majority of the file is also my own work and unfortunately the
> above addition of TI's copyright makes it look like 100% TIs own
> work.  See commit 690b5a13b27ba3bb2c9d61c1f4018c5074b591e6.
Thanks for pointing out this but the intention was not that. That's why just below the copyright, OMAP4 line is added.
I will add your credits to the header. 

Regards,
Santosh

 