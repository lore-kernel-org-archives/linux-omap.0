From: <kalle.jokiniemi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH 0/2] isp1704_charger: fix powering for N900
Date: Mon, 28 Mar 2011 06:41:24 +0000
Message-ID: <9D0D31AA57AAF5499AFDC63D6472631B06CD89@008-AM1MPN1-036.mgdnok.nokia.com>
References: <1301293985-21687-1-git-send-email-kalle.jokiniemi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1301293985-21687-1-git-send-email-kalle.jokiniemi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
Cc: Heikki.Krogerus-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, jhnikula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Ugh, Monday morning :(

Managed to send old version of the patch, this has a boot issue. Please disregard this patch set, I'll send V2 set soon...

- Kalle

 > -----Original Message-----
 > From: Jokiniemi Kalle (Nokia-MS/Tampere)
 > Sent: 28. maaliskuuta 2011 9:33
 > To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; balbi-l0cyMroinI0@public.gmane.org
 > Cc: Krogerus Heikki (Nokia-MS/Helsinki); jhnikula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; khilman-l0cyMroinI0@public.gmane.org;
 > Jokiniemi Kalle (Nokia-MS/Tampere)
 > Subject: [PATCH 0/2] isp1704_charger: fix powering for N900
 > 
 > This patch set enables powering down the isp1704 usb
 > tranceiver when not in use.
 > 
 > Tested on RX-51.
 > 
 > Kalle Jokiniemi (2):
 >   isp1704_charger: allow board specific powering routine
 >   RX-51: Enable isp1704 power on/off
 > 
 >  arch/arm/mach-omap2/board-rx51-peripherals.c |   27
 > ++++++++++++++++++++++-
 >  drivers/power/isp1704_charger.c              |   25 +++++++++++++++++++++-
 >  include/linux/power/isp1704_charger.h        |   29
 > ++++++++++++++++++++++++++
 >  3 files changed, 78 insertions(+), 3 deletions(-)
 >  create mode 100644 include/linux/power/isp1704_charger.h

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
