From: "Philip, Avinash" <avinashphilip@ti.com>
Subject: [PATCH v3 05/10] pwm: pwm-tiecap: pinctrl support
Date: Tue, 20 Nov 2012 10:33:46 +0530
Message-ID: <1353387831-31538-6-git-send-email-avinashphilip@ti.com>
References: <1353387831-31538-1-git-send-email-avinashphilip@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56406 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750759Ab2KTFME (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Nov 2012 00:12:04 -0500
In-Reply-To: <1353387831-31538-1-git-send-email-avinashphilip@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: thierry.reding@avionic-design.de, paul@pwsan.com, tony@atomide.com, linux@arm.linux.org.uk, b-cousson@ti.com
Cc: hvaibhav@ti.com, anilkumar@ti.com, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com, gururaja.hebbar@ti.com, vaibhav.bedia@ti.com, "Philip, Avinash" <avinashphilip@ti.com>

Enable pinctrl for pwm-tiecap

Signed-off-by: Philip, Avinash <avinashphilip@ti.com>
---
:100644 100644 351199b... 3b66e22... M	drivers/pwm/pwm-tiecap.c
 drivers/pwm/pwm-tiecap.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/pwm/pwm-tiecap.c b/drivers/pwm/pwm-tiecap.c
index 351199b..3b66e22 100644
--- a/drivers/pwm/pwm-tiecap.c
+++ b/drivers/pwm/pwm-tiecap.c
@@ -26,6 +26,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/pwm.h>
 #include <linux/of_device.h>
+#include <linux/pinctrl/consumer.h>
 
 #include "tipwmss.h"
 
@@ -202,6 +203,11 @@ static int __devinit ecap_pwm_probe(struct platform_device *pdev)
 	struct clk *clk;
 	struct ecap_pwm_chip *pc;
 	u16 status;
+	struct pinctrl *pinctrl;
+
+	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
+	if (IS_ERR(pinctrl))
+		dev_warn(&pdev->dev, "failed to configure pins from driver\n");
 
 	pc = devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
 	if (!pc) {
-- 
1.7.0.4

