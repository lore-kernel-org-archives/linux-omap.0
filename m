From: "Philip, Avinash" <avinashphilip@ti.com>
Subject: [PATCH v5 05/12] pwm: pwm-tiecap: pinctrl support
Date: Tue, 27 Nov 2012 14:18:10 +0530
Message-ID: <1354006097-25895-6-git-send-email-avinashphilip@ti.com>
References: <1354006097-25895-1-git-send-email-avinashphilip@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1354006097-25895-1-git-send-email-avinashphilip@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@avionic-design.de, paul@pwsan.com, tony@atomide.com, linux@arm.linux.org.uk, b-cousson@ti.com
Cc: hvaibhav@ti.com, anilkumar@ti.com, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com, gururaja.hebbar@ti.com, vaibhav.bedia@ti.com, "Philip, Avinash" <avinashphilip@ti.com>
List-Id: linux-omap@vger.kernel.org

Enable pinctrl for pwm-tiecap if pinctrl driver available, else
bail out with warning message.

Signed-off-by: Philip, Avinash <avinashphilip@ti.com>
---
Changes since v4:
	- Changes warning message.

 drivers/pwm/pwm-tiecap.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/pwm/pwm-tiecap.c b/drivers/pwm/pwm-tiecap.c
index 0f541c5..b4f9d47 100644
--- a/drivers/pwm/pwm-tiecap.c
+++ b/drivers/pwm/pwm-tiecap.c
@@ -26,6 +26,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/pwm.h>
 #include <linux/of_device.h>
+#include <linux/pinctrl/consumer.h>
 
 #include "pwm-tipwmss.h"
 
@@ -200,6 +201,11 @@ static int __devinit ecap_pwm_probe(struct platform_device *pdev)
 	struct clk *clk;
 	struct ecap_pwm_chip *pc;
 	u16 status;
+	struct pinctrl *pinctrl;
+
+	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
+	if (IS_ERR(pinctrl))
+		dev_warn(&pdev->dev, "unable to select pin group\n");
 
 	pc = devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
 	if (!pc) {
-- 
1.7.0.4
