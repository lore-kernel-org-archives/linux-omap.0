From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH] ARM: OMAP2+: Prevent redefinition errors for soc.h
Date: Fri, 9 Nov 2012 10:19:21 -0600
Message-ID: <1352477961-7634-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53752 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752420Ab2KIQT2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Nov 2012 11:19:28 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

If the header soc.h is included more than once in a source (for example
once directly by the source file and once indirectly by another header
file), then the compiler will generate redefintion errors for the macros
in soc.h. Prevent this by only allowing the content in soc.h to be
included once.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---

Please note that I ran into this problem when rebasing my dmtimer fixes
series [1] on Tony's Linux-OMAP master branch. I am including plat/cpu.h
in dmtimer.h and I found several other files including dmtimer.h are also
including soc.h and so generate a lot of errors.

[1] http://marc.info/?l=linux-omap&m=135231490218361&w=2

 arch/arm/mach-omap2/soc.h |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-omap2/soc.h b/arch/arm/mach-omap2/soc.h
index 0700964..6b270a0 100644
--- a/arch/arm/mach-omap2/soc.h
+++ b/arch/arm/mach-omap2/soc.h
@@ -25,6 +25,9 @@
  *
  */
 
+#ifndef __ARCH_ARM_MACH_OMAP2_SOC_H
+#define __ARCH_ARM_MACH_OMAP2_SOC_H
+
 #include "omap24xx.h"
 #include "omap34xx.h"
 #include "omap44xx.h"
@@ -471,3 +474,4 @@ OMAP4_HAS_FEATURE(mpu_1_5ghz, MPU_1_5GHZ)
 
 #endif	/* __ASSEMBLY__ */
 
+#endif	/* __ARCH_ARM_MACH_OMAP2_SOC_H */
-- 
1.7.9.5

