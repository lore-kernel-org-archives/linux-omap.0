From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 008/123] ARM: dts: am3517: Fix pinmuxing for CD on MMC1
Date: Wed,  5 Dec 2018 04:34:00 -0500
Message-ID: <20181205093555.5386-8-sashal@kernel.org>
References: <20181205093555.5386-1-sashal@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181205093555.5386-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Adam Ford <aford173@gmail.com>, Tony Lindgren <tony@atomide.com>, Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Adam Ford <aford173@gmail.com>

[ Upstream commit e7f4ffffa972db4820c23ff9831a6a4f3f6d8cc5 ]

The MMC1 is active low, not active high.  For some reason,
this worked with different combination of U-Boot and kernels,
but it's supposed to be active low and is currently broken.

Fixes: cfaa856a2510 ("ARM: dts: am3517: Add pinmuxing, CD and
WP for MMC1") #kernel 4.18+

Signed-off-by: Adam Ford <aford173@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/am3517-evm.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am3517-evm.dts b/arch/arm/boot/dts/am3517-evm.dts
index 1d158cfda15f..c45aef806870 100644
--- a/arch/arm/boot/dts/am3517-evm.dts
+++ b/arch/arm/boot/dts/am3517-evm.dts
@@ -227,7 +227,7 @@
 	vmmc-supply = <&vmmc_fixed>;
 	bus-width = <4>;
 	wp-gpios = <&gpio4 30 GPIO_ACTIVE_HIGH>; /* gpio_126 */
-	cd-gpios = <&gpio4 31 GPIO_ACTIVE_HIGH>; /* gpio_127 */
+	cd-gpios = <&gpio4 31 GPIO_ACTIVE_LOW>; /* gpio_127 */
 };
 
 &mmc3 {
-- 
2.17.1
