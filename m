From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 2/2] ARM: OMAP: Remove definition cpu_is_omap4430()
Date: Thu, 1 Mar 2012 19:10:32 -0600
Message-ID: <1330650632-10919-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51203 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756069Ab2CBBKf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 1 Mar 2012 20:10:35 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, manjugk@ti.com, Jon Hunter <jon-hunter@ti.com>

From: Jon Hunter <jon-hunter@ti.com>

The definition cpu_is_omap4430() always returns 0 even when CONFIG_ARCH_OMAP4
is enabled. This macro should be removed and the macro cpu_is_omap443x() should
be used where needed for OMAP4430 devices.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/plat-omap/include/plat/cpu.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index 6b51086..4f18eae 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -250,7 +250,6 @@ IS_AM_SUBCLASS(335x, 0x335)
  * cpu_is_omap2423():	True for OMAP2423
  * cpu_is_omap2430():	True for OMAP2430
  * cpu_is_omap3430():	True for OMAP3430
- * cpu_is_omap4430():	True for OMAP4430
  * cpu_is_omap3505():	True for OMAP3505
  * cpu_is_omap3517():	True for OMAP3517
  */
@@ -299,7 +298,6 @@ IS_OMAP_TYPE(3517, 0x3517)
 #define cpu_is_omap3505()		0
 #define cpu_is_omap3517()		0
 #define cpu_is_omap3430()		0
-#define cpu_is_omap4430()		0
 #define cpu_is_omap3630()		0
 
 /*
-- 
1.7.1

