From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 06/12] omap: mailbox: Flush posted write when acking mailbox
	irq
Date: Thu, 24 Sep 2009 16:39:21 -0700
Message-ID: <20090924233920.6065.16789.stgit@localhost>
References: <20090924233027.6065.95725.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:51745 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752711AbZIXXjS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Sep 2009 19:39:18 -0400
In-Reply-To: <20090924233027.6065.95725.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

The only way to flush posted write to L4 bus is to do a read back
of the same register right after the write.

This seems to be mostly needed in interrupt handlers to avoid
causing spurious interrupts.

The earlier fix has been to mark the L4 bus as strongly ordered
memory, which solves the problem, but causes performance penalties.

Similar to the fix, 03803a71041e3bc3c077f4e7b92f6ceaa9426df3

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/mailbox.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index 5bf9a2f..f3fefca 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -176,6 +176,9 @@ static void omap2_mbox_ack_irq(struct omap_mbox *mbox,
 	u32 bit = (irq == IRQ_TX) ? p->notfull_bit : p->newmsg_bit;
 
 	mbox_write_reg(bit, p->irqstatus);
+
+	/* Flush posted write for irq status to avoid spurious interrupts */
+	mbox_read_reg(p->irqstatus);
 }
 
 static int omap2_mbox_is_irq(struct omap_mbox *mbox,

