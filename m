From: Sebastian Reichel <sre@debian.org>
Subject: [PATCH 4/5] OMAPDSS: SDI: Use V28 as regulator for N900
Date: Sat, 23 Nov 2013 21:57:23 +0100
Message-ID: <1385240244-28629-5-git-send-email-sre@debian.org>
References: <1385240244-28629-1-git-send-email-sre@debian.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([91.143.88.219]:56845 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755969Ab3KWU6G (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 23 Nov 2013 15:58:06 -0500
In-Reply-To: <1385240244-28629-1-git-send-email-sre@debian.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@ring0.de>, Tomi Valkeinen <tomi.valkeinen@ti.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Landley <rob@landley.net>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Sebastian Reichel <sre@debian.org>

This adds a Nokia N900 quirk, so that the V28
regulator is used for the omapdss.sdi port.

This quirk is needed until omapdss is converted
to DT, so that the regulator can be acquired via
a phandle.

On other boards the regulator can be renamed in
the DT data, but on the Nokia N900 the regulator
is also used for other hardware components.

Signed-off-by: Sebastian Reichel <sre@debian.org>
---
 drivers/video/omap2/dss/sdi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index ccc569a..ca8f102 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -26,6 +26,7 @@
 #include <linux/export.h>
 #include <linux/platform_device.h>
 #include <linux/string.h>
+#include <linux/of.h>
 
 #include <video/omapdss.h>
 #include "dss.h"
@@ -263,7 +264,12 @@ static int sdi_init_regulator(void)
 	if (sdi.vdds_sdi_reg)
 		return 0;
 
-	vdds_sdi = devm_regulator_get(&sdi.pdev->dev, "vdds_sdi");
+	/* TODO: remove this hack, once we acquire regulator via DT phandle */
+	if (of_machine_is_compatible("nokia,omap3-n900"))
+		vdds_sdi = devm_regulator_get(&sdi.pdev->dev, "V28");
+	else
+		vdds_sdi = devm_regulator_get(&sdi.pdev->dev, "vdds_sdi");
+
 	if (IS_ERR(vdds_sdi)) {
 		DSSERR("can't get VDDS_SDI regulator\n");
 		return PTR_ERR(vdds_sdi);
-- 
1.8.4.3

