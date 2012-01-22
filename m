From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] W1: OMAP HDQ1W: use 32-bit register accesses
Date: Sun, 22 Jan 2012 13:26:23 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1201221319270.26641@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49528 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752437Ab2AVU0Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 22 Jan 2012 15:26:24 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Evgeniy Polyakov <zbr@ioremap.net>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, neilb@suse.de


HDQ/1-wire registers are 32 bits long, even if the register contents
fit into 8 bits, so accesses must be 32-bit aligned.  Evidently the
OMAP2/3 interconnects allowed the driver to get away with 8 bit accesses,
but the OMAP4 puts a stop to that:

[    1.488800] Driver for 1-wire Dallas network protocol.
[    1.495025] Bad mode in data abort handler detected
[    1.500122] Internal error: Oops - bad mode: 0 [#1] SMP
[    1.505615] Modules linked in:
[    1.508819] CPU: 0    Not tainted  (3.3.0-rc1-00008-g45030e9 #992)
[    1.515289] PC is at 0xffff0018
[    1.518615] LR is at omap_hdq_probe+0xd4/0x2cc

The OMAP4430 ES2 Rev X TRM does warn about this restriction in section 
23.2.6.2 "HDQ/1-Wire Registers".

Fixes the crash on OMAP4430 ES2 Pandaboard.  Tested also on OMAP34xx and 
OMAP2420; it seems to work fine on those chips, although due to the lack 
of boards with HDQ/1-wire devices here, a more indepth test was not 
possible.

---
Intended for the v3.4 merge window.

 drivers/w1/masters/omap_hdq.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/w1/masters/omap_hdq.c b/drivers/w1/masters/omap_hdq.c
index 63e3eda..291897c 100644
--- a/drivers/w1/masters/omap_hdq.c
+++ b/drivers/w1/masters/omap_hdq.c
@@ -100,20 +100,20 @@ static struct w1_bus_master omap_w1_master = {
 /* HDQ register I/O routines */
 static inline u8 hdq_reg_in(struct hdq_data *hdq_data, u32 offset)
 {
-	return __raw_readb(hdq_data->hdq_base + offset);
+	return __raw_readl(hdq_data->hdq_base + offset);
 }
 
 static inline void hdq_reg_out(struct hdq_data *hdq_data, u32 offset, u8 val)
 {
-	__raw_writeb(val, hdq_data->hdq_base + offset);
+	__raw_writel(val, hdq_data->hdq_base + offset);
 }
 
 static inline u8 hdq_reg_merge(struct hdq_data *hdq_data, u32 offset,
 			u8 val, u8 mask)
 {
-	u8 new_val = (__raw_readb(hdq_data->hdq_base + offset) & ~mask)
+	u8 new_val = (__raw_readl(hdq_data->hdq_base + offset) & ~mask)
 			| (val & mask);
-	__raw_writeb(new_val, hdq_data->hdq_base + offset);
+	__raw_writel(new_val, hdq_data->hdq_base + offset);
 
 	return new_val;
 }
-- 
1.7.8.3

