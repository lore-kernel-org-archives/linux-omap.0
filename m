From: <kalle.jokiniemi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH v3 0/2] isp1704_charger: fix powering for N900
Date: Thu, 7 Apr 2011 07:13:25 +0000
Message-ID: <9D0D31AA57AAF5499AFDC63D6472631B072DD4@008-AM1MPN1-036.mgdnok.nokia.com>
References: <1301405280-16899-1-git-send-email-kalle.jokiniemi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1301405280-16899-1-git-send-email-kalle.jokiniemi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: balbi-l0cyMroinI0@public.gmane.org, Heikki.Krogerus-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jhnikula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hello Anton,

Will you take my patch set in, it has been acked by Heikki, and 
there has been no more comments to be fixed.

- Kalle

 > -----Original Message-----
 > From: Kalle Jokiniemi [mailto:kalle.jokiniemi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org]
 > Sent: 29. maaliskuuta 2011 16:28
 > To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
 > Cc: balbi-l0cyMroinI0@public.gmane.org; Krogerus Heikki (Nokia-MS/Helsinki); sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org;
 > tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org; khilman-l0cyMroinI0@public.gmane.org; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
 > jhnikula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; Jokiniemi Kalle (Nokia-MS/Tampere)
 > Subject: [PATCH v3 0/2] isp1704_charger: fix powering for N900
 > 
 > This patch set enables powering down the isp1704 usb
 > tranceiver when not in use.
 > 
 > tested on RX-51 and MeeGo.
 > 
 > Thanks to Felipe Balbi, Sergei Shtylyov, and Heikki Krogerus
 > for comments.
 > 
 > v3:
 > * fixed power down handling in isp1704_charger_probe
 > * removed init_done variable
 > * changed BUG_ON to WARN_ON
 > * editorial fixes
 > 
 > v2: fixed boot issue in the 1/2 patch.
 > 
 > Kalle Jokiniemi (2):
 >   isp1704_charger: allow board specific powering routine
 >   RX-51: Enable isp1704 power on/off
 > 
 >  arch/arm/mach-omap2/board-rx51-peripherals.c |   27
 > ++++++++++++++++++++++-
 >  drivers/power/isp1704_charger.c              |   22 +++++++++++++++++++
 >  include/linux/power/isp1704_charger.h        |   29
 > ++++++++++++++++++++++++++
 >  3 files changed, 76 insertions(+), 2 deletions(-)
 >  create mode 100644 include/linux/power/isp1704_charger.h

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
