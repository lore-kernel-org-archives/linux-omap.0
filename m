From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 0/9] arm: omap: intc: remaining patches
Date: Mon, 15 Sep 2014 16:15:00 -0500
Message-ID: <1410815709-462-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54195 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753571AbaIOVPy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Sep 2014 17:15:54 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jason Cooper <jason@lakedaemon.net>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

Hi Tony,

Here are the remaining INTC patches rebased on your omap-for-v3.18/intc-v2
branch.

Based on our IRC chat, I kept irq-omap-intc.h header, but included it
on common.h instead of modifying every board-file.

cheers

Felipe Balbi (9):
  irqchip: add irq-omap-intc.h header
  arm: omap: irq: move irq.c to drivers/irqchip/
  irqchip: omap-intc: minor improvement to omap_irq_pending()
  irqchip: omap-intc: comment style cleanup
  irqchip: omap-intc: remove unnecesary of_address_to_resource() call
  irqchip: omap-intc: enable IP protection
  irqchip: omap-intc: enable TURBO idle mode
  irqchip: omap-intc: correct maximum number or MIR registers
  irqchip: omap-intc: remove unnecessary comments

 arch/arm/mach-omap2/Kconfig                        |  1 +
 arch/arm/mach-omap2/Makefile                       |  3 +-
 arch/arm/mach-omap2/common.h                       | 10 +---
 drivers/irqchip/Kconfig                            |  5 ++
 drivers/irqchip/Makefile                           |  1 +
 .../irq.c => drivers/irqchip/irq-omap-intc.c       | 64 +++++++++++++---------
 include/linux/irqchip/irq-omap-intc.h              | 32 +++++++++++
 7 files changed, 78 insertions(+), 38 deletions(-)
 rename arch/arm/mach-omap2/irq.c => drivers/irqchip/irq-omap-intc.c (89%)
 create mode 100644 include/linux/irqchip/irq-omap-intc.h

-- 
2.0.1.563.g66f467c

