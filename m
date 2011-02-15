From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH 0/2] omap3: minor clean-up in flash related code
Date: Tue, 15 Feb 2011 16:27:30 +0530
Message-ID: <1297767452-22554-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51775 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751008Ab1BOK5o (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Feb 2011 05:57:44 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Sanjeev Premi <premi@ti.com>

Changes include:
 - fixing typos
 - using pr_err() instead of printk

Sanjeev Premi (2):
  omap3: fix minor typos
  omap3: flash: use pr_err instead of printk

 arch/arm/mach-omap2/board-flash.c |   19 ++++++++-----------
 1 files changed, 8 insertions(+), 11 deletions(-)

-- 
1.7.2.2

