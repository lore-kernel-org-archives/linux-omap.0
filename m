From: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Subject: [PATCH] MMC: OMAP: Readable output for IRQ status register
Date: Mon, 18 Aug 2008 18:13:17 +0300
Message-ID: <1219072400-7814-4-git-send-email-jarkko.lavinen@nokia.com>
References: <1219072400-7814-1-git-send-email-jarkko.lavinen@nokia.com>
 <1219072400-7814-2-git-send-email-jarkko.lavinen@nokia.com>
 <1219072400-7814-3-git-send-email-jarkko.lavinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:55426 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752178AbYHRPRK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Aug 2008 11:17:10 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m7IFGBke015871
	for <linux-omap@vger.kernel.org>; Mon, 18 Aug 2008 10:17:08 -0500
In-Reply-To: <1219072400-7814-3-git-send-email-jarkko.lavinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Francisco Alecrim <francisco.alecrim@indt.org.br>, Jarkko Lavinen <jarkko.lavinen@nokia.com>

From: Francisco Alecrim <francisco.alecrim@indt.org.br>

Readable output for IRQ status register

Signed-off-by: Francisco Alecrim <francisco.alecrim@indt.org.br>
Acked-by: Anderson Lizardo <anderson.lizardo@indt.org.br>
---
 drivers/mmc/host/omap_hsmmc.c |   34 ++++++++++++++++++++++++++++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index e361213..f5acf91 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -298,6 +298,37 @@ static void mmc_dma_cleanup(struct mmc_omap_host *host)
 }
 
 /*
+ * Readable error output
+ */
+#ifdef CONFIG_MMC_DEBUG
+static void mmc_omap_report_irq(struct mmc_omap_host *host, u32 status)
+{
+	/* --- means reserved bit without definition at documentation */
+	static const char *mmc_omap_status_bits[] = {
+		"CC", "TC", "BGE", "---", "BWR", "BRR", "---", "---", "CIRQ",
+		"OBI", "---", "---", "---", "---", "---", "ERRI", "CTO", "CCRC",
+		"CEB", "CIE", "DTO", "DCRC", "DEB", "---", "ACE", "---",
+		"---", "---", "---", "CERR", "CERR", "BADA", "---", "---", "---"
+	};
+	int i;
+
+	dev_dbg(mmc_dev(host->mmc), "MMC IRQ 0x%x :", status);
+
+	for (i = 0; i < ARRAY_SIZE(mmc_omap_status_bits); i++)
+		if (status & (1 << i))
+			/*
+			 * KERN_* facility is not used here because this should
+			 * print a single line.
+			 */
+			printk(" %s", mmc_omap_status_bits[i]);
+
+	printk("\n");
+
+}
+#endif  /* CONFIG_MMC_DEBUG */
+
+
+/*
  * MMC controller IRQ handler
  */
 static irqreturn_t mmc_omap_irq(int irq, void *dev_id)
@@ -317,6 +348,9 @@ static irqreturn_t mmc_omap_irq(int irq, void *dev_id)
 	dev_dbg(mmc_dev(host->mmc), "IRQ Status is %x\n", status);
 
 	if (status & ERR) {
+#ifdef CONFIG_MMC_DEBUG
+		mmc_omap_report_irq(host, status);
+#endif
 		if ((status & CMD_TIMEOUT) ||
 			(status & CMD_CRC)) {
 			if (host->cmd) {
-- 
1.5.6.3

