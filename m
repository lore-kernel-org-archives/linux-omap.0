From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2] thermal: ti-soc-thermal: fix incorrect entry in
 omap5430_adc_to_temp[]
Date: Wed, 02 May 2018 16:14:32 +0200
Message-ID: <17742083.Vu59BImYbG@amdc3058>
References: <CGME20180502141432eucas1p1c85aa366979b73c59a46ec0c2f7ef8e6@eucas1p1.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Entry for Index 941 has one zero too much. Fix it.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
v2:
- Fix patch description.

 drivers/thermal/ti-soc-thermal/omap5-thermal-data.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/thermal/ti-soc-thermal/omap5-thermal-data.c
===================================================================
--- a/drivers/thermal/ti-soc-thermal/omap5-thermal-data.c	2018-04-30 16:23:42.000000000 +0200
+++ b/drivers/thermal/ti-soc-thermal/omap5-thermal-data.c	2018-05-02 14:16:09.461434201 +0200
@@ -310,7 +310,7 @@ omap5430_adc_to_temp[
 	119800, 120200, 120600, 121000, 121400, 121800, 122400, 122600, 123000,
 	123400,
 	/* Index 940 - 945 */
-	123800, 1242000, 124600, 124900, 125000, 125000,
+	123800, 124200, 124600, 124900, 125000, 125000,
 };
 
 /* OMAP54xx ES2.0 data */
