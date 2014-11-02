From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] mfd: twl4030-power: Fix regression with missing compatible
 flag
Date: Sun, 2 Nov 2014 10:09:38 -0800
Message-ID: <20141102180938.GI31454@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Commit e7cd1d1eb16f ("mfd: twl4030-power: Add generic reset
configuration") accidentally removed the compatible flag for
"ti,twl4030-power" that should be there as documented in the
binding.

If "ti,twl4030-power" only the poweroff configuration is done
by the driver.

Fixes: e7cd1d1eb16f ("mfd: twl4030-power: Add generic reset configuration")
Cc: stable@vger.kernel.org # v3.16+
Reported-by: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/drivers/mfd/twl4030-power.c
+++ b/drivers/mfd/twl4030-power.c
@@ -831,6 +831,9 @@ static struct twl4030_power_data osc_off_idle = {
 
 static struct of_device_id twl4030_power_of_match[] = {
 	{
+		.compatible = "ti,twl4030-power",
+	},
+	{
 		.compatible = "ti,twl4030-power-reset",
 		.data = &omap3_reset,
 	},
