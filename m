From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 09/14] omap: Use ioremap in dispc.c
Date: Fri, 16 Oct 2009 16:41:49 -0700
Message-ID: <20091016234149.2463.92822.stgit@localhost>
References: <20091016233624.2463.26653.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:61031 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897AbZJPXlq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Oct 2009 19:41:46 -0400
In-Reply-To: <20091016233624.2463.26653.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Imre Deak <imre.deak@nokia.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>, linux-omap@vger.kernel.org

Use ioremap in dispc.c

Cc: Imre Deak <imre.deak@nokia.com>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/video/omap/dispc.c |   20 +++++++++++++++++---
 1 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/video/omap/dispc.c b/drivers/video/omap/dispc.c
index f16e421..6f957ce 100644
--- a/drivers/video/omap/dispc.c
+++ b/drivers/video/omap/dispc.c
@@ -204,6 +204,7 @@ static u32 inline dispc_read_reg(int idx)
 /* Select RFBI or bypass mode */
 static void enable_rfbi_mode(int enable)
 {
+	void __iomem *rfbi_control;
 	u32 l;
 
 	l = dispc_read_reg(DISPC_CONTROL);
@@ -216,9 +217,15 @@ static void enable_rfbi_mode(int enable)
 	dispc_write_reg(DISPC_CONTROL, l);
 
 	/* Set bypass mode in RFBI module */
-	l = __raw_readl(OMAP2_IO_ADDRESS(RFBI_CONTROL));
+	rfbi_control = ioremap(RFBI_CONTROL, SZ_1K);
+	if (!rfbi_control) {
+		pr_err("Unable to ioremap rfbi_control\n");
+		return;
+	}
+	l = __raw_readl(rfbi_control);
 	l |= enable ? 0 : (1 << 1);
-	__raw_writel(l, OMAP2_IO_ADDRESS(RFBI_CONTROL));
+	__raw_writel(l, rfbi_control);
+	iounmap(rfbi_control);
 }
 
 static void set_lcd_data_lines(int data_lines)
@@ -1367,6 +1374,7 @@ static int omap_dispc_init(struct omapfb_device *fbdev, int ext_mode,
 	int r;
 	u32 l;
 	struct lcd_panel *panel = fbdev->panel;
+	void __iomem *ram_fw_base;
 	int tmo = 10000;
 	int skip_init = 0;
 	int i;
@@ -1441,7 +1449,13 @@ static int omap_dispc_init(struct omapfb_device *fbdev, int ext_mode,
 	}
 
 	/* L3 firewall setting: enable access to OCM RAM */
-	__raw_writel(0x402000b0, OMAP2_IO_ADDRESS(0x680050a0));
+	ram_fw_base = ioremap(0x68005000, SZ_1K);
+	if (!ram_fw_base) {
+		dev_err(dispc.fbdev->dev, "Cannot ioremap to enable OCM RAM\n");
+		goto fail1;
+	}
+	__raw_writel(0x402000b0, ram_fw_base + 0xa0);
+	iounmap(ram_fw_base);
 
 	if ((r = alloc_palette_ram()) < 0)
 		goto fail2;

