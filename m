From: Tomasz Figa <t.figa@samsung.com>
Subject: [PATCH v2 3/6] ARM: mm: cache-l2x0: Use l2c_write_sec() for
 LATENCY_CTRL registers
Date: Wed, 25 Jun 2014 15:37:28 +0200
Message-ID: <1403703451-12233-4-git-send-email-t.figa@samsung.com>
References: <1403703451-12233-1-git-send-email-t.figa@samsung.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:57284 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756563AbaFYNiU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Jun 2014 09:38:20 -0400
In-reply-to: <1403703451-12233-1-git-send-email-t.figa@samsung.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Laura Abbott <lauraa@codeaurora.org>, Linus Walleij <linus.walleij@linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, Tomasz Figa <tomasz.figa@gmail.com>, Daniel Drake <drake@endlessm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Tomasz Figa <t.figa@samsung.com>

According to the documentation, TAG_LATENCY_CTRL and DATA_LATENCY_CTRL
registers of L2C-310 can be written only in secure mode, so
l2c_write_sec() should be used to change them, instead of plain
writel_relaxed().

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/mm/cache-l2x0.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 478566b..6600fd9 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -622,10 +622,10 @@ static void l2c310_resume(void)
 		unsigned revision;
 
 		/* restore pl310 setup */
-		writel_relaxed(l2x0_saved_regs.tag_latency,
-			       base + L310_TAG_LATENCY_CTRL);
-		writel_relaxed(l2x0_saved_regs.data_latency,
-			       base + L310_DATA_LATENCY_CTRL);
+		l2c_write_sec(l2x0_saved_regs.tag_latency,
+			       base, L310_TAG_LATENCY_CTRL);
+		l2c_write_sec(l2x0_saved_regs.data_latency,
+			       base, L310_DATA_LATENCY_CTRL);
 		writel_relaxed(l2x0_saved_regs.filter_end,
 			       base + L310_ADDR_FILTER_END);
 		writel_relaxed(l2x0_saved_regs.filter_start,
@@ -1024,20 +1024,20 @@ static void __init l2c310_of_parse(const struct device_node *np,
 
 	of_property_read_u32_array(np, "arm,tag-latency", tag, ARRAY_SIZE(tag));
 	if (tag[0] && tag[1] && tag[2])
-		writel_relaxed(
+		l2c_write_sec(
 			L310_LATENCY_CTRL_RD(tag[0] - 1) |
 			L310_LATENCY_CTRL_WR(tag[1] - 1) |
 			L310_LATENCY_CTRL_SETUP(tag[2] - 1),
-			l2x0_base + L310_TAG_LATENCY_CTRL);
+			l2x0_base, L310_TAG_LATENCY_CTRL);
 
 	of_property_read_u32_array(np, "arm,data-latency",
 				   data, ARRAY_SIZE(data));
 	if (data[0] && data[1] && data[2])
-		writel_relaxed(
+		l2c_write_sec(
 			L310_LATENCY_CTRL_RD(data[0] - 1) |
 			L310_LATENCY_CTRL_WR(data[1] - 1) |
 			L310_LATENCY_CTRL_SETUP(data[2] - 1),
-			l2x0_base + L310_DATA_LATENCY_CTRL);
+			l2x0_base, L310_DATA_LATENCY_CTRL);
 
 	of_property_read_u32_array(np, "arm,filter-ranges",
 				   filter, ARRAY_SIZE(filter));
-- 
1.9.3

