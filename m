From: Vivek Gautam <gautam.vivek-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH RFC 0/4] Fine tune USB 3.0 PHY on exynos5420
Date: Tue, 10 Dec 2013 16:25:22 +0530
Message-ID: <1386672926-26885-1-git-send-email-gautam.vivek@samsung.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, jwerner-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org
List-Id: linux-omap@vger.kernel.org

The DWC3-exynos eXtensible host controller present on Exynos5420
SoC is quirky. The PHY serving this controller operates at High-Speed
by default, so it detects even Super-speed devices as high-speed ones.
This PHY needs to be tuned for its Tx LOS levels and Boost levels.

In this patch-set, we are registering a quirk for this DWC3-Exynos
controller with XHCI, so that once after xhci_reset(), the controller
can call to tune the associated PHY and achieve the SuperSpeed.

These patches are based on new USB 3.0 phy driver for Exynos SoC series. [1]

[1] Add Exynos5 USB 3.0 phy driver based on generic PHY framework
http://lwn.net/Articles/575586/

Vivek Gautam (4):
  phy: Add provision for tuning phy.
  xhci: Add quirk for DWC3-Exynos controller
  xhci: Tune PHY for the DWC3-Exynos host controller
  phy-exynos-usb3: Fine tune LOS levels for exynos5420

 drivers/phy/phy-core.c         |   20 +++++++
 drivers/phy/phy-exynos5-usb3.c |  107 ++++++++++++++++++++++++++++++++++++++++
 drivers/usb/dwc3/host.c        |    7 +++
 drivers/usb/host/xhci-plat.c   |   62 ++++++++++++++++++++++-
 drivers/usb/host/xhci.h        |    1 +
 include/linux/phy/phy.h        |    7 +++
 include/linux/usb/hcd.h        |    1 +
 7 files changed, 203 insertions(+), 2 deletions(-)

-- 
1.7.6.5

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
