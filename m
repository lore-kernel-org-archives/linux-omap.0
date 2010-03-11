From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 0/3] USB compile fixes omaps
Date: Thu, 11 Mar 2010 10:03:16 -0800
Message-ID: <20100311180023.20537.27516.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Felipe & Greg,

Here are three fixes to make USB compile for omaps.
Can you please take a look and queue?

The tusb6010 DMA fix needs a platform init patch that I'll
send along with other omap fixes.

Regards,

Tony


---

Tony Lindgren (3):
      usb: Fix compile error for omaps for musb_hdrc
      usb: Fix USB_SUSPEND dependency for OTG
      usb: Fix tusb6010 for DMA API


 drivers/usb/core/Kconfig         |    2 +-
 drivers/usb/musb/musb_core.h     |    4 ++--
 drivers/usb/musb/tusb6010.c      |   13 +++++++++++++
 drivers/usb/musb/tusb6010_omap.c |   22 ++++++++++++++--------
 4 files changed, 30 insertions(+), 11 deletions(-)

-- 
Signature
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
