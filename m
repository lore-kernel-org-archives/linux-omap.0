From: Satish Patel <satish.patel@ti.com>
Subject: [PATCH v2 4/5] ARM: dts: AM43xx: DT entries added for ti-usim
Date: Mon, 20 Jan 2014 10:03:53 +0530
Message-ID: <1390192434-19386-5-git-send-email-satish.patel@ti.com>
References: <1390192434-19386-1-git-send-email-satish.patel@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1390192434-19386-1-git-send-email-satish.patel@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, gregkh@linuxfoundation.org, rob@landley.net
Cc: Satish Patel <satish.patel@ti.com>
List-Id: linux-omap@vger.kernel.org

SoC specific DT entries added for TI's USIM - smart card controller of AM43xx
platfrom.

Signed-off-by: Satish Patel <satish.patel@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 974d103..7ed1cd1 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -663,5 +663,15 @@
 			       <&edma 11>;
 			dma-names = "tx", "rx";
 		};
+
+		usim0: usim@48034000 {
+			compatible = "ti,usim";
+			reg = <0x48034000 0x1000>;
+			interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "usim0";
+			clocks = <&usim0_opt_fck>, <&usim0_opt_fck32>;
+			clock-names = "opt_fck", "opt_fck32";
+			status = "disabled";
+		};
 	};
 };
-- 
1.7.1
