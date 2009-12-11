From: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: [RFC/PATCH 0/5] usb transceiver notifier
Date: Fri, 11 Dec 2009 13:31:21 +0200
Message-ID: <1260531086-23857-1-git-send-email-felipe.balbi@nokia.com>
References: <6ed0b2680912101251jeec28e6i216dfc51caab13aa@mail.gmail.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <6ed0b2680912101251jeec28e6i216dfc51caab13aa-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>, Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Madhusudhan Chikkature <madhu.cr-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The following patches are a prototype for supporting
notification of some usb events to whoever is interested
in them.

This way we can communicate common usb events to several
interested drivers so they can e.g. kick usb charger detection
and configure charging with proper input current.

THEY ARE NOT READY AND ARE NOT SUPPOSED TO BE APPLIED TO ANY
BRANCH.

please comment.

ps: patches were compile tested only.

Felipe Balbi (5):
  usb: otg: add notifier support
  usb: otg: twl4030: add support for notifier
  usb: musb: add support for ulpi block
  usb: musb: isp1704: add registers from isp1704
  usb: musb: musb supports otg notifier

 drivers/usb/musb/isp1704.h    |   81 +++++++++++++++++++++++++++++++++++++++++
 drivers/usb/musb/musb_core.c  |   72 ++++++++++++++++++++++++++++++++++++
 drivers/usb/musb/musb_core.h  |    5 +++
 drivers/usb/musb/musb_regs.h  |   62 +++++++++++++++++++++++++++++++
 drivers/usb/otg/twl4030-usb.c |    7 +++-
 include/linux/usb/otg.h       |   25 +++++++++++++
 6 files changed, 250 insertions(+), 2 deletions(-)
 create mode 100644 drivers/usb/musb/isp1704.h

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
