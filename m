From: Kalle Jokiniemi <kalle.jokiniemi-sMOQStClEysAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/1] USB: disable twl4030 usb regulators
Date: Fri, 20 Feb 2009 14:02:30 +0200
Message-ID: <1235131351-3178-1-git-send-email-kalle.jokiniemi@digia.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <>
References: <>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org, broonie-GFdadSzt00ze9xe1eoZjHA@public.gmane.org, lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jouni.hogander-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

This patch combines the two patches "TWL: USB: disable VUSB
regulators when cable unplugged" and "USB: OTG: Twl4030 depends
on REGULATOR_TWL4030" sent earlier by me.

New thing is that the patch now handles situations where
disabling of VUSB3V1 regulator resets the ACTIVE state
remapping to SLEEP to be enabled.

Thanks to Jouni Hogander and David Brownell for helping
out with the patch. 

 drivers/usb/otg/Kconfig       |    2 +-
 drivers/usb/otg/twl4030-usb.c |   73 ++++++++++++++++++++++++++++++++++++-----
 2 files changed, 65 insertions(+), 10 deletions(-)


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
