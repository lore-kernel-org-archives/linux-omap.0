From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] ti-thermal-common: Delete an error message for a failed
 memory allocation in ti_thermal_build_data()
Date: Thu, 18 May 2017 22:30:07 +0200
Message-ID: <d85aaf2b-0db5-1ad0-f57f-1000c96e1c38@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Language: en-GB
Sender: linux-pm-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>, Zhang Rui <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-omap@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 18 May 2017 22:20:12 +0200

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
index 02790f69e26c..5d29aa35cc34 100644
--- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
@@ -160,10 +160,9 @@ static struct ti_thermal_data
 	struct ti_thermal_data *data;
 
 	data = devm_kzalloc(bgp->dev, sizeof(*data), GFP_KERNEL);
-	if (!data) {
-		dev_err(bgp->dev, "kzalloc fail\n");
+	if (!data)
 		return NULL;
-	}
+
 	data->sensor_id = id;
 	data->bgp = bgp;
 	data->mode = THERMAL_DEVICE_ENABLED;
-- 
2.13.0
