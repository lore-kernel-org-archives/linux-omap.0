From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/2] I2C: OMAP: spurious IRQ fixes
Date: Sat, 25 Apr 2009 22:28:05 -0600
Message-ID: <20090426042504.31316.68357.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:59244 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212AbZDZEns (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 26 Apr 2009 00:43:48 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

This is a set of I2C fixes.  Its primary purpose is to deal with the
I2C spurious IRQ problem:

Spurious irq 95: 0xffffffdf, please flush posted write for irq 56

It seems to work: under constant I2C load, no spurious IRQ messages
showed up after several hours of testing.  (Without these patches,
spurious IRQs usually show up in a few minutes.)  Some of the code has
also been cleaned up.

Any feedback on how this series works for others is appreciated.

Tested on N800, Beagle and 3430SDP.


- Paul

---

  text    data     bss     dec     hex filename
3636832  210560  104320 3951712  3c4c60 vmlinux.3430sdp.orig
3636896  210560  104320 3951776  3c4ca0 vmlinux.3430sdp


Paul Walmsley (2):
      I2C: OMAP: overhaul the rev2+ interrupt service routine and omap_i2c_xfer_msg()
      I2C: OMAP: use consolidated flags field rather than bitfields


 drivers/i2c/busses/i2c-omap.c |  150 ++++++++++++++++++++++++++---------------
 1 files changed, 95 insertions(+), 55 deletions(-)

