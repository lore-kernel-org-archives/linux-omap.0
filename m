From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 6/7] watchdog: OMAP: use standard GETBOOTSTATUS interface;
 use platform_data fn ptr
Date: Mon, 15 Oct 2012 19:32:53 -0600
Message-ID: <20121016013233.21844.1279.stgit@dusk.lan>
References: <20121016012448.21844.92339.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:42862 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755532Ab2JPBe3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Oct 2012 21:34:29 -0400
In-Reply-To: <20121016012448.21844.92339.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org

Previously the OMAP watchdog driver used a non-standard way to report
the chip reset source via the GETBOOTSTATUS ioctl.  This patch
converts the driver to use the standard WDIOF_* flags for this
purpose.

This patch may break existing userspace code that uses the existing
non-standard data format returned by the OMAP watchdog driver's
GETBOOTSTATUS ioctl.  To fetch detailed reset source information,
userspace code will need to retrieve it directly from the CGRM or PRM
drivers when those are completed.

Previously, to fetch the reset source, the driver either read a
register outside the watchdog IP block (OMAP1), or called a function
exported directly from arch/arm/mach-omap2.  Both approaches are
broken.  This patch also converts the driver to use a platform_data
function pointer.  This approach is temporary, and is due to the lack
of drivers for the OMAP16xx+ Clock Generation and Reset Management IP
block and the OMAP2+ Power and Reset Management IP block.  Once
drivers are available for those IP blocks, the watchdog driver can be
converted to call exported drivers from those functions directly.
At that point, the platform_data function pointer can be removed.

In the short term, this patch is needed to allow the PRM code to be
removed from arch/arm/mach-omap2 (it is being moved to a driver).

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Wim Van Sebroeck <wim@iguana.be>
---
 drivers/watchdog/omap_wdt.c |   26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
index f5db18db..5d33bc0 100644
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -46,8 +46,8 @@
 #include <linux/slab.h>
 #include <linux/pm_runtime.h>
 #include <mach/hardware.h>
-#include <plat/cpu.h>
-#include <plat/prcm.h>
+
+#include <linux/platform_data/omap-wd-timer.h>
 
 #include "omap_wdt.h"
 
@@ -202,8 +202,10 @@ static ssize_t omap_wdt_write(struct file *file, const char __user *data,
 static long omap_wdt_ioctl(struct file *file, unsigned int cmd,
 						unsigned long arg)
 {
+	struct omap_wd_timer_platform_data *pdata;
 	struct omap_wdt_dev *wdev;
-	int new_margin;
+	u32 rs;
+	int new_margin, bs;
 	static const struct watchdog_info ident = {
 		.identity = "OMAP Watchdog",
 		.options = WDIOF_SETTIMEOUT,
@@ -211,6 +213,7 @@ static long omap_wdt_ioctl(struct file *file, unsigned int cmd,
 	};
 
 	wdev = file->private_data;
+	pdata = wdev->dev->platform_data;
 
 	switch (cmd) {
 	case WDIOC_GETSUPPORT:
@@ -219,17 +222,12 @@ static long omap_wdt_ioctl(struct file *file, unsigned int cmd,
 	case WDIOC_GETSTATUS:
 		return put_user(0, (int __user *)arg);
 	case WDIOC_GETBOOTSTATUS:
-#ifdef CONFIG_ARCH_OMAP1
-		if (cpu_is_omap16xx())
-			return put_user(__raw_readw(ARM_SYSST),
-					(int __user *)arg);
-#endif
-#ifdef CONFIG_ARCH_OMAP2PLUS
-		if (cpu_is_omap24xx())
-			return put_user(omap_prcm_get_reset_sources(),
-					(int __user *)arg);
-#endif
-		return put_user(0, (int __user *)arg);
+		if (!pdata->read_reset_sources)
+			return put_user(0, (int __user *)arg);
+		rs = pdata->read_reset_sources();
+		bs = (rs & (1 << OMAP_MPU_WD_RST_SRC_ID_SHIFT)) ?
+			WDIOF_CARDRESET : 0;
+		return put_user(bs, (int __user *)arg);
 	case WDIOC_KEEPALIVE:
 		spin_lock(&wdt_lock);
 		omap_wdt_ping(wdev);


