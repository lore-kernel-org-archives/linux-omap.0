From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v2] dt-bindings: regulator: Change regulator-coupled-max-spread property
Date: Mon, 19 Nov 2018 00:56:16 +0300
Message-ID: <20181118215619.21518-2-digetx@gmail.com>
References: <20181118215619.21518-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181118215619.21518-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc: linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Redefine binding for regulator-coupled-max-spread property in a way that
max-spread values are defined per regulator couple instead of defining
single max-spread for the whole group of coupled regulators.

With that change the following regulators coupling configuration will be
possible:

regA: regulatorA {
	regulator-coupled-with = <&regB &regC>;
	regulator-coupled-max-spread = <100000 300000>;
};

regB: regulatorB {
	regulator-coupled-with = <&regA &regC>;
	regulator-coupled-max-spread = <100000 200000>;
};

regC: regulatorC {
	regulator-coupled-with = <&regA &regB>;
	regulator-coupled-max-spread = <300000 200000>;
};

Note that the regulator-coupled-max-spread property does not have any
users yet, hence it's okay to change the binding.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---

v2: Added note to the commit description, saying that the property doesn't
    have users yet. That was requested by Rob Herring in the review comment
    to v1.

 Documentation/devicetree/bindings/regulator/regulator.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/regulator.txt b/Documentation/devicetree/bindings/regulator/regulator.txt
index a7cd36877bfe..9b525b657fca 100644
--- a/Documentation/devicetree/bindings/regulator/regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/regulator.txt
@@ -76,8 +76,9 @@ Optional properties:
 - regulator-coupled-with: Regulators with which the regulator
   is coupled. The linkage is 2-way - all coupled regulators should be linked
   with each other. A regulator should not be coupled with its supplier.
-- regulator-coupled-max-spread: Max spread between voltages of coupled regulators
-  in microvolts.
+- regulator-coupled-max-spread: Array of maximum spread between voltages of
+  coupled regulators in microvolts, each value in the array relates to the
+  corresponding couple specified by the regulator-coupled-with property.
 
 Deprecated properties:
 - regulator-compatible: If a regulator chip contains multiple
-- 
2.19.1
