From: David Brownell <david-b@pacbell.net>
Subject: Re: Git tree updated to v2.6.29-rc1, omap-2.6.28 branch added
Date: Thu, 15 Jan 2009 14:01:17 -0800
Message-ID: <200901151401.17763.david-b@pacbell.net>
References: <20090115154327.GF4128@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp125.sbc.mail.sp1.yahoo.com ([69.147.65.184]:30037 "HELO
	smtp125.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S933196AbZAOWBT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Jan 2009 17:01:19 -0500
In-Reply-To: <20090115154327.GF4128@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

On Thursday 15 January 2009, Tony Lindgren wrote:
> I've updated our git tree to v2.6.29-rc1,

OK, after adding the IRQ patch from Anand, and the appended
USB patch (from before the 2.6.29 merge window), it builds.

Then when it tries to boot, (a) the HSMMC driver reports
"error -110" then chokes, so no root FS; and then (b) MUSB
misdetects the high speed hub as full speed then chokes,
so no network links either.  I'm not thinking (a) relates
to the "can't get debounce clock" message, I saw that on
earlier code that still booted just fine.

That's on a trusty Beagle config.  I don't think I'll be
upgrading anything else just yet...

- Dave


============= CUT HERE
Subject: drivers/usb/core/hub.c: fix CONFIG_USB_OTG=y build
From: David Brownell <dbrownell@users.sourceforge.net>

Carry out the PM-routine interface change in the USB OTG pathway.  This
was omitted from the earlier interface-change patch by mistake.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg KH <greg@kroah.com>
Cc: Russell King <rmk@arm.linux.org.uk>
Cc: Felipe Balbi <felipe.balbi@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/usb/core/hub.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/usb/core/hub.c~drivers-usb-core-hubc-fix-config_usb_otg=y-build drivers/usb/core/hub.c
--- a/drivers/usb/core/hub.c~drivers-usb-core-hubc-fix-config_usb_otg=y-build
+++ a/drivers/usb/core/hub.c
@@ -1554,7 +1554,7 @@ static int usb_configure_device_otg(stru
 		 * (Includes HNP test device.)
 		 */
 		if (udev->bus->b_hnp_enable || udev->bus->is_b_host) {
-			err = usb_port_suspend(udev);
+			err = usb_port_suspend(udev, PMSG_SUSPEND);
 			if (err < 0)
 				dev_dbg(&udev->dev, "HNP fail, %d\n", err);
 		}
