From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/7] ARM: OMAP2+: hwmod: control all hardreset lines attached
 to a hwmod
Date: Mon, 30 Jan 2012 03:18:13 -0700
Message-ID: <20120130101810.10450.45161.stgit@dusk>
References: <20120130101251.10450.58423.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42188 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751202Ab2A3KSn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Jan 2012 05:18:43 -0500
In-Reply-To: <20120130101251.10450.58423.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

Parts of the hwmod code test to see if a module has one and only one
hardreset line before taking an action.  It seems more appropriate
to control all hardreset lines associated with a hwmod, not just one.

It so happens that with the current hwmod data, this will not change
any behavior, since hwmods with hardreset lines have only one
hardreset line associated with them, and 'pseudo-hwmods' are used to
handle the other hardreset lines.  But future hwmod data patches to
remove the pseudo-hwmods will change this.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   29 +++++++++++++++--------------
 1 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/oma=
p_hwmod.c
index 5192cab..0ef2710 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1475,6 +1475,11 @@ static int _reset(struct omap_hwmod *oh)
=20
 	pr_debug("omap_hwmod: %s: resetting\n", oh->name);
=20
+	/*
+	 * XXX We're not resetting modules with hardreset lines
+	 * automatically here.  Should we do this also, or just expect
+	 * those modules to define custom reset functions?
+	 */
 	ret =3D (oh->class->reset) ? oh->class->reset(oh) : _ocp_softreset(oh=
);
=20
 	return ret;
@@ -1490,7 +1495,7 @@ static int _reset(struct omap_hwmod *oh)
  */
 static int _enable(struct omap_hwmod *oh)
 {
-	int r;
+	int r, i;
 	int hwsup =3D 0;
=20
 	pr_debug("omap_hwmod: %s: enabling\n", oh->name);
@@ -1522,15 +1527,15 @@ static int _enable(struct omap_hwmod *oh)
 		return -EINVAL;
 	}
=20
-
 	/*
-	 * If an IP contains only one HW reset line, then de-assert it in ord=
er
+	 * If an IP contains HW reset lines, then de-assert them in order
 	 * to allow the module state transition. Otherwise the PRCM will retu=
rn
 	 * Intransition status, and the init will failed.
 	 */
-	if ((oh->_state =3D=3D _HWMOD_STATE_INITIALIZED ||
-	     oh->_state =3D=3D _HWMOD_STATE_DISABLED) && oh->rst_lines_cnt =3D=
=3D 1)
-		_deassert_hardreset(oh, oh->rst_lines[0].name);
+	if (oh->_state =3D=3D _HWMOD_STATE_INITIALIZED ||
+	    oh->_state =3D=3D _HWMOD_STATE_DISABLED)
+		for (i =3D 0; i < oh->rst_lines_cnt; i++)
+			_deassert_hardreset(oh, oh->rst_lines[i].name);
=20
 	/* Mux pins for device runtime if populated */
 	if (oh->mux && (!oh->mux->enabled ||
@@ -1677,7 +1682,7 @@ int omap_hwmod_set_ocp_autoidle(struct omap_hwmod=
 *oh, u8 autoidle)
  */
 static int _shutdown(struct omap_hwmod *oh)
 {
-	int ret;
+	int ret, i;
 	u8 prev_state;
=20
 	if (oh->_state !=3D _HWMOD_STATE_IDLE &&
@@ -1718,12 +1723,8 @@ static int _shutdown(struct omap_hwmod *oh)
 	}
 	/* XXX Should this code also force-disable the optional clocks? */
=20
-	/*
-	 * If an IP contains only one HW reset line, then assert it
-	 * after disabling the clocks and before shutting down the IP.
-	 */
-	if (oh->rst_lines_cnt =3D=3D 1)
-		_assert_hardreset(oh, oh->rst_lines[0].name);
+	for (i =3D 0; i < oh->rst_lines_cnt; i++)
+		_assert_hardreset(oh, oh->rst_lines[i].name);
=20
 	/* Mux pins to safe mode or use populated off mode values */
 	if (oh->mux)
@@ -1776,7 +1777,7 @@ static int _setup(struct omap_hwmod *oh, void *da=
ta)
 	 * reset asserted. Exit without warning because that behavior is
 	 * expected.
 	 */
-	if ((oh->flags & HWMOD_INIT_NO_RESET) && oh->rst_lines_cnt =3D=3D 1)
+	if ((oh->flags & HWMOD_INIT_NO_RESET) && oh->rst_lines_cnt > 0)
 		return 0;
=20
 	r =3D _enable(oh);


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
