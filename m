From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [RFC PATCH 1/7] OMAP2+: hwmod_data: define number of mailboxes
Date: Fri, 24 Jun 2011 20:17:37 -0500
Message-ID: <1308964663-5669-2-git-send-email-omar.ramirez@ti.com>
References: <1308964663-5669-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:56582 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751588Ab1FYBSN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Jun 2011 21:18:13 -0400
Received: by mail-yi0-f42.google.com with SMTP id 10so1559298yih.29
        for <linux-omap@vger.kernel.org>; Fri, 24 Jun 2011 18:18:12 -0700 (PDT)
In-Reply-To: <1308964663-5669-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi Doyu <hiroshi.doyu@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Benoit Cousson <b-cousson@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>, lo <linux-omap@vger.kernel.org>, lak <linux-arm-kernel@lists.infradead.org>

Define number of mailboxes available to a specific chip.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |    6 ++++++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |    6 ++++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    6 ++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    6 ++++++
 arch/arm/plat-omap/include/plat/mailbox.h  |    8 ++++++++
 5 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index c4d0ae8..6493eb5 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -18,6 +18,7 @@
 #include <plat/serial.h>
 #include <plat/i2c.h>
 #include <plat/gpio.h>
+#include <plat/mailbox.h>
 #include <plat/mcspi.h>
 #include <plat/dmtimer.h>
 #include <plat/l3_2xxx.h>
@@ -1855,6 +1856,10 @@ static struct omap_hwmod_class omap2420_mailbox_hwmod_class = {
 	.sysc = &omap2420_mailbox_sysc,
 };
 
+static struct omap_mailbox_dev_attr mailbox_dev_attr = {
+	.nr_mbox	= 6,
+};
+
 /* mailbox */
 static struct omap_hwmod omap2420_mailbox_hwmod;
 static struct omap_hwmod_irq_info omap2420_mailbox_irqs[] = {
@@ -1899,6 +1904,7 @@ static struct omap_hwmod omap2420_mailbox_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_MAILBOXES_SHIFT,
 		},
 	},
+	.dev_attr	= &mailbox_dev_attr,
 	.slaves		= omap2420_mailbox_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2420_mailbox_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index 9682dd5..8d9d455 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -18,6 +18,7 @@
 #include <plat/serial.h>
 #include <plat/i2c.h>
 #include <plat/gpio.h>
+#include <plat/mailbox.h>
 #include <plat/mcbsp.h>
 #include <plat/mcspi.h>
 #include <plat/dmtimer.h>
@@ -1989,6 +1990,10 @@ static struct omap_hwmod_class omap2430_mailbox_hwmod_class = {
 	.sysc = &omap2430_mailbox_sysc,
 };
 
+static struct omap_mailbox_dev_attr mailbox_dev_attr = {
+	.nr_mbox	= 6,
+};
+
 /* mailbox */
 static struct omap_hwmod omap2430_mailbox_hwmod;
 static struct omap_hwmod_irq_info omap2430_mailbox_irqs[] = {
@@ -2032,6 +2037,7 @@ static struct omap_hwmod omap2430_mailbox_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_MAILBOXES_SHIFT,
 		},
 	},
+	.dev_attr	= &mailbox_dev_attr,
 	.slaves		= omap2430_mailbox_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2430_mailbox_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 909a84d..d7fa0ae 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -22,6 +22,7 @@
 #include <plat/l4_3xxx.h>
 #include <plat/i2c.h>
 #include <plat/gpio.h>
+#include <plat/mailbox.h>
 #include <plat/mmc.h>
 #include <plat/mcbsp.h>
 #include <plat/mcspi.h>
@@ -3022,6 +3023,10 @@ static struct omap_hwmod_class omap3xxx_mailbox_hwmod_class = {
 	.sysc = &omap3xxx_mailbox_sysc,
 };
 
+static struct omap_mailbox_dev_attr mailbox_dev_attr = {
+	.nr_mbox	= 6,
+};
+
 static struct omap_hwmod omap3xxx_mailbox_hwmod;
 static struct omap_hwmod_irq_info omap3xxx_mailbox_irqs[] = {
 	{ .irq = 26 },
@@ -3064,6 +3069,7 @@ static struct omap_hwmod omap3xxx_mailbox_hwmod = {
 			.idlest_idle_bit = OMAP3430_ST_MAILBOXES_SHIFT,
 		},
 	},
+	.dev_attr	= &mailbox_dev_attr,
 	.slaves		= omap3xxx_mailbox_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_mailbox_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index e1c69ff..eb279f0 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -24,6 +24,7 @@
 #include <plat/cpu.h>
 #include <plat/gpio.h>
 #include <plat/dma.h>
+#include <plat/mailbox.h>
 #include <plat/mcspi.h>
 #include <plat/mcbsp.h>
 #include <plat/mmc.h>
@@ -2717,6 +2718,10 @@ static struct omap_hwmod_class omap44xx_mailbox_hwmod_class = {
 	.sysc	= &omap44xx_mailbox_sysc,
 };
 
+static struct omap_mailbox_dev_attr mailbox_dev_attr = {
+	.nr_mbox	= 8,
+};
+
 /* mailbox */
 static struct omap_hwmod omap44xx_mailbox_hwmod;
 static struct omap_hwmod_irq_info omap44xx_mailbox_irqs[] = {
@@ -2756,6 +2761,7 @@ static struct omap_hwmod omap44xx_mailbox_hwmod = {
 			.clkctrl_reg = OMAP4430_CM_L4CFG_MAILBOX_CLKCTRL,
 		},
 	},
+	.dev_attr	= &mailbox_dev_attr,
 	.slaves		= omap44xx_mailbox_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_mailbox_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
diff --git a/arch/arm/plat-omap/include/plat/mailbox.h b/arch/arm/plat-omap/include/plat/mailbox.h
index cc3921e..337b93c 100644
--- a/arch/arm/plat-omap/include/plat/mailbox.h
+++ b/arch/arm/plat-omap/include/plat/mailbox.h
@@ -41,6 +41,14 @@ struct omap_mbox_ops {
 	void		(*restore_ctx)(struct omap_mbox *mbox);
 };
 
+struct omap_mailbox_dev_attr {
+	u16		nr_mbox;
+};
+
+struct omap_mailbox_platform_data {
+	u16		nr_mbox;
+};
+
 struct omap_mbox_queue {
 	spinlock_t		lock;
 	struct kfifo		fifo;
-- 
1.7.0.4

