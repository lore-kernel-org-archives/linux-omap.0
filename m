From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 3/7] ARM: OMAP2+: hwmod: ensure that SYSCONFIG bits are
 reprogrammed after a reset
Date: Mon, 30 Jan 2012 03:18:15 -0700
Message-ID: <20120130101815.10450.6214.stgit@dusk>
References: <20120130101251.10450.58423.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42198 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751669Ab2A3KSo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Jan 2012 05:18:44 -0500
In-Reply-To: <20120130101251.10450.58423.stgit@dusk>
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
 arch/arm/mach-omap2/omap_hwmod.c |   23 +++++++++++------------
 1 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/oma=
p_hwmod.c
index 0ef2710..c991bd7 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1482,6 +1482,16 @@ static int _reset(struct omap_hwmod *oh)
 	 */
 	ret =3D (oh->class->reset) ? oh->class->reset(oh) : _ocp_softreset(oh=
);
=20
+	/*
+	 * OCP_SYSCONFIG bits need to be reprogrammed after a
+	 * softreset.  The _enable() function should be split to avoid
+	 * the rewrite of the OCP_SYSCONFIG register.
+	 */
+	if (oh->class->sysc) {
+		_update_sysc_cache(oh);
+		_enable_sysc(oh);
+	}
+
 	return ret;
 }
=20
@@ -1787,20 +1797,9 @@ static int _setup(struct omap_hwmod *oh, void *d=
ata)
 		return 0;
 	}
=20
-	if (!(oh->flags & HWMOD_INIT_NO_RESET)) {
+	if (!(oh->flags & HWMOD_INIT_NO_RESET))
 		_reset(oh);
=20
-		/*
-		 * OCP_SYSCONFIG bits need to be reprogrammed after a softreset.
-		 * The _enable() function should be split to
-		 * avoid the rewrite of the OCP_SYSCONFIG register.
-		 */
-		if (oh->class->sysc) {
-			_update_sysc_cache(oh);
-			_enable_sysc(oh);
-		}
-	}
-
 	postsetup_state =3D oh->_postsetup_state;
 	if (postsetup_state =3D=3D _HWMOD_STATE_UNKNOWN)
 		postsetup_state =3D _HWMOD_STATE_ENABLED;


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
