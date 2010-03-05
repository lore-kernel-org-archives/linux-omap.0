From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH] OMAP2: fix cpu_is_omap24* optimizations
Date: Fri,  5 Mar 2010 15:37:12 -0800
Message-ID: <1267832232-26187-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f199.google.com ([209.85.221.199]:41744 "EHLO
	mail-qy0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755407Ab0CEXpA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Mar 2010 18:45:00 -0500
Received: by qyk37 with SMTP id 37so2841922qyk.20
        for <linux-omap@vger.kernel.org>; Fri, 05 Mar 2010 15:45:00 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Currently if omap2420 is defined but not omap2430, cpu_is_omap2430()
is still defined as a macro, instead of #define'd to zero.  This
results in conditional cpu_is_omap2430() code still being compiled,
and leads to possible compile/link errors.  In particular for hwmod
init calls in io.c

To fix, add extra #ifdefs to CPU check macros to ensure that the
is_omap* macros are zero for each OMAP2 if they are not configured
into the kernel.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/plat-omap/include/plat/cpu.h |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index ed8786c..7514174 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -167,10 +167,14 @@ IS_OMAP_SUBCLASS(443x, 0x443)
 #if defined(MULTI_OMAP2)
 # if defined(CONFIG_ARCH_OMAP2)
 #  undef  cpu_is_omap24xx
-#  undef  cpu_is_omap242x
-#  undef  cpu_is_omap243x
 #  define cpu_is_omap24xx()		is_omap24xx()
+# endif
+# if defined (CONFIG_ARCH_OMAP2420)
+#  undef  cpu_is_omap242x
 #  define cpu_is_omap242x()		is_omap242x()
+# endif
+# if defined (CONFIG_ARCH_OMAP2430)
+#  undef  cpu_is_omap243x
 #  define cpu_is_omap243x()		is_omap243x()
 # endif
 # if defined(CONFIG_ARCH_OMAP3)
-- 
1.6.6

