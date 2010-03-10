From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 1/2] OMAP2: cpu_is_omap2*: fix compile-time removal of unused code.
Date: Wed, 10 Mar 2010 09:16:30 -0800
Message-ID: <1268241391-26312-2-git-send-email-khilman@deeprootsystems.com>
References: <1268241391-26312-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f194.google.com ([209.85.222.194]:51554 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756589Ab0CJRQm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Mar 2010 12:16:42 -0500
Received: by mail-pz0-f194.google.com with SMTP id 32so221983pzk.4
        for <linux-omap@vger.kernel.org>; Wed, 10 Mar 2010 09:16:42 -0800 (PST)
In-Reply-To: <1268241391-26312-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Currently if omap2420 is defined but not omap2430, cpu_is_omap2430()
is still defined as a macro, instead of #define'd to zero.  This
results in conditional cpu_is_omap2430() code still being compiled,
and leads to possible compile/link errors.  In particular for hwmod
init.

To fix, add extra #ifdefs to CPU check macros to ensure that the
is_omap* macros are zero for each OMAP2 if they are not configured
into the kernel.

Tested-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
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
1.7.0.2

