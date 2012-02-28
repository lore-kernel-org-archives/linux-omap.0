From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2 5/8] ARM: OMAP2+: hwmod: ensure that SYSCONFIG bits are
 reprogrammed after a reset
Date: Mon, 27 Feb 2012 22:37:01 -0700
Message-ID: <20120228053657.16278.76132.stgit@dusk>
References: <20120228053524.16278.59430.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58096 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754219Ab2B1Fhr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Feb 2012 00:37:47 -0500
In-Reply-To: <20120228053524.16278.59430.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

Move the code that reprograms the OCP_SYSCONFIG bits into the _reset()
function to ensure that it is called after every reset.  The code was
previously in the _setup() function.  So, before this patch, if
_reset() was called from another function, the SYSCONFIG register
won't be reprogrammed.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   31 +++++++++++++++---------------=
-
 1 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/oma=
p_hwmod.c
index db4ad41..aeb6f4c 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1490,13 +1490,22 @@ static int _reset(struct omap_hwmod *oh)
 	pr_debug("omap_hwmod: %s: resetting\n", oh->name);
=20
 	if (oh->class->reset)
-		return oh->class->reset(oh);
-
-	if (!oh->rst_lines_cnt)
-		return _ocp_softreset(oh);
+		oh->class->reset(oh);
+	else if (!oh->rst_lines_cnt)
+		_ocp_softreset(oh);
+	else
+		for (i =3D 0; i < oh->rst_lines_cnt; i++)
+			_assert_hardreset(oh, oh->rst_lines[i].name);
=20
-	for (i =3D 0; i < oh->rst_lines_cnt; i++)
-		_assert_hardreset(oh, oh->rst_lines[i].name);
+	/*
+	 * OCP_SYSCONFIG bits need to be reprogrammed after a
+	 * softreset.  The _enable() function should be split to avoid
+	 * the rewrite of the OCP_SYSCONFIG register.
+	 */
+	if (oh->class->sysc) {
+		_update_sysc_cache(oh);
+		_enable_sysc(oh);
+	}
=20
 	return 0;
 }
@@ -1830,16 +1839,6 @@ static int __init _setup_reset(struct omap_hwmod=
 *oh)
 	if (!(oh->flags & HWMOD_INIT_NO_RESET))
 		r =3D _reset(oh);
=20
-	/*
-	 * OCP_SYSCONFIG bits need to be reprogrammed after a
-	 * softreset.  The _enable() function should be split to avoid
-	 * the rewrite of the OCP_SYSCONFIG register.
-	 */
-	if (oh->class->sysc) {
-		_update_sysc_cache(oh);
-		_enable_sysc(oh);
-	}
-
 	return r;
 }
=20


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
