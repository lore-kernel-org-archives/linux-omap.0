From: Hari Kanigeri <h-kanigeri2@ti.com>
Subject: [PATCH 2/7] omap:mailbox: fix rx interrupt disable in omap4
Date: Thu, 14 Oct 2010 20:13:17 -0500
Message-ID: <1287105202-31861-3-git-send-email-h-kanigeri2@ti.com>
References: <1287105202-31861-1-git-send-email-h-kanigeri2@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43311 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755731Ab0JOBNh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Oct 2010 21:13:37 -0400
In-Reply-To: <1287105202-31861-1-git-send-email-h-kanigeri2@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, linux omap <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Ohad Ben-Cohen <ohad@wizery.com>, Linux ARM <linux-arm-kernel@lists.arm.linux.org.uk>, Hari Kanigeri <h-kanigeri2@ti.com>

disabling rx interrupt on omap4 is different than its pre-decessors.
The bit in OMAP4_MAILBOX_IRQENABLE_CLR should be set to disable the
interrupts instead of clearing the bit.

Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
---
 arch/arm/mach-omap2/mailbox.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index 42dbfa4..82b5ced 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -195,7 +195,10 @@ static void omap2_mbox_disable_irq(struct omap_mbox *mbox,
 	struct omap_mbox2_priv *p = (struct omap_mbox2_priv *)mbox->priv;
 	u32 l, bit = (irq == IRQ_TX) ? p->notfull_bit : p->newmsg_bit;
 	l = mbox_read_reg(p->irqdisable);
-	l &= ~bit;
+	if (cpu_is_omap44xx())
+		l |= bit;
+	else
+		l &= ~bit;
 	mbox_write_reg(l, p->irqdisable);
 }
 
-- 
1.7.0

