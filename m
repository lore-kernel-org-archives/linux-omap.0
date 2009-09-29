From: Tony Lindgren <tony@atomide.com>
Subject: Re: Patch missing in 2.6.32-rc1
Date: Tue, 29 Sep 2009 13:35:25 -0700
Message-ID: <20090929203525.GF16865@atomide.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301DCD67D97@dbde02.ent.ti.com> <1250677938-27955-1-git-send-email-felipe.balbi@nokia.com> <B85A65D85D7EB246BE421B3FB0FBB59301DD1AD8FB@dbde02.ent.ti.com> <20090819131752.GC7629@atomide.com> <B85A65D85D7EB246BE421B3FB0FBB59301DDAB3F19@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ikeVEW9yuYc//A+q"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:55406 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919AbZI2UfY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Sep 2009 16:35:24 -0400
Content-Disposition: inline
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DDAB3F19@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Premi, Sanjeev <premi@ti.com> [090929 04:34]:
> Hi Tony,
> 
> Can you push this patch to 2.6.32-rc1?
> 
> 7a8d53a0:  arch: arm: omap: terminate ifndef
> 
> I was unable to refresh my patches against this baseline.
> OR, is it okay if I re-submit against the 'master'.

Sorry, I was meaning to look where the mismatch really came
from but forgot.

Looks like adding omap850 support added an #else without removing
the #endif above it, and also removed another #endif in commit
ae302f40061235f6bc58ae9ba02aa849d60223b5.

I added some more comments to your original patch, see below.

I did not notice earlier that adding omap850 also accidentally did
both changes. So I was wondering where the second change came
from..

Can you please check that this patch is still OK?

Regards,

Tony

--ikeVEW9yuYc//A+q
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="fix-cpu-omap850-endif.patch"

>From 64fd0b5983e2b6f6bcf3ff66dc6b011b2c6d3c02 Mon Sep 17 00:00:00 2001
From: Sanjeev Premi <premi@ti.com>
Date: Tue, 29 Sep 2009 13:21:26 -0700
Subject: [PATCH] omap: Fix mismatched ifdefs

The #endif at end of the file was missing. However, an
additional #else ... #endif was causing the compiler to
keep going.

The problem was found when compiler started reporting
the newly added inline functions were being reported as
redeclared by the compiler.

This was caused by cd92204924fafbd5c7241dfd12ca3176d542e0c5
that added support for omap850. However, the patch
accidentally removed the wrong ifdef:

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

Signed-off-by: Sanjeev Premi <premi@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/plat-omap/include/mach/cpu.h b/arch/arm/plat-omap/include/mach/cpu.h
index 11e73d9..1acc4ec 100644
--- a/arch/arm/plat-omap/include/mach/cpu.h
+++ b/arch/arm/plat-omap/include/mach/cpu.h
@@ -317,7 +317,6 @@ IS_OMAP_TYPE(3430, 0x3430)
 #  undef  cpu_is_omap730
 #  define cpu_is_omap730()		1
 # endif
-#endif
 #else
 # if defined(CONFIG_ARCH_OMAP850)
 #  undef  cpu_is_omap850
@@ -433,3 +432,5 @@ IS_OMAP_TYPE(3430, 0x3430)
 
 int omap_chip_is(struct omap_chip_id oci);
 void omap2_check_revision(void);
+
+#endif

--ikeVEW9yuYc//A+q--
