From: Anand Gadiyar <gadiyar@ti.com>
Subject: [PATCH RFC 0/5] usb: ohci: introduce ohci-hcd driver for omap3
Date: Sun, 21 Mar 2010 17:01:58 +0530
Message-ID: <1269171123-9874-1-git-send-email-gadiyar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37140 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751900Ab0CULcJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 21 Mar 2010 07:32:09 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Anand Gadiyar <gadiyar@ti.com>

Hi all,

(Apologies if you get this twice - I sent this out 24 hours ago,
and it still hasn't reached the lists. So resending).

This patch series adds the bus glue layer for the OHCI controller
on OMAP3 and later chips. This controller is a companion
to the EHCI controller on that IP, and some code is common
across the drivers. The driver has been sitting in internal
trees for ages, and I've finally found time to clean it up
and submit it.


The older OMAP1 and OMAP2 chips had a different OHCI controller,
which already has driver support in mainline. I don't have access
to this and haven't tested the driver on those boards.
(Also, I made some updates to Kconfig, and have not yet updated the
defconfigs for those omap1/2 boards. I'll update them if the Kconfig
changes are okay)


This controller supports multiple interface modes. Only 2 of them
(3-pin DAT/SE0 and 4-pin DP/DM PHY modes) have been tested with this
driver. (However the only change for the other modes is one register
setting for selecting the mode, and the padconf setting for the omap
pads), so I expect it to work correctly with this version.

If anyone has OMAP3 boards with an OHCI controller, please test.

Thanks,
Anand

TODO:
- Factor out code common to EHCI into a separate file
	- Also, make sure EHCI and OHCI don't step over each other's toes
- Add hooks for configuring transceivers, etc
- Make sure padconfs are tailored to the different interface modes
- Update defconfigs, if Kconfig changes are okay

