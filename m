From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/2] ARM: OMAP2+: Drop remaining plat/cpu.h usage where
 possible
Date: Fri, 14 Dec 2012 11:44:50 -0800
Message-ID: <20121214194450.9874.57095.stgit@muffinssi.local>
References: <20121214194325.9874.95898.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:11817 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932237Ab2LNTov (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Dec 2012 14:44:51 -0500
In-Reply-To: <20121214194325.9874.95898.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, Jean Pihet <jean.pihet@newoldbits.com>

These macros are now in local soc.h in arch/arm/mach-omap2,
and plat/cpu.h is around only until the remaining drivers
are fixed.

Also remove the unused plat/cpu.h from smartreflex.c as it
will cause compile errors with ARCH_MULTIPLATFORM enabled.

Cc: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/drm.c        |    1 -
 arch/arm/mach-omap2/dss-common.c |    3 +--
 arch/arm/mach-omap2/prm2xxx.c    |    3 +--
 arch/arm/mach-omap2/prm3xxx.c    |    3 +--
 drivers/power/avs/smartreflex.c  |    2 --
 5 files changed, 3 insertions(+), 9 deletions(-)

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

