From: "Philip, Avinash" <avinashphilip@ti.com>
Subject: [PATCH v3 07/10] pwm: pwm-tiehrpwm: pinctrl support
Date: Tue, 20 Nov 2012 10:33:48 +0530
Message-ID: <1353387831-31538-8-git-send-email-avinashphilip@ti.com>
References: <1353387831-31538-1-git-send-email-avinashphilip@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1353387831-31538-1-git-send-email-avinashphilip@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: thierry.reding@avionic-design.de, paul@pwsan.com, tony@atomide.com, linux@arm.linux.org.uk, b-cousson@ti.com
Cc: hvaibhav@ti.com, anilkumar@ti.com, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com, gururaja.hebbar@ti.com, vaibhav.bedia@ti.com, "Philip, Avinash" <avinashphilip@ti.com>
List-Id: linux-omap@vger.kernel.org

Enable pinctrl for pwm-tiehrpwm

Signed-off-by: Philip, Avinash <avinashphilip@ti.com>
---
:100644 100644 b7e63fb... 1cb54aa... M	drivers/pwm/pwm-tiehrpwm.c
 drivers/pwm/pwm-tiehrpwm.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index b7e63fb..1cb54aa 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -26,6 +26,7 @@
 #include <linux/clk.h>
 #include <linux/pm_runtime.h>
 #include <linux/of_device.h>
+#include <linux/pinctrl/consumer.h>
 
 #include "tipwmss.h"
 
@@ -410,6 +411,11 @@ static int __devinit ehrpwm_pwm_probe(struct platform_device *pdev)
 	struct clk *clk;
 	struct ehrpwm_pwm_chip *pc;
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

