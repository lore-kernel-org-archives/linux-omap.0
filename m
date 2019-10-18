From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 5/7] ARM: DTS: omap36xx: add sgx gpu child node
Date: Fri, 18 Oct 2019 20:46:28 +0200
Message-ID: <e0021cc2a92ff07c31dc663150965416ad143e0f.1571424390.git.hns@goldelico.com>
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

Tested on GTA04 and BeagleBoard XM.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap36xx.dtsi | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/omap36xx.dtsi b/arch/arm/boot/dts/omap36xx.dtsi
index 1e552f08f120..4d813cce8676 100644
--- a/arch/arm/boot/dts/omap36xx.dtsi
+++ b/arch/arm/boot/dts/omap36xx.dtsi
@@ -145,7 +145,7 @@
 		 * "ti,sysc-omap4" type register with just sidle and midle bits
 		 * available while omap34xx has "ti,sysc-omap2" type sysconfig.
 		 */
-		sgx_module: target-module@50000000 {
+		target-module@50000000 {
 			compatible = "ti,sysc-omap4", "ti,sysc";
 			reg = <0x5000fe00 0x4>,
 			      <0x5000fe10 0x4>;
@@ -162,10 +162,13 @@
 			#size-cells = <1>;
 			ranges = <0 0x50000000 0x2000000>;
 
-			/*
-			 * Closed source PowerVR driver, no child device
-			 * binding or driver in mainline
-			 */
+			sgx: sgx@0 {
+				compatible = "img,sgx530-125", "img,sgx530", "ti,omap-omap3-sgx530-125";
+				reg = <0x0 0x10000>;	/* 64kB */
+				reg-names = "sgx";
+				interrupts = <21>;
+				timer = <&timer11>;
+			};
 		};
 	};
 
-- 
2.19.1
