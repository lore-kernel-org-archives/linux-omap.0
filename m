From: Kalle Jokiniemi <kalle.jokiniemi@nokia.com>
Subject: [PATCH 1/2] OMAP: hw_mod: consider supported idlemodes in enable_sysc
Date: Thu, 10 Mar 2011 11:32:48 +0200
Message-ID: <1299749569-22673-2-git-send-email-kalle.jokiniemi@nokia.com>
References: <1299749569-22673-1-git-send-email-kalle.jokiniemi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:17653 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752250Ab1CJJej (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Mar 2011 04:34:39 -0500
In-Reply-To: <1299749569-22673-1-git-send-email-kalle.jokiniemi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, khilman@ti.com, linux-omap@vger.kernel.org
Cc: ilkka.koskinen@nokia.com, jhnikula@gmail.com, b-cousson@ti.com, Kalle Jokiniemi <kalle.jokiniemi@nokia.com>

Current implementation of the hw_mod sysconfig configuration
always sets up SMART idle mode for HW modules. However, a certain
HW module may not support smart idle mode or may have
HW bugs that prevent using smart idle mode.

This patch introduces a mechanism to check supported
idle modes and select in following priority:
1. Smart idle mode
2. Force idle mode
3.=C2=A0No idle mode.

Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi@nokia.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   28 ++++++++++++++++++++--------
 1 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/oma=
p_hwmod.c
index 028efda..ef77697 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -757,7 +757,7 @@ static void __iomem * __init _find_mpu_rt_base(stru=
ct omap_hwmod *oh, u8 index)
  */
 static void _enable_sysc(struct omap_hwmod *oh)
 {
-	u8 idlemode, sf;
+	u8 idlemode, sf, idlemode_flags;
 	u32 v;
=20
 	if (!oh->class->sysc)
@@ -765,17 +765,28 @@ static void _enable_sysc(struct omap_hwmod *oh)
=20
 	v =3D oh->_sysc_cache;
 	sf =3D oh->class->sysc->sysc_flags;
+	idlemode_flags =3D oh->class->sysc->idlemodes;
+
+	/* Set the idlemode, priority order: 1. SMART 2. FORCE 3. NOIDLE */
+	if (idlemode_flags & SIDLE_SMART)
+		idlemode =3D HWMOD_IDLEMODE_SMART;
+	else if (idlemode_flags & SIDLE_FORCE)
+		idlemode =3D HWMOD_IDLEMODE_FORCE;
+	else
+		idlemode =3D HWMOD_IDLEMODE_NO;
=20
 	if (sf & SYSC_HAS_SIDLEMODE) {
-		idlemode =3D (oh->flags & HWMOD_SWSUP_SIDLE) ?
-			HWMOD_IDLEMODE_NO : HWMOD_IDLEMODE_SMART;
-		_set_slave_idlemode(oh, idlemode, &v);
+		if (oh->flags & HWMOD_SWSUP_SIDLE)
+			_set_slave_idlemode(oh, HWMOD_IDLEMODE_NO, &v);
+		else
+			_set_slave_idlemode(oh, idlemode, &v);
 	}
=20
 	if (sf & SYSC_HAS_MIDLEMODE) {
-		idlemode =3D (oh->flags & HWMOD_SWSUP_MSTANDBY) ?
-			HWMOD_IDLEMODE_NO : HWMOD_IDLEMODE_SMART;
-		_set_master_standbymode(oh, idlemode, &v);
+		if (oh->flags & HWMOD_SWSUP_MSTANDBY)
+			_set_master_standbymode(oh, HWMOD_IDLEMODE_NO, &v);
+		else
+			_set_master_standbymode(oh, idlemode, &v);
 	}
=20
 	/*
@@ -788,7 +799,8 @@ static void _enable_sysc(struct omap_hwmod *oh)
 		_set_clockactivity(oh, oh->class->sysc->clockact, &v);
=20
 	/* If slave is in SMARTIDLE, also enable wakeup */
-	if ((sf & SYSC_HAS_SIDLEMODE) && !(oh->flags & HWMOD_SWSUP_SIDLE))
+	if ((sf & SYSC_HAS_SIDLEMODE) && !(oh->flags & HWMOD_SWSUP_SIDLE) &&
+			idlemode_flags & SIDLE_SMART)
 		_enable_wakeup(oh, &v);
=20
 	_write_sysconfig(v, oh);
--=20
1.7.1

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
