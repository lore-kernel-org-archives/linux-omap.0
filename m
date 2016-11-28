From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v3] Documentation: pinctrl: palmas: Add ti,palmas-powerhold-override property definition
Date: Mon, 28 Nov 2016 09:31:58 +0530
Message-ID: <1480305718-5127-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: linus.walleij@linaro.org
Cc: j-keerthy@ti.com, t-kristo@ti.com, robh+dt@kernel.org, tony@atomide.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

GPIO7 is configured in POWERHOLD mode which has higher priority
over DEV_ON bit and keeps the PMIC supplies on even after the DEV_ON
bit is turned off. This property enables driver to over ride the
POWERHOLD value to GPIO7 so as to turn off the PMIC in power off
scenarios.

Signed-off-by: Keerthy <j-keerthy@ti.com>
Acked-by: Rob Herring <robh@kernel.org>
---

Remaining patches of the series are already queued.

Changes in v3: Added Rob's Ack.

 Documentation/devicetree/bindings/pinctrl/pinctrl-palmas.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-palmas.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-palmas.txt
index caf297b..c28d4eb8 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-palmas.txt
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-palmas.txt
@@ -35,6 +35,15 @@ Optional properties:
 - ti,palmas-enable-dvfs2: Enable DVFS2. Configure pins for DVFS2 mode.
 	Selection primary or secondary function associated to GPADC_START
 	and SYSEN2 pin/pad for DVFS2 interface
+- ti,palmas-override-powerhold: This is applicable for PMICs for which
+	GPIO7 is configured in POWERHOLD mode which has higher priority
+	over DEV_ON bit and keeps the PMIC supplies on even after the DEV_ON
+	bit is turned off. This property enables driver to over ride the
+	POWERHOLD value to GPIO7 so as to turn off the PMIC in power off
+	scenarios. So for GPIO7 if ti,palmas-override-powerhold is set
+	then the GPIO_7 field should never be muxed to anything else.
+	It should be set to POWERHOLD by default and only in case of
+	power off scenarios the driver will over ride the mux value.
 
 This binding uses the following generic properties as defined in
 pinctrl-bindings.txt:
-- 
1.9.1

