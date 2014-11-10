From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v2 0/2] bus: omap_l3_noc: Add resume hook to restore mask registers
Date: Mon, 10 Nov 2014 23:49:46 +0530
Message-ID: <1415643588-14508-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45615 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750941AbaKJSYA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Nov 2014 13:24:00 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: j-keerthy@ti.com, nm@ti.com, afzal@ti.com, tony@atomide.com

l3_noc module loses context during both DS0 and RTC+DDR in self refresh modes.
This causes the previously masked l3 interrupts to trigger and the software
book keeping assumes the interrupts are masked and does nothing to mask.
This software/hardware out of sync leads to back to back l3 interrupts
and eventually causes a hang. Hence adding resume hook to restore the
mask registers based on the book keeping variables

Keerthy (2):
  bus: omap_l3_noc: Add resume hook to restore context
  bus: omap_l3_noc: Correct returning IRQ_HANDLED unconditionally in
    the irq handler

 drivers/bus/omap_l3_noc.c |   63 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 61 insertions(+), 2 deletions(-)

-- 
1.7.9.5

