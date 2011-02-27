From: Michael Buesch <mb@bu3sch.de>
Subject: [PATCH] omap-mmc: Fix possible NULL pointer deref
Date: Sun, 27 Feb 2011 12:38:17 +0100
Message-ID: <1298806697.30857.5.camel@marge>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 80-190-117-144.ip-home.de ([80.190.117.144]:44924 "EHLO
	bu3sch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751937Ab1B0LiV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 27 Feb 2011 06:38:21 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Either OMAP_MMC_STAT_CARD_ERR or OMAP_MMC_STAT_END_OF_CMD might
fire if there is no host->cmd pointer.
Check for a valid host->cmd pointer before calling mmc_omap_cmd_done().

Signed-off-by: Michael Buesch <mb@bu3sch.de>

---

Fixes

[    3.814483] Unable to handle kernel NULL pointer dereference at virtual address 00000018
...
[    3.841247] CPU: 0    Not tainted  (2.6.38-rc6 #5)
[    3.846374] PC is at mmc_omap_cmd_done+0x1c/0x154
[    3.851379] LR is at mmc_omap_cmd_done+0x1c/0x154
...
[    4.140014] [<c0234af0>] (mmc_omap_cmd_done+0x1c/0x154) from [<c0234ea4>] (mmc_omap_irq+0x27c/0x32c)
[    4.149749] [<c0234ea4>] (mmc_omap_irq+0x27c/0x32c) from [<c008645c>] (handle_IRQ_event+0x24/0xe4)
[    4.159332] [<c008645c>] (handle_IRQ_event+0x24/0xe4) from [<c0087dac>] (handle_level_irq+0xbc/0x13c)
[    4.169158] [<c0087dac>] (handle_level_irq+0xbc/0x13c) from [<c002b070>] (asm_do_IRQ+0x70/0x94)
[    4.178466] [<c002b070>] (asm_do_IRQ+0x70/0x94) from [<c003016c>] (__irq_svc+0x4c/0xb8)


Index: linux-omap-2.6/drivers/mmc/host/omap.c
===================================================================
--- linux-omap-2.6.orig/drivers/mmc/host/omap.c	2011-02-27 12:32:03.051061690 +0100
+++ linux-omap-2.6/drivers/mmc/host/omap.c	2011-02-27 12:32:27.622530875 +0100
@@ -832,7 +832,7 @@
 		return IRQ_HANDLED;
 	}
 
-	if (end_command)
+	if (end_command && host->cmd)
 		mmc_omap_cmd_done(host, host->cmd);
 	if (host->data != NULL) {
 		if (transfer_error)


