From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 7/7] ARM: DTS: omap5: add sgx gpu child node
Date: Fri, 18 Oct 2019 20:46:30 +0200
Message-ID: <790e680db41f12c5962a5ed4ffe468615afe9716.1571424390.git.hns@goldelico.com>
References: <cover.1571424390.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1571424390.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

and add timer and interrupt.

Teste on Pyra-Handheld.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap5.dtsi | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 1fb7937638f0..041a05b1cc4d 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -274,10 +274,14 @@
 			#size-cells = <1>;
 			ranges = <0 0x56000000 0x2000000>;
 
-			/*
-			 * Closed source PowerVR driver, no child device
-			 * binding or driver in mainline
-			 */
+			sgx: sgx@0 {
+				compatible = "img,sgx544-116", "img,sgx544", "ti,omap-omap5-sgx544-116";
+				reg = <0x0 0x10000>;
+				reg-names = "sgx";
+				interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
+				timer = <&timer11>;
+				img,cores = <2>;
+			};
 		};
 
 		dss: dss@58000000 {
-- 
2.19.1
