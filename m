From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 4/4] ARM: dts: am57xx-idk-common: Enable PRU-ICSS nodes
Date: Mon, 4 Feb 2019 17:53:57 +0200
Message-ID: <1549295637-24890-5-git-send-email-rogerq@ti.com>
References: <1549295637-24890-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1549295637-24890-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: s-anna@ti.com, nsekhar@ti.com, linux-omap@vger.kernel.org, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com, m-karicheri2@ti.com, david@lechnology.com, woods.technical@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Suman Anna <s-anna@ti.com>

The two PRU-ICSS processor subsystem bus nodes and their corresponding
subsystem nodes were left in disabled state in the base dra7.dts file.
The PRU-ICSSs are supported on only the AM57xx SoCs, so enable these
nodes (both PRU-ICSS1 and PRU-ICSS2 instances) to support them on
all the AM571x, AM572x and AM574x IDK boards. The PRU nodes are
already enabled in the base dts file, and so become effective
automatically with the enabling of these PRU-ICSS nodes.

The corresponding PRU nodes can be disabled later on if there are
no use-cases defined to use a particular PRU core or the whole
PRU-ICSS subsystem itself if both its PRU cores are unused.

Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/am57xx-idk-common.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/am57xx-idk-common.dtsi b/arch/arm/boot/dts/am57xx-idk-common.dtsi
index f7bd264..6991412 100644
--- a/arch/arm/boot/dts/am57xx-idk-common.dtsi
+++ b/arch/arm/boot/dts/am57xx-idk-common.dtsi
@@ -492,3 +492,11 @@
 &cpu0 {
 	vdd-supply = <&smps12_reg>;
 };
+
+&pruss1 {
+	status = "okay";
+};
+
+&pruss2 {
+	status = "okay";
+};
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
