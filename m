From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH] Fix mismatched ifdefs
Date: Mon, 17 Aug 2009 20:26:39 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301D8E1D921@dbde02.ent.ti.com>
References: <1250506755-920-1-git-send-email-premi@ti.com>
 <20090817144526.GA7278@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41130 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750982AbZHQO4s convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Aug 2009 10:56:48 -0400
In-Reply-To: <20090817144526.GA7278@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

 

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com] 
> Sent: Monday, August 17, 2009 8:15 PM
> To: Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH] Fix mismatched ifdefs
> 
> * Sanjeev Premi <premi@ti.com> [090817 13:59]:
> > The #endif at end of the file was missing. However, an
> > additional #else ... #endif was causing the compiler to
> > keep going.
> > 
> > The problem was found when compiler started reporting
> > the newly added inline functions were being reported as
> > redeclared by the compiler.
> > 
> > Signed-off-by: Sanjeev Premi <premi@ti.com>
> > ---
> >  arch/arm/plat-omap/include/mach/cpu.h |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/plat-omap/include/mach/cpu.h 
> b/arch/arm/plat-omap/include/mach/cpu.h
> > index 11e73d9..4fbc6a9 100644
> > --- a/arch/arm/plat-omap/include/mach/cpu.h
> > +++ b/arch/arm/plat-omap/include/mach/cpu.h
> > @@ -317,8 +317,6 @@ IS_OMAP_TYPE(3430, 0x3430)
> >  #  undef  cpu_is_omap730
> >  #  define cpu_is_omap730()		1
> >  # endif
> > -#endif
> > -#else
> 
> Hmm, to me it looks like this should remove the second 
> #endif, but keep the
> #else for the !MULTI_OMAP1 configurations.
> 

[sp] I did the maching as annotated in the snippet below:

#if defined(MULTI_OMAP1)
# if defined(CONFIG_ARCH_OMAP730)
#  undef  cpu_is_omap730
#  define cpu_is_omap730()		is_omap730()
# endif 
# if defined(CONFIG_ARCH_OMAP850)
#  undef  cpu_is_omap850
#  define cpu_is_omap850()		is_omap850()
# endif
#else  /* sp - else for multi-omap1 */
# if defined(CONFIG_ARCH_OMAP730)
#  undef  cpu_is_omap730
#  define cpu_is_omap730()		1
# endif
#endif
#else
  /* sp - seems like needed in the else path of MULTI_OMAP1
   * else the symbol could go undefined.
   */
# if defined(CONFIG_ARCH_OMAP850)
#  undef  cpu_is_omap850
#  define cpu_is_omap850()		1
# endif
#endif

> >  # if defined(CONFIG_ARCH_OMAP850)
> >  #  undef  cpu_is_omap850
> >  #  define cpu_is_omap850()		1
> > @@ -433,3 +431,5 @@ IS_OMAP_TYPE(3430, 0x3430)
> >  
> >  int omap_chip_is(struct omap_chip_id oci);
> >  void omap2_check_revision(void);
> > +
> > +#endif	/* __ASM_ARCH_OMAP_CPU_H */
> 
> And this should not be needed.

[sp] So where does this end:

#ifndef __ASM_ARCH_OMAP_CPU_H
#define __ASM_ARCH_OMAP_CPU_H

I was hitting the problem possibly due to mutiple inclusion of cpu.h

Any static inline function declared at bottom of cpu.h gets the errors like:

arch/arm/plat-omap/include/mach/cpu.h:465: error: redefinition of 'omap3_has_iva'
arch/arm/plat-omap/include/mach/cpu.h:465: error: previous definition of 'omap3_has_iva' was here


> 
> Regards,
> 
> Tony
> 
> > -- 
> > 1.6.2.2
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 