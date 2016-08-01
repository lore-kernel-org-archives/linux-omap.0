From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH] ARM: dts: dra7xx: Increase spi-max-frequency to 76.8MHz for
 QSPI
Date: Mon, 1 Aug 2016 18:36:55 +0530
Message-ID: <20160801130655.15004-1-vigneshr@ti.com>
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

According to AM572x DM SPRS953A, QSPI maximum bus speed can be 76.8MHz.
Therefore, increase the spi-max-frequency value of QSPI node to 76.8MHz
for DRA74 and DRA72 evm. This improves flash raw read speed by ~2MB/s.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 arch/arm/boot/dts/dra7-evm.dts          | 4 ++--
 arch/arm/boot/dts/dra72-evm-common.dtsi | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index bafcfac067ec..f9d1170033fd 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -664,10 +664,10 @@
 &qspi {
 	status = "okay";
 
-	spi-max-frequency = <64000000>;
+	spi-max-frequency = <76800000>;
 	m25p80@0 {
 		compatible = "s25fl256s1";
-		spi-max-frequency = <64000000>;
+		spi-max-frequency = <76800000>;
 		reg = <0>;
 		spi-tx-bus-width = <1>;
 		spi-rx-bus-width = <4>;
diff --git a/arch/arm/boot/dts/dra72-evm-common.dtsi b/arch/arm/boot/dts/dra72-evm-common.dtsi
index 9d3cf50ca37e..c94d8d64710d 100644
--- a/arch/arm/boot/dts/dra72-evm-common.dtsi
+++ b/arch/arm/boot/dts/dra72-evm-common.dtsi
@@ -681,10 +681,10 @@
 &qspi {
 	status = "okay";
 
-	spi-max-frequency = <64000000>;
+	spi-max-frequency = <76800000>;
 	m25p80@0 {
 		compatible = "s25fl256s1";
-		spi-max-frequency = <64000000>;
+		spi-max-frequency = <76800000>;
 		reg = <0>;
 		spi-tx-bus-width = <1>;
 		spi-rx-bus-width = <4>;
-- 
2.9.2
