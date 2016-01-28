From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 5/7] usb: isp1301-omap: mark power_up as __maybe_unused
Date: Thu, 28 Jan 2016 17:23:13 +0100
Message-ID: <1453998206-3490016-1-git-send-email-arnd@arndb.de>
References: <1453997722-3489596-1-git-send-email-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453997722-3489596-1-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, Felipe Balbi <balbi@ti.com>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Robert Jarzmik <robert.jarzmik@free.fr>, Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@zonque.org>, Imre Kaloz <kaloz@openwrt.org>, Krzysztof Halasa <khalasa@piap.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The power_up function is used for otg or udc mode, but nost when
the driver is only configured for host mode:

drivers/usb/phy/phy-isp1301-omap.c:261:13: error: 'power_up' defined but not used [-Werror=unused-function]

This marks the function __maybe_unused to avoid the warning and
silently drop the definition when it is unused.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/usb/phy/phy-isp1301-omap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/phy/phy-isp1301-omap.c b/drivers/usb/phy/phy-isp1301-omap.c
index 3af263cc0caa..8d111ec653e4 100644
--- a/drivers/usb/phy/phy-isp1301-omap.c
+++ b/drivers/usb/phy/phy-isp1301-omap.c
@@ -258,7 +258,7 @@ static void power_down(struct isp1301 *isp)
 	isp1301_clear_bits(isp, ISP1301_MODE_CONTROL_1, MC1_DAT_SE0);
 }
 
-static void power_up(struct isp1301 *isp)
+static void __maybe_unused power_up(struct isp1301 *isp)
 {
 	// isp1301_clear_bits(isp, ISP1301_MODE_CONTROL_2, MC2_GLOBAL_PWR_DN);
 	isp1301_clear_bits(isp, ISP1301_MODE_CONTROL_1, MC1_SUSPEND);
-- 
2.7.0
