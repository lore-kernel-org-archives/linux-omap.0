From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 0/2] OMAP2+: optional clock handling fixes
Date: Wed, 23 Apr 2014 11:41:02 +0530
Message-ID: <1398233465-8845-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50705 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753866AbaDWGMx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Apr 2014 02:12:53 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com, paul@pwsan.com, Rajendra Nayak <rnayak@ti.com>

The patches fix some opt clock handling in gpio and in
hwmod.

Rajendra Nayak (2):
  gpio: omap: prepare and unprepare the debounce clock
  ARM: OMAP2+: hwmod: Don't leave the optional clocks in
    clk_prepare()ed state

 arch/arm/mach-omap2/omap_hwmod.c |   13 ++-----------
 drivers/gpio/gpio-omap.c         |   10 +++++-----
 2 files changed, 7 insertions(+), 16 deletions(-)

-- 
1.7.9.5

