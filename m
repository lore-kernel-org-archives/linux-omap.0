From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/3] ARM: dts: Add minimal dra62x j5-eco evm support
Date: Thu,  3 Dec 2015 15:11:40 -0800
Message-ID: <1449184300-15693-4-git-send-email-tony@atomide.com>
References: <1449184300-15693-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1449184300-15693-1-git-send-email-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Matthijs van Duin <matthijsvanduin@gmail.com>, Neil Armstrong <narmstrong@baylibre.com>, Philipp Rosenberger <ilu@linutronix.de>, Delio Brignoli <dbrignoli@audioscience.com>, Brian Hutchinson <b.hutchman@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

This allows us to boot dra62x j5-eco evm with NFSroot.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/Makefile             |  3 ++-
 arch/arm/boot/dts/dra62x-j5eco-evm.dts | 28 ++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/dra62x-j5eco-evm.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 30bbc37..aa237cf14 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -452,7 +452,8 @@ dtb-$(CONFIG_ARCH_OMAP3) += \
 dtb-$(CONFIG_SOC_TI81XX) += \
 	dm8148-evm.dtb \
 	dm8148-t410.dtb \
-	dm8168-evm.dtb
+	dm8168-evm.dtb \
+	dra62x-j5eco-evm.dtb
 dtb-$(CONFIG_SOC_AM33XX) += \
 	am335x-baltos-ir5221.dtb \
 	am335x-base0033.dtb \
diff --git a/arch/arm/boot/dts/dra62x-j5eco-evm.dts b/arch/arm/boot/dts/dra62x-j5eco-evm.dts
new file mode 100644
index 0000000..49a05d2
--- /dev/null
+++ b/arch/arm/boot/dts/dra62x-j5eco-evm.dts
@@ -0,0 +1,28 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+/dts-v1/;
+
+#include "dra62x.dtsi"
+
+/ {
+	model = "DRA62x J5 Eco EVM";
+	compatible = "ti,dra62x-j5eco-evm", "ti,dra62x", "ti,dm8148";
+
+	memory {
+		device_type = "memory";
+		reg = <0x80000000 0x40000000>;	/* 1 GB */
+	};
+};
+
+&cpsw_emac0 {
+	phy_id = <&davinci_mdio>, <0>;
+	phy-mode = "rgmii";
+};
+
+&cpsw_emac1 {
+	phy_id = <&davinci_mdio>, <1>;
+	phy-mode = "rgmii";
+};
-- 
2.6.2
