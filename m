From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 0/3] ARM: OMAP2+: gpmc warning fixes
Date: Thu, 17 Mar 2011 21:30:03 +0530
Message-ID: <1300377606-16616-1-git-send-email-balajitk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44858 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754455Ab1CQP4q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Mar 2011 11:56:46 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Balaji T K <balajitk@ti.com>

Applies on omap-for-linus branch
Boot tested on OMAP4430 SDP and OMAP3630SDP

Balaji T K (3):
  ARM: OMAP2+: correct GPMC IRQ
  ARM: OMAP2+: GPMC set dummy irq chip
  ARM: OMAP4: correct GPMC IRQ number

 arch/arm/mach-omap2/gpmc.c             |   13 ++++++++-----
 arch/arm/plat-omap/include/plat/irqs.h |    2 +-
 2 files changed, 9 insertions(+), 6 deletions(-)

