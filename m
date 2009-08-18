From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] OMAP: Fix incorrect 730 vs 850 detection (Re: [PATCH] Fix
	mismatched ifdefs)
Date: Tue, 18 Aug 2009 13:00:03 +0300
Message-ID: <20090818100002.GC17595@atomide.com>
References: <1250506755-920-1-git-send-email-premi@ti.com> <20090817144526.GA7278@atomide.com> <B85A65D85D7EB246BE421B3FB0FBB59301D8E1D921@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="RnlQjJ0d97Da+TV1"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:59814 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752164AbZHRKAG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Aug 2009 06:00:06 -0400
Content-Disposition: inline
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301D8E1D921@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Premi, Sanjeev <premi@ti.com> [090817 17:56]:
>  
> 
> > -----Original Message-----
> > From: Tony Lindgren [mailto:tony@atomide.com] 
> > Sent: Monday, August 17, 2009 8:15 PM
> > To: Premi, Sanjeev
> > Cc: linux-omap@vger.kernel.org
> > Subject: Re: [PATCH] Fix mismatched ifdefs
> > 
> > * Sanjeev Premi <premi@ti.com> [090817 13:59]:
> > > The #endif at end of the file was missing. However, an
> > > additional #else ... #endif was causing the compiler to
> > > keep going.
> > > 
> > > The problem was found when compiler started reporting
> > > the newly added inline functions were being reported as
> > > redeclared by the compiler.
> > > 
> > > Signed-off-by: Sanjeev Premi <premi@ti.com>
> > > ---
> > >  arch/arm/plat-omap/include/mach/cpu.h |    4 ++--
> > >  1 files changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/arch/arm/plat-omap/include/mach/cpu.h 
> > b/arch/arm/plat-omap/include/mach/cpu.h
> > > index 11e73d9..4fbc6a9 100644
> > > --- a/arch/arm/plat-omap/include/mach/cpu.h
> > > +++ b/arch/arm/plat-omap/include/mach/cpu.h
> > > @@ -317,8 +317,6 @@ IS_OMAP_TYPE(3430, 0x3430)
> > >  #  undef  cpu_is_omap730
> > >  #  define cpu_is_omap730()		1
> > >  # endif
> > > -#endif
> > > -#else
> > 
> > Hmm, to me it looks like this should remove the second 
> > #endif, but keep the
> > #else for the !MULTI_OMAP1 configurations.
> > 
> 
> [sp] I did the maching as annotated in the snippet below:
> 
> #if defined(MULTI_OMAP1)
> # if defined(CONFIG_ARCH_OMAP730)
> #  undef  cpu_is_omap730
> #  define cpu_is_omap730()		is_omap730()
> # endif 
> # if defined(CONFIG_ARCH_OMAP850)
> #  undef  cpu_is_omap850
> #  define cpu_is_omap850()		is_omap850()
> # endif
> #else  /* sp - else for multi-omap1 */
> # if defined(CONFIG_ARCH_OMAP730)
> #  undef  cpu_is_omap730
> #  define cpu_is_omap730()		1
> # endif
> #endif
> #else
>   /* sp - seems like needed in the else path of MULTI_OMAP1
>    * else the symbol could go undefined.
>    */
> # if defined(CONFIG_ARCH_OMAP850)
> #  undef  cpu_is_omap850
> #  define cpu_is_omap850()		1
> # endif
> #endif
> 
> > >  # if defined(CONFIG_ARCH_OMAP850)
> > >  #  undef  cpu_is_omap850
> > >  #  define cpu_is_omap850()		1
> > > @@ -433,3 +431,5 @@ IS_OMAP_TYPE(3430, 0x3430)
> > >  
> > >  int omap_chip_is(struct omap_chip_id oci);
> > >  void omap2_check_revision(void);
> > > +
> > > +#endif	/* __ASM_ARCH_OMAP_CPU_H */
> > 
> > And this should not be needed.
> 
> [sp] So where does this end:
> 
> #ifndef __ASM_ARCH_OMAP_CPU_H
> #define __ASM_ARCH_OMAP_CPU_H
> 
> I was hitting the problem possibly due to mutiple inclusion of cpu.h
> 
> Any static inline function declared at bottom of cpu.h gets the errors like:
> 
> arch/arm/plat-omap/include/mach/cpu.h:465: error: redefinition of 'omap3_has_iva'
> arch/arm/plat-omap/include/mach/cpu.h:465: error: previous definition of 'omap3_has_iva' was here

Here's what I think is the right fix to this, the extra endif got introduced
with the 850 patch. Removing that is not the right fix still, we just need to
remove the special case for 730 as now we need to detect between 730 and 850.

Can please you try the attached patch?

Regards,

Tony

--RnlQjJ0d97Da+TV1
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="fix-730-850-detect.patch"

>From 751797cca47c9ccb5443190a0f3d82924ee1eaeb Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Tue, 18 Aug 2009 12:57:06 +0300
Subject: [PATCH] OMAP: Fix incorrect 730 vs 850 detection

Commit ae302f40 introduced support for omap850 but had a bug in
ifdef handling of the non-multi-omap case for 730 and 850.

Fix the problem by removing the non-multi-omap special handling,
as we need to detect between omap730 and omap850 anyways.

Problem reported by Sanjeev Premi <premi@ti.com>.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/plat-omap/include/mach/cpu.h b/arch/arm/plat-omap/include/mach/cpu.h
index 11e73d9..61dbe90 100644
--- a/arch/arm/plat-omap/include/mach/cpu.h
+++ b/arch/arm/plat-omap/include/mach/cpu.h
@@ -303,32 +303,21 @@ IS_OMAP_TYPE(3430, 0x3430)
 #define cpu_is_omap2430()		0
 #define cpu_is_omap3430()		0
 
-#if defined(MULTI_OMAP1)
-# if defined(CONFIG_ARCH_OMAP730)
-#  undef  cpu_is_omap730
-#  define cpu_is_omap730()		is_omap730()
-# endif
-# if defined(CONFIG_ARCH_OMAP850)
-#  undef  cpu_is_omap850
-#  define cpu_is_omap850()		is_omap850()
-# endif
-#else
-# if defined(CONFIG_ARCH_OMAP730)
-#  undef  cpu_is_omap730
-#  define cpu_is_omap730()		1
-# endif
-#endif
-#else
-# if defined(CONFIG_ARCH_OMAP850)
-#  undef  cpu_is_omap850
-#  define cpu_is_omap850()		1
-# endif
-#endif
-
 /*
  * Whether we have MULTI_OMAP1 or not, we still need to distinguish
- * between 330 vs. 1510 and 1611B/5912 vs. 1710.
+ * between 730 vs 850, 330 vs. 1510 and 1611B/5912 vs. 1710.
  */
+
+#if defined(CONFIG_ARCH_OMAP730)
+# undef  cpu_is_omap730
+# define cpu_is_omap730()		is_omap730()
+#endif
+
+#if defined(CONFIG_ARCH_OMAP850)
+# undef  cpu_is_omap850
+# define cpu_is_omap850()		is_omap850()
+#endif
+
 #if defined(CONFIG_ARCH_OMAP15XX)
 # undef  cpu_is_omap310
 # undef  cpu_is_omap1510

--RnlQjJ0d97Da+TV1--
