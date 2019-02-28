From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 20/81] ARM: dts: n900: fix mmc1 card detect gpio polarity
Date: Thu, 28 Feb 2019 10:07:12 -0500
Message-ID: <20190228150813.10256-20-sashal@kernel.org>
References: <20190228150813.10256-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190228150813.10256-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Arthur Demchenkov <spinal.by@gmail.com>, Tony Lindgren <tony@atomide.com>, Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Arthur Demchenkov <spinal.by@gmail.com>

[ Upstream commit ac9c908eecde3ed252cb1d67fc79b3c1346f76bc ]

Wrong polarity of card detect GPIO pin leads to the system not
booting from external mmc, if the back cover of N900 is closed.
When the cover is open the system boots fine.

This wasn't noticed before, because of a bug, which was fixed
by commit e63201f19 (mmc: omap_hsmmc: Delete platform data GPIO
CD and WP).

Kernels up to 4.19 ignored the card detect GPIO from DT.

Fixes: e63201f19438 ("mmc: omap_hsmmc: Delete platform data GPIO CD and WP")
Signed-off-by: Arthur Demchenkov <spinal.by@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/omap3-n900.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index 182a53991c901..826920e6b8787 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -814,7 +814,7 @@
 	/* For debugging, it is often good idea to remove this GPIO.
 	   It means you can remove back cover (to reboot by removing
 	   battery) and still use the MMC card. */
-	cd-gpios = <&gpio6 0 GPIO_ACTIVE_HIGH>; /* 160 */
+	cd-gpios = <&gpio6 0 GPIO_ACTIVE_LOW>; /* 160 */
 };
 
 /* most boards use vaux3, only some old versions use vmmc2 instead */
-- 
2.19.1
