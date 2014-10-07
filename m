From: Romain Perier <romain.perier@gmail.com>
Subject: [RFC PATCH v1 4/4] dt-bindings: Document the property poweroff-source for act8865 regulator
Date: Tue,  7 Oct 2014 19:45:04 +0000
Message-ID: <1412711104-15902-4-git-send-email-romain.perier@gmail.com>
References: <1412711104-15902-1-git-send-email-romain.perier@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1412711104-15902-1-git-send-email-romain.perier@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org
Cc: broonie@kernel.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, heiko@sntech.de, sameo@linux.intel.com, lee.jones@linaro.org, grant.likely@linaro.org, robh@kernel.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, anton@enomsg.org, ldewangan@nvidia.com, linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Romain Perier <romain.perier@gmail.com>
---
 Documentation/devicetree/bindings/regulator/act8865-regulator.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/act8865-regulator.txt b/Documentation/devicetree/bindings/regulator/act8865-regulator.txt
index 865614b..4d7f33e 100644
--- a/Documentation/devicetree/bindings/regulator/act8865-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/act8865-regulator.txt
@@ -5,6 +5,10 @@ Required properties:
 - compatible: "active-semi,act8846" or "active-semi,act8865"
 - reg: I2C slave address
 
+Optional properties:
+- poweroff-source: Telling whether or not this pmic is controlling
+  the system power
+
 Any standard regulator properties can be used to configure the single regulator.
 
 The valid names for regulators are:
-- 
1.9.1
