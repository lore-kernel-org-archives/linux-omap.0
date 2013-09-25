From: Joel Fernandes <joelf-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 3/9] ARM: dts: Add SHAM data and documentation for AM33XX
Date: Wed, 25 Sep 2013 17:01:03 -0500
Message-ID: <1380146469-29496-4-git-send-email-joelf@ti.com>
References: <1380146469-29496-1-git-send-email-joelf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1380146469-29496-1-git-send-email-joelf-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Jason Kridner <jkridner-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>, Koen Kooi <koen-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>
Cc: Devicetree Discuss <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: "Mark A. Greer" <mgreer-luAo+O/VEmrlveNOaEYElw@public.gmane.org>

Add the generic AM33XX SHAM module's device tree data and
enable it for the am335x-evm, am335x-evmsk, and am335x-bone
platforms.  Also add Documentation file describing the data
for the SHAM module.

CC: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark A. Greer <mgreer-luAo+O/VEmrlveNOaEYElw@public.gmane.org>
---
 .../devicetree/bindings/crypto/omap-sham.txt       | 31 ++++++++++++++++++++++
 arch/arm/boot/dts/am335x-bone.dts                  |  4 +++
 arch/arm/boot/dts/am335x-evm.dts                   |  4 +++
 arch/arm/boot/dts/am335x-evmsk.dts                 |  4 +++
 arch/arm/boot/dts/am33xx.dtsi                      | 10 +++++++
 5 files changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/crypto/omap-sham.txt

diff --git a/Documentation/devicetree/bindings/crypto/omap-sham.txt b/Documentation/devicetree/bindings/crypto/omap-sham.txt
new file mode 100644
index 0000000..b97710f
--- /dev/null
+++ b/Documentation/devicetree/bindings/crypto/omap-sham.txt
@@ -0,0 +1,31 @@
+OMAP SoC SHA crypto Module
+
+Required properties:
+
+- compatible : Should contain entries for this and backward compatible
+  SHAM versions:
+  - "ti,omap2-sham" for OMAP2 & OMAP3.
+  - "ti,omap4-sham" for OMAP4 and AM33XX.
+  Note that these two versions are incompatible.
+- ti,hwmods: Name of the hwmod associated with the SHAM module
+- reg : Offset and length of the register set for the module
+- interrupt-parent : the phandle for the interrupt controller that
+  services interrupts for this module.
+- interrupts : the interrupt number for the SHAM module.
+
+Optional properties:
+- dmas: DMA specifier for the rx dma. See the DMA client binding,
+	Documentation/devicetree/bindings/dma/dma.txt
+- dma-names: DMA request name. Should be "rx" if a dma is present.
+
+Example:
+	/* AM335x */
+	sham: sham@53100000 {
+		compatible = "ti,omap4-sham";
+		ti,hwmods = "sham";
+		reg = <0x53100000 0x200>;
+		interrupt-parent = <&intc>;
+		interrupts = <109>;
+		dmas = <&edma 36>;
+		dma-names = "rx";
+	};
diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
index 0d63348..8a9802e 100644
--- a/arch/arm/boot/dts/am335x-bone.dts
+++ b/arch/arm/boot/dts/am335x-bone.dts
@@ -19,3 +19,7 @@
 &mmc1 {
 	vmmc-supply = <&ldo3_reg>;
 };
+
+&sham {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 23b0a3e..d59e51c 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -522,3 +522,7 @@
 	status = "okay";
 	vmmc-supply = <&vmmc_reg>;
 };
+
+&sham {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index bc93895..d45a330 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -424,3 +424,7 @@
 	status = "okay";
 	vmmc-supply = <&vmmc_reg>;
 };
+
+&sham {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 553adc6..e77aa6e 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -710,5 +710,15 @@
 			#size-cells = <1>;
 			status = "disabled";
 		};
+
+		sham: sham@53100000 {
+			compatible = "ti,omap4-sham";
+			ti,hwmods = "sham";
+			reg = <0x53100000 0x200>;
+			interrupt-parent = <&intc>;
+			interrupts = <109>;
+			dmas = <&edma 36>;
+			dma-names = "rx";
+		};
 	};
 };
-- 
1.8.1.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
