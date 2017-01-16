From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH 5/6] ARM: dts: am335x-sl50: Enable the MCP23017 GPIO Expander.
Date: Mon, 16 Jan 2017 17:57:35 +0100
Message-ID: <20170116165736.17197-6-enric.balletbo@collabora.com>
References: <20170116165736.17197-1-enric.balletbo@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170116165736.17197-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Add support for the 16-Bit I/O Expander connected via the I2C bus.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 arch/arm/boot/dts/am335x-sl50.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-sl50.dts b/arch/arm/boot/dts/am335x-sl50.dts
index fddef18..010c99e 100644
--- a/arch/arm/boot/dts/am335x-sl50.dts
+++ b/arch/arm/boot/dts/am335x-sl50.dts
@@ -313,6 +313,10 @@
 		reg = <0x50>;
 	};
 
+	gpio_exp: mcp23017@20 {
+		compatible = "microchip,mcp23017";
+		reg = <0x20>;
+	};
 
 };
 
-- 
2.9.3
