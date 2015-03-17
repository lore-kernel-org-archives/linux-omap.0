From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 1/2] regulator: palmas: Correct TPS659038 register definition for REGEN2
Date: Tue, 17 Mar 2015 15:56:04 +0530
Message-ID: <1426587965-23553-2-git-send-email-j-keerthy@ti.com>
References: <1426587965-23553-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426587965-23553-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, sameo@linux.intel.com, lee.jones@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, j-keerthy@ti.com
List-Id: linux-omap@vger.kernel.org

The register offset for REGEN2_CTRL in different for TPS659038 chip as when
compared with other Palmas family PMICs. In the case of TPS659038 the wrong
offset pointed to PLLEN_CTRL and was causing a hang. Correcting the same.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
Tested for the regulator enumerations on DRA7 and BEAGLE-X15 boards.
No Hang observed.

 drivers/regulator/palmas-regulator.c | 4 ++++
 include/linux/mfd/palmas.h           | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/drivers/regulator/palmas-regulator.c b/drivers/regulator/palmas-regulator.c
index 9205f43..1819831 100644
--- a/drivers/regulator/palmas-regulator.c
+++ b/drivers/regulator/palmas-regulator.c
@@ -1572,6 +1572,10 @@ static int palmas_regulators_probe(struct platform_device *pdev)
 	if (!pmic)
 		return -ENOMEM;
 
+	if (of_device_is_compatible(node, "ti,tps659038-pmic"))
+		palmas_generic_regs_info[PALMAS_REG_REGEN2].ctrl_addr =
+							TPS659038_REGEN2_CTRL;
+
 	pmic->dev = &pdev->dev;
 	pmic->palmas = palmas;
 	palmas->pmic = pmic;
diff --git a/include/linux/mfd/palmas.h b/include/linux/mfd/palmas.h
index fb0390a..ee7b1ce 100644
--- a/include/linux/mfd/palmas.h
+++ b/include/linux/mfd/palmas.h
@@ -2999,6 +2999,9 @@ enum usb_irq_events {
 #define PALMAS_GPADC_TRIM15					0x0E
 #define PALMAS_GPADC_TRIM16					0x0F
 
+/* TPS659038 regen2_ctrl offset iss different from palmas */
+#define TPS659038_REGEN2_CTRL					0x12
+
 /* TPS65917 Interrupt registers */
 
 /* Registers for function INTERRUPT */
-- 
1.9.1
