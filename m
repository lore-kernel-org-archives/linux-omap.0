From: Jon Hunter <jon-hunter@ti.com>
Subject: [Fwd: patch usb-ehci-ensure-all-watchdog-timer-events-are-deleted-when-suspending-usb.patch
 added to gregkh-2.6 tree]
Date: Fri, 14 Aug 2009 12:40:31 -0500
Message-ID: <4A85A18F.4040207@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57995 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756699AbZHNRkg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Aug 2009 13:40:36 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n7EHeWa5005247
	for <linux-omap@vger.kernel.org>; Fri, 14 Aug 2009 12:40:37 -0500
Received: from dlep20.itg.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id n7EHeWp5007461
	for <linux-omap@vger.kernel.org>; Fri, 14 Aug 2009 12:40:32 -0500 (CDT)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep20.itg.ti.com (8.12.11/8.12.11) with ESMTP id n7EHeWk4000296
	for <linux-omap@vger.kernel.org>; Fri, 14 Aug 2009 12:40:32 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi All,

I just thought I would send out this patch as an FYI. We recently ran 
into an issue where we were getting a kernel panic in the ehci driver 
when entering suspend on the omap3. We discussed this with the linux-usb 
folks and they recommended the below fix. This problem is hard to 
reproduce, but has not been seen since adding this fix. Anyway the 
details are below.

Cheers
Jon

-------- Original Message --------
Subject: patch 
usb-ehci-ensure-all-watchdog-timer-events-are-deleted-when-suspending-usb.patch 
added to gregkh-2.6 tree
Date: Fri, 14 Aug 2009 11:48:45 -0500
From: gregkh@suse.de <gregkh@suse.de>
To: Hunter, Jon <jon-hunter@ti.com>, fei.yang@motorola.com 
<fei.yang@motorola.com>, gregkh@suse.de <gregkh@suse.de>, 
greg@kroah.com	<greg@kroah.com>, stern@rowland.harvard.edu 
<stern@rowland.harvard.edu>


This is a note to let you know that I've just added the patch titled

     Subject: USB: EHCI: ensure all watchdog timer events are deleted 
when suspending usb

to my gregkh-2.6 tree.  Its filename is

 
usb-ehci-ensure-all-watchdog-timer-events-are-deleted-when-suspending-usb.patch

This tree can be found at
 
http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


 From stern@rowland.harvard.edu  Thu Aug 13 16:37:16 2009
From: Jon Hunter <jon-hunter@ti.com>
Date: Wed, 12 Aug 2009 11:57:59 -0400 (EDT)
Subject: USB: EHCI: ensure all watchdog timer events are deleted when 
suspending usb
To: Greg KH <greg@kroah.com>, Jon Hunter <jon-hunter@ti.com>
Cc: Fei Yang <fei.yang@motorola.com>
Message-ID: <Pine.LNX.4.44L0.0908121157090.9635-100000@iolanthe.rowland.org>


From: Jon Hunter <jon-hunter@ti.com>

This patch was previously discussed in the following thread:
http://thread.gmane.org/gmane.linux.usb.general/19472/focus=19484

On the OMAP3 device the usbhost controller is in a separate internal
power-domain. So when the usbhost is inactive or suspend is called,
we can disable clocks and power-down the usbhost to save power.

Recently we found that after calling ehci_bus_suspend() and disabling
the usbhost clocks we would see the ehci watchdog timer event fire. This
was causing a kernel panic because the usbhost controllers clocks were
disabled and inside the watchdog timer function the clocks were not
being re-enabled, so when the ehci registers were accessed this resulted
in a CPU data-abort.

To avoid this panic, per recommendation from Alan Stern (see above 
thread), we
make sure any pending timer events (that may have been scheduled by calling
ehci_work within the ehci_bus_suspend() function) are deleted before 
returning.

Signed-off-by: Fei Yang <fei.yang@motorola.com>
Signed-off-by: Jon Hunter <jon-hunter@ti.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
  drivers/usb/host/ehci-hub.c |    5 +++++
  1 file changed, 5 insertions(+)

--- a/drivers/usb/host/ehci-hub.c
+++ b/drivers/usb/host/ehci-hub.c
@@ -209,6 +209,11 @@ static int ehci_bus_suspend (struct usb_

  	ehci->next_statechange = jiffies + msecs_to_jiffies(10);
  	spin_unlock_irq (&ehci->lock);
+
+	/* ehci_work() may have re-enabled the watchdog timer, which we do not
+	 * want, and so we must delete any pending watchdog timer events.
+	 */
+	del_timer_sync(&ehci->watchdog);
  	return 0;
  }



