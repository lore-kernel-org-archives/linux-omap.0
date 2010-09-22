From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 3/5] OMAP: hwmod: Enable module wakeup if in smartidle
Date: Tue, 21 Sep 2010 18:19:34 -0600
Message-ID: <20100922001931.8621.46565.stgit@twilight.localdomain>
References: <20100922001834.8621.76144.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35988 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752522Ab0IVAV3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Sep 2010 20:21:29 -0400
In-Reply-To: <20100922001834.8621.76144.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Partha Basak <p-basak2@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Rajendra Nayak <rnayak@ti.com>, =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

=46rom: Rajendra Nayak <rnayak@ti.com>

If a module's OCP slave port is programmed to be in smartidle,
its also necessary that they have module level wakeup enabled.
Update _sysc_enable in hwmod framework to do this.

The thread "[PATCH 7/8] : Hwmod api changes" archived here:

http://www.mail-archive.com/linux-omap@vger.kernel.org/msg34212.html

has additional technical information on the rationale of this patch.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Partha Basak <p-basak2@ti.com>
Signed-off-by: Beno=C3=AEt Cousson <b-cousson@ti.com>
[paul@pwsan.com: revised patch description]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/oma=
p_hwmod.c
index f320cfb..3f3d61a 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -691,8 +691,6 @@ static void _sysc_enable(struct omap_hwmod *oh)
 		_set_module_autoidle(oh, idlemode, &v);
 	}
=20
-	/* XXX OCP ENAWAKEUP bit? */
-
 	/*
 	 * XXX The clock framework should handle this, by
 	 * calling into this code.  But this must wait until the
@@ -703,6 +701,10 @@ static void _sysc_enable(struct omap_hwmod *oh)
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


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
