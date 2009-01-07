From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH 2/3] usb: musb: fix compilation error in musb_platform_init
Date: Wed,  7 Jan 2009 16:44:06 +0530
Message-ID: <1231326846-22691-1-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48262 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751521AbZAGLOS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Jan 2009 06:14:18 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, david-b@pacbell.net, felipe.balbi@nokia.com, Ajay Kumar Gupta <ajay.gupta@ti.com>

Fixes the compilation error while musb is selected for OMAP35x EVM and
twl4030 phy is not selected and thus USB_OTG_UTILS is also not defined.
This causes below compilation error,

drivers/built-in.o: In function `musb_platform_init':
hid-quirks.c:(.init.text+0x4244): undefined reference to `otg_get_transceiver'
make: *** [.tmp_vmlinux1] Error 1

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
 drivers/usb/musb/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
index 669acbe..764e362 100644
--- a/drivers/usb/musb/Kconfig
+++ b/drivers/usb/musb/Kconfig
@@ -11,6 +11,7 @@ config USB_MUSB_HDRC
 	depends on (USB || USB_GADGET) && HAVE_CLK
 	depends on !SUPERH
 	select TWL4030_USB if MACH_OMAP_3430SDP
+	select USB_OTG_UTILS if ARCH_OMAP34XX
 	tristate 'Inventra Highspeed Dual Role Controller (TI, ADI, ...)'
 	help
 	  Say Y here if your system has a dual role high speed USB
-- 
1.5.6

