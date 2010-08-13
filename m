From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/6] omap fixes for upcoming 2.6.36-rc1
Date: Fri, 13 Aug 2010 11:01:38 +0300
Message-ID: <20100813080034.18750.15410.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:63647 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755243Ab0HMIBp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Aug 2010 04:01:45 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi all,

Here are some omap fixes for review.

Regards,

Tony

---

Kevin Hilman (1):
      OMAP3: PM: ensure IO wakeups are properly disabled

Nishanth Menon (1):
      omap3: id: fix 3630 rev detection

Tony Lindgren (3):
      omap: Fix sev instruction usage for multi-omap
      omap: Use CONFIG_SMP for test_for_ipi and test_for_ltirq
      omap: Fix omap_4430sdp_defconfig for make oldconfig

stanley.miao (1):
      OMAP3: Fix a cpu type check problem


 arch/arm/configs/omap_4430sdp_defconfig        |    3 +++
 arch/arm/mach-omap2/Makefile                   |    1 +
 arch/arm/mach-omap2/clock3xxx_data.c           |   14 +++++++-------
 arch/arm/mach-omap2/id.c                       |    2 +-
 arch/arm/mach-omap2/include/mach/entry-macro.S |    6 ++++--
 arch/arm/mach-omap2/omap-smp.c                 |    3 +--
 arch/arm/mach-omap2/pm34xx.c                   |    4 +++-
 arch/arm/plat-omap/include/plat/smp.h          |    7 -------
 8 files changed, 20 insertions(+), 20 deletions(-)

-- 
Signature
