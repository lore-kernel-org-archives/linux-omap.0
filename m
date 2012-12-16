From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/2] ARM: OMAP2+: Drop plat/cpu.h for omap2plus
Date: Sun, 16 Dec 2012 12:03:17 -0800
Message-ID: <20121216200317.24238.63954.stgit@muffinssi.local>
References: <20121216200236.24238.38151.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:40334 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751569Ab2LPUDW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 16 Dec 2012 15:03:22 -0500
In-Reply-To: <20121216200236.24238.38151.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Mauro Carvalho Chehab <mchehab@redhat.com>, linux-omap@vger.kernel.org, Jean Pihet <jean.pihet@newoldbits.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

The cpu_is_omap macros are now local to arch/arm/mach-omap2
in soc.h and plat/cpu.h can finally be dropped for omap2+.
Thanks everybody for help with fixing the drivers.

Note that we can now also remove the unused plat/cpu.h from
smartreflex.c and isp.c as they will cause compile errors
with ARCH_MULTIPLATFORM enabled.

Cc: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@redhat.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/drm.c             |    1 -
 arch/arm/mach-omap2/dss-common.c      |    3 +--
 arch/arm/mach-omap2/prm2xxx.c         |    3 +--
 arch/arm/mach-omap2/prm3xxx.c         |    3 +--
 arch/arm/plat-omap/include/plat/cpu.h |    4 ----
 drivers/media/platform/omap3isp/isp.c |    2 --
 drivers/power/avs/smartreflex.c       |    2 --
 7 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap2/drm.c b/arch/arm/mach-omap2/drm.c
index fce5aa3..4c7566c 100644
--- a/arch/arm/mach-omap2/drm.c
+++ b/arch/arm/mach-omap2/drm.c
@@ -27,7 +27,6 @@
 
 #include "omap_device.h"
 #include "omap_hwmod.h"
-#include <plat/cpu.h>
 
 #if defined(CONFIG_DRM_OMAP) || (CONFIG_DRM_OMAP_MODULE)
 
diff --git a/arch/arm/mach-omap2/dss-common.c b/arch/arm/mach-omap2/dss-common.c
index 679a047..4be5cfc 100644
--- a/arch/arm/mach-omap2/dss-common.c
+++ b/arch/arm/mach-omap2/dss-common.c
@@ -31,8 +31,7 @@
 #include <video/omap-panel-nokia-dsi.h>
 #include <video/omap-panel-picodlp.h>
 
-#include <plat/cpu.h>
-
+#include "soc.h"
 #include "dss-common.h"
 #include "mux.h"
 
diff --git a/arch/arm/mach-omap2/prm2xxx.c b/arch/arm/mach-omap2/prm2xxx.c
index faeab18..cc0e714 100644
--- a/arch/arm/mach-omap2/prm2xxx.c
+++ b/arch/arm/mach-omap2/prm2xxx.c
@@ -18,9 +18,8 @@
 #include <linux/io.h>
 #include <linux/irq.h>
 
+#include "soc.h"
 #include "common.h"
-#include <plat/cpu.h>
-
 #include "vp.h"
 #include "powerdomain.h"
 #include "clockdomain.h"
diff --git a/arch/arm/mach-omap2/prm3xxx.c b/arch/arm/mach-omap2/prm3xxx.c
index db198d0..39822aa 100644
--- a/arch/arm/mach-omap2/prm3xxx.c
+++ b/arch/arm/mach-omap2/prm3xxx.c
@@ -18,9 +18,8 @@
 #include <linux/io.h>
 #include <linux/irq.h>
 
+#include "soc.h"
 #include "common.h"
-#include <plat/cpu.h>
-
 #include "vp.h"
 #include "powerdomain.h"
 #include "prm3xxx.h"
diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index b4516ab..c9a66bf 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -32,8 +32,4 @@
 #include <mach/soc.h>
 #endif
 
-#ifdef CONFIG_ARCH_OMAP2PLUS
-#include "../../mach-omap2/soc.h"
-#endif
-
 #endif
diff --git a/drivers/media/platform/omap3isp/isp.c b/drivers/media/platform/omap3isp/isp.c
index a9f6de5..2e8c0cb 100644
--- a/drivers/media/platform/omap3isp/isp.c
+++ b/drivers/media/platform/omap3isp/isp.c
@@ -71,8 +71,6 @@
 #include <media/v4l2-common.h>
 #include <media/v4l2-device.h>
 
-#include <plat/cpu.h>
-
 #include "isp.h"
 #include "ispreg.h"
 #include "ispccdc.h"
diff --git a/drivers/power/avs/smartreflex.c b/drivers/power/avs/smartreflex.c
index a17d084..6b2238b 100644
--- a/drivers/power/avs/smartreflex.c
+++ b/drivers/power/avs/smartreflex.c
@@ -27,8 +27,6 @@
 #include <linux/pm_runtime.h>
 #include <linux/power/smartreflex.h>
 
-#include <plat/cpu.h>
-
 #define SMARTREFLEX_NAME_LEN	16
 #define NVALUE_NAME_LEN		40
 #define SR_DISABLE_TIMEOUT	200

