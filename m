From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH 3/3] ARM: dts: am571x-idk: Add Industrial input load trigger
Date: Fri, 31 Aug 2018 14:34:03 -0500
Message-ID: <20180831193403.26777-3-afd@ti.com>
References: <20180831193403.26777-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180831193403.26777-1-afd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>
List-Id: linux-omap@vger.kernel.org

The SN65HVS882 load trigger is attached to GPIO2_23 on the AM571x IDK.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 arch/arm/boot/dts/am571x-idk.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/am571x-idk.dts b/arch/arm/boot/dts/am571x-idk.dts
index a206f3e344d7..afe188c5ec91 100644
--- a/arch/arm/boot/dts/am571x-idk.dts
+++ b/arch/arm/boot/dts/am571x-idk.dts
@@ -147,6 +147,10 @@
 	vbus-gpio = <&gpio7 22 GPIO_ACTIVE_HIGH>;
 };
 
+&sn65hvs882 {
+	load-gpios = <&gpio2 23 GPIO_ACTIVE_LOW>;
+};
+
 &mailbox5 {
 	status = "okay";
 	mbox_ipu1_ipc3x: mbox_ipu1_ipc3x {
-- 
2.18.0
