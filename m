From: Sricharan R <r.sricharan@ti.com>
Subject: [PATCH 0/5] irqchip/dra7: crossbar bug fixes
Date: Mon, 5 May 2014 19:48:42 +0530
Message-ID: <1399299527-10955-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51489 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932538AbaEEOU1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 May 2014 10:20:27 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: nm@ti.com, rnayak@ti.com, santosh.shilimkar@ti.com, tony@atomide.com

These are fixes for the crossbar to handle two interrupts getting
mapped twice to same crossbar and to skip some interrupts being used
due to hardware bugs.

Nishanth Menon (5):
  irqchip: crossbar: dont use '0' to mark reserved interrupts
  irqchip: crossbar: check for premapped crossbar before allocating
  irqchip: crossbar: Skip some irqs from getting mapped to crossbar
  irqchip: crossbar: Initialise the crossbar with a safe value
  irqchip: crossbar: Change allocation logic by reversing search for
    free irqs

 drivers/irqchip/irq-crossbar.c |   82 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 74 insertions(+), 8 deletions(-)

-- 
1.7.9.5

