From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 16/17] ARM: dts: AM33xx: Add PRU system events for virtio
Date: Thu, 22 Nov 2018 13:39:12 +0200
Message-ID: <1542886753-17625-17-git-send-email-rogerq@ti.com>
References: <1542886753-17625-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542886753-17625-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: robh+dt@kernel.org, bcousson@baylibre.com, ssantosh@kernel.org, ohad@wizery.com, bjorn.andersson@linaro.org, s-anna@ti.com, nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com, m-karicheri2@ti.com, woods.technical@gmail.com, linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, rogerq@ti.com
List-Id: linux-omap@vger.kernel.org

From: Suman Anna <s-anna@ti.com>

Two PRU system events "vring" and "kick" have been added to each
of the PRU nodes in the PRU-ICSS remote processor subsystem to
enable the virtio/rpmsg communication between MPU and that PRU
core. The additions are done in the base am33xx.dtsi file, and
so are inherited by all the AM33xx boards. Do note that PRUSS
is not available on all AM335x SoCs.

The PRU system events is the preferred approach over using OMAP
mailboxes, as it eliminates an external peripheral access from
the PRU-side, and keeps the interrupt generation internal to the
PRUSS. The difference from MPU would be minimal in using one
versus the other.

Mailboxes can still be used if desired. Either approach would
require that an appropriate firmware image is loaded/booted on
the PRU.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index ce42cd9..b7e3f69 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -983,6 +983,9 @@
 					      <0x4a322400 0x100>;
 					reg-names = "iram", "control", "debug";
 					firmware-name = "am335x-pru0-fw";
+					interrupt-parent = <&pruss_intc>;
+					interrupts = <16>, <17>;
+					interrupt-names = "vring", "kick";
 				};
 
 				pru1: pru@4a338000 {
@@ -992,6 +995,9 @@
 					      <0x4a324400 0x100>;
 					reg-names = "iram", "control", "debug";
 					firmware-name = "am335x-pru1-fw";
+					interrupt-parent = <&pruss_intc>;
+					interrupts = <18>, <19>;
+					interrupt-names = "vring", "kick";
 				};
 			};
 		};
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
