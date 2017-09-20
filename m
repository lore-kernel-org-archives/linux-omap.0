From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 05/10] ARM: OMAP2+: Parse module IO range from dts for legacy "ti,hwmods" support
Date: Wed, 20 Sep 2017 15:46:16 -0700
Message-ID: <20170920224621.16236-6-tony@atomide.com>
References: <20170920224621.16236-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170920224621.16236-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

When removing legacy platform data for IO ranges for the hwmod
interconnect code, we still need to support the "ti,hwmods"
property.

And as we're going to use a generic sysc device driver to handle the
interconnect target instances, we can parse the information needed
for legacy "ti,hwmods" IO range from the dts. It's always the first
range the interconnect target module provides.

Note that we want to parse the range instead of the first child
device IO regs as the child device may not always be defined.

The child IP device node may not exist in cases where there is no
driver binding for the device, or when the child IP block may not
even be functional for some SoC revisions. But the IO range of the
interconnect target module is always known.

Cc: "Benoît Cousson" <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Cc: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 arch/arm/mach-omap2/omap_hwmod.c | 80 +++++++++++++++++++++++++++++++++++++++-
 arch/arm/mach-omap2/omap_hwmod.h |  5 +++
 2 files changed, 84 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2395,6 +2395,75 @@ static int of_dev_hwmod_lookup(struct device_node *np,
 	return -ENODEV;
 }
 
+/**
+ * omap_hwmod_parse_module_range - map module IO range from device tree
+ * @oh: struct omap_hwmod *
+ * @np: struct device_node *
+ *
+ * Parse the device tree range an interconnect target module provides
+ * for it's child device IP blocks. This way we can support the old
+ * "ti,hwmods" property with just dts data without a need for platform
+ * data for IO resources. And we don't need all the child IP device
+ * nodes available in the dts.
+ */
+int omap_hwmod_parse_module_range(struct omap_hwmod *oh,
+				  struct device_node *np,
+				  struct resource *res)
+{
+	struct property *prop;
+	const __be32 *ranges;
+	const char *name;
+	u32 nr_addr, nr_size;
+	u64 base, size;
+	int len, error;
+
+	if (!res)
+		return -EINVAL;
+
+	ranges = of_get_property(np, "ranges", &len);
+	if (!ranges)
+		return -ENOENT;
+
+	len /= sizeof(*ranges);
+
+	if (len < 3)
+		return -EINVAL;
+
+	of_property_for_each_string(np, "compatible", prop, name)
+		if (!strncmp("ti,sysc-", name, 8))
+			break;
+
+	if (!name)
+		return -ENOENT;
+
+	error = of_property_read_u32(np, "#address-cells", &nr_addr);
+	if (error)
+		return -ENOENT;
+
+	error = of_property_read_u32(np, "#size-cells", &nr_size);
+	if (error)
+		return -ENOENT;
+
+	if (nr_addr != 1 || nr_size != 1) {
+		pr_err("%s: invalid range for %s->%s\n", __func__,
+		       oh->name, np->name);
+		return -EINVAL;
+	}
+
+	ranges++;
+	base = of_translate_address(np, ranges++);
+	size = be32_to_cpup(ranges);
+
+	pr_debug("omap_hwmod: %s %s at 0x%llx size 0x%llx\n",
+		 oh->name, np->name, base, size);
+
+	res->start = base;
+	res->end = base + size - 1;
+	res->flags = IORESOURCE_MEM;
+
+	return 0;
+}
+
 /**
  * _init_mpu_rt_base - populate the virtual address for a hwmod
  * @oh: struct omap_hwmod * to locate the virtual address
@@ -2417,6 +2486,8 @@ static int __init _init_mpu_rt_base(struct omap_hwmod *oh, void *data,
 {
 	struct omap_hwmod_addr_space *mem;
 	void __iomem *va_start = NULL;
+	struct resource res;
+	int error;
 
 	if (!oh)
 		return -EINVAL;
@@ -2442,7 +2513,14 @@ static int __init _init_mpu_rt_base(struct omap_hwmod *oh, void *data,
 			return -ENXIO;
 		}
 
-		va_start = of_iomap(np, index + oh->mpu_rt_idx);
+		/* Do we have a dts range for the interconnect target module? */
+		error = omap_hwmod_parse_module_range(oh, np, &res);
+		if (!error)
+			va_start = ioremap(res.start, resource_size(&res));
+
+		/* No ranges, rely on device reg entry */
+		if (!va_start)
+			va_start = of_iomap(np, index + oh->mpu_rt_idx);
 	} else {
 		va_start = ioremap(mem->pa_start, mem->pa_end - mem->pa_start);
 	}
diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hwmod.h
--- a/arch/arm/mach-omap2/omap_hwmod.h
+++ b/arch/arm/mach-omap2/omap_hwmod.h
@@ -690,11 +690,16 @@ struct omap_hwmod {
 	struct omap_hwmod		*parent_hwmod;
 };
 
+struct device_node;
+
 struct omap_hwmod *omap_hwmod_lookup(const char *name);
 int omap_hwmod_for_each(int (*fn)(struct omap_hwmod *oh, void *data),
 			void *data);
 
 int __init omap_hwmod_setup_one(const char *name);
+int omap_hwmod_parse_module_range(struct omap_hwmod *oh,
+				  struct device_node *np,
+				  struct resource *res);
 
 int omap_hwmod_enable(struct omap_hwmod *oh);
 int omap_hwmod_idle(struct omap_hwmod *oh);
-- 
2.14.1
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
