From: "Govindraj.R" <govindraj.raja-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/2] mfd: omap-usb-host: Minor omap-usb host fixes
Date: Wed, 15 Feb 2012 15:53:32 +0530
Message-ID: <1329301414-31003-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, "Govindraj.R" <govindraj.raja-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: "Govindraj.R" <govindraj.raja-l0cyMroinI0@public.gmane.org>

Minor fixes, boot tested on panda with ehci enabled.
Patches based on 3.3-rc3

Govindraj.R (2):
  mfd: omap-usb-host: Remove magic numbers for dev dma mask
  mfd: omap-usb-host: Move usbhs init before allocing child dev

 drivers/mfd/omap-usb-host.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

-- 
1.7.5.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
