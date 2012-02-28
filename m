From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2 4/8] ARM: OMAP2+: hwmod: revise hardreset behavior
Date: Mon, 27 Feb 2012 22:36:57 -0700
Message-ID: <20120228053654.16278.73632.stgit@dusk>
References: <20120228053524.16278.59430.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58093 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754094Ab2B1Fhp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Feb 2012 00:37:45 -0500
In-Reply-To: <20120228053524.16278.59430.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

Change the way that hardreset lines are handled by the hwmod code.
Hardreset lines are generally associated with initiator IP blocks.
Prior to this change, the hwmod code expected to control hardreset
lines itself, asserting them on shutdown and deasserting them upon
enable.  But driver authors inside TI have commented to us that their
drivers require direct control over these lines.  Unfortunately, these
drivers haven't been posted publicly yet, so it's hard to determine
exactly what is needed, a priori.  This change attempts to set forth
some reasonable semantics that should be an improvement over the
current code.

The semantics implemented by this patch are as follows:

- If the hwmod is not marked with HWMOD_INIT_NO_RESET, then assert all
  associated hardreset lines during IP block setup.  This is intended
  to place the IP blocks into a known state that will not interfere
  with other devices during kernel boot.

- IP blocks with hardreset lines will not be automatically enabled or
  idled during setup.  Instead, they will be left in the INITIALIZED
  state.

- When the hwmod code is asked to enable the IP block -- presumably by
  the driver -- all clocks will be enabled, but the hardreset lines
  will remain untouched.  For this to not return timeout warnings if
  the hardreset lines are asserted, we bypass the PRCM transition
  test.

- When the hwmod code is asked to idle the IP block -- presumably by
  the driver -- all clocks will be disabled, but the hardreset lines
  will remain untouched.  For this to not return timeout warnings if
  the hardreset lines are asserted, we bypass the PRCM transition
  test.

Custom reset functions for IP blocks with hardreset lines still should
be supported and are strongly endorsed.  It is intended that every
subsystem with hardreset lines should have a custom reset function
that can place their subsystem into quiescent idle with the hardreset
lines deasserted.

This reverts most of commit 5365efbe29250a227502256cc912351fe2157b42
("OMAP: hwmod: Add hardreset management support").  Later code
reorganizations caused the sequencing of the code from this patch to
be changed, anyway.

It is expected that drivers may require additional functions to be
exposed from the hwmod code, such as a function to allow drivers to
wait for IDLEST bits to change after hardreset lines are toggled.
Driver authors are expected to propose these if needed.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   51 ++++++++++++++++++------------=
--------
 1 files changed, 24 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/oma=
p_hwmod.c
index 5b368ee..db4ad41 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -805,6 +805,9 @@ static int _omap4_disable_module(struct omap_hwmod =
*oh)
 				    oh->clkdm->clkdm_offs,
 				    oh->prcm.omap4.clkctrl_offs);
=20
+	if (oh->rst_lines_cnt >=3D 0)
+		return 0;
+
 	v =3D _omap4_wait_target_disable(oh);
 	if (v)
 		pr_warn("omap_hwmod: %s: _wait_target_disable failed\n",
@@ -1508,7 +1511,7 @@ static int _reset(struct omap_hwmod *oh)
  */
 static int _enable(struct omap_hwmod *oh)
 {
-	int r, i;
+	int r;
 	int hwsup =3D 0;
=20
 	pr_debug("omap_hwmod: %s: enabling\n", oh->name);
@@ -1539,16 +1542,6 @@ static int _enable(struct omap_hwmod *oh)
 		return -EINVAL;
 	}
=20
-	/*
-	 * If an IP contains HW reset lines, then de-assert them in order
-	 * to allow the module state transition. Otherwise the PRCM will retu=
rn
-	 * Intransition status, and the init will failed.
-	 */
-	if (oh->_state =3D=3D _HWMOD_STATE_INITIALIZED ||
-	    oh->_state =3D=3D _HWMOD_STATE_DISABLED)
-		for (i =3D 0; i < oh->rst_lines_cnt; i++)
-			_deassert_hardreset(oh, oh->rst_lines[i].name);
-
 	/* Mux pins for device runtime if populated */
 	if (oh->mux && (!oh->mux->enabled ||
 			((oh->_state =3D=3D _HWMOD_STATE_IDLE) &&
@@ -1575,7 +1568,19 @@ static int _enable(struct omap_hwmod *oh)
 	_enable_clocks(oh);
 	_enable_module(oh);
=20
-	r =3D _wait_target_ready(oh);
+	/*
+	 * If an IP contains HW reset lines, we leave them
+	 * asserted.  But this will block the module's idle state
+	 * transition - the PRCM will return Intransition status.  So
+	 * we need to avoid the target ready-wait in this case.  XXX
+	 * We also need to give the drivers a way to wait for the
+	 * target to become ready once they decide to deassert some
+	 * hardreset lines.  XXX Is this strategy going to break PM
+	 * because the clockdomain may not be able to enter idle while
+	 * the module's idle status is in-transition?  We may just need
+	 * custom reset blocks for all IPs with hardreset lines.
+	 */
+	r =3D (oh->rst_lines_cnt =3D=3D 0) ? _wait_target_ready(oh) : 1;
 	if (!r) {
 		/*
 		 * Set the clockdomain to HW_AUTO only if the target is ready,
@@ -1813,21 +1818,13 @@ static int __init _setup_reset(struct omap_hwmo=
d *oh)
 	if (oh->_state !=3D _HWMOD_STATE_INITIALIZED)
 		return -EINVAL;
=20
-	/*
-	 * In the case of hwmod with hardreset that should not be
-	 * de-assert at boot time, we have to keep the module
-	 * initialized, because we cannot enable it properly with the
-	 * reset asserted. Exit without warning because that behavior
-	 * is expected.
-	 */
-	if ((oh->flags & HWMOD_INIT_NO_RESET) && oh->rst_lines_cnt > 0)
-		return 0;
-
-	r =3D _enable(oh);
-	if (r) {
-		pr_warning("omap_hwmod: %s: cannot be enabled (%d)\n",
-			   oh->name, oh->_state);
-		return 0;
+	if (oh->rst_lines_cnt =3D=3D 0) {
+		r =3D _enable(oh);
+		if (r) {
+			pr_warning("omap_hwmod: %s: cannot be enabled for reset (%d)\n",
+				   oh->name, oh->_state);
+			return -EINVAL;
+		}
 	}
=20
 	if (!(oh->flags & HWMOD_INIT_NO_RESET))


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
