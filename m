From: Felipe Balbi <balbi@ti.com>
Subject: [RFC/PATCH 0/3] arm: omap: patches from -rt
Date: Thu, 1 Aug 2013 15:12:42 +0300
Message-ID: <1375359165-8411-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52672 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753662Ab3HAMOA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 1 Aug 2013 08:14:00 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Cc: Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

Hi,

the next three patches were taken from v3.10.4-rt1 patchset.

I don't have any boards available to test them, so I'd suggest
testing in as many platforms as possible before pushing
upstream.

By pushing these patches upstream, we help decrease the amount
of out-of-tree changes rt folks need to carry.

Frank Rowand (1):
  arm: omap: convert omap boot_lock to raw

Sebastian Andrzej Siewior (1):
  i2c/omap: drop the lock hard irq context

Thomas Gleixner (1):
  serial: omap: fix omap lock crap

 arch/arm/mach-omap2/omap-smp.c   | 10 +++++-----
 drivers/i2c/busses/i2c-omap.c    |  5 +----
 drivers/tty/serial/omap-serial.c | 12 ++++--------
 3 files changed, 10 insertions(+), 17 deletions(-)

-- 
1.8.3.4.840.g6a90778

