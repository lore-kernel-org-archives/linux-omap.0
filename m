From: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH v4 0/2] usb: musb dsps updates
Date: Fri, 17 Jan 2014 10:22:34 +0100
Message-ID: <1389950556-6453-1-git-send-email-mpa@pengutronix.de>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Bin Liu <binmlist-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

The two remaining patches from the previous series "usb: musb bugfixes". In v4
I used the device name for the debugfs root dir and added a commit message to
the second patch.

Regards,

Markus


Markus Pargmann (2):
  usb: musb: dsps, debugfs files
  usb: musb: dsps, use devm_kzalloc

 drivers/usb/musb/musb_dsps.c | 58 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 55 insertions(+), 3 deletions(-)

-- 
1.8.5.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
