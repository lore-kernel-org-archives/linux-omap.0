From: Armando Uribe <x0095078@ti.com>
Subject: [PATCH] omap:mailbox: resolve hang issue
Date: Mon, 28 Feb 2011 18:14:23 -0600
Message-ID: <1298938463-15653-1-git-send-email-x0095078@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.orglinux
Cc: Hari Kanigeri <h-kanigeri2@ti.com>, Armando Uribe <x0095078@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Hari Kanigeri <h-kanigeri2@ti.com>

omap4 interrupt disable bits is different. On rx kfifo full, the mbox rx
interrupts wasn't getting disabled, and this is causing the rcm stress tests
to hang.

Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
Signed-off-by: Armando Uribe <x0095078@ti.com>
---
 arch/arm/mach-omap2/mailbox.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index 3d05ac8..2bfe8c6 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -207,7 +207,10 @@ static void omap2_mbox_disable_irq(struct omap_mbox *mbox,
 	struct omap_mbox2_priv *p = mbox->priv;
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
1.7.0.4
