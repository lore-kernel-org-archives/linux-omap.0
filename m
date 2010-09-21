From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH] OMAP: hwmod: Enable module wakeup if in smartidle
Date: Tue, 21 Sep 2010 19:58:30 +0530
Message-ID: <1285079310-15888-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60825 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751456Ab0IUO2j (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Sep 2010 10:28:39 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>, Partha Basak <p-basak2@ti.com>, =?utf-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>

If a module's OCP slave port is programmed to be in smartidle,
its also necessary that they have module level wakeup enabled.
Update _sysc_enable in hwmod framework to do this.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Partha Basak <p-basak2@ti.com>
Signed-off-by: Beno=C3=83=C2=AEt Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/oma=
p_hwmod.c
index cb911d7..d82e7e8 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -659,8 +659,6 @@ static void _sysc_enable(struct omap_hwmod *oh)
 		_set_module_autoidle(oh, idlemode, &v);
 	}
=20
-	/* XXX OCP ENAWAKEUP bit? */
-
 	/*
 	 * XXX The clock framework should handle this, by
 	 * calling into this code.  But this must wait until the
@@ -671,6 +669,10 @@ static void _sysc_enable(struct omap_hwmod *oh)
 		_set_clockactivity(oh, oh->class->sysc->clockact, &v);
=20
 	_write_sysconfig(v, oh);
+
+	/* If slave is in SMARTIDLE, also enable wakeup */
+	if ((sf & SYSC_HAS_SIDLEMODE) && !(oh->flags & HWMOD_SWSUP_SIDLE))
+			_enable_wakeup(oh);
 }
=20
 /**
--=20
1.7.0.4

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
