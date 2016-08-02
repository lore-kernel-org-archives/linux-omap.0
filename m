From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH] ARM: dts: am57xx-idk-common: Enable support for QSPI
Date: Tue, 2 Aug 2016 10:51:47 +0530
Message-ID: <20160802052147.11085-1-vigneshr@ti.com>
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
To: Tony Lindgren <tony@atomide.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Vignesh R <vigneshr@ti.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

AM572x IDK has a Spansion s25fl256s1 QSPI flash on the EVM connected to
TI QSPI IP over CS0. Hence, add QSPI and flash slave DT nodes.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 arch/arm/boot/dts/am57xx-idk-common.dtsi | 49 ++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/arm/boot/dts/am57xx-idk-common.dtsi b/arch/arm/boot/dts/am57xx-idk-common.dtsi
index 0e63b9dff6e7..03cec62260e1 100644
--- a/arch/arm/boot/dts/am57xx-idk-common.dtsi
+++ b/arch/arm/boot/dts/am57xx-idk-common.dtsi
@@ -304,3 +304,52 @@
 	ti,non-removable;
 	max-frequency = <96000000>;
 };
+
+&qspi {
+	status = "okay";
+
+	spi-max-frequency = <76800000>;
+	m25p80@0 {
+		compatible = "s25fl256s1", "jedec,spi-nor";
+		spi-max-frequency = <76800000>;
+		reg = <0>;
+		spi-tx-bus-width = <1>;
+		spi-rx-bus-width = <4>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		/* MTD partition table.
+		 * The ROM checks the first four physical blocks
+		 * for a valid file to boot and the flash here is
+		 * 64KiB block size.
+		 */
+		partition@0 {
+			label = "QSPI.SPL";
+			reg = <0x00000000 0x000040000>;
+		};
+		partition@1 {
+			label = "QSPI.u-boot";
+			reg = <0x00040000 0x00100000>;
+		};
+		partition@2 {
+			label = "QSPI.u-boot-spl-os";
+			reg = <0x00140000 0x00080000>;
+		};
+		partition@3 {
+			label = "QSPI.u-boot-env";
+			reg = <0x001c0000 0x00010000>;
+		};
+		partition@4 {
+			label = "QSPI.u-boot-env.backup1";
+			reg = <0x001d0000 0x0010000>;
+		};
+		partition@5 {
+			label = "QSPI.kernel";
+			reg = <0x001e0000 0x0800000>;
+		};
+		partition@6 {
+			label = "QSPI.file-system";
+			reg = <0x009e0000 0x01620000>;
+		};
+	};
+};
-- 
2.9.2
