From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH 1/4] ARM: OMAP2+: omap_hwmod: Introduce ti,no-init dt property
Date: Thu, 5 Mar 2015 07:13:28 -0600
Message-ID: <1425561211-31003-2-git-send-email-d-gerlach@ti.com>
References: <1425561211-31003-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35203 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754706AbbCENOO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 5 Mar 2015 08:14:14 -0500
In-Reply-To: <1425561211-31003-1-git-send-email-d-gerlach@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, KEERTHY <j-keerthy@ti.com>, Dave Gerlach <d-gerlach@ti.com>

Introduce a dt property, ti,no-init, that prevents hwmod initialization.
Even if a dt node is marked as disabled, hwmod still at least enables
the hwmod and programs the sysconfig before attempting to idle it at
boot. If an IP has been disabled by the hardware configuration on a
platform, this will cause a hang due to writing to inactive registers.
This property prevents that from happening by marking the hwmod as
_HWMOD_STATE_DISABLED during init.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 Documentation/devicetree/bindings/arm/omap/omap.txt | 2 ++
 arch/arm/mach-omap2/omap_hwmod.c                    | 7 ++++++-
 arch/arm/mach-omap2/omap_hwmod.h                    | 4 ++++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
index 4f6a82c..7c0d3a53 100644
--- a/Documentation/devicetree/bindings/arm/omap/omap.txt
+++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
@@ -23,6 +23,8 @@ Optional properties:
   during suspend.
 - ti,no-reset-on-init: When present, the module should not be reset at init
 - ti,no-idle-on-init: When present, the module should not be idled at init
+- ti,no_init: When present, the module is marked as disabled immediately and
+  no setup is done.
 
 Example:
 
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 92afb72..e835f61 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2471,9 +2471,14 @@ static int __init _init(struct omap_hwmod *oh, void *data)
 			oh->flags |= HWMOD_INIT_NO_RESET;
 		if (of_find_property(np, "ti,no-idle-on-init", NULL))
 			oh->flags |= HWMOD_INIT_NO_IDLE;
+		if (of_find_property(np, "ti,no-init", NULL))
+			oh->flags |= HWMOD_NO_INIT;
 	}
 
-	oh->_state = _HWMOD_STATE_INITIALIZED;
+	if (oh->flags & HWMOD_NO_INIT)
+		oh->_state = _HWMOD_STATE_DISABLED;
+	else
+		oh->_state = _HWMOD_STATE_INITIALIZED;
 
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hwmod.h
index 9d4bec6e..75061fc 100644
--- a/arch/arm/mach-omap2/omap_hwmod.h
+++ b/arch/arm/mach-omap2/omap_hwmod.h
@@ -517,6 +517,9 @@ struct omap_hwmod_omap4_prcm {
  * HWMOD_RECONFIG_IO_CHAIN: omap_hwmod code needs to reconfigure wake-up 
  *     events by calling _reconfigure_io_chain() when a device is enabled
  *     or idled.
+ * HWMOD_NO_INIT: Do not initialize the hwmod. Useful for when certain
+ *     platforms disable the IP through hardware configuration, like the
+ *     RTC on the AM437x EPOS EVM.
  */
 #define HWMOD_SWSUP_SIDLE			(1 << 0)
 #define HWMOD_SWSUP_MSTANDBY			(1 << 1)
@@ -532,6 +535,7 @@ struct omap_hwmod_omap4_prcm {
 #define HWMOD_FORCE_MSTANDBY			(1 << 11)
 #define HWMOD_SWSUP_SIDLE_ACT			(1 << 12)
 #define HWMOD_RECONFIG_IO_CHAIN			(1 << 13)
+#define HWMOD_NO_INIT				(1 << 14)
 
 /*
  * omap_hwmod._int_flags definitions
-- 
2.3.0

