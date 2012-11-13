From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 01/13] MFD: twl-core: Register twl4030-madc child only for twl4030 class
Date: Tue, 13 Nov 2012 09:28:42 +0100
Message-ID: <1352795334-7406-2-git-send-email-peter.ujfalusi@ti.com>
References: <1352795334-7406-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1352795334-7406-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

twl4030-madc driver can only handle twl4030 class MADC. The newer revisions
of twl does not have MADC, instead they have different IP called GPADC which
is not backward compatible.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/mfd/twl-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index a071a86..d7577cb 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -646,7 +646,8 @@ add_children(struct twl4030_platform_data *pdata, unsigned irq_base,
 			return PTR_ERR(child);
 	}
 
-	if (IS_ENABLED(CONFIG_TWL4030_MADC) && pdata->madc) {
+	if (IS_ENABLED(CONFIG_TWL4030_MADC) && pdata->madc &&
+	    twl_class_is_4030()) {
 		child = add_child(2, "twl4030_madc",
 				pdata->madc, sizeof(*pdata->madc),
 				true, irq_base + MADC_INTR_OFFSET, 0);
-- 
1.8.0
