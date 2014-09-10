From: Suman Anna <s-anna@ti.com>
Subject: [REPOST PATCHv3 0/2] OMAP Mailbox DT support for 3.18
Date: Wed, 10 Sep 2014 14:20:57 -0500
Message-ID: <1410376859-7297-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55052 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750967AbaIJTV0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 10 Sep 2014 15:21:26 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jassi Brar <jaswinder.singh@linaro.org>, Dave Gerlach <d-gerlach@ti.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Suman Anna <s-anna@ti.com>

Hi Tony,

This is a repost of just the DT support patches (first 2 patches out
of 5) from the OMAP Mailbox framework adoption and DT support series [1],
so that they can be picked up for 3.18. The only change is an Acked-by
picked up on the second patch. I will repost the third patch separately,
and the last 2 patches once a framework branch is published (no changes
on those as well).

The patches are rebased onto 3.17-rc3. The previous dependencies - the
OMAP mailbox DT/hwmod cleanup series [2] and the OMAP mailbox cleanup
series [3] have already been merged in 3.17-rc1, so there are no more
pending dependencies for these patches.

The following shows the boot logs on various OMAP platforms with just these
patches:
  OMAP2 (SDP2430)           : http://pastebin.ubuntu.com/8311033
  OMAP3 (BeagleXM)          : http://pastebin.ubuntu.com/8310760
  OMAP4 (PandaBoard)        : http://pastebin.ubuntu.com/8310633 
  OMAP5 (OMAP5 uEVM)        : http://pastebin.ubuntu.com/8310650
  DRA7  (DRA7 EVM)          : http://pastebin.ubuntu.com/8310700
  AM33xx (BeagleBone Black) : http://pastebin.ubuntu.com/8310732
  AM43xx (AM437x GP EVM)    : http://pastebin.ubuntu.com/8310824

[1] http://marc.info/?l=linux-omap&m=140668054422693&w=2
[2] http://marc.info/?l=linux-omap&m=140511512208519&w=2
[3] http://www.spinics.net/lists/linux-omap/msg108574.html

Suman Anna (2):
  Documentation: dt: add omap mailbox bindings
  mailbox/omap: add support for parsing dt devices

 .../devicetree/bindings/mailbox/omap-mailbox.txt   | 108 ++++++++++++++
 drivers/mailbox/omap-mailbox.c                     | 156 +++++++++++++++++----
 2 files changed, 240 insertions(+), 24 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mailbox/omap-mailbox.txt

-- 
2.0.4

