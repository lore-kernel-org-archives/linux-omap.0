From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/8] OMAP2+: hwmod: allow custom pre-shutdown functions
Date: Tue, 16 Nov 2010 03:18:06 -0700
Message-ID: <20101116101805.22777.70795.stgit@twilight.localdomain>
References: <20101116101615.22777.49212.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51515 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932861Ab0KPKTM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Nov 2010 05:19:12 -0500
In-Reply-To: <20101116101615.22777.49212.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

Some OMAP IP blocks, such as the watchdog timers, cannot be completely
shut down via the standard hwmod shutdown mechanism.  This patch
enables the hwmod data files to supply a pointer to a custom
pre-shutdown function via the struct omap_hwmod_class.pre_shutdown
function pointer.  If the struct omap_hwmod_class.pre_shutdown
function pointer is non-null, the function will be executed before the
existing hwmod shutdown code runs.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |   15 +++++++++++++++
 arch/arm/plat-omap/include/plat/omap_hwmod.h |   10 ++++++++++
 2 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/oma=
p_hwmod.c
index 5a30658..c051fa4 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1261,6 +1261,9 @@ int _omap_hwmod_idle(struct omap_hwmod *oh)
  */
 static int _shutdown(struct omap_hwmod *oh)
 {
+	int ret;
+	u8 prev_state;
+
 	if (oh->_state !=3D _HWMOD_STATE_IDLE &&
 	    oh->_state !=3D _HWMOD_STATE_ENABLED) {
 		WARN(1, "omap_hwmod: %s: disabled state can only be entered "
@@ -1270,6 +1273,18 @@ static int _shutdown(struct omap_hwmod *oh)
=20
 	pr_debug("omap_hwmod: %s: disabling\n", oh->name);
=20
+	if (oh->class->pre_shutdown) {
+		prev_state =3D oh->_state;
+		if (oh->_state =3D=3D _HWMOD_STATE_IDLE)
+			_omap_hwmod_enable(oh);
+		ret =3D oh->class->pre_shutdown(oh);
+		if (ret) {
+			if (prev_state =3D=3D _HWMOD_STATE_IDLE)
+				_omap_hwmod_idle(oh);
+			return ret;
+		}
+	}
+
 	if (oh->class->sysc)
 		_shutdown_sysc(oh);
=20
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/pl=
at-omap/include/plat/omap_hwmod.h
index 7eaa8ed..d1f1265 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -415,14 +415,24 @@ struct omap_hwmod_omap4_prcm {
  * @name: name of the hwmod_class
  * @sysc: device SYSCONFIG/SYSSTATUS register data
  * @rev: revision of the IP class
+ * @pre_shutdown: ptr to fn to be executed immediately prior to device=
 shutdown
  *
  * Represent the class of a OMAP hardware "modules" (e.g. timer,
  * smartreflex, gpio, uart...)
+ *
+ * @pre_shutdown is a function that will be run immediately before
+ * hwmod clocks are disabled, etc.  It is intended for use for hwmods
+ * like the MPU watchdog, which cannot be disabled with the standard
+ * omap_hwmod_shutdown().  The function should return 0 upon success,
+ * or some negative error upon failure.  Returning an error will cause
+ * omap_hwmod_shutdown() to abort the device shutdown and return an
+ * error.
  */
 struct omap_hwmod_class {
 	const char				*name;
 	struct omap_hwmod_class_sysconfig	*sysc;
 	u32					rev;
+	int					(*pre_shutdown)(struct omap_hwmod *oh);
 };
=20
 /**


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
