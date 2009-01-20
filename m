From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 2/3v4] Runtime check for OMAP35x
Date: Tue, 20 Jan 2009 07:37:22 -0800
Message-ID: <87ljt66lal.fsf@deeprootsystems.com>
References: <1232120769-7569-1-git-send-email-premi@ti.com>
	<87mydmn9z3.fsf@deeprootsystems.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301C69A03AD@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.247]:61214 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752722AbZATPhx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Jan 2009 10:37:53 -0500
Received: by an-out-0708.google.com with SMTP id c37so77995anc.27
        for <linux-omap@vger.kernel.org>; Tue, 20 Jan 2009 07:37:51 -0800 (PST)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301C69A03AD@dbde02.ent.ti.com> (Sanjeev Premi's message of "Tue\, 20 Jan 2009 17\:55\:21 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Premi, Sanjeev" <premi@ti.com> writes:

> <snip>--<snip>
>
>> > +#ifdef CONFIG_ARCH_OMAP35XX
>> > +static struct omap_globals omap35xx_globals = {
>> > +	.class	= OMAP35XX_CLASS,
>> > +	.tap	= OMAP2_IO_ADDRESS(0x4830A000),
>> > +	.sdrc	= OMAP2_IO_ADDRESS(OMAP343X_SDRC_BASE),
>> > +	.sms	= OMAP2_IO_ADDRESS(OMAP343X_SMS_BASE),
>> > +	.ctrl	= OMAP2_IO_ADDRESS(OMAP343X_CTRL_BASE),
>> > +	.prm	= OMAP2_IO_ADDRESS(OMAP3430_PRM_BASE),
>> > +	.cm	= OMAP2_IO_ADDRESS(OMAP3430_CM_BASE),
>> > +};
>> 
>> This is exactly the same as omap34xx_globals.  Why is this needed?
>

> [sp] I have tried to add minimal support for OMAP35x. Since OMAP34x
> and OMAP35x seem to be compatible today, this structure seems
> same. As more code for specific OMAP35x variants comes in, I expect
> this to change.
>
> The key difference here (as against OMAP34x) is use of
> OMAP35XX_CLASS; which helps in identifying the different OMAP
> variants. We could have 're-used' OMAP35XX_CLASS, it I wouldn't be
> right as this definition is used to print the CPU name and Si
> version in id.c.
>
> With this patch, boot log with show (for example) "OMAP3530 ES2.1"
> on the OMAP3530 EVM - which can be considered same as OMAP3430
> ES2.1; but with 3503, 3515 and 3525 the print would read 3403, 3415,
> 3425 resp; this definitley would not be right.

I was not asking about the patch as a whole, I was commenting only on
the addition of the omap35xx_globals variable.  You added a new
struct which is exactly the same as the 35xx struct instead of
just re-using the old one with a new name as I suggested.

Kevin

>> 
>> > +
>> > +void __init omap2_set_globals_35xx(void) {
>> > +	omap2_globals = &omap35xx_globals;
>> > +
>> > +	__omap2_set_globals();
>> > +}
>> > +#endif	/* CONFIG_ARCH_OMAP35XX */
>> > +
>> 
>> What is the problem of the init code just leaving
>> omap2_set_globals_343x()
>> 
>> If you really think this will confuse folks, then how about 
>> just changing the #ifdef of the 343x defines to:
>> 
>> #if defined(CONFIG_ARCH_OMAP3430) || defined(CONFIG_ARCH_OMAP35XX)
>> 
>> and then adding this:
>> 
>> #define omap2_set_globals_35xx omap2_set_globals_343x()
>> 
>> Kevin
>> 
>> > diff --git a/arch/arm/plat-omap/include/mach/common.h 
>> > b/arch/arm/plat-omap/include/mach/common.h
>> > index af4105f..f41cba2 100644
>> > --- a/arch/arm/plat-omap/include/mach/common.h
>> > +++ b/arch/arm/plat-omap/include/mach/common.h
>> > @@ -60,6 +60,7 @@ struct omap_globals {  void 
>> > omap2_set_globals_242x(void);  void omap2_set_globals_243x(void);  
>> > void omap2_set_globals_343x(void);
>> > +void omap2_set_globals_35xx(void);
>> >  
>> >  /* These get called from omap2_set_globals_xxxx(), do not 
>> call these 
>> > */  void omap2_set_globals_tap(struct omap_globals *); diff --git 
>> > a/arch/arm/plat-omap/include/mach/cpu.h 
>> > b/arch/arm/plat-omap/include/mach/cpu.h
>> > index b2062f1..447e053 100644
>> > --- a/arch/arm/plat-omap/include/mach/cpu.h
>> > +++ b/arch/arm/plat-omap/include/mach/cpu.h
>> > @@ -93,7 +93,7 @@ unsigned int omap_rev(void);  #  define OMAP_NAME 
>> > omap2430  # endif  #endif -#ifdef CONFIG_ARCH_OMAP3430
>> > +#if defined(CONFIG_ARCH_OMAP3430) && !defined(CONFIG_ARCH_OMAP35XX)
>> >  # ifdef OMAP_NAME
>> >  #  undef  MULTI_OMAP2
>> >  #  define MULTI_OMAP2
>> > @@ -102,6 +102,46 @@ unsigned int omap_rev(void);  # endif  #endif
>> >  
>> > +#ifdef CONFIG_ARCH_OMAP35XX
>> > +# ifdef CONFIG_ARCH_OMAP3503
>> > +#  ifdef OMAP_NAME
>> > +#   undef  MULTI_OMAP2
>> > +#   define MULTI_OMAP2
>> > +#  else
>> > +#   define OMAP_NAME omap3503
>> > +#  endif
>> > +# endif  /* ifdef CONFIG_ARCH_OMAP3503 */
>> > +
>> > +# ifdef CONFIG_ARCH_OMAP3515
>> > +#  ifdef OMAP_NAME
>> > +#   undef  MULTI_OMAP2
>> > +#   define MULTI_OMAP2
>> > +#  else
>> > +#   define OMAP_NAME omap3515
>> > +#  endif
>> > +# endif  /* ifdef CONFIG_ARCH_OMAP3515 */
>> > +
>> > +# ifdef CONFIG_ARCH_OMAP3525
>> > +#  ifdef OMAP_NAME
>> > +#   undef  MULTI_OMAP2
>> > +#   define MULTI_OMAP2
>> > +#  else
>> > +#   define OMAP_NAME omap3525
>> > +#  endif
>> > +# endif  /* ifdef CONFIG_ARCH_OMAP3525 */
>> > +
>> > +# ifdef CONFIG_ARCH_OMAP3530
>> > +#  ifdef OMAP_NAME
>> > +#   undef  MULTI_OMAP2
>> > +#   define MULTI_OMAP2
>> > +#  else
>> > +#   define OMAP_NAME omap3530
>> > +#  endif
>> > +# endif  /* ifdef CONFIG_ARCH_OMAP3530 */
>> > +
>> > +#endif  /* ifdef CONFIG_ARCH_OMAP35XX */
>> > +
>> > +
>> >  /*
>> >   * Macros to group OMAP into cpu classes.
>> >   * These can be used in most places.
>> > @@ -112,6 +152,7 @@ unsigned int omap_rev(void);
>> >   * cpu_is_omap242x():	True for OMAP2420, OMAP2422, OMAP2423
>> >   * cpu_is_omap243x():	True for OMAP2430
>> >   * cpu_is_omap343x():	True for OMAP3430
>> > + * cpu_is_omap35xx():	True for OMAP35XX
>> >   */
>> >  #define GET_OMAP_CLASS	(omap_rev() & 0xff)
>> >  
>> > @@ -147,6 +188,7 @@ IS_OMAP_SUBCLASS(343x, 0x343)
>> >  #define cpu_is_omap243x()		0
>> >  #define cpu_is_omap34xx()		0
>> >  #define cpu_is_omap343x()		0
>> > +#define cpu_is_omap35xx()		0
>> >  
>> >  #if defined(MULTI_OMAP1)
>> >  # if defined(CONFIG_ARCH_OMAP730)
>> > @@ -191,6 +233,10 @@ IS_OMAP_SUBCLASS(343x, 0x343)
>> >  #  define cpu_is_omap34xx()		is_omap34xx()
>> >  #  define cpu_is_omap343x()		is_omap343x()
>> >  # endif
>> > +# if defined(CONFIG_ARCH_OMAP35XX)
>> > +#  undef  cpu_is_omap35xx
>> > +#  define cpu_is_omap35xx()		is_omap35xx()
>> > +# endif
>> >  #else
>> >  # if defined(CONFIG_ARCH_OMAP24XX)
>> >  #  undef  cpu_is_omap24xx
>> > @@ -212,6 +258,10 @@ IS_OMAP_SUBCLASS(343x, 0x343)  #  undef  
>> > cpu_is_omap343x
>> >  #  define cpu_is_omap343x()		1
>> >  # endif
>> > +# if defined(CONFIG_ARCH_OMAP35XX)
>> > +#  undef  cpu_is_omap35xx
>> > +#  define cpu_is_omap35xx()		1
>> > +# endif
>> >  #endif
>> >  
>> >  /*
>> > @@ -230,7 +280,11 @@ IS_OMAP_SUBCLASS(343x, 0x343)
>> >   * cpu_is_omap2423():	True for OMAP2423
>> >   * cpu_is_omap2430():	True for OMAP2430
>> >   * cpu_is_omap3430():	True for OMAP3430
>> > - */
>> > + * cpu_is_omap3503():	True for OMAP3503
>> > + * cpu_is_omap3515():	True for OMAP3515
>> > + * cpu_is_omap3525():	True for OMAP3525
>> > + * cpu_is_omap3530():	True for OMAP3530
>> > + */;
>> >  #define GET_OMAP_TYPE	((omap_rev() >> 16) & 0xffff)
>> >  
>> >  #define IS_OMAP_TYPE(type, id)				\
>> > @@ -252,6 +306,10 @@ IS_OMAP_TYPE(2422, 0x2422)  IS_OMAP_TYPE(2423, 
>> > 0x2423)  IS_OMAP_TYPE(2430, 0x2430)  IS_OMAP_TYPE(3430, 0x3430)
>> > +IS_OMAP_TYPE(3503, 0x3503)
>> > +IS_OMAP_TYPE(3515, 0x3515)
>> > +IS_OMAP_TYPE(3525, 0x3525)
>> > +IS_OMAP_TYPE(3530, 0x3530)
>> >  
>> >  #define cpu_is_omap310()		0
>> >  #define cpu_is_omap730()		0
>> > @@ -266,6 +324,10 @@ IS_OMAP_TYPE(3430, 0x3430)
>> >  #define cpu_is_omap2423()		0
>> >  #define cpu_is_omap2430()		0
>> >  #define cpu_is_omap3430()		0
>> > +#define cpu_is_omap3503()		0
>> > +#define cpu_is_omap3515()		0
>> > +#define cpu_is_omap3525()		0
>> > +#define cpu_is_omap3530()		0
>> >  
>> >  #if defined(MULTI_OMAP1)
>> >  # if defined(CONFIG_ARCH_OMAP730)
>> > @@ -319,6 +381,18 @@ IS_OMAP_TYPE(3430, 0x3430)
>> >  # define cpu_is_omap3430()		is_omap3430()
>> >  #endif
>> >  
>> > +#if defined(CONFIG_ARCH_OMAP35XX)
>> > +# undef cpu_is_omap3503
>> > +# undef cpu_is_omap3515
>> > +# undef cpu_is_omap3525
>> > +# undef cpu_is_omap3530
>> > +
>> > +# define cpu_is_omap3503()		is_omap3503()
>> > +# define cpu_is_omap3515()		is_omap3515()
>> > +# define cpu_is_omap3525()		is_omap3525()
>> > +# define cpu_is_omap3530()		is_omap3530()
>> > +#endif	/* if defined(CONFIG_ARCH_OMAP35XX) */
>> > +
>> >  /* Macros to detect if we have OMAP1 or OMAP2 */
>> >  #define cpu_class_is_omap1()	(cpu_is_omap730() || 
>> cpu_is_omap15xx() || \
>> >  				cpu_is_omap16xx())
>> > @@ -340,6 +414,16 @@ IS_OMAP_TYPE(3430, 0x3430)
>> >  #define OMAP3430_REV_ES2_1	0x34302034
>> >  #define OMAP3430_REV_ES3_0	0x34303034
>> >  
>> > +#define OMAP35XX_CLASS		0x35000035
>> > +#define OMAP3503_MASK		0x00030000
>> > +#define OMAP3515_MASK		0x00150000
>> > +#define OMAP3525_MASK		0x00250000
>> > +#define OMAP3530_MASK		0x00300000
>> > +
>> > +#define OMAP35XX_MASK_ES2_0	0x00001000
>> > +#define OMAP35XX_MASK_ES2_1	0x00002000
>> > +#define OMAP35XX_MASK_ES3_0	0x00003000
>> > +
>> >  /*
>> >   * omap_chip bits
>> >   *
>> > --
>> > 1.5.6
>> >
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe 
>> linux-omap" 
>> > in the body of a message to majordomo@vger.kernel.org More 
>> majordomo 
>> > info at  http://vger.kernel.org/majordomo-info.html
>> 
>> 
