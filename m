From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 5/8] OMAP2+: hwmod: allow multiple calls to omap_hwmod_init()
Date: Wed, 23 Feb 2011 00:11:51 -0700
Message-ID: <20110223071150.5874.58996.stgit@twilight.localdomain>
References: <20110223070455.5874.51326.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58767 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752513Ab1BWHNI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Feb 2011 02:13:08 -0500
In-Reply-To: <20110223070455.5874.51326.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@ti.com>, =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

There's no longer any reason why we should prevent multiple
calls to omap_hwmod_init().  It is now simply used to register an
array of hwmods.

This should allow a subset of hwmods (e.g., hwmods
handling the system clocksource and clockevents) to be registered
earlier than the remaining mass of hwmods.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   29 ++++++++++-------------------
 1 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/oma=
p_hwmod.c
index 41f548e..86eacaf 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -162,9 +162,6 @@ static LIST_HEAD(omap_hwmod_list);
 /* mpu_oh: used to add/remove MPU initiator from sleepdep list */
 static struct omap_hwmod *mpu_oh;
=20
-/* inited: 0 if omap_hwmod_init() has not yet been called; 1 otherwise=
 */
-static u8 inited;
-
=20
 /* Private functions */
=20
@@ -1600,26 +1597,20 @@ int omap_hwmod_for_each(int (*fn)(struct omap_h=
wmod *oh, void *data),
  */
 int __init omap_hwmod_init(struct omap_hwmod **ohs)
 {
-	struct omap_hwmod *oh;
-	int r;
-
-	if (inited)
-		return -EINVAL;
-
-	inited =3D 1;
+	int r, i;
=20
 	if (!ohs)
 		return 0;
=20
-	oh =3D *ohs;
-	while (oh) {
-		if (omap_chip_is(oh->omap_chip)) {
-			r =3D _register(oh);
-			WARN(r, "omap_hwmod: %s: _register returned "
-			     "%d\n", oh->name, r);
-		}
-		oh =3D *++ohs;
-	}
+	i =3D 0;
+	do {
+		if (!omap_chip_is(ohs[i]->omap_chip))
+			continue;
+
+		r =3D _register(ohs[i]);
+		WARN(r, "omap_hwmod: %s: _register returned %d\n", ohs[i]->name,
+		     r);
+	} while (ohs[++i]);
=20
 	return 0;
 }


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
