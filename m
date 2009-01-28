From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: 2.6.29-rc: remaining regression: n770_defconfig,
	omap_apollon_2420_defconfig
Date: Wed, 28 Jan 2009 10:10:41 +0900
Message-ID: <9c9fda240901271710q50ba1233m363c628013648d93@mail.gmail.com>
References: <20090127225000.GC639@n2100.arm.linux.org.uk>
	 <20090127234155.GI32148@atomide.com>
	 <200901271545.59632.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.30]:52298 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751696AbZA1BKm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Jan 2009 20:10:42 -0500
In-Reply-To: <200901271545.59632.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dbrownell@users.sourceforge.net
Cc: Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org

Hi,

On Wed, Jan 28, 2009 at 8:45 AM, David Brownell <david-b@pacbell.net> wrote:
> On Tuesday 27 January 2009, Tony Lindgren wrote:
>> * Russell King - ARM Linux <linux@arm.linux.org.uk> [090127 14:50]:
>> > Now that the usb_port_suspend() build error is fixed in 2.6.29-rc1-git6,
>> > n770_defconfig and omap_apollon_2420_defconfig now suffers from:
>> >
>> > drivers/built-in.o: In function `ohci_omap_init':
>> > hid-quirks.c:(.text+0x6c620): undefined reference to `otg_get_transceiver'
>> > drivers/built-in.o: In function `omap_udc_probe':
>> > hid-quirks.c:(.init.text+0x34c0): undefined reference to `otg_get_transceiver'
>> > hid-quirks.c:(.init.text+0x3d40): undefined reference to `otg_put_transceiver'
>>
>> Adding linux-usb to the list hoping there's already a fix for this.
>
> Scheduled for 2.6.29-soon:
>
> http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6
>        /gregkh-02-usb.current/usb-omap1-ohci-buildfix.patch
>

Also need following patch in case of usb gadget only.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index 3219d13..b26d6e6 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -191,6 +191,7 @@ config USB_GADGET_OMAP
 	boolean "OMAP USB Device Controller"
 	depends on ARCH_OMAP
 	select ISP1301_OMAP if MACH_OMAP_H2 || MACH_OMAP_H3 || MACH_OMAP_H4_OTG
+	select USB_OTG_UTILS if ARCH_OMAP
 	help
 	   Many Texas Instruments OMAP processors have flexible full
 	   speed USB device controllers, with support for up to 30
