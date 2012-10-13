From: Vikas Sajjan <vikas.sajjan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v2 0/3] USB: dwc3: Add suspend/resume support
Date: Sat, 13 Oct 2012 18:40:22 +0530
Message-ID: <1350133825-24181-1-git-send-email-vikas.sajjan@linaro.org>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, joshi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Changes from v1:
 - Reverted back the code movements in core.c and also reverted dwc3_core_reset() 
 - Removed the pdata dependency for phy init and exit from dwc3-exynos.c 

Based on 'usb-next' of greg's tree.
Tested USB detection and enumeration across multiple cycles of
suspend/resume using 2.0 and 3.0 devices on D-link SS hub.

Vikas Sajjan (3):
  usb: dwc3: Add the suspend/resume functionality
  usb: xhci: Add the suspend/resume functionality
  exynos5: usb: dwc3: Add the suspend/resume functionality

 drivers/usb/dwc3/core.c        |   54 ++++++++++++++++++++++++++++++++++++++++
 drivers/usb/dwc3/dwc3-exynos.c |   39 ++++++++++++++++++++++++++++
 drivers/usb/host/xhci-plat.c   |   33 ++++++++++++++++++++++++
 3 files changed, 126 insertions(+), 0 deletions(-)

-- 
1.7.6.5

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
