From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCH 3/4] arm/dts: omap5-evm: Add keypad data
Date: Mon, 13 Aug 2012 15:35:12 +0530
Message-ID: <1344852313-30484-4-git-send-email-sourav.poddar@ti.com>
References: <1344852313-30484-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1344852313-30484-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Sourav Poddar <sourav.poddar@ti.com>, Benoit Cousson <b-cousson@ti.com>, Felipe Balbi <balbi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
List-Id: linux-omap@vger.kernel.org

Add keypad data node in omap5 device tree file.
Also fill the device tree binding parameters
with the required value in "omap5-evm" dts file.

Tested on omap5430 evm with 3.5 custom kernel.

Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
---
v1->v2
Add key names as comments
 arch/arm/boot/dts/omap5-evm.dts |   12 ++++++++++++
 arch/arm/boot/dts/omap5.dtsi    |    5 +++++
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap5-evm.dts b/arch/arm/boot/dts/omap5-evm.dts
index 45a8aeb..c2ea189 100644
--- a/arch/arm/boot/dts/omap5-evm.dts
+++ b/arch/arm/boot/dts/omap5-evm.dts
@@ -17,6 +17,18 @@
 		device_type = "memory";
 		reg = <0x80000000 0x40000000>; /* 1 GB */
 	};
+
+	keypad {
+		keypad,num-rows = <8>;
+		keypad,num-columns = <8>;
+		linux,keymap = < 0x02020073  /* VOLUP */
+			0x02030072  /* VOLDOWM */
+			0x020400e7  /* SEND */
+			0x02050066  /* HOME */
+			0x0206006b  /* END */
+			0x020700d9 >; /* SEARCH */
+		linux,input-no-autorepeat;
+	};
 };
 
 &i2c4 {
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 6b68dfe..c38b823 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -216,4 +216,9 @@
 			clock-frequency = <48000000>;
 		};
 	};
+
+	keypad {
+		compatible = "ti,omap4-keypad";
+		ti,hwmods = "kbd";
+	};
 };
-- 
1.7.1
