From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [RFC/PATCH] OMAP PM: remove OMAP_PM_NONE config option
Date: Fri,  6 May 2011 11:11:27 +0200
Message-ID: <1304673087-24643-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:39601 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755312Ab1EFJLu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 May 2011 05:11:50 -0400
Received: by wwa36 with SMTP id 36so3294797wwa.1
        for <linux-omap@vger.kernel.org>; Fri, 06 May 2011 02:11:49 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com
Cc: Jean Pihet <j-pihet@ti.com>

The current code base is not linking with the OMAP_PM_NONE
option set.
Since the option OMAP_PM_NOOP provides a no-op/debug layer,
OMAP_PM_NONE can be removed.
OMAP_PM_NOOP is enabled by default by Kconfig.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/plat-omap/Kconfig                |    3 ---
 arch/arm/plat-omap/include/plat/omap-pm.h |    8 --------
 2 files changed, 0 insertions(+), 11 deletions(-)

diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index cd5f993..16e3293 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -209,9 +209,6 @@ choice
 	depends on ARCH_OMAP
 	default OMAP_PM_NOOP
 
-config OMAP_PM_NONE
-	bool "No PM layer"
-
 config OMAP_PM_NOOP
 	bool "No-op/debug PM layer"
 
diff --git a/arch/arm/plat-omap/include/plat/omap-pm.h b/arch/arm/plat-omap/include/plat/omap-pm.h
index c0a7520..0840df8 100644
--- a/arch/arm/plat-omap/include/plat/omap-pm.h
+++ b/arch/arm/plat-omap/include/plat/omap-pm.h
@@ -40,11 +40,7 @@
  * framework starts.  The "_if_" is to avoid name collisions with the
  * PM idle-loop code.
  */
-#ifdef CONFIG_OMAP_PM_NONE
-#define omap_pm_if_early_init() 0
-#else
 int __init omap_pm_if_early_init(void);
-#endif
 
 /**
  * omap_pm_if_init - OMAP PM init code called after clock fw init
@@ -52,11 +48,7 @@ int __init omap_pm_if_early_init(void);
  * The main initialization code.  OPP tables are passed in here.  The
  * "_if_" is to avoid name collisions with the PM idle-loop code.
  */
-#ifdef CONFIG_OMAP_PM_NONE
-#define omap_pm_if_init() 0
-#else
 int __init omap_pm_if_init(void);
-#endif
 
 /**
  * omap_pm_if_exit - OMAP PM exit code
-- 
1.7.1

