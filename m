From: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/5] musb/dsps: suspend related patches for 3.14 (rebased)
Date: Mon, 25 Nov 2013 20:39:48 +0100
Message-ID: <1385408393-19707-1-git-send-email-zonque@gmail.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, neumann-SRDuVqtxQLSzQB+pC5nmwQ@public.gmane.org, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Felipe,

These five patches for musb/dsps didn't make it into 3.13, which is no
big deal, at least as far as I'm concerned :)

I rebased the missing bits on top of 3.13-rc1. There are no functional
changes in comparison to what was posted earlier on this list.

Successfully tested on a AM33xx board.


Thanks,
Daniel


Daniel Mack (5):
  usb: musb: conditionally save and restore the context on suspend
  usb: musb: call musb_port_suspend from musb_bus_suspend
  usb: musb: dsps: add {tx,rx}_mode to wrapper
  usb: musb: dsps: add support for suspend and resume
  usb: musb: dsps: indentation and whitespace fixes

 drivers/usb/musb/musb_core.c    | 17 +++++++-
 drivers/usb/musb/musb_core.h    |  1 +
 drivers/usb/musb/musb_dsps.c    | 86 +++++++++++++++++++++++++++++++++++------
 drivers/usb/musb/musb_host.c    |  2 +
 drivers/usb/musb/musb_host.h    |  4 ++
 drivers/usb/musb/musb_virthub.c |  4 +-
 include/linux/usb/musb.h        |  3 ++
 7 files changed, 102 insertions(+), 15 deletions(-)

-- 
1.8.4.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
