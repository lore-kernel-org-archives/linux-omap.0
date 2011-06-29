From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 0/2] RETU meets Sparse IRQ
Date: Wed, 29 Jun 2011 14:46:49 +0300
Message-ID: <1309348011-23141-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:43591 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754734Ab1F2Lq6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Jun 2011 07:46:58 -0400
Received: by bwf20 with SMTP id 20so1182676bwf.20
        for <linux-omap@vger.kernel.org>; Wed, 29 Jun 2011 04:46:55 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

now with Sparse IRQ numbering, we don't need
to add a bunch of defines in <plat/irqs.h>

Compile tested with omap2plus_defconfig (+cbus)
and omap1_defconfig (+cbus).

Felipe Balbi (2):
  cbus: retu: use sparse IRQ numbering
  cbus: retu: stop polluting <plat/irqs.h>

 arch/arm/mach-omap1/board-nokia770.c   |    2 --
 arch/arm/mach-omap2/board-n8x0.c       |    2 --
 arch/arm/plat-omap/include/plat/irqs.h |   10 +---------
 drivers/cbus/retu.c                    |   25 ++++++++++++++++---------
 include/linux/platform_data/cbus.h     |    2 --
 5 files changed, 17 insertions(+), 24 deletions(-)

-- 
1.7.6

