From: Vivek Gautam <gautam.vivek-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 0/4] usb: dwc3/xhci: Enable runtime power management
Date: Mon, 28 Jan 2013 17:12:24 +0530
Message-ID: <1359373348-18320-1-git-send-email-gautam.vivek@samsung.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, sylvester.nawrocki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

This patch-series enables runtime power management on xhci-plat,
dwc3-core, dwc3-exynos as well as on samsung-usb3 type PHY.
This allows usb 3.0 host ports to be power managed at runtime.
We also turn off the PHY ref_clk PLL, which supplies reference clock
to USB3 type phy, when ports are not in use.

This patch-series is based on 'usb-next' with follwing patches:

usb: phy: samsung: Introducing usb phy driver for hsotg
usb: phy: s3c-hsotg: adding phy driver support

usb: phy: samsung: Add support to set pmu isolation
ARM: EXYNOS: Update & move usb-phy types to generic include layer
usb: phy: samsung: Add host phy support to samsung-phy driver
USB: ehci-s5p: Add phy driver support
USB: ohci-exynos: Add phy driver support
usb: phy: samsung: Remove __devinit, __devexit_p and __exit annotations

[PATCH v4 1/2] usb: phy: samsung: Common out the generic stuff
[PATCH v4 2/2] usb: phy: samsung: Add PHY support for USB 3.0 controller

Vivek Gautam (4):
  usb: xhci: Enable runtime pm in xhci-plat
  USB: dwc3: Adjust runtime pm the dwc3 driver to allow runtime suspend
  usb: dwc3: exynos: Enable runtime power management
  usb: phy: samsung: Enable runtime power management on samsung-usb3

 drivers/usb/dwc3/core.c          |    4 +-
 drivers/usb/dwc3/dwc3-exynos.c   |   47 +++++++++++++++++
 drivers/usb/host/xhci-plat.c     |    9 +++
 drivers/usb/phy/samsung-usb3.c   |  107 +++++++++++++++++++++++++++++++++++--
 drivers/usb/phy/samsung-usbphy.c |   26 +++++++++
 drivers/usb/phy/samsung-usbphy.h |    1 +
 6 files changed, 187 insertions(+), 7 deletions(-)

-- 
1.7.6.5

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
