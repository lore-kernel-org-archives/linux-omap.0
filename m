From: "Dasgupta, Romit" <romit@ti.com>
Subject: [PATCH] mfd: twl: Fix possible NULL pointer violation
Date: Wed, 22 Jul 2009 13:45:20 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301D88D7CA2@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42821 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755968AbZGVIPc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Jul 2009 04:15:32 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>, "sameo@linux.intel.com" <sameo@linux.intel.com>

Fixes a possible NULL pointer violation. Tested on SDP 3430.

Signed-off-by: Romit Dasgupta <romit@ti.com>
---

diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
index 07e40dc..fd5504c 100644
--- a/drivers/mfd/twl4030-power.c
+++ b/drivers/mfd/twl4030-power.c
@@ -352,11 +352,9 @@ void __init twl4030_power_init(struct twl4030_power_data *triton2_scripts)
 	}
 
 	resconfig = triton2_scripts->resource_config;
-	if (resconfig) {
-		while (resconfig->resource) {
+	while (resconfig && resconfig->resource) {
 			twl4030_configure_resource(resconfig);
 			resconfig++;
-		}
 	}
 
 	if (twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, 0, R_PROTECT_KEY))
