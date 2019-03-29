From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH 2/5] ARM: dts: am43xx-epos-evm: Keep DCDC3 regulator on in suspend to memory
Date: Fri, 29 Mar 2019 12:53:33 -0500
Message-ID: <20190329175336.19824-2-afd@ti.com>
References: <20190329175336.19824-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190329175336.19824-1-afd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Mike Erdahl <m-erdahl@ti.com>

When going to suspend to ram mode (or rtc-only mode), the DDR regulator
must be told to stay on, else this rail will go down when the PMIC_EN
signal is deasserted.

Signed-off-by: Mike Erdahl <m-erdahl@ti.com>
Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 arch/arm/boot/dts/am43x-epos-evm.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index 7db5cf3facde..606b848d809f 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -620,6 +620,12 @@
 			regulator-name = "vdcdc3";
 			regulator-boot-on;
 			regulator-always-on;
+			regulator-state-mem {
+				regulator-on-in-suspend;
+			};
+			regulator-state-disk {
+				regulator-off-in-suspend;
+			};
 		};
 
 		dcdc4: regulator-dcdc4 {
-- 
2.21.0
