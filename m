From: Rajendra Nayak <rnayak@ti.com>
Subject: [RFC 1/2] ARM: OMAP2+: hwmod: Split _init() into _init_early() and _init_late()
Date: Mon, 29 Jul 2013 14:42:41 +0530
Message-ID: <1375089162-30664-2-git-send-email-rnayak@ti.com>
References: <1375089162-30664-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47732 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752067Ab3G2JNT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Jul 2013 05:13:19 -0400
In-Reply-To: <1375089162-30664-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: paul@pwsan.com, tony@atomide.com, Rajendra Nayak <rnayak@ti.com>

Split the _init() function into something that can be done early and
the rest which can be done late (during drivers inits).

This is done in preperation to remove the hwmod dependency to do all
clock inits (which inturn need clockdomain and other frameworks to be
in place) and module resets quite early in boot, and instead do these
on demand when the drivers initialize.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 7341eff..e49159c 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2415,16 +2415,21 @@ static void __init _init_mpu_rt_base(struct omap_hwmod *oh, void *data)
  * upon success or if the hwmod isn't registered, or -EINVAL upon
  * failure.
  */
-static int __init _init(struct omap_hwmod *oh, void *data)
+static int __init _init_early(struct omap_hwmod *oh, void *data)
 {
-	int r;
-
 	if (oh->_state != _HWMOD_STATE_REGISTERED)
 		return 0;
 
 	if (oh->class->sysc)
 		_init_mpu_rt_base(oh, NULL);
 
+	return 0;
+}
+
+static int __init _init_late(struct omap_hwmod *oh, void *data)
+{
+	int r;
+
 	r = _init_clocks(oh, NULL);
 	if (r < 0) {
 		WARN(1, "omap_hwmod: %s: couldn't init clocks\n", oh->name);
@@ -3284,7 +3289,8 @@ int __init omap_hwmod_setup_one(const char *oh_name)
 
 	_ensure_mpu_hwmod_is_setup(oh);
 
-	_init(oh, NULL);
+	_init_early(oh, NULL);
+	_init_late(oh, NULL);
 	_setup(oh, NULL);
 
 	return 0;
@@ -3302,7 +3308,8 @@ static int __init omap_hwmod_setup_all(void)
 {
 	_ensure_mpu_hwmod_is_setup(NULL);
 
-	omap_hwmod_for_each(_init, NULL);
+	omap_hwmod_for_each(_init_early, NULL);
+	omap_hwmod_for_each(_init_late, NULL);
 	omap_hwmod_for_each(_setup, NULL);
 
 	return 0;
-- 
1.7.9.5

