From: Tero Kristo <t-kristo@ti.com>
Subject: [RFC PATCH 05/35] ARM: OMAP2+: hwmod: add support for rerouting hwmod links
Date: Wed, 15 Apr 2015 15:52:52 +0300
Message-ID: <1429102402-5276-6-git-send-email-t-kristo@ti.com>
References: <1429102402-5276-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42499 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755318AbbDOMwo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Apr 2015 08:52:44 -0400
In-Reply-To: <1429102402-5276-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org

If a hwmod with same name is already registered, reroute the links to
use the existing one rather than fail. This is needed when hwmod data
is made into a separate module, and for example, l3 bus is already
registered under different hwmod. The late module init will use
an l3 dummy hwmod instead, which will be rerouted to use the real
l3 hwmod.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 939161e..4fc42c9 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2797,6 +2797,8 @@ static int __init _add_link(struct omap_hwmod_ocp_if *oi)
  */
 static int __init _register_link(struct omap_hwmod_ocp_if *oi)
 {
+	struct omap_hwmod *oh;
+
 	if (!oi || !oi->master || !oi->slave || !oi->user)
 		return -EINVAL;
 
@@ -2810,11 +2812,27 @@ static int __init _register_link(struct omap_hwmod_ocp_if *oi)
 	 * Register the connected hwmods, if they haven't been
 	 * registered already
 	 */
-	if (oi->master->_state != _HWMOD_STATE_REGISTERED)
-		_register(oi->master);
+	if (oi->master->_state != _HWMOD_STATE_REGISTERED) {
+		oh = _lookup(oi->master->name);
+		if (oh) {
+			pr_debug("%s: remapping %s to %08x\n", __func__,
+				 oh->name, (u32)oh);
+			oi->master = oh;
+		} else {
+			_register(oi->master);
+		}
+	}
 
-	if (oi->slave->_state != _HWMOD_STATE_REGISTERED)
-		_register(oi->slave);
+	if (oi->slave->_state != _HWMOD_STATE_REGISTERED) {
+		oh = _lookup(oi->slave->name);
+		if (oh) {
+			pr_debug("%s: remapping %s to %08x\n", __func__,
+				 oh->name, (u32)oh);
+			oi->slave = oh;
+		} else {
+			_register(oi->slave);
+		}
+	}
 
 	_add_link(oi);
 
-- 
1.7.9.5

