From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCHv2 0/7] usb: phy: twl4030-usb fixes
Date: Sun, 17 Mar 2013 20:23:20 +0200
Message-ID: <1363544607-17634-1-git-send-email-notasas@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ea0-f182.google.com ([209.85.215.182]:36075 "EHLO
	mail-ea0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756411Ab3CQSXl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 17 Mar 2013 14:23:41 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, NeilBrown <neilb@suse.de>, kishon <kishon@ti.com>, Grazvydas Ignotas <notasas@gmail.com>

I have a pandora board which has similar musb setup to beagleboard
(OMAP3530 + TWL4030) and musb never worked well on it for me in mainline.
Well it usually works if you plug the cable once, but as soon as you start
replugging cables and mixing host adapter into the game it totally breaks
and reboot is then needed. Host mode is especially broken, any replugs
after musb has been in host mode result in dead port that needs reboot
to recover.

With this series I can switch host/peripheral cables any way I like and
even suspend works with cable plugged with musb in peripheral mode!
("ARM: OMAP3: hwmod data: keep MIDLEMODE in force-standby for musb" is
needed that was sent separately). This also fixes power drain when cable
is plugged an no gadget driver is loaded.

Changed since v1:
- rebased on Felipe's testing branch
- added locking for patch 4 to take care of possible races
  between work item and IRQ
- changed patch 6 to only disable VBUS if not runtime suspended,
  otherwise we get data abort on OMAP3

Grazvydas Ignotas (7):
  usb: phy: twl4030-usb: don't enable PHY during init
  usb: phy: twl4030-usb: ignore duplicate events
  usb: phy: twl4030-usb: don't switch the phy on/off needlessly
  usb: phy: twl4030-usb: poll for ID disconnect
  usb: phy: twl4030-usb: check if vbus is driven by twl itself
  usb: musb: omap2430: turn off vbus on cable disconnect
  usb: musb: gadget: use platform callback to enable vbus

 drivers/usb/musb/musb_gadget.c    |    5 +-
 drivers/usb/musb/omap2430.c       |    1 +
 drivers/usb/phy/phy-twl4030-usb.c |  123 +++++++++++++++++++++++++++++--------
 3 files changed, 99 insertions(+), 30 deletions(-)

-- 
1.7.9.5

