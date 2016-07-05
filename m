From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: dts: Fix USB selection to keep Ethernet working
Date: Tue,  5 Jul 2016 00:58:00 -0700
Message-ID: <1467705480-8560-1-git-send-email-tony@atomide.com>
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
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

With the recent Kconfig changes we need to now enable
the PHYs to keep USB working.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/omap2plus_defconfig | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 506f4fa..2530472 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -355,11 +355,13 @@ CONFIG_USB_OHCI_HCD=m
 CONFIG_USB_WDM=m
 CONFIG_USB_STORAGE=m
 CONFIG_USB_MUSB_HDRC=m
+CONFIG_USB_MUSB_TUSB6010=m
 CONFIG_USB_MUSB_OMAP2PLUS=m
 CONFIG_USB_MUSB_AM35X=m
 CONFIG_USB_MUSB_DSPS=m
 CONFIG_USB_INVENTRA_DMA=y
 CONFIG_USB_TI_CPPI41_DMA=y
+CONFIG_USB_TUSB_OMAP_DMA=y
 CONFIG_USB_DWC3=m
 CONFIG_USB_SERIAL=m
 CONFIG_USB_SERIAL_GENERIC=y
@@ -367,7 +369,8 @@ CONFIG_USB_SERIAL_SIMPLE=m
 CONFIG_USB_SERIAL_FTDI_SIO=m
 CONFIG_USB_SERIAL_PL2303=m
 CONFIG_USB_TEST=m
-CONFIG_AM335X_PHY_USB=y
+CONFIG_NOP_USB_XCEIV=m
+CONFIG_AM335X_PHY_USB=m
 CONFIG_TWL6030_USB=m
 CONFIG_USB_GADGET=m
 CONFIG_USB_GADGET_DEBUG=y
-- 
2.8.1
