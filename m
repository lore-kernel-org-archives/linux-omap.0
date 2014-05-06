From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [TEMP PATCH 17/17] ARM: dts: dra7: Add *resets* property for PCIe dt node
Date: Tue, 6 May 2014 19:04:03 +0530
Message-ID: <1399383244-14556-18-git-send-email-kishon@ti.com>
References: <1399383244-14556-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1399383244-14556-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-pci@vger.kernel.org
Cc: rogerq@ti.com, balajitk@ti.com, Kishon Vijay Abraham I <kishon@ti.com>, Dan Murphy <dmurphy@ti.com>
List-Id: linux-omap@vger.kernel.org

Added *resets* and *reset-names* properies for PCIe dt node.
The documention for this node can be found @ ../bindings/pci/ti-pci.txt.

Cc: Dan Murphy <dmurphy@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 20b1a09..7bc0555 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1031,6 +1031,8 @@
 			ti,hwmods = "pcie1";
 			phys = <&pcie1_phy>;
 			phy-names = "pcie-phy";
+			resets = <&prm_resets &device_reset>;
+			reset-names = "reset";
 		};
 
 		sata: sata@4a141100 {
-- 
1.7.9.5
