From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v2] ARM: OMAP2+: hwmod: Add a new state to handle hwmods left enabled at init
Date: Mon, 21 Nov 2011 11:45:14 +0530
Message-ID: <1321856114-11260-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42365 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752745Ab1KUGPe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Nov 2011 01:15:34 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: b-cousson@ti.com, linux-omap@vger.kernel.org
Cc: tony@atomide.com, khilman@ti.com, paul@pwsan.com, govindraj.raja@ti.com, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, robherring2@gmail.com, Rajendra Nayak <rnayak@ti.com>

An hwmod with a 'HWMOD_INIT_NO_IDLE' flag set, is left in
enabled state by the hwmod framework post the initial setup.
Once a real user of the device (a driver) tries to enable it
at a later point, the hwmod framework throws a WARN() about
the device being already in enabled state.

Fix this by introducing a new state '_HWMOD_STATE_ENABLED_AT_INIT'
to identify such devices/hwmods, so nothing but just a state
change to '_HWMOD_STATE_ENABLED' can be done when the device/hwmod
is requested to be enabled (the first time) by its driver/user.

A good example of a such a device is an UART used as debug console.
The UART module needs to be kept enabled through the boot, until the
UART driver takes control of it, for debug prints to appear on
the console.

Acked-by: Kevin Hilman <khilman@ti.com>
Acked-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
changes in v2:
Fixed minor typos, removed stay change, updated comment
in header.

 arch/arm/mach-omap2/omap_hwmod.c             |   15 ++++++++++++++-
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    6 ++++++
 2 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 6b3088d..72ee723 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1441,6 +1441,17 @@ static int _enable(struct omap_hwmod *oh)
 
 	pr_debug("omap_hwmod: %s: enabling\n", oh->name);
 
+	/*
+	 * hwmods' with HWMOD_INIT_NO_IDLE flag set, are left
+	 * in enabled state at init.
+	 * Now that someone is really trying to enable them,
+	 * just update the state.
+	 */
+	if (oh->_state == _HWMOD_STATE_ENABLED_AT_INIT) {
+		oh->_state = _HWMOD_STATE_ENABLED;
+		return 0;
+	}
+
 	if (oh->_state != _HWMOD_STATE_INITIALIZED &&
 	    oh->_state != _HWMOD_STATE_IDLE &&
 	    oh->_state != _HWMOD_STATE_DISABLED) {
@@ -1744,8 +1755,10 @@ static int _setup(struct omap_hwmod *oh, void *data)
 	 * it should be set by the core code as a runtime flag during startup
 	 */
 	if ((oh->flags & HWMOD_INIT_NO_IDLE) &&
-	    (postsetup_state == _HWMOD_STATE_IDLE))
+	    (postsetup_state == _HWMOD_STATE_IDLE)) {
+		oh->_state = _HWMOD_STATE_ENABLED_AT_INIT;
 		postsetup_state = _HWMOD_STATE_ENABLED;
+	}
 
 	if (postsetup_state == _HWMOD_STATE_IDLE)
 		_idle(oh);
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 8b372ed..2bd3929 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -436,6 +436,12 @@ struct omap_hwmod_omap4_prcm {
 #define _HWMOD_STATE_ENABLED			4
 #define _HWMOD_STATE_IDLE			5
 #define _HWMOD_STATE_DISABLED			6
+/*
+ * This state signifies the hwmod was left enabled
+ * after init, by the framework, because of the
+ * 'HWMOD_INIT_NO_IDLE' flag.
+ */
+#define _HWMOD_STATE_ENABLED_AT_INIT		7
 
 /**
  * struct omap_hwmod_class - the type of an IP block
-- 
1.7.1

