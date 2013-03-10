From: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/7] usb: otg: twl4030-usb fixes
Date: Sun, 10 Mar 2013 03:07:54 +0200
Message-ID: <1362877681-8102-1-git-send-email-notasas@gmail.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>, Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

I have a pandora board which has similar musb setup to beagleboard
(OMAP3530 + TWL4030) and musb never worked well on it for me in mainline.
Well it usually works if you plug the cable once, but as soon as you start
replugging cables and mixing host adapter into the game it totally breaks
and reboot is then needed. Host mode is especially broken, any replugs
after musb has been in host mode result in dead port that needs reboot
to recover.

With this series I can switch host/peripheral cables any way I like and
even suspend works with cable plugged with musb in peripheral mode!
("ARM: OMAP3: hwmod data: disable MIDLEMODE control for musb" is needed
that was sent separately). This also fixes power drain when cable is
plugged an no gadget driver is loaded.

Grazvydas Ignotas (7):
  usb: otg: twl4030-usb: don't enable PHY during init
  usb: otg: twl4030-usb: ignore duplicate events
  usb: otg: twl4030-usb: don't switch the phy on/off needlessly
  usb: otg: twl4030-usb: poll for ID disconnect
  usb: otg: twl4030-usb: check if vbus is driven by twl itself
  usb: musb: omap2430: turn off vbus on cable disconnect
  usb: musb: gadget: use platform callback to enable vbus

 drivers/usb/musb/musb_gadget.c |    5 +-
 drivers/usb/musb/omap2430.c    |    1 +
 drivers/usb/otg/twl4030-usb.c  |  105 ++++++++++++++++++++++++++++++----------
 3 files changed, 82 insertions(+), 29 deletions(-)

-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
