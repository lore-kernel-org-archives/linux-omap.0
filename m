From: Felipe Balbi <balbi@ti.com>
Subject: [rft/rfc/patch 00/22] Big I2C cleanup
Date: Wed, 13 Jun 2012 18:50:49 +0300
Message-ID: <1339602671-8431-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog129.obsmtp.com ([74.125.149.142]:48633 "EHLO
	na3sys009aog129.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752151Ab2FMPxO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Jun 2012 11:53:14 -0400
Received: by lbom4 with SMTP id m4so1749367lbo.30
        for <linux-omap@vger.kernel.org>; Wed, 13 Jun 2012 08:53:11 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti Datta <shubhrajyoti@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

First of all, this isn't fully tested yet. I can
see some issues poping up after this patchset which
I'm not sure if it's a race condition somewhere or
the HW is just misbehaving.

All in all, the IRQ handler looks cleaner now. There's
still lots of things to be done and before I'm going any
further, I'd like help testing this patchset.

Note that on multiple boots you might face some issues
with the XDR IRQ which aparently keeps getting retriggered
even though it gets acked and properly cleared. I didn't
look yet if there's an errata for that.

I'll give myself a break of the I2C driver because it's
just driving me nuts already. If you have the balls to
look over the unfinished patches (see that there are
a few patches which could be combined, will do that later)
and help out testing, reviewing, commenting...

Next steps (after this set is done) would be to get rid
of that stupid, nonsensical FIFO clear before starting
every transfer, fix up NAK handling, clean up debugging
messages, figure out why sometimes IRQs don't fire (AKA
"controller timed out" crap) and lots more.

For convenience it's also located on the following git
branch:

git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git i2c

ps: boot tested on OMAP4 Panda. When it boots fine, it's actually
quite stable, I managed to do many transfers with the PMIC (checking
regulators' state) and it works very reliably (while true; cat
/sys/class/regulators/*/state; done works fine for multiple iterations);

Felipe Balbi (22):
  i2c: omap: simplify num_bytes handling
  i2c: omap: decrease indentation level on data handling
  i2c: omap: add blank lines
  i2c: omap: simplify omap_i2c_ack_stat()
  i2c: omap: split out [XR]DR and [XR]RDY
  i2c: omap: improve 1p153 errata handling
  i2c: omap: re-factor receive/transmit data loop
  i2c: omap: switch over to do {} while loop
  i2c: omap: ack IRQ in parts
  i2c: omap: switch I2C REV2 to threaded IRQ
  i2c: omap: get rid of "count" variable
  i2c: omap: get rid of the "complete" label
  i2c: omap: if controller is suspended, bail out
  i2c: omap: ack ARDY IRQ
  i2c: omap: switch to devm_* API
  i2c: omap: switch to platform_get_irq()
  i2c: omap: drop Access Ready IRQ
  i2c: omap: drop errata i207 from RRDY interrupt
  i2c: omap: bus: add a receiver flag
  i2c: omap: avoid unnecessary register read
  i2c: omap: no need to reinitialize "stat"
  i2c: omap: simplify errata check

 drivers/i2c/busses/i2c-omap.c |  386 +++++++++++++++++++++++------------------
 1 file changed, 216 insertions(+), 170 deletions(-)

-- 
1.7.10.4

