From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v4 3/8] ARM: DTS: am3517: add sgx gpu child node
Date: Tue, 17 Dec 2019 19:02:01 +0100
Message-ID: <2b4a61c0ca433dc8577f6f23d68af083cc32f2d6.1576605726.git.hns@goldelico.com>
References: <cover.1576605726.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1576605726.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Paul Cercueil <paul@crapouillou.net>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paulburton@kernel.org>, James Hogan <jhogan@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, openpvrsgx-devgroup@letux.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com, linux-mips@vger.kernel.org, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

and add interrupt.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/am3517.dtsi | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/am3517.dtsi b/arch/arm/boot/dts/am3517.dtsi
index 125379ecab2f..6d2ad5e5f1a6 100644
--- a/arch/arm/boot/dts/am3517.dtsi
+++ b/arch/arm/boot/dts/am3517.dtsi
@@ -128,7 +128,7 @@
 		 * revision register instead of the unreadable OCP revision
 		 * register.
 		 */
-		sgx_module: target-module@50000000 {
+		target-module@50000000 {
 			compatible = "ti,sysc-omap2", "ti,sysc";
 			reg = <0x50000014 0x4>;
 			reg-names = "rev";
@@ -138,10 +138,11 @@
 			#size-cells = <1>;
 			ranges = <0 0x50000000 0x4000>;
 
-			/*
-			 * Closed source PowerVR driver, no child device
-			 * binding or driver in mainline
-			 */
+			sgx: gpu@0 {
+				compatible = "ti,am3517-sgx530-125", "img,sgx530-125", "img,sgx530";
+				reg = <0x0 0x4000>;
+				interrupts = <21>;
+			};
 		};
 	};
 };
-- 
2.23.0
