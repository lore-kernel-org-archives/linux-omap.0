From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCHv3 0/3] usb: phy: remaining twl4030-usb/omap fixes
Date: Sun, 24 Mar 2013 17:36:52 +0200
Message-ID: <1364139415-16695-1-git-send-email-notasas@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ea0-f171.google.com ([209.85.215.171]:52727 "EHLO
	mail-ea0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753932Ab3CXPhD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 24 Mar 2013 11:37:03 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, kishon <kishon@ti.com>, Grazvydas Ignotas <notasas@gmail.com>

These are the last 3 patches of earlier twl4030-usb/omap fix series:
http://marc.info/?l=linux-usb&m=136354462519052&w=2

Changed since v2:
- simplified patch 5/7 (now 1/3) according to Felipe's suggestion
- changed vbus_supplied to be always set to true when VBUS_PRES is set,
  even when ID is grounded at the same time (like it was before the patch).

Grazvydas Ignotas (3):
  usb: phy: twl4030-usb: check if vbus is driven by twl itself
  usb: musb: omap2430: turn off vbus on cable disconnect
  usb: musb: gadget: use platform callback to enable vbus

 drivers/usb/musb/musb_gadget.c    |    5 ++---
 drivers/usb/musb/omap2430.c       |    1 +
 drivers/usb/phy/phy-twl4030-usb.c |   31 ++++++++++++++++++++++++++++---
 3 files changed, 31 insertions(+), 6 deletions(-)

-- 
1.7.9.5

