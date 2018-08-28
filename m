From: Rob Herring <robh@kernel.org>
Subject: [PATCH] ARM: omap: Convert to using %pOFn instead of device_node.name
Date: Mon, 27 Aug 2018 20:52:02 -0500
Message-ID: <20180828015252.28511-1-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: "Benoît Cousson" <bcousson@baylibre.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/mach-omap2/omap_hwmod.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 2ceffd85dd3d..b5757646355a 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -738,7 +738,7 @@ static int __init _setup_clkctrl_provider(struct device_node *np)
 	provider->size = size | 0xff;
 	provider->node = np;
 
-	pr_debug("%s: %s: %x...%x [+%x]\n", __func__, np->parent->name,
+	pr_debug("%pOF: %s: %x...%x [+%x]\n", __func__, np->parent,
 		 provider->addr, provider->addr + provider->size,
 		 provider->offset);
 
@@ -799,9 +799,9 @@ static struct clk *_lookup_clkctrl_clk(struct omap_hwmod *oh)
 
 			clk = of_clk_get_from_provider(&clkspec);
 
-			pr_debug("%s: %s got %p (offset=%x, provider=%s)\n",
+			pr_debug("%s: %s got %p (offset=%x, provider=%pOFn)\n",
 				 __func__, oh->name, clk, clkspec.args[0],
-				 provider->node->parent->name);
+				 provider->node->parent);
 
 			return clk;
 		}
@@ -2107,8 +2107,8 @@ static int of_dev_find_hwmod(struct device_node *np,
 		if (res)
 			continue;
 		if (!strcmp(p, oh->name)) {
-			pr_debug("omap_hwmod: dt %s[%i] uses hwmod %s\n",
-				 np->name, i, oh->name);
+			pr_debug("omap_hwmod: dt %pOFn[%i] uses hwmod %s\n",
+				 np, i, oh->name);
 			return i;
 		}
 	}
@@ -2210,8 +2210,8 @@ int omap_hwmod_parse_module_range(struct omap_hwmod *oh,
 		return -ENOENT;
 
 	if (nr_addr != 1 || nr_size != 1) {
-		pr_err("%s: invalid range for %s->%s\n", __func__,
-		       oh->name, np->name);
+		pr_err("%s: invalid range for %s->%pOFn\n", __func__,
+		       oh->name, np);
 		return -EINVAL;
 	}
 
@@ -2219,8 +2219,8 @@ int omap_hwmod_parse_module_range(struct omap_hwmod *oh,
 	base = of_translate_address(np, ranges++);
 	size = be32_to_cpup(ranges);
 
-	pr_debug("omap_hwmod: %s %s at 0x%llx size 0x%llx\n",
-		 oh->name, np->name, base, size);
+	pr_debug("omap_hwmod: %s %pOFn at 0x%llx size 0x%llx\n",
+		 oh->name, np, base, size);
 
 	res->start = base;
 	res->end = base + size - 1;
@@ -2322,8 +2322,8 @@ static int __init _init(struct omap_hwmod *oh, void *data)
 	if (r)
 		pr_debug("omap_hwmod: %s missing dt data\n", oh->name);
 	else if (np && index)
-		pr_warn("omap_hwmod: %s using broken dt data from %s\n",
-			oh->name, np->name);
+		pr_warn("omap_hwmod: %s using broken dt data from %pOFn\n",
+			oh->name, np);
 
 	r = _init_mpu_rt_base(oh, NULL, index, np);
 	if (r < 0) {
-- 
2.17.1
