From: "Dasgupta, Romit" <romit@ti.com>
Subject: [PATCH] mfd: twl: Fix possible NULL pointer violation
Date: Wed, 22 Jul 2009 14:00:38 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301D88D7CE4@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301D88D7CA2@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52767 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754619AbZGVIau convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Jul 2009 04:30:50 -0400
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301D88D7CA2@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>, "sameo@linux.intel.com" <sameo@linux.intel.com>

Missed some formatting earlier.

Fixes a possible NULL pointer violation. Tested on 3430 SDP.
Signed-off-by: Romit Dasgupta <romit@ti.com>
---

diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
index 07e40dc..e050a5e 100644
--- a/drivers/mfd/twl4030-power.c
+++ b/drivers/mfd/twl4030-power.c
@@ -352,11 +352,9 @@ void __init twl4030_power_init(struct twl4030_power_data *triton2_scripts)
 	}
 
 	resconfig = triton2_scripts->resource_config;
-	if (resconfig) {
-		while (resconfig->resource) {
-			twl4030_configure_resource(resconfig);
-			resconfig++;
-		}
+	while (resconfig && resconfig->resource) {
+		twl4030_configure_resource(resconfig);
+		resconfig++;
 	}
 
 	if (twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, 0, R_PROTECT_KEY))

>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>owner@vger.kernel.org] On Behalf Of Dasgupta, Romit
>Sent: Wednesday, July 22, 2009 1:45 PM
>To: Kevin Hilman
>Cc: linux-omap@vger.kernel.org Mailing List; sameo@linux.intel.com
>Subject: [PATCH] mfd: twl: Fix possible NULL pointer violation
>
>Fixes a possible NULL pointer violation. Tested on SDP 3430.
>
>Signed-off-by: Romit Dasgupta <romit@ti.com>
>---
>
>diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
>index 07e40dc..fd5504c 100644
>--- a/drivers/mfd/twl4030-power.c
>+++ b/drivers/mfd/twl4030-power.c
>@@ -352,11 +352,9 @@ void __init twl4030_power_init(struct
>twl4030_power_data *triton2_scripts)
> 	}
>
> 	resconfig = triton2_scripts->resource_config;
>-	if (resconfig) {
>-		while (resconfig->resource) {
>+	while (resconfig && resconfig->resource) {
> 			twl4030_configure_resource(resconfig);
> 			resconfig++;
>-		}
> 	}
>
> 	if (twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, 0,
>R_PROTECT_KEY))
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

