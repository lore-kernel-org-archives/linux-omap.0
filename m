From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/2] OMAP: I2C: reprogram OCP_SYSCONFIG after device reset
Date: Tue, 14 Oct 2008 06:19:21 -0600
Message-ID: <20081014121031.1210.96214.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:38056 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754558AbYJNMVb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Oct 2008 08:21:31 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Richard Woodruff <r-woodruff2@ti.com>

Hello,

This patch set programs the I2C controller OCP_SYSCONFIG register
after the driver resets the device.  It is derived from the changes
mentioned by Richard Woodruff <r-woodruff2@ti.com> at

http://git.omapzoom.org/?p=omapkernel;a=blob;f=drivers/i2c/busses/i2c-omap.c;hb=d0b4bad4926f9a147a73498f7a62a0ae1cf6f83a

however, the CLOCKACTIVITY change on clk_enable()/clk_disable() in that
code currently seems pointless, so it has been excluded until more
information is available from TI or until problems are encountered.

This patchset should only change behavior on OMAP2x30 and OMAP3xxx devices.

Boot-tested on 2430SDP and 3430SDP; compile-tested with the 5912OSK (OMAP1)
defconfig.  Comments welcome,


- Paul

---

  text    data     bss     dec      hex filename
3472584  160600  105760 3738944  390d40 vmlinux.3430sdp.orig
3472616  160600  105760 3738976  390d60 vmlinux.3430sdp

 drivers/i2c/busses/i2c-omap.c |   65 ++++++++++++++++++++++++++++++++---------
 1 files changed, 50 insertions(+), 15 deletions(-)

