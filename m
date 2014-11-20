From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [RFC PATCH 1/6] ARM: OMAP2+: hwmod: add parent_hwmod support
Date: Thu, 20 Nov 2014 07:03:43 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1411200702440.9204@utopia.booyaka.com>
References: <1412863399-9508-1-git-send-email-tomi.valkeinen@ti.com> <1412863399-9508-2-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:59393 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750838AbaKTHDp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Nov 2014 02:03:45 -0500
In-Reply-To: <1412863399-9508-2-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, Archit Taneja <archit.taneja@gmail.com>

Hi

On Thu, 9 Oct 2014, Tomi Valkeinen wrote:

> Add parent_hwmod pointer to omap_hwmod. This can be set to point to a
> "parent" hwmod that needs to be enabled for the "child" hwmod to work.
> 
> This is used at hwmod setup time: when doing the initial setup and
> reset, first enable the parent hwmod, and after setup and reset is done,
> restore the parent hwmod to postsetup_state.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

This one has been updated here to add some kerneldoc documentation.  
Please let me know if you have any objections.


- Paul

From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 9 Oct 2014 17:03:14 +0300
Subject: [PATCH] ARM: OMAP2+: hwmod: add parent_hwmod support

Add parent_hwmod pointer to omap_hwmod. This can be set to point to a
"parent" hwmod that needs to be enabled for the "child" hwmod to work.

This is used at hwmod setup time: when doing the initial setup and
reset, first enable the parent hwmod, and after setup and reset is done,
restore the parent hwmod to postsetup_state.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Reviewed-by: Archit Taneja <archit.taneja@gmail.com>
[paul@pwsan.com: add kerneldoc documentation for parent_hwmod; note that it
 is a temporary workaround]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod.c | 22 ++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod.h |  8 ++++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index acae6d5d1151..a2c7b300fe89 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2719,11 +2719,33 @@ static int __init _setup(struct omap_hwmod *oh, void *data)
 	if (oh->_state != _HWMOD_STATE_INITIALIZED)
 		return 0;
 
+	if (oh->parent_hwmod) {
+		int r;
+
+		r = _enable(oh->parent_hwmod);
+		WARN(r, "hwmod: %s: setup: failed to enable parent hwmod %s\n",
+		     oh->name, oh->parent_hwmod->name);
+	}
+
 	_setup_iclk_autoidle(oh);
 
 	if (!_setup_reset(oh))
 		_setup_postsetup(oh);
 
+	if (oh->parent_hwmod) {
+		u8 postsetup_state;
+
+		postsetup_state = oh->parent_hwmod->_postsetup_state;
+
+		if (postsetup_state == _HWMOD_STATE_IDLE)
+			_idle(oh->parent_hwmod);
+		else if (postsetup_state == _HWMOD_STATE_DISABLED)
+			_shutdown(oh->parent_hwmod);
+		else if (postsetup_state != _HWMOD_STATE_ENABLED)
+			WARN(1, "hwmod: %s: unknown postsetup state %d! defaulting to enabled\n",
+			     oh->parent_hwmod->name, postsetup_state);
+	}
+
 	return 0;
 }
 
diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hwmod.h
index 512f809a3f4d..35ca6efbec31 100644
--- a/arch/arm/mach-omap2/omap_hwmod.h
+++ b/arch/arm/mach-omap2/omap_hwmod.h
@@ -633,6 +633,7 @@ struct omap_hwmod_link {
  * @flags: hwmod flags (documented below)
  * @_lock: spinlock serializing operations on this hwmod
  * @node: list node for hwmod list (internal use)
+ * @parent_hwmod: (temporary) a pointer to the hierarchical parent of this hwmod
  *
  * @main_clk refers to this module's "main clock," which for our
  * purposes is defined as "the functional clock needed for register
@@ -643,6 +644,12 @@ struct omap_hwmod_link {
  * the omap_hwmod code and should not be set during initialization.
  *
  * @masters and @slaves are now deprecated.
+ *
+ * @parent_hwmod is temporary; there should be no need for it, as this
+ * information should already be expressed in the OCP interface
+ * structures.  @parent_hwmod is present as a workaround until we improve
+ * handling for hwmods with multiple parents (e.g., OMAP4+ DSS with
+ * multiple register targets across different interconnects).
  */
 struct omap_hwmod {
 	const char			*name;
@@ -680,6 +687,7 @@ struct omap_hwmod {
 	u8				_int_flags;
 	u8				_state;
 	u8				_postsetup_state;
+	struct omap_hwmod		*parent_hwmod;
 };
 
 struct omap_hwmod *omap_hwmod_lookup(const char *name);
-- 
2.1.3

