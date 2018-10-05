From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v1 07/11] dt-bindings: regulator: Document new regulator-max-step-microvolt property
Date: Fri,  5 Oct 2018 18:36:34 +0300
Message-ID: <20181005153638.1886-8-digetx@gmail.com>
References: <20181005153638.1886-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181005153638.1886-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Maciej Purski <m.purski@samsung.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, Lucas Stach <l.stach@pengutronix.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Certain hardware may require supply voltage to be changed in steps. Define
new property that allow to describe such hardware.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 Documentation/devicetree/bindings/regulator/regulator.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/regulator.txt b/Documentation/devicetree/bindings/regulator/regulator.txt
index 9b525b657fca..0c3a243c95df 100644
--- a/Documentation/devicetree/bindings/regulator/regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/regulator.txt
@@ -79,6 +79,8 @@ Optional properties:
 - regulator-coupled-max-spread: Array of maximum spread between voltages of
   coupled regulators in microvolts, each value in the array relates to the
   corresponding couple specified by the regulator-coupled-with property.
+- regulator-max-step-microvolt: Maximum difference between current and target
+  voltages that can be changed safely in a single step.
 
 Deprecated properties:
 - regulator-compatible: If a regulator chip contains multiple
-- 
2.19.0
