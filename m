From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] omap: Fix incorrect 730 vs 850 detection, v2 (Re: Patch
	missing in 2.6.32-rc1)
Date: Tue, 29 Sep 2009 17:32:19 -0700
Message-ID: <20090930003218.GH16865@atomide.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301DCD67D97@dbde02.ent.ti.com> <1250677938-27955-1-git-send-email-felipe.balbi@nokia.com> <B85A65D85D7EB246BE421B3FB0FBB59301DD1AD8FB@dbde02.ent.ti.com> <20090819131752.GC7629@atomide.com> <B85A65D85D7EB246BE421B3FB0FBB59301DDAB3F19@dbde02.ent.ti.com> <20090929203525.GF16865@atomide.com> <3d374d00909291652m3f52fbf6y1ea45ac7bec99018@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="3lcZGd9BuhuYXNfi"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:55969 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753626AbZI3AcV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Sep 2009 20:32:21 -0400
Content-Disposition: inline
In-Reply-To: <3d374d00909291652m3f52fbf6y1ea45ac7bec99018@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alistair Buxton <a.j.buxton@gmail.com>
Cc: "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


--3lcZGd9BuhuYXNfi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

* Alistair Buxton <a.j.buxton@gmail.com> [090929 16:52]:
> 2009/9/29 Tony Lindgren <tony@atomide.com>:
> > * Premi, Sanjeev <premi@ti.com> [090929 04:34]:
> >> Hi Tony,
> >>
> >> Can you push this patch to 2.6.32-rc1?
> >>
> >> 7a8d53a0:  arch: arm: omap: terminate ifndef
> >>
> >> I was unable to refresh my patches against this baseline.
> >> OR, is it okay if I re-submit against the 'master'.
> >
> > Sorry, I was meaning to look where the mismatch really came
> > from but forgot.
> >
> > Looks like adding omap850 support added an #else without removing
> > the #endif above it, and also removed another #endif in commit
> > ae302f40061235f6bc58ae9ba02aa849d60223b5.
> 
> The #else immediately after the removed #endif needs to go as well,
> because the block that the #endif(s) belongs to already has an #else.
> 
> That means the bug not only caused everything after the extra #endif
> to have no multiple inclusion protection (causing the redefinitions),
> but the extra #else also caused cpu_is_omap850() to be true only when
> cpu.h was included twice.

Ah, right! So we're back to http://patchwork.kernel.org/patch/42292/
and we also need to add back the missing #endif to the end of file
file.

Here's an updated version of 42292, hopefully this will do the trick.

Regards,

Tony

--3lcZGd9BuhuYXNfi
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="fix-cpu-omap850-endif.patch"

>From 980dda1d160a665c4cbe62c583333448449573a4 Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Tue, 29 Sep 2009 17:22:11 -0700
Subject: [PATCH] omap: Fix incorrect 730 vs 850 detection

Commit cd92204924fafbd5c7241dfd12ca3176d542e0c5 added
support for omap850. However, the patch accidentally
removed the wrong ifdef:

 #  define cpu_is_omap730()		1
 # endif
 #endif
+#else
+# if defined(CONFIG_ARCH_OMAP850)
+#  undef  cpu_is_omap850
+#  define cpu_is_omap850()		1
+# endif
+#endif

...

 void omap2_check_revision(void);

 #endif    /* defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) */
-
-#endif

Instead of removing removing the #endif at the end of the file,
the #endif before #else should have been removed.

But we cannot have multiple #else statements as pointed out by
Alistair Buxton <a.j.buxton@gmail.com>. So the fix is to:

- remove the non-multi-omap special handling, as we need to
  detect between omap730 and omap850 anyways.

- add the missing #endif back to the end of the file

Reported-by: Sanjeev Premi <premi@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/plat-omap/include/mach/cpu.h b/arch/arm/plat-omap/include/mach/cpu.h
index 11e73d9..f129efb 100644
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
@@ -433,3 +422,5 @@ IS_OMAP_TYPE(3430, 0x3430)
 
 int omap_chip_is(struct omap_chip_id oci);
 void omap2_check_revision(void);
+
+#endif

--3lcZGd9BuhuYXNfi--
