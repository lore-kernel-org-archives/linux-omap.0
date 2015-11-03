From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH v2 4/5] ARM: dts: DRA7: add entry for qspi mmap region
Date: Tue, 3 Nov 2015 15:36:13 +0530
Message-ID: <1446545174-14193-5-git-send-email-vigneshr@ti.com>
References: <1446545174-14193-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1446545174-14193-1-git-send-email-vigneshr@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, Michal Suchanek <hramrach@gmail.com>, Russell King <linux@arm.linux.org.uk>, Vignesh R <vigneshr@ti.com>, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Add qspi memory mapped region entries for DRA7xx based SoCs. Also,
update the binding documents for the controller to document this change.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 Documentation/devicetree/bindings/spi/ti_qspi.txt | 13 +++++++++++++
 arch/arm/boot/dts/dra7.dtsi                       |  6 ++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/ti_qspi.txt b/Documentation/devicetree/bindings/spi/ti_qspi.txt
index 601a360531a5..f05dd631bef1 100644
--- a/Documentation/devicetree/bindings/spi/ti_qspi.txt
+++ b/Documentation/devicetree/bindings/spi/ti_qspi.txt
@@ -26,3 +26,16 @@ qspi: qspi@4b300000 {
 	spi-max-frequency = <25000000>;
 	ti,hwmods = "qspi";
 };
+
+For dra7xx:
+qspi: qspi@4b300000 {
+	compatible = "ti,dra7xxx-qspi";
+	reg = <0x4b300000 0x100>, <0x4a002558 0x4>,
+	      <0x5c000000 0x4000000>;
+	reg-names = "qspi_base", "qspi_ctrlmod",
+		    "qspi_mmap";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	spi-max-frequency = <48000000>;
+	ti,hwmods = "qspi";
+};
diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index e289c706d27d..13c2f10ec217 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1108,8 +1108,10 @@
 
 		qspi: qspi@4b300000 {
 			compatible = "ti,dra7xxx-qspi";
-			reg = <0x4b300000 0x100>;
-			reg-names = "qspi_base";
+			reg = <0x4b300000 0x100>, <0x4a002558 0x4>,
+			      <0x5c000000 0x4000000>;
+			reg-names = "qspi_base", "qspi_ctrlmod",
+				    "qspi_mmap";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "qspi";
-- 
2.6.2
