From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH REBASE 0/6] i2c: omap: misc changes
Date: Fri, 14 Dec 2012 18:34:03 +0200
Message-ID: <1355502849-9289-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40753 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755599Ab2LNQlc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Dec 2012 11:41:32 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-i2c@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>

Hi,

this is just a rebase of the previous series adding support
for amount of bytes transferred upon NACK.

Well, actually the patches implementing transferred bytes
reporting aren't here because we need to discuss how to move
forward.

This series is just a preparation for that, but it also
contains a at least one bugfix.

Each and every patch has been tested with pandaboard, it
would be nice to get Tested-bys from other folks on other
platforms before pushing this for v3.9 (there's more than
enough time for that).

Note that we're also dropping b_hw flag since that becomes
useless since we'll never set STT and STP together anymore.

Give it a good round of test, please.

Felipe Balbi (6):
  i2c: omap: no need to access platform_device
  i2c: omap: also complete() when stat becomes zero
  i2c: omap: improve 'rev' a little bit
  i2c: omap: in case of VERSION_2 read IRQSTATUS_RAW but write to
    IRQSTATUS
  i2c: omap: wait for transfer completion before sending STP bit
  i2c: omap: get rid of b_hw flag

 drivers/i2c/busses/i2c-omap.c | 184 +++++++++++++++++++++---------------------
 1 file changed, 93 insertions(+), 91 deletions(-)

-- 
1.8.1.rc1.5.g7e0651a

