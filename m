From: yegorslists@googlemail.com
Subject: [PATCH] ARM: omap2plus_defconfig: Enable MDIO Bus/PHY emulation
 support
Date: Fri,  8 Apr 2016 12:11:59 +0200
Message-ID: <1460110319-31525-1-git-send-email-yegorslists@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, linux-arm-kernel@lists.infradead.org, Yegor Yefremov <yegorslists@googlemail.com>
List-Id: linux-omap@vger.kernel.org

From: Yegor Yefremov <yegorslists@googlemail.com>

MDIO Bus/PHY emulation with fixed speed/link PHYs will be used in
Baltos iR5221 devices to connect to ICPlus IP175D switch IC.

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 arch/arm/configs/omap2plus_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 156bc88..e5a2782 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -178,6 +178,7 @@ CONFIG_TI_CPTS=y
 # CONFIG_NET_VENDOR_WIZNET is not set
 CONFIG_AT803X_PHY=y
 CONFIG_SMSC_PHY=y
+CONFIG_FIXED_PHY=y
 CONFIG_USB_USBNET=m
 CONFIG_USB_NET_SMSC75XX=m
 CONFIG_USB_NET_SMSC95XX=m
-- 
2.1.4
