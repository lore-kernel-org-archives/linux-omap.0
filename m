From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: [PATCH] ARM: omap2plus_defconfig: add networking over USB device
Date: Tue,  4 Dec 2018 21:59:01 +0100
Message-ID: <20181204205901.14620-1-michael.opdenacker@bootlin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: linux@armlinux.org.uk, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Michael Opdenacker <michael.opdenacker@bootlin.com>
List-Id: linux-omap@vger.kernel.org

This adds support for networking over USB device,
which allows boards such as the BeagleBoneBlack Wireless and
Pocket Beagle to boot on an NFS root filesystem. Such boards
have no Ethernet port.

This is for consistency with CONFIG_ROOT_NFS=y
which makes no sense if there is no networking.

Tested on BeagleBoneBlack Wireless and BeagleBoneBlack

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
---
 arch/arm/configs/omap2plus_defconfig | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 6491419b1dad..7e8a8ed028fd 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -403,11 +403,11 @@ CONFIG_USB_EHCI_HCD=m
 CONFIG_USB_OHCI_HCD=m
 CONFIG_USB_ACM=m
 CONFIG_USB_STORAGE=m
-CONFIG_USB_MUSB_HDRC=m
-CONFIG_USB_MUSB_TUSB6010=m
+CONFIG_USB_MUSB_HDRC=y
+CONFIG_USB_MUSB_TUSB6010=y
 CONFIG_USB_MUSB_OMAP2PLUS=m
 CONFIG_USB_MUSB_AM35X=m
-CONFIG_USB_MUSB_DSPS=m
+CONFIG_USB_MUSB_DSPS=y
 CONFIG_USB_INVENTRA_DMA=y
 CONFIG_USB_TI_CPPI41_DMA=y
 CONFIG_USB_TUSB_OMAP_DMA=y
@@ -418,10 +418,10 @@ CONFIG_USB_SERIAL_SIMPLE=m
 CONFIG_USB_SERIAL_FTDI_SIO=m
 CONFIG_USB_SERIAL_PL2303=m
 CONFIG_USB_TEST=m
-CONFIG_NOP_USB_XCEIV=m
-CONFIG_AM335X_PHY_USB=m
+CONFIG_NOP_USB_XCEIV=y
+CONFIG_AM335X_PHY_USB=y
 CONFIG_TWL6030_USB=m
-CONFIG_USB_GADGET=m
+CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_DEBUG=y
 CONFIG_USB_GADGET_DEBUG_FILES=y
 CONFIG_USB_GADGET_DEBUG_FS=y
@@ -442,6 +442,7 @@ CONFIG_USB_CONFIGFS_F_UAC1=y
 CONFIG_USB_CONFIGFS_F_UAC2=y
 CONFIG_USB_CONFIGFS_F_MIDI=y
 CONFIG_USB_CONFIGFS_F_HID=y
+CONFIG_USB_ETH=y
 CONFIG_USB_ZERO=m
 CONFIG_USB_G_NOKIA=m
 CONFIG_MMC=y
-- 
2.17.1
