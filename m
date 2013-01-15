From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v2 4/5] ARM: dts: AM33XX: Add am335x-evmsk lcdc panel timings
Date: Tue, 15 Jan 2013 19:21:03 +0530
Message-ID: <39ee4570dd03b4b6139048f51fb18ea9653009c7.1358252955.git.afzal@ti.com>
References: <cover.1358252955.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1358252955.git.afzal@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Sekhar Nori <nsekhar@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Update lcdc node with panel timings (typical) for AM335X-EVMSK.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/boot/dts/am335x-evmsk.dts |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index f5a6162..a7e017b 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -248,3 +248,23 @@
 		};
 	};
 };
+
+&lcdc {
+	status = "okay";
+
+	display-timings {
+		480x272p57 {
+			clock-frequency = <9000000>;
+			hactive = <480>;
+			vactive = <272>;
+			hfront-porch = <8>;
+			hback-porch = <43>;
+			hsync-len = <4>;
+			vback-porch = <12>;
+			vfront-porch = <4>;
+			vsync-len = <10>;
+			hsync-active = <1>;
+			vsync-active = <1>;
+		};
+	};
+};
-- 
1.7.9.5
