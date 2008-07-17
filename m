From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/2] OMAP3 clock: fix 96MHz clocks, usbhost_120m_fclk enable
Date: Wed, 16 Jul 2008 20:13:00 -0600
Message-ID: <20080717021112.21489.95137.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52901 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754401AbYGQCPn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Jul 2008 22:15:43 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: vikram.pandita@ti.com

This series fixes a few bugs in the OMAP3 clock tree.  The most noticeable
difference is that the "Clock usbhost_48m_fck didn't enable in 100000 tries"
no longer appears during boot.


---

   text    data     bss     dec     hex filename
3391587  157104  107136 3655827  37c893 vmlinux.3430sdp.orig
3391683  157104  107136 3655923  37c8f3 vmlinux.3430sdp.new

 arch/arm/mach-omap2/clock.c           |   63 ++++++++++++++++++---------------
 arch/arm/mach-omap2/clock34xx.h       |   60 ++++++++++++++++++++-----------
 arch/arm/mach-omap2/cm-regbits-34xx.h |   10 ++++-
 3 files changed, 80 insertions(+), 53 deletions(-)

