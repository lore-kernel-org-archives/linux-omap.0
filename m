From: <gregkh@suse.de>
Subject: patch arm-defconfig-rx51-enable-phonet-and-g_nokia.patch added to gregkh-2.6 tree
Date: Fri, 15 Jan 2010 12:15:37 -0800
Message-ID: <12635865373646@kroah.org>
References: <1262700614-16438-2-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:51614 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758241Ab0AOURB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Jan 2010 15:17:01 -0500
In-Reply-To: <1262700614-16438-2-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com, gregkh@suse.de, greg@kroah.com, linux-omap@vger.kernel.org, tony@atomide.com


This is a note to let you know that I've just added the patch titled

    Subject: arm: defconfig: rx51: enable phonet and g_nokia

to my gregkh-2.6 tree.  Its filename is

    arm-defconfig-rx51-enable-phonet-and-g_nokia.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


>From felipe.balbi@nokia.com  Fri Jan 15 10:59:45 2010
From: Felipe Balbi <felipe.balbi@nokia.com>
Date: Tue,  5 Jan 2010 16:10:14 +0200
Subject: arm: defconfig: rx51: enable phonet and g_nokia
To: linux-usb@vger.kernel.org
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Greg KH <greg@kroah.com>, Felipe Balbi <felipe.balbi@nokia.com>
Message-ID: <1262700614-16438-2-git-send-email-felipe.balbi@nokia.com>


trivial patch enabling g_nokia on rx51_defconfig.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 arch/arm/configs/rx51_defconfig |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/arch/arm/configs/rx51_defconfig
+++ b/arch/arm/configs/rx51_defconfig
@@ -445,6 +445,8 @@ CONFIG_IP_NF_FILTER=m
 # CONFIG_LAPB is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
+CONFIG_PHONET=y
+# CONFIG_IEEE802154 is not set
 # CONFIG_NET_SCHED is not set
 # CONFIG_DCB is not set
 
@@ -1325,27 +1327,34 @@ CONFIG_USB_GADGET_SELECTED=y
 # CONFIG_USB_GADGET_LH7A40X is not set
 # CONFIG_USB_GADGET_OMAP is not set
 # CONFIG_USB_GADGET_PXA25X is not set
+# CONFIG_USB_GADGET_R8A66597 is not set
 # CONFIG_USB_GADGET_PXA27X is not set
-# CONFIG_USB_GADGET_S3C2410 is not set
+# CONFIG_USB_GADGET_S3C_HSOTG is not set
 # CONFIG_USB_GADGET_IMX is not set
+# CONFIG_USB_GADGET_S3C2410 is not set
 # CONFIG_USB_GADGET_M66592 is not set
 # CONFIG_USB_GADGET_AMD5536UDC is not set
 # CONFIG_USB_GADGET_FSL_QE is not set
 # CONFIG_USB_GADGET_CI13XXX is not set
 # CONFIG_USB_GADGET_NET2280 is not set
 # CONFIG_USB_GADGET_GOKU is not set
+# CONFIG_USB_GADGET_LANGWELL is not set
 # CONFIG_USB_GADGET_DUMMY_HCD is not set
 CONFIG_USB_GADGET_DUALSPEED=y
 CONFIG_USB_ZERO=m
 # CONFIG_USB_ZERO_HNPTEST is not set
+# CONFIG_USB_AUDIO is not set
 # CONFIG_USB_ETH is not set
 # CONFIG_USB_GADGETFS is not set
 CONFIG_USB_FILE_STORAGE=m
 # CONFIG_USB_FILE_STORAGE_TEST is not set
+# CONFIG_USB_MASS_STORAGE is not set
 # CONFIG_USB_G_SERIAL is not set
 # CONFIG_USB_MIDI_GADGET is not set
 # CONFIG_USB_G_PRINTER is not set
 # CONFIG_USB_CDC_COMPOSITE is not set
+CONFIG_USB_G_NOKIA=m
+# CONFIG_USB_G_MULTI is not set
 
 #
 # OTG and related infrastructure

