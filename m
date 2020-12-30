Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B678C433E9
	for <linux-omap@archiver.kernel.org>; Wed, 30 Dec 2020 08:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDB4321D1B
	for <linux-omap@archiver.kernel.org>; Wed, 30 Dec 2020 08:45:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbgL3Ioh (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 30 Dec 2020 03:44:37 -0500
Received: from muru.com ([72.249.23.125]:40518 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726350AbgL3Iog (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Wed, 30 Dec 2020 03:44:36 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 00282812F;
        Wed, 30 Dec 2020 08:44:07 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Amit Kucheria <amitk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, Adam Ford <aford173@gmail.com>,
        Carl Philipp Klemm <philipp@uvos.xyz>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Pavel Machek <pavel@ucw.cz>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 2/3] thermal: ti-soc-thermal: Simplify polling with iopoll
Date:   Wed, 30 Dec 2020 10:43:37 +0200
Message-Id: <20201230084338.19410-2-tony@atomide.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201230084338.19410-1-tony@atomide.com>
References: <20201230084338.19410-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

We can use iopoll for checking the EOCZ (end of conversion) bit.

Cc: Adam Ford <aford173@gmail.com>
Cc: Carl Philipp Klemm <philipp@uvos.xyz>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Merlijn Wajer <merlijn@wizzup.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/thermal/ti-soc-thermal/ti-bandgap.c | 30 ++++++++++-----------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
@@ -15,7 +15,6 @@
 #include <linux/kernel.h>
 #include <linux/interrupt.h>
 #include <linux/clk.h>
-#include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/err.h>
@@ -27,6 +26,7 @@
 #include <linux/of_platform.h>
 #include <linux/of_irq.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/cpu_pm.h>
 #include <linux/device.h>
 #include <linux/pm_runtime.h>
@@ -603,8 +603,9 @@ void *ti_bandgap_get_sensor_data(struct ti_bandgap *bgp, int id)
 static int
 ti_bandgap_force_single_read(struct ti_bandgap *bgp, int id)
 {
-	u32 counter = 1000;
 	struct temp_sensor_registers *tsr;
+	int error;
+	u32 val;
 
 	/* Select continuous or single conversion mode */
 	if (TI_BANDGAP_HAS(bgp, CONT_MODE_ONLY))
@@ -615,27 +616,24 @@ ti_bandgap_force_single_read(struct ti_bandgap *bgp, int id)
 	/* Start of Conversion = 1 */
 	RMW_BITS(bgp, id, temp_sensor_ctrl, bgap_soc_mask, 1);
 
-	/* Wait for EOCZ going up */
 	tsr = bgp->conf->sensors[id].registers;
 
-	while (--counter) {
-		if (ti_bandgap_readl(bgp, tsr->temp_sensor_ctrl) &
-		    tsr->bgap_eocz_mask)
-			break;
-		udelay(1);
-	}
+	/* Wait for EOCZ going up */
+	error = readl_poll_timeout_atomic(bgp->base + tsr->temp_sensor_ctrl,
+					  val, val & tsr->bgap_eocz_mask,
+					  1, 1000);
+	if (error)
+		dev_warn(bgp->dev, "eocz timed out waiting high\n");
 
 	/* Start of Conversion = 0 */
 	RMW_BITS(bgp, id, temp_sensor_ctrl, bgap_soc_mask, 0);
 
 	/* Wait for EOCZ going down */
-	counter = 1000;
-	while (--counter) {
-		if (!(ti_bandgap_readl(bgp, tsr->temp_sensor_ctrl) &
-		      tsr->bgap_eocz_mask))
-			break;
-		udelay(1);
-	}
+	error = readl_poll_timeout_atomic(bgp->base + tsr->temp_sensor_ctrl,
+					  val, !(val & tsr->bgap_eocz_mask),
+					  1, 1000);
+	if (error)
+		dev_warn(bgp->dev, "eocz timed out waiting low\n");
 
 	return 0;
 }
-- 
2.29.2
