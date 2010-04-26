From: Anand Gadiyar <gadiyar@ti.com>
Subject: [PATCH v3 0/3] usb: ohci: introduce ohci-hcd driver for omap3
Date: Mon, 26 Apr 2010 10:04:46 +0530
Message-ID: <1272256489-3389-1-git-send-email-gadiyar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54432 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750825Ab0DZEfE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 Apr 2010 00:35:04 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Greg KH <gregkh@suse.de>
Cc: Anand Gadiyar <gadiyar@ti.com>

Hi all,

This patch series adds the bus glue layer for the OHCI controller
on OMAP3 and later chips. This controller is a companion
to the EHCI controller on that chip, and some code is common
between the two drivers. The driver has been sitting in internal
trees for ages, and I've finally found time to clean it up
and submit it.

The older OMAP1 and OMAP2 chips had a different OHCI controller,
which already has driver support in mainline. I don't have access
to any boards with this old controller and haven't tested the old
driver on those boards - not sure if it still works.
(Also, I made some updates to Kconfig, and have not yet
updated the defconfigs for those omap1/2 boards. I'll update them
if the Kconfig changes are okay)

This controller supports multiple interface modes. Only 2 of them
(3-pin DAT/SE0 and 4-pin DP/DM PHY modes) have been tested with this
driver. (However the only change for the other modes is one register
setting for selecting the mode, and the padconf setting for the omap
pads, so I expect it to work correctly).
(Someone did offer to test the 6-pin mode. Still awaiting results...)

If anyone has OMAP3 boards with an OHCI controller, please test.

Since no comments were given to the v2 series for 3 weeks, I hope
we can queue it up for .35.

Thanks,
Anand

TODO:
- Factor out code common to EHCI into a separate file
  -- Also, make sure EHCI and OHCI don't step over each other's toes
- Add hooks for configuring transceivers, etc
- Update defconfigs, if Kconfig changes are okay

v3 changes from v2:
- Remove extra semicolon in one patch
- Drop board file changes so they can go through linux-omap

v2 changes:
- Cover all padconf combinations for mux-mode for OMAP3
- Added a new flag for ES2.x compatibility to platform data
  to remove the check in the driver
- rename some references from *omap* to *omap3*
- Fix review comments from Felipe and Sergio
