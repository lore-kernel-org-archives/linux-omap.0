From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH] ARM: dts: am43xx-epos-evm: Enable SGX on EPOS boards
Date: Mon, 18 Sep 2017 12:31:30 -0500
Message-ID: <20170918173130.17657-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Yogesh Siraswar <yogeshs@ti.com>

The SGX IP is valid and usable on AM438x devices, enable this
here.

Signed-off-by: Yogesh Siraswar <yogeshs@ti.com>
Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 arch/arm/boot/dts/am43x-epos-evm.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index 9d276af7c539..17c081b2cff3 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -796,3 +796,7 @@
 	assigned-clocks = <&mux_synctimer32k_ck>;
 	assigned-clock-parents = <&clkdiv32k_ick>;
 };
+
+&sgx {
+	status = "okay";
+};
-- 
2.14.1
