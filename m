From: Felipe Balbi <balbi@ti.com>
Subject: [RFC/PATCH 5/7] arm: omap: hwmod: allow for registration of class-less hwmods
Date: Tue, 9 Dec 2014 16:27:50 -0600
Message-ID: <1418164072-19087-6-git-send-email-balbi@ti.com>
References: <1418164072-19087-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44485 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753387AbaLIW21 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 9 Dec 2014 17:28:27 -0500
In-Reply-To: <1418164072-19087-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>, Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org, Felipe Balbi <balbi@ti.com>

Before this patch, HWMOD requires the existence
of a struct omap_hwmod_class very early. It just
so happens that we're moving that data to DeviceTree
in a follow-up commit so we need to allow the
registration of HWMODs with a valid omap_hwmod_class
pointer.

When the device is built from DT, we will allocate and
populate struct omap_hwmod_class based on DT data.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index cbb908d..2355764 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -504,6 +504,9 @@ static int _set_dmadisable(struct omap_hwmod *oh)
 	u32 v;
 	u32 dmadisable_mask;
 
+	if (!oh->class)
+		return -EINVAL;
+
 	if (!oh->class->sysc ||
 	    !(oh->class->sysc->sysc_flags & SYSC_HAS_DMADISABLE))
 		return -EINVAL;
@@ -1843,7 +1846,7 @@ static int _ocp_softreset(struct omap_hwmod *oh)
 	int c = 0;
 	int ret = 0;
 
-	if (!oh->class->sysc ||
+	if (!oh->class || !oh->class->sysc ||
 	    !(oh->class->sysc->sysc_flags & SYSC_HAS_SOFTRESET))
 		return -ENOENT;
 
@@ -1937,12 +1940,13 @@ static int _reset(struct omap_hwmod *oh)
 
 	pr_debug("omap_hwmod: %s: resetting\n", oh->name);
 
-	if (oh->class->reset) {
+	if (oh->class && oh->class->reset) {
 		r = oh->class->reset(oh);
 	} else {
 		if (oh->rst_lines_cnt > 0) {
-			for (i = 0; i < oh->rst_lines_cnt; i++)
+			for (i = 0; i < oh->rst_lines_cnt; i++) {
 				_assert_hardreset(oh, oh->rst_lines[i].name);
+			}
 			return 0;
 		} else {
 			r = _ocp_softreset(oh);
@@ -1958,7 +1962,7 @@ static int _reset(struct omap_hwmod *oh)
 	 * softreset.  The _enable() function should be split to avoid
 	 * the rewrite of the OCP_SYSCONFIG register.
 	 */
-	if (oh->class->sysc) {
+	if (oh->class && oh->class->sysc) {
 		_update_sysc_cache(oh);
 		_enable_sysc(oh);
 	}
@@ -2036,7 +2040,7 @@ static int _omap4_get_context_lost(struct omap_hwmod *oh)
  */
 static int _enable_preprogram(struct omap_hwmod *oh)
 {
-	if (!oh->class->enable_preprogram)
+	if (!oh->class || !oh->class->enable_preprogram)
 		return 0;
 
 	return oh->class->enable_preprogram(oh);
@@ -2145,7 +2149,7 @@ static int _enable(struct omap_hwmod *oh)
 		oh->_state = _HWMOD_STATE_ENABLED;
 
 		/* Access the sysconfig only if the target is ready */
-		if (oh->class->sysc) {
+		if (oh->class && oh->class->sysc) {
 			if (!(oh->_int_flags & _HWMOD_SYSCONFIG_LOADED))
 				_update_sysc_cache(oh);
 			_enable_sysc(oh);
@@ -2186,7 +2190,7 @@ static int _idle(struct omap_hwmod *oh)
 	if (_are_all_hardreset_lines_asserted(oh))
 		return 0;
 
-	if (oh->class->sysc)
+	if (oh->class && oh->class->sysc)
 		_idle_sysc(oh);
 	_del_initiator_dep(oh, mpu_oh);
 
@@ -2244,7 +2248,7 @@ static int _shutdown(struct omap_hwmod *oh)
 
 	pr_debug("omap_hwmod: %s: disabling\n", oh->name);
 
-	if (oh->class->pre_shutdown) {
+	if (oh->class && oh->class->pre_shutdown) {
 		prev_state = oh->_state;
 		if (oh->_state == _HWMOD_STATE_IDLE)
 			_enable(oh);
@@ -2256,7 +2260,7 @@ static int _shutdown(struct omap_hwmod *oh)
 		}
 	}
 
-	if (oh->class->sysc) {
+	if (oh->class && oh->class->sysc) {
 		if (oh->_state == _HWMOD_STATE_IDLE)
 			_enable(oh);
 		_shutdown_sysc(oh);
@@ -2451,7 +2455,7 @@ static int __init _init(struct omap_hwmod *oh, void *data)
 				oh->name, np->name);
 	}
 
-	if (oh->class->sysc) {
+	if (oh->class && oh->class->sysc) {
 		r = _init_mpu_rt_base(oh, NULL, index, np);
 		if (r < 0) {
 			WARN(1, "omap_hwmod: %s: doesn't have mpu register target base\n",
@@ -2684,8 +2688,7 @@ static int __init _setup(struct omap_hwmod *oh, void *data)
  */
 static int __init _register(struct omap_hwmod *oh)
 {
-	if (!oh || !oh->name || !oh->class || !oh->class->name ||
-	    (oh->_state != _HWMOD_STATE_UNKNOWN))
+	if (!oh || !oh->name || (oh->_state != _HWMOD_STATE_UNKNOWN))
 		return -EINVAL;
 
 	pr_debug("omap_hwmod: %s: registering\n", oh->name);
@@ -3942,6 +3945,9 @@ int omap_hwmod_for_each_by_class(const char *classname,
 		 __func__, classname);
 
 	list_for_each_entry(temp_oh, &omap_hwmod_list, node) {
+		if (!temp_oh->class)
+			continue;
+
 		if (!strcmp(temp_oh->class->name, classname)) {
 			pr_debug("omap_hwmod: %s: %s: calling callback fn\n",
 				 __func__, temp_oh->name);
-- 
2.2.0

