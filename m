From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [RESUBMIT][PATCH 4/7] OMAP4: Update common omap platform	common
 sources.
Date: Mon, 18 May 2009 17:37:24 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02B49CB490@dbde02.ent.ti.com>
References: <1241677756-28756-1-git-send-email-santosh.shilimkar@ti.com>
 <1241677756-28756-2-git-send-email-santosh.shilimkar@ti.com>
 <1241677756-28756-3-git-send-email-santosh.shilimkar@ti.com>
 <1241677756-28756-4-git-send-email-santosh.shilimkar@ti.com>
 <20090516095332.GH15328@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46214 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755317AbZERMHl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 May 2009 08:07:41 -0400
In-Reply-To: <20090516095332.GH15328@n2100.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Russell,

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

OK. I will fix this for OMAP4 now. Will create patch for OMAP2/3 bit later.

> As for the pointer to the array of names, why can't this be declared
> const and therefore that cast be removed?
I am sorry but didn't get this point. 
dm_source_names = (char **)omap4_dm_source_names; 
In this 'omap4_dm_source_names' is already const. The problem is dm_source_names is declared as 'char ** ' and hence compiler cribs for right reasons without cast.

Did you mean don't declare 'omap4_dm_source_name' as const ?

> TTOTD: Casts are bad news.  It's far better to have stuff correctly
> typed in the first place.

Regards,
Santosh
  
