From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v2 5/9] regulator: palmas: Shift the reg_info structure definition to the header file
Date: Wed, 18 Jun 2014 15:28:56 +0530
Message-ID: <1403085540-20014-6-git-send-email-j-keerthy@ti.com>
References: <1403085540-20014-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1403085540-20014-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: lgirdwood@gmail.com, broonie@kernel.org, linux-kernel@vger.kernel.org, sameo@linux.intel.com, lee.jones@linaro.org, Keerthy <j-keerthy@ti.com>
List-Id: linux-omap@vger.kernel.org

Shift the reg_info structure definition to the header file.

Acked-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 drivers/regulator/palmas-regulator.c |    9 ---------
 include/linux/mfd/palmas.h           |    9 +++++++++
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/regulator/palmas-regulator.c b/drivers/regulator/palmas-regulator.c
index b982f0f..1cf462f 100644
--- a/drivers/regulator/palmas-regulator.c
+++ b/drivers/regulator/palmas-regulator.c
@@ -27,15 +27,6 @@
 #include <linux/of_platform.h>
 #include <linux/regulator/of_regulator.h>
 
-struct regs_info {
-	char	*name;
-	char	*sname;
-	u8	vsel_addr;
-	u8	ctrl_addr;
-	u8	tstep_addr;
-	int	sleep_id;
-};
-
 static const struct regulator_linear_range smps_low_ranges[] = {
 	REGULATOR_LINEAR_RANGE(0, 0x0, 0x0, 0),
 	REGULATOR_LINEAR_RANGE(500000, 0x1, 0x6, 0),
diff --git a/include/linux/mfd/palmas.h b/include/linux/mfd/palmas.h
index f760a07..c123666 100644
--- a/include/linux/mfd/palmas.h
+++ b/include/linux/mfd/palmas.h
@@ -88,6 +88,15 @@ struct palmas {
 	u8 pwm_muxed;
 };
 
+struct regs_info {
+	char	*name;
+	char	*sname;
+	u8	vsel_addr;
+	u8	ctrl_addr;
+	u8	tstep_addr;
+	int	sleep_id;
+};
+
 struct palmas_gpadc_platform_data {
 	/* Channel 3 current source is only enabled during conversion */
 	int ch3_current;
-- 
1.7.9.5
