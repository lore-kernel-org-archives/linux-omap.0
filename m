From: David Brownell <david-b@pacbell.net>
Subject: Re: git-pull request for omap-fixes for 2.6.29-rc1 (Re: [PATCH 00/10] Omap fixes for 2.6.29-rc1)
Date: Sat, 17 Jan 2009 12:47:17 -0800
Message-ID: <200901171247.18153.david-b@pacbell.net>
References: <20090112143405.24205.52151.stgit@localhost> <20090115134908.GC20409@n2100.arm.linux.org.uk> <20090117142651.GA9947@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp118.sbc.mail.sp1.yahoo.com ([69.147.64.91]:42200 "HELO
	smtp118.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1758671AbZAQUr0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 17 Jan 2009 15:47:26 -0500
In-Reply-To: <20090117142651.GA9947@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Saturday 17 January 2009, Russell King - ARM Linux wrote:
> Now that akpm pushed the usb_port_suspend() fix upstream, we move on
> to the next breakage found by kautobuild, which for n770_defconfig is:
> 
> drivers/built-in.o: In function `ohci_omap_init':
> hid-quirks.c:(.text+0x6c608): undefined reference to `otg_get_transceiver'
> drivers/built-in.o: In function `omap_udc_probe':
> hid-quirks.c:(.init.text+0x34c0): undefined reference to `otg_get_transceiver'
> hid-quirks.c:(.init.text+0x3d40): undefined reference to `otg_put_transceiver'

Does this fix that problem?

---
 drivers/usb/host/Kconfig |    1 +
 drivers/usb/otg/Kconfig  |    4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -140,6 +140,7 @@ config USB_OHCI_HCD
 	tristate "OHCI HCD support"
 	depends on USB && USB_ARCH_HAS_OHCI
 	select ISP1301_OMAP if MACH_OMAP_H2 || MACH_OMAP_H3
+	select USB_OTG_UTILS if ARCH_OMAP
 	---help---
 	  The Open Host Controller Interface (OHCI) is a standard for accessing
 	  USB 1.1 host controller hardware.  It does more in hardware than Intel's
--- a/drivers/usb/otg/Kconfig
+++ b/drivers/usb/otg/Kconfig
@@ -6,14 +6,14 @@
 
 comment "OTG and related infrastructure"
 
-if USB || USB_GADGET
-
 config USB_OTG_UTILS
 	bool
 	help
 	  Select this to make sure the build includes objects from
 	  the OTG infrastructure directory.
 
+if USB || USB_GADGET
+
 #
 # USB Transceiver Drivers
 #

