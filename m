From: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 4/4] MFD: twl-core: regulator configuration for twl6030 V1V8,
	V2V1 SMPS
Date: Tue, 28 Feb 2012 15:09:13 +0530
Message-ID: <1330421953-29517-5-git-send-email-rnayak@ti.com>
References: <1330421953-29517-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <1330421953-29517-1-git-send-email-rnayak-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Cc: linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Misael Lopez Cruz <misael.lopez-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lrg-l0cyMroinI0@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>

To be able to attach consumers to these supplies from board
files we need to have regulator_init_data for them.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Signed-off-by: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
Cc: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Misael Lopez Cruz <misael.lopez-l0cyMroinI0@public.gmane.org>
Cc: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
---
 drivers/mfd/twl-core.c  |   10 ++++++++++
 include/linux/i2c/twl.h |    2 ++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index e1d3a64..6cb1061 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -966,6 +966,16 @@ add_children(struct twl4030_platform_data *pdata, unsigned long features)
 		if (IS_ERR(child))
 			return PTR_ERR(child);
 
+		child = add_regulator(TWL6030_REG_V1V8, pdata->v1v8,
+					features);
+		if (IS_ERR(child))
+			return PTR_ERR(child);
+
+		child = add_regulator(TWL6030_REG_V2V1, pdata->v2v1,
+					features);
+		if (IS_ERR(child))
+			return PTR_ERR(child);
+
 		child = add_regulator(TWL6030_REG_VMMC, pdata->vmmc,
 					features);
 		if (IS_ERR(child))
diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
index f66c031..7fcab23 100644
--- a/include/linux/i2c/twl.h
+++ b/include/linux/i2c/twl.h
@@ -734,6 +734,8 @@ struct twl4030_platform_data {
 	struct regulator_init_data              *vcxio;
 	struct regulator_init_data              *vusb;
 	struct regulator_init_data		*clk32kg;
+	struct regulator_init_data              *v1v8;
+	struct regulator_init_data              *v2v1;
 	/* TWL6025 LDO regulators */
 	struct regulator_init_data		*ldo1;
 	struct regulator_init_data		*ldo2;
-- 
1.7.1
