From: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v4 4/5] ARM: dts: DRA7: add entry for qspi mmap region
Date: Mon, 30 Nov 2015 10:45:14 +0530
Message-ID: <1448860515-28336-5-git-send-email-vigneshr@ti.com>
References: <1448860515-28336-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1448860515-28336-1-git-send-email-vigneshr-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Add qspi memory mapped region entries for DRA7xx based SoCs. Also,
update the binding documents for the controller to document this change.

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
---

v4: No changes.

 Documentation/devicetree/bindings/spi/ti_qspi.txt | 14 ++++++++++++++
 arch/arm/boot/dts/dra7.dtsi                       |  7 +++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/ti_qspi.txt b/Documentation/devicetree/bindings/spi/ti_qspi.txt
index 601a360531a5..334aa3f32cbc 100644
--- a/Documentation/devicetree/bindings/spi/ti_qspi.txt
+++ b/Documentation/devicetree/bindings/spi/ti_qspi.txt
@@ -26,3 +26,17 @@ qspi: qspi@4b300000 {
 	spi-max-frequency = <25000000>;
 	ti,hwmods = "qspi";
 };
+
+For dra7xx:
+qspi: qspi@4b300000 {
+	compatible = "ti,dra7xxx-qspi";
+	reg = <0x4b300000 0x100>,
+	      <0x5c000000 0x4000000>,
+	      <0x4a002558 0x4>;
+	reg-names = "qspi_base", "qspi_mmap",
+		    "qspi_ctrlmod";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	spi-max-frequency = <48000000>;
+	ti,hwmods = "qspi";
+};
diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index fe99231cbde5..debe7523643d 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1153,8 +1153,11 @@
 
 		qspi: qspi@4b300000 {
 			compatible = "ti,dra7xxx-qspi";
-			reg = <0x4b300000 0x100>;
-			reg-names = "qspi_base";
+			reg = <0x4b300000 0x100>,
+			      <0x5c000000 0x4000000>,
+			      <0x4a002558 0x4>;
+			reg-names = "qspi_base", "qspi_mmap",
+				    "qspi_ctrlmod";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "qspi";
-- 
2.6.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
