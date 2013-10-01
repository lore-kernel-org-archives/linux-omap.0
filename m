From: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 0/5] usb: musb_dsps: support for suspend and resume
Date: Tue,  1 Oct 2013 15:39:52 +0200
Message-ID: <1380634797-29541-1-git-send-email-zonque@gmail.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, neumann-SRDuVqtxQLSzQB+pC5nmwQ@public.gmane.org, bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

I've been working on some patches that allow suspending and resuming
the musb-dsps platform. This was tested for host mode only.

With these patches applied, I can successfully bring an AM335x board
to suspend with a USB media connected, and access it again after
resume.

This works for both PIO mode and CPPI41 enabled configurations,
together with my cppi41 patches that I posted here:

  http://marc.info/?l=linux-usb&m=138063429219730&w=2

More testing is certainly appreciated.


Thanks,
Daniel

Daniel Mack (5):
  usb: musb: move port reset to worker
  usb: musb: call musb_port_suspend from musb_bus_suspend
  usb: musb: conditionally save and restore the context on suspend
  usb: musb: dsps: add {tx,rx}_mode to wrapper
  usb: musb: dsps: add support for suspend and resume

 drivers/usb/musb/musb_core.c    | 24 +++++++++++++++-
 drivers/usb/musb/musb_core.h    |  3 ++
 drivers/usb/musb/musb_dsps.c    | 64 +++++++++++++++++++++++++++++++++++++++++
 drivers/usb/musb/musb_host.c    |  2 ++
 drivers/usb/musb/musb_host.h    |  4 +++
 drivers/usb/musb/musb_virthub.c | 15 ++++++----
 include/linux/usb/musb.h        |  1 +
 7 files changed, 106 insertions(+), 7 deletions(-)

-- 
1.8.3.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
