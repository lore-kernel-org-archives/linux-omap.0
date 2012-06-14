From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 00/17] Big OMAP I2C Cleanup
Date: Thu, 14 Jun 2012 13:20:33 +0300
Message-ID: <1339669250-9183-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog133.obsmtp.com ([74.125.149.82]:60048 "EHLO
	na3sys009aog133.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751709Ab2FNKWy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Jun 2012 06:22:54 -0400
Received: by lbgc1 with SMTP id c1so1738784lbg.15
        for <linux-omap@vger.kernel.org>; Thu, 14 Jun 2012 03:22:52 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ben-linux@fluff.org
Cc: Tony Lindgren <tony@atomide.com>, w.sang@pengutronix.de, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-i2c@vger.kernel.org, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

Hi guys,

I have dropped a few patches from the series and also
tested every single patch on my pandaboard. I2C messages
are still working fine with panda after each patch.

There's still lots of work to be done on the i2c-omap.c
driver but it's now easier to read, IMO.

Felipe Balbi (17):
  i2c: omap: simplify num_bytes handling
  i2c: omap: decrease indentation level on data handling
  i2c: omap: add blank lines
  i2c: omap: simplify omap_i2c_ack_stat()
  i2c: omap: split out [XR]DR and [XR]RDY
  i2c: omap: improve 1p153 errata handling
  i2c: omap: re-factor receive/transmit data loop
  i2c: omap: switch over to do {} while loop
  i2c: omap: ack IRQ in parts
  i2c: omap: get rid of the "complete" label
  i2c: omap: switch to devm_* API
  i2c: omap: switch to platform_get_irq()
  i2c: omap: bus: add a receiver flag
  i2c: omap: simplify errata check
  i2c: omap: always return IRQ_HANDLED
  i2c: omap: simplify IRQ exit path
  i2c: omap: resize fifos before each message

 drivers/i2c/busses/i2c-omap.c |  388 +++++++++++++++++++++++------------------
 1 file changed, 222 insertions(+), 166 deletions(-)

-- 
1.7.10.4

