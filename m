From: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH RFC v2 0/5] usb: ohci: introduce ohci-hcd driver for omap3
Date: Fri,  2 Apr 2010 20:34:07 +0530
Message-ID: <1270220652-29127-1-git-send-email-gadiyar@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Gregory Clement <gclement00-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>, Sergio Aguirre <saaguirre-l0cyMroinI0@public.gmane.org>, Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

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
pads), so I expect it to work correctly.
(Someone did offer to test the 6-pin mode. Still awaiting results...)

If anyone has OMAP3 boards with an OHCI controller, please test.

Thanks,
Anand

TODO:
- Factor out code common to EHCI into a separate file
  -- Also, make sure EHCI and OHCI don't step over each other's toes
- Add hooks for configuring transceivers, etc
- Update defconfigs, if Kconfig changes are okay

v2 changes:
- Cover all padconf combinations for mux-mode for OMAP3
- Added a new flag for ES2.x compatibility to platform data
  to remove the check in the driver
- rename some references from *omap* to *omap3*
- Fix review comments from Felipe and Sergio
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
