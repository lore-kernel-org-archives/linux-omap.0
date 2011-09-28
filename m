From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/4] Few omap fixes for review
Date: Wed, 28 Sep 2011 14:48:12 -0700
Message-ID: <20110928214707.29263.58095.stgit@kaulin.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:35062 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751701Ab1I1VsO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Sep 2011 17:48:14 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi all,

Here are some omap fixes for review. Only the first two would
be nice to get into v3.1 during the -rc cycle.

Regards,

Tony

---

Bjarne Steinsbo (1):
      ARM: OMAP4: Keyboard: Fix section mismatch in the board file

Bryan Buckley (1):
      ARM: OMAP4: MMC: fix power and audio issue, decouple USBC1 from MMC1

Tapani Utriainen (1):
      ARM: OMAP: irq: loop counter fix in omap_init_irq()

Tony Lindgren (1):
      ARM: OMAP: Fix i2c init for twl4030


 arch/arm/mach-omap2/board-2430sdp.c |    3 ++-
 arch/arm/mach-omap2/board-4430sdp.c |    2 +-
 arch/arm/mach-omap2/hsmmc.c         |   12 ++++--------
 arch/arm/mach-omap2/irq.c           |    4 ++--
 4 files changed, 9 insertions(+), 12 deletions(-)

-- 
Signature
