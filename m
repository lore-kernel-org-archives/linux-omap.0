From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 3/3] mfd: menelaus: use macro for magic number
Date: Sat, 28 Mar 2015 22:45:37 +0200
Message-ID: <1427575537-28508-4-git-send-email-aaro.koskinen@iki.fi>
References: <1427575537-28508-1-git-send-email-aaro.koskinen@iki.fi>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427575537-28508-1-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: linux-omap@vger.kernel.org

Use macro to check a register bit.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/mfd/menelaus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/menelaus.c b/drivers/mfd/menelaus.c
index 917fa86..c2ca665 100644
--- a/drivers/mfd/menelaus.c
+++ b/drivers/mfd/menelaus.c
@@ -1216,7 +1216,7 @@ static int menelaus_probe(struct i2c_client *client,
 	err = menelaus_read_reg(MENELAUS_VCORE_CTRL1);
 	if (err < 0)
 		goto fail;
-	if (err & BIT(7))
+	if (err & VCORE_CTRL1_HW_NSW)
 		menelaus->vcore_hw_mode = 1;
 	else
 		menelaus->vcore_hw_mode = 0;
-- 
2.2.0
