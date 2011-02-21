From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/3] OMAP: smartreflex: move plat/smartreflex.h to
	mach-omap2/smartreflex.h
Date: Sun, 20 Feb 2011 19:08:55 -0700
Message-ID: <20110221020851.7598.57763.stgit@twilight.localdomain>
References: <20110221020231.7598.14024.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:59242 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754994Ab1BUCMH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 20 Feb 2011 21:12:07 -0500
In-Reply-To: <20110221020231.7598.14024.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

There's no reason for this header file to be in
plat-omap/include/plat/smartreflex.h.  The hardware devices are in
OMAP2+ SoCs only.  Leaving this header file in plat-omap causes
problems due to cross-dependencies with other header files that should
live in mach-omap2/.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c    |    2 +-
 arch/arm/mach-omap2/smartreflex-class3.c      |    2 +-
 arch/arm/mach-omap2/smartreflex.c             |    2 +-
 arch/arm/mach-omap2/smartreflex.h             |    0 
 arch/arm/mach-omap2/sr_device.c               |    2 +-
 5 files changed, 4 insertions(+), 4 deletions(-)
 rename arch/arm/{plat-omap/include/plat/smartreflex.h => mach-omap2/smartreflex.h} (100%)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 8d81813..7f0b5e7 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -21,13 +21,13 @@
 #include <plat/l4_3xxx.h>
 #include <plat/i2c.h>
 #include <plat/gpio.h>
-#include <plat/smartreflex.h>
 
 #include "omap_hwmod_common_data.h"
 
 #include "prm-regbits-34xx.h"
 #include "cm-regbits-34xx.h"
 #include "wd_timer.h"
+#include "smartreflex.h"
 
 /*
  * OMAP3xxx hardware module integration data
diff --git a/arch/arm/mach-omap2/smartreflex-class3.c b/arch/arm/mach-omap2/smartreflex-class3.c
index 60e7055..f438cf4 100644
--- a/arch/arm/mach-omap2/smartreflex-class3.c
+++ b/arch/arm/mach-omap2/smartreflex-class3.c
@@ -11,7 +11,7 @@
  * published by the Free Software Foundation.
  */
 
-#include <plat/smartreflex.h>
+#include "smartreflex.h"
 
 static int sr_class3_enable(struct voltagedomain *voltdm)
 {
diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index c37e823..077dfb6 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -26,9 +26,9 @@
 #include <linux/pm_runtime.h>
 
 #include <plat/common.h>
-#include <plat/smartreflex.h>
 
 #include "pm.h"
+#include "smartreflex.h"
 
 #define SMARTREFLEX_NAME_LEN	16
 #define NVALUE_NAME_LEN		40
diff --git a/arch/arm/plat-omap/include/plat/smartreflex.h b/arch/arm/mach-omap2/smartreflex.h
similarity index 100%
rename from arch/arm/plat-omap/include/plat/smartreflex.h
rename to arch/arm/mach-omap2/smartreflex.h
diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr_device.c
index b1e0af1..a636604 100644
--- a/arch/arm/mach-omap2/sr_device.c
+++ b/arch/arm/mach-omap2/sr_device.c
@@ -23,9 +23,9 @@
 #include <linux/io.h>
 
 #include <plat/omap_device.h>
-#include <plat/smartreflex.h>
 #include <plat/voltage.h>
 
+#include "smartreflex.h"
 #include "control.h"
 #include "pm.h"
 


