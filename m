From: Tomasz Figa <t.figa@samsung.com>
Subject: [PATCH v2 4/6] ARM: mm: l2x0: Add support for overriding prefetch
 settings
Date: Wed, 25 Jun 2014 15:37:29 +0200
Message-ID: <1403703451-12233-5-git-send-email-t.figa@samsung.com>
References: <1403703451-12233-1-git-send-email-t.figa@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1403703451-12233-1-git-send-email-t.figa@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Laura Abbott <lauraa@codeaurora.org>, Linus Walleij <linus.walleij@linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, Tomasz Figa <tomasz.figa@gmail.com>, Daniel Drake <drake@endlessm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Tomasz Figa <t.figa@samsung.com>
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
---
 Documentation/devicetree/bindings/arm/l2cc.txt | 10 ++++++
 arch/arm/mm/cache-l2x0.c                       | 46 ++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/l2cc.txt b/Documentation/devicetree/bindings/arm/l2cc.txt
index b513cb8..8096fcd 100644
--- a/Documentation/devicetree/bindings/arm/l2cc.txt
+++ b/Documentation/devicetree/bindings/arm/l2cc.txt
@@ -44,6 +44,16 @@ Optional properties:
 - cache-id-part: cache id part number to be used if it is not present
   on hardware
 - wt-override: If present then L2 is forced to Write through mode
+- arm,double-linefill : Override double linefill enable setting. Enable if
+  non-zero, disable if zero.
+- arm,double-linefill-incr : Override double linefill on INCR read. Enable
+  if non-zero, disable if zero.
+- arm,double-linefill-wrap : Override double linefill on WRAP read. Enable
+  if non-zero, disable if zero.
+- arm,prefetch-drop : Override prefetch drop enable setting. Enable if non-zero,
+  disable if zero.
+- arm,prefetch-offset : Override prefetch offset value. Valid values are
+  0-7, 15, 23, and 31.
 
 Example:
 
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 6600fd9..fd23cce 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -1018,9 +1018,12 @@ static const struct l2c_init_data of_l2c220_data __initconst = {
 static void __init l2c310_of_parse(const struct device_node *np,
 	u32 *aux_val, u32 *aux_mask)
 {
+	bool set_prefetch = false;
 	u32 data[3] = { 0, 0, 0 };
 	u32 tag[3] = { 0, 0, 0 };
 	u32 filter[2] = { 0, 0 };
+	u32 prefetch;
+	u32 val;
 
 	of_property_read_u32_array(np, "arm,tag-latency", tag, ARRAY_SIZE(tag));
 	if (tag[0] && tag[1] && tag[2])
@@ -1047,6 +1050,49 @@ static void __init l2c310_of_parse(const struct device_node *np,
 		writel_relaxed((filter[0] & ~(SZ_1M - 1)) | L310_ADDR_FILTER_EN,
 			       l2x0_base + L310_ADDR_FILTER_START);
 	}
+
+	prefetch = readl_relaxed(l2x0_base + L310_PREFETCH_CTRL);
+
+	if (!of_property_read_u32(np, "arm,double-linefill", &val)) {
+		if (val)
+			prefetch |= L310_PREFETCH_CTRL_DBL_LINEFILL;
+		else
+			prefetch &= ~L310_PREFETCH_CTRL_DBL_LINEFILL;
+		set_prefetch = true;
+	}
+
+	if (!of_property_read_u32(np, "arm,double-linefill-incr", &val)) {
+		if (val)
+			prefetch |= L310_PREFETCH_CTRL_DBL_LINEFILL_INCR;
+		else
+			prefetch &= ~L310_PREFETCH_CTRL_DBL_LINEFILL_INCR;
+		set_prefetch = true;
+	}
+
+	if (!of_property_read_u32(np, "arm,double-linefill-wrap", &val)) {
+		if (!val)
+			prefetch |= L310_PREFETCH_CTRL_DBL_LINEFILL_WRAP;
+		else
+			prefetch &= ~L310_PREFETCH_CTRL_DBL_LINEFILL_WRAP;
+		set_prefetch = true;
+	}
+
+	if (!of_property_read_u32(np, "arm,prefetch-drop", &val)) {
+		if (val)
+			prefetch |= L310_PREFETCH_CTRL_PREFETCH_DROP;
+		else
+			prefetch &= ~L310_PREFETCH_CTRL_PREFETCH_DROP;
+		set_prefetch = true;
+	}
+
+	if (!of_property_read_u32(np, "arm,prefetch-offset", &val)) {
+		prefetch &= ~L310_PREFETCH_CTRL_OFFSET_MASK;
+		prefetch |= val & L310_PREFETCH_CTRL_OFFSET_MASK;
+		set_prefetch = true;
+	}
+
+	if (set_prefetch)
+		l2c_write_sec(prefetch, l2x0_base, L310_PREFETCH_CTRL);
 }
 
 static const struct l2c_init_data of_l2c310_data __initconst = {
-- 
1.9.3
