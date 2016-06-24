From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v2 4/5] mfd: tps65218: add version check to the PMIC probe
Date: Fri, 24 Jun 2016 13:58:10 +0530
Message-ID: <1466756892-17015-4-git-send-email-j-keerthy@ti.com>
References: <1466756892-17015-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466756892-17015-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, tony@atomide.com, broonie@kernel.org
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, t-kristo@ti.com, russ.dill@ti.com, j-keerthy@ti.com, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Tero Kristo <t-kristo@ti.com>

Version information will be needed to handle some error cases under the
regulator driver, so store the information once during MFD probe.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 drivers/mfd/tps65218.c       | 9 +++++++++
 include/linux/mfd/tps65218.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/mfd/tps65218.c b/drivers/mfd/tps65218.c
index 80b9dc3..ba610ad 100644
--- a/drivers/mfd/tps65218.c
+++ b/drivers/mfd/tps65218.c
@@ -219,6 +219,7 @@ static int tps65218_probe(struct i2c_client *client,
 	struct tps65218 *tps;
 	const struct of_device_id *match;
 	int ret;
+	unsigned int chipid;
 
 	match = of_match_device(of_tps65218_match_table, &client->dev);
 	if (!match) {
@@ -250,6 +251,14 @@ static int tps65218_probe(struct i2c_client *client,
 	if (ret < 0)
 		return ret;
 
+	ret = tps65218_reg_read(tps, TPS65218_REG_CHIPID, &chipid);
+	if (ret) {
+		dev_err(tps->dev, "Failed to read chipid: %d\n", ret);
+		return ret;
+	}
+
+	tps->rev = chipid & TPS65218_CHIPID_REV_MASK;
+
 	ret = of_platform_populate(client->dev.of_node, NULL, NULL,
 				   &client->dev);
 	if (ret < 0)
diff --git a/include/linux/mfd/tps65218.h b/include/linux/mfd/tps65218.h
index 7fdf532..85e464e 100644
--- a/include/linux/mfd/tps65218.h
+++ b/include/linux/mfd/tps65218.h
@@ -267,6 +267,7 @@ struct tps_info {
 struct tps65218 {
 	struct device *dev;
 	unsigned int id;
+	u8 rev;
 
 	struct mutex tps_lock;		/* lock guarding the data structure */
 	/* IRQ Data */
-- 
1.9.1
