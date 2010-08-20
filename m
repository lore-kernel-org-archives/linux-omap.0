From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: RE: omap3_defconfig: USB_OTG unmet dependencies
Date: Fri, 20 Aug 2010 15:30:28 -0500
Message-ID: <A24693684029E5489D1D202277BE89445721F932@dlee02.ent.ti.com>
References: <A24693684029E5489D1D202277BE89445721F86D@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35481 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016Ab0HTUab convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Aug 2010 16:30:31 -0400
In-Reply-To: <A24693684029E5489D1D202277BE89445721F86D@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre, Sergio" <saaguirre@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>

(Looping linux-usb)

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Aguirre, Sergio
> Sent: Friday, August 20, 2010 2:21 PM
> To: linux-omap@vger.kernel.org
> Subject: omap3_defconfig: USB_OTG unmet dependencies
> 
> Hi all,
> 
> Today, I tried loading the omap3_defconfig from current master commit:
> 
> ddfc2d1 Linux-omap rebuilt: Updated to v2.6.36-rc1
> 
> And I noticed this bad Kconfig dependency:

I noticed that there's 2 Kconfig files that have a "config USB_OTG" entry.

The one in drivers/usb/gadget/Kconfig looks misplaced, and by looking at the
Description, it seems to be some OMAP specific thing...

Shouldn't that go away? What do you think?:

diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index cd27f9b..19a6eb6 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -209,17 +209,6 @@ config USB_OMAP
        default USB_GADGET
        select USB_GADGET_SELECTED

-config USB_OTG
-       boolean "OTG Support"
-       depends on USB_GADGET_OMAP && ARCH_OMAP_OTG && USB_OHCI_HCD
-       help
-          The most notable feature of USB OTG is support for a
-          "Dual-Role" device, which can act as either a device
-          or a host.  The initial role choice can be changed
-          later, when two dual-role devices talk to each other.
-
-          Select this only if your OMAP board has a Mini-AB connector.
-
 config USB_GADGET_PXA25X
        boolean "PXA 25x or IXP 4xx"
        depends on (ARCH_PXA && PXA25x) || ARCH_IXP4XX

