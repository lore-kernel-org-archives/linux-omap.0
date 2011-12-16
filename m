From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v3] ARM: OMAP2+: hwmod: Add a new state to handle hwmods
 left enabled at init
Date: Fri, 16 Dec 2011 03:37:42 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1112160334100.12660@utopia.booyaka.com>
References: <1321877570-4333-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49789 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751499Ab1LPKhn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Dec 2011 05:37:43 -0500
In-Reply-To: <1321877570-4333-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: b-cousson@ti.com, linux-omap@vger.kernel.org, tony@atomide.com, khilman@ti.com, govindraj.raja@ti.com, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, robherring2@gmail.com

Hi

On Mon, 21 Nov 2011, Rajendra Nayak wrote:

> An hwmod with a 'HWMOD_INIT_NO_IDLE' flag set, is left in
> enabled state by the hwmod framework post the initial setup.
> Once a real user of the device (a driver) tries to enable it
> at a later point, the hwmod framework throws a WARN() about
> the device being already in enabled state.
> 
> Fix this by introducing a new state '_HWMOD_STATE_ENABLED_AT_INIT'
> to identify such devices/hwmods. When the device/hwmod
> is requested to be enabled (the first time) by its driver/user,
> nothing except the mux-enable and a state change to '_HWMOD_STATE_ENABLED'
> is needed. The mux data is board specific and is unavailable during
> initial enable() of the device, done by the framework as part of
> setup().
> 
> A good example of a such a device is an UART used as debug console.
> The UART module needs to be kept enabled through the boot, until the
> UART driver takes control of it, for debug prints to appear on
> the console.
> 
> Acked-by: Kevin Hilman <khilman@ti.com>
> Acked-by: Benoit Cousson <b-cousson@ti.com>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>

I've tweaked this patch a little bit, mostly to avoid adding a new state, 
which increases the complexity of the rest of the code that handles the 
hwmod state machine.  The modified patch below just uses an internal flag.  
Please let me know if you have any comments.


- Paul


From: Rajendra Nayak <rnayak@ti.com>
Date: Mon, 21 Nov 2011 17:42:50 +0530
Subject: [PATCH] ARM: OMAP2+: hwmod: Add a new flag to handle hwmods left
 enabled at init

An hwmod with a 'HWMOD_INIT_NO_IDLE' flag set, is left in
enabled state by the hwmod framework post the initial setup.
Once a real user of the device (a driver) tries to enable it
at a later point, the hwmod framework throws a WARN() about
the device being already in enabled state.

Fix this by introducing a new internal '_HWMOD_SKIP_ENABLE' to
identify such devices/hwmods. When the device/hwmod is requested to be
enabled (the first time) by its driver/user, nothing except the
mux-enable is needed. The mux data is board specific and is
unavailable during initial enable() of the device, done by the
framework as part of setup().

A good example of a such a device is an UART used as debug console.
The UART module needs to be kept enabled through the boot, until the
UART driver takes control of it, for debug prints to appear on
the console.

Acked-by: Kevin Hilman <khilman@ti.com>
Acked-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
[paul@pwsan.com: use a flag rather than a state; updated commit message;
 edited some documentation]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |   23 ++++++++++++++++++++++-
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    3 +++
 2 files changed, 25 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index ebace0f..0a89335 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1449,6 +1449,25 @@ static int _enable(struct omap_hwmod *oh)
 
 	pr_debug("omap_hwmod: %s: enabling\n", oh->name);
 
+	/*
+	 * hwmods with HWMOD_INIT_NO_IDLE flag set are left
+	 * in enabled state at init.
+	 * Now that someone is really trying to enable them,
+	 * just ensure that the hwmod mux is set.
+	 */
+	if (oh->_int_flags & _HWMOD_SKIP_ENABLE) {
+		/*
+		 * If the caller has mux data populated, do the mux'ing
+		 * which wouldn't have been done as part of the _enable()
+		 * done during setup.
+		 */
+		if (oh->mux)
+			omap_hwmod_mux(oh->mux, _HWMOD_STATE_ENABLED);
+
+		oh->_int_flags &= ~_HWMOD_SKIP_ENABLE;
+		return 0;
+	}
+
 	if (oh->_state != _HWMOD_STATE_INITIALIZED &&
 	    oh->_state != _HWMOD_STATE_IDLE &&
 	    oh->_state != _HWMOD_STATE_DISABLED) {
@@ -1744,8 +1763,10 @@ static int _setup(struct omap_hwmod *oh, void *data)
 	 * it should be set by the core code as a runtime flag during startup
 	 */
 	if ((oh->flags & HWMOD_INIT_NO_IDLE) &&
-	    (postsetup_state == _HWMOD_STATE_IDLE))
+	    (postsetup_state == _HWMOD_STATE_IDLE)) {
+		oh->_int_flags |= _HWMOD_SKIP_ENABLE;
 		postsetup_state = _HWMOD_STATE_ENABLED;
+	}
 
 	if (postsetup_state == _HWMOD_STATE_IDLE)
 		_idle(oh);
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 8b372ed..1a13c02 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -416,10 +416,13 @@ struct omap_hwmod_omap4_prcm {
  * _HWMOD_NO_MPU_PORT: no path exists for the MPU to write to this module
  * _HWMOD_WAKEUP_ENABLED: set when the omap_hwmod code has enabled ENAWAKEUP
  * _HWMOD_SYSCONFIG_LOADED: set when the OCP_SYSCONFIG value has been cached
+ * _HWMOD_SKIP_ENABLE: set if hwmod enabled during init (HWMOD_INIT_NO_IDLE) -
+ *     causes the first call to _enable() to only update the pinmux
  */
 #define _HWMOD_NO_MPU_PORT			(1 << 0)
 #define _HWMOD_WAKEUP_ENABLED			(1 << 1)
 #define _HWMOD_SYSCONFIG_LOADED			(1 << 2)
+#define _HWMOD_SKIP_ENABLE			(1 << 3)
 
 /*
  * omap_hwmod._state definitions
-- 
1.7.7.3

