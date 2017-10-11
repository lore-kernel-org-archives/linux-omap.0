From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH] ARM: dts: dra7-evm: Move pcie RC node to common file
Date: Wed, 11 Oct 2017 13:34:30 +0530
Message-ID: <20171011080430.13160-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>, nsekhar@ti.com, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, Ravikumar Kattekola <rk@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: Ravikumar Kattekola <rk@ti.com>

Move the pcie_rc node to common file so that it can be
used by dra76-evm as well.

Signed-off-by: Ravikumar Kattekola <rk@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/boot/dts/dra7-evm-common.dtsi | 4 ++++
 arch/arm/boot/dts/dra7-evm.dts         | 4 ----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/dra7-evm-common.dtsi b/arch/arm/boot/dts/dra7-evm-common.dtsi
index 343e95f9a001..e088bb93636a 100644
--- a/arch/arm/boot/dts/dra7-evm-common.dtsi
+++ b/arch/arm/boot/dts/dra7-evm-common.dtsi
@@ -256,3 +256,7 @@
 		status = "okay";
 	};
 };
+
+&pcie1_rc {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index aa426dabb6c3..ef9c90daa74b 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -497,7 +497,3 @@
 	pinctrl-1 = <&dcan1_pins_sleep>;
 	pinctrl-2 = <&dcan1_pins_default>;
 };
-
-&pcie1_rc {
-	status = "okay";
-};
-- 
2.11.0
