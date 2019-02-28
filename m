From: Robert Yang <decatf@gmail.com>
Subject: [PATCH] mfd: tps65910: Properly disable the power on state
Date: Thu, 28 Feb 2019 11:57:30 -0500
Message-ID: <20190228165730.GA14387@r>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

In the tps65910/1 datasheets under "Device POWER ON Disable Conditions".
There are four conditions which can disable power on:
Long press interrupt (PWRON_LP_IT) OR thermal trip OR DEV_OFF bit OR
DEV_OFF_RST bit.

The Ouya game console has TPS65911. Before this patch the device will not
power off through the pm_power_off call. The power light stays on and the
device heatsink is warm. Long pressing the power button can power off the
device. After this patch the device powers off correctly when calling power
off through userspace software.

Signed-off-by: Robert Yang <decatf@gmail.com>
---
 drivers/mfd/tps65910.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/tps65910.c b/drivers/mfd/tps65910.c
index aa3d472a10ff..c067dcacbe61 100644
--- a/drivers/mfd/tps65910.c
+++ b/drivers/mfd/tps65910.c
@@ -445,8 +445,12 @@ static void tps65910_power_off(void)
 			DEVCTRL_PWR_OFF_MASK) < 0)
 		return;
 
-	tps65910_reg_clear_bits(tps65910, TPS65910_DEVCTRL,
-			DEVCTRL_DEV_ON_MASK);
+	if (tps65910_reg_clear_bits(tps65910, TPS65910_DEVCTRL,
+			DEVCTRL_DEV_ON_MASK) < 0)
+		return;
+
+	tps65910_reg_set_bits(tps65910, TPS65910_DEVCTRL,
+		DEVCTRL_DEV_OFF_MASK);
 }
 
 static int tps65910_i2c_probe(struct i2c_client *i2c,
-- 
2.17.1
