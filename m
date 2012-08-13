From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCHv2 2/4] arm/dts: omap5-evm: Add tmp102 sensor support
Date: Mon, 13 Aug 2012 15:35:11 +0530
Message-ID: <1344852313-30484-3-git-send-email-sourav.poddar@ti.com>
References: <1344852313-30484-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1344852313-30484-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Sourav Poddar <sourav.poddar@ti.com>, Benoit Cousson <b-cousson@ti.com>, Felipe Balbi <balbi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
List-Id: linux-omap@vger.kernel.org

Add tmp102 temperature sensor data in omap5 evm dts file.

Tested on omap5430 evm with 3.5 custom kernel.

Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
---
 arch/arm/boot/dts/omap5-evm.dts |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap5-evm.dts b/arch/arm/boot/dts/omap5-evm.dts
index 200c39a..45a8aeb 100644
--- a/arch/arm/boot/dts/omap5-evm.dts
+++ b/arch/arm/boot/dts/omap5-evm.dts
@@ -18,3 +18,12 @@
 		reg = <0x80000000 0x40000000>; /* 1 GB */
 	};
 };
+
+&i2c4 {
+	clock-frequency = <400000>;
+
+	tmp102@48{
+		compatible = "ti,tmp102";
+		reg = <0x48>;
+	};
+};
-- 
1.7.1
