From: "Anna, Suman" <s-anna@ti.com>
Subject: [PATCH 2/5] omap: mailbox: correct OMAP4 reset logic
Date: Thu, 18 Feb 2010 15:07:21 -0600
Message-ID: <2C1563023E232C49B9F505633D57C2DA2640D0235C@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45703 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753151Ab0BRVH1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Feb 2010 16:07:27 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Hiroshi.DOYU@nokia.com" <Hiroshi.DOYU@nokia.com>, "Clark, Rob" <rob@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "C.A, Subramaniam" <subramaniam.ca@ti.com>

>From 2488815a9facca29e2da3ddd279de441a5de6a58 Mon Sep 17 00:00:00 2001
From: Suman Anna <s-anna@ti.com>
Date: Tue, 26 Jan 2010 16:55:29 -0600
Subject: [PATCH 2/5] omap: mailbox: correct OMAP4 reset logic

OMAP4 mailbox has a different register set. There is
no MAILBOX_SYSSTATUS register. The reset is indicated
with the SOFTRESET bit of the MAILBOX_SYSCONFIG register
itself. This bit should read 0 for a successful Reset.
Also, the SOFTRESET bit occupies bit0 and not bit1 as with
previous generations.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/mach-omap2/mailbox.c |   38 +++++++++++++++++++++++++++-----------
 1 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index c970cf6..88e9043 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -40,6 +40,7 @@
 #define AUTOIDLE	(1 << 0)
 #define SOFTRESET	(1 << 1)
 #define SMARTIDLE	(2 << 3)
+#define OMAP4_SOFTRESET	(1 << 0)
 
 /* SYSSTATUS: register bit definition */
 #define RESETDONE	(1 << 0)
@@ -99,17 +100,32 @@ static int omap2_mbox_startup(struct omap_mbox *mbox)
 	}
 	clk_enable(mbox_ick_handle);
 
-	mbox_write_reg(SOFTRESET, MAILBOX_SYSCONFIG);
-	timeout = jiffies + msecs_to_jiffies(20);
-	do {
-		l = mbox_read_reg(MAILBOX_SYSSTATUS);
-		if (l & RESETDONE)
-			break;
-	} while (!time_after(jiffies, timeout));
-
-	if (!(l & RESETDONE)) {
-		pr_err("Can't take mmu out of reset\n");
-		return -ENODEV;
+	if (cpu_is_omap44xx()) {
+		mbox_write_reg(OMAP4_SOFTRESET, MAILBOX_SYSCONFIG);
+		timeout = jiffies + msecs_to_jiffies(20);
+		do {
+			l = mbox_read_reg(MAILBOX_SYSCONFIG);
+			if (!(l & OMAP4_SOFTRESET))
+				break;
+		} while (!time_after(jiffies, timeout));
+
+		if (l & OMAP4_SOFTRESET) {
+			pr_err("Can't take mailbox out of reset\n");
+			return -ENODEV;
+		}
+	} else {
+		mbox_write_reg(SOFTRESET, MAILBOX_SYSCONFIG);
+		timeout = jiffies + msecs_to_jiffies(20);
+		do {
+			l = mbox_read_reg(MAILBOX_SYSSTATUS);
+			if (l & RESETDONE)
+				break;
+		} while (!time_after(jiffies, timeout));
+
+		if (!(l & RESETDONE)) {
+			pr_err("Can't take mailbox out of reset\n");
+			return -ENODEV;
+		}
 	}
 
 	l = mbox_read_reg(MAILBOX_REVISION);
-- 
1.6.6.2

