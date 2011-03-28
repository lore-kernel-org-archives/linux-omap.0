From: Kalle Jokiniemi <kalle.jokiniemi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/2] isp1704_charger: fix powering for N900
Date: Mon, 28 Mar 2011 09:33:03 +0300
Message-ID: <1301293985-21687-1-git-send-email-kalle.jokiniemi@nokia.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
Cc: heikki.krogerus-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, jhnikula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org, Kalle Jokiniemi <kalle.jokiniemi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This patch set enables powering down the isp1704 usb
tranceiver when not in use.

Tested on RX-51.

Kalle Jokiniemi (2):
  isp1704_charger: allow board specific powering routine
  RX-51: Enable isp1704 power on/off

 arch/arm/mach-omap2/board-rx51-peripherals.c |   27 ++++++++++++++++++++++-
 drivers/power/isp1704_charger.c              |   25 +++++++++++++++++++++-
 include/linux/power/isp1704_charger.h        |   29 ++++++++++++++++++++++++++
 3 files changed, 78 insertions(+), 3 deletions(-)
 create mode 100644 include/linux/power/isp1704_charger.h

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
