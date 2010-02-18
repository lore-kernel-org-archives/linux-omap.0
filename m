From: "Anna, Suman" <s-anna@ti.com>
Subject: [PATCH 3/5] omap: mailbox: correct OMAP4 SIDLEMODE logic
Date: Thu, 18 Feb 2010 15:07:24 -0600
Message-ID: <2C1563023E232C49B9F505633D57C2DA2640D0235D@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49776 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753151Ab0BRVH3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Feb 2010 16:07:29 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Hiroshi.DOYU@nokia.com" <Hiroshi.DOYU@nokia.com>, "Clark, Rob" <rob@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "C.A, Subramaniam" <subramaniam.ca@ti.com>

>From 18beb1784db07e4eb2b9d10783a309b5caccb979 Mon Sep 17 00:00:00 2001
From: Suman Anna <s-anna@ti.com>
Date: Fri, 5 Feb 2010 17:20:26 -0600
Subject: [PATCH 3/5] omap: mailbox: correct OMAP4 SIDLEMODE logic

OMAP4 mailbox has a different MAILBOX_SYSCONFIG register.
There is now no AutoIdle. The SIDLEMODE bits have been
right-shifted by 1 bit and now occupy bits 2 & 3.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/mach-omap2/mailbox.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index 88e9043..e0c1f1b 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -41,6 +41,8 @@
 #define SOFTRESET	(1 << 1)
 #define SMARTIDLE	(2 << 3)
 #define OMAP4_SOFTRESET	(1 << 0)
+#define OMAP4_NOIDLE	(1 << 2)
+#define OMAP4_SMARTIDLE	(2 << 2)
 
 /* SYSSTATUS: register bit definition */
 #define RESETDONE	(1 << 0)
@@ -131,7 +133,10 @@ static int omap2_mbox_startup(struct omap_mbox *mbox)
 	l = mbox_read_reg(MAILBOX_REVISION);
 	pr_info("omap mailbox rev %d.%d\n", (l & 0xf0) >> 4, (l & 0x0f));
 
-	l = SMARTIDLE | AUTOIDLE;
+	if (cpu_is_omap44xx())
+		l = OMAP4_SMARTIDLE;
+	else
+		l = SMARTIDLE | AUTOIDLE;
 	mbox_write_reg(l, MAILBOX_SYSCONFIG);
 
 	omap2_mbox_enable_irq(mbox, IRQ_RX);
-- 
1.6.6.2
