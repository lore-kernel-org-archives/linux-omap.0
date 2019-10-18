From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 3/7] ARM: DTS: am3517: add sgx gpu child node
Date: Fri, 18 Oct 2019 20:46:26 +0200
Message-ID: <8102dc33bcf21d653539cb43fb41ce600c1f9e74.1571424390.git.hns@goldelico.com>
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

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/am3517.dtsi | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/am3517.dtsi b/arch/arm/boot/dts/am3517.dtsi
index bf3002009b00..5716bb33d7fe 100644
--- a/arch/arm/boot/dts/am3517.dtsi
+++ b/arch/arm/boot/dts/am3517.dtsi
@@ -97,7 +97,7 @@
 		 * revision register instead of the unreadable OCP revision
 		 * register.
 		 */
-		sgx_module: target-module@50000000 {
+		target-module@50000000 {
 			compatible = "ti,sysc-omap2", "ti,sysc";
 			reg = <0x50000014 0x4>;
 			reg-names = "rev";
@@ -107,10 +107,13 @@
 			#size-cells = <1>;
 			ranges = <0 0x50000000 0x4000>;
 
-			/*
-			 * Closed source PowerVR driver, no child device
-			 * binding or driver in mainline
-			 */
+			sgx: sgx@0 {
+				compatible = "img,sgx530-125", "img,sgx530", "ti,omap-am3517-sgx530-125";
+				reg = <0x0 0x4000>;
+				reg-names = "sgx";
+				interrupts = <21>;
+				timer = <&timer11>;
+			};
 		};
 	};
 };
-- 
2.19.1
