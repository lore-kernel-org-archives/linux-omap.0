From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v2 2/3] mfd: lp87565: Add support for 4-phase lp87561 combination
Date: Thu, 16 May 2019 10:02:17 +0530
Message-ID: <20190516043218.8222-3-j-keerthy@ti.com>
References: <20190516043218.8222-1-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190516043218.8222-1-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, robh+dt@kernel.org, broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, t-kristo@ti.com, j-keerthy@ti.com
List-Id: linux-omap@vger.kernel.org

Add support for 4-phase lp87561 combination.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 drivers/mfd/lp87565.c       | 4 ++++
 include/linux/mfd/lp87565.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/mfd/lp87565.c b/drivers/mfd/lp87565.c
index 32d2a07d4354..8ad688fe75f9 100644
--- a/drivers/mfd/lp87565.c
+++ b/drivers/mfd/lp87565.c
@@ -33,6 +33,10 @@ static const struct of_device_id of_lp87565_match_table[] = {
 		.compatible = "ti,lp87565-q1",
 		.data = (void *)LP87565_DEVICE_TYPE_LP87565_Q1,
 	},
+	{
+		.compatible = "ti,lp87561-q1",
+		.data = (void *)LP87565_DEVICE_TYPE_LP87561_Q1,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, of_lp87565_match_table);
diff --git a/include/linux/mfd/lp87565.h b/include/linux/mfd/lp87565.h
index d0c91ba65525..976447607ea2 100644
--- a/include/linux/mfd/lp87565.h
+++ b/include/linux/mfd/lp87565.h
@@ -17,6 +17,7 @@
 
 enum lp87565_device_type {
 	LP87565_DEVICE_TYPE_UNKNOWN	= 0,
+	LP87565_DEVICE_TYPE_LP87561_Q1,
 	LP87565_DEVICE_TYPE_LP87565_Q1,
 };
 
@@ -249,6 +250,7 @@ enum LP87565_regulator_id {
 	LP87565_BUCK_3,
 	LP87565_BUCK_10,
 	LP87565_BUCK_23,
+	LP87565_BUCK_3210,
 };
 
 /**
-- 
2.17.1
