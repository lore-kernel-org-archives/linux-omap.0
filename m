From: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv11 02/49] clk: fixed-rate: add support for registering fixed-rate clock from descriptor
Date: Thu, 19 Dec 2013 13:23:33 +0200
Message-ID: <1387452260-23276-3-git-send-email-t-kristo@ti.com>
References: <1387452260-23276-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1387452260-23276-1-git-send-email-t-kristo-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

From: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

New clk_register_desc() call can be used to register this clock type now.

Signed-off-by: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Signed-off-by: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
---
 drivers/clk/clk-fixed-rate.c |   24 ++++++++++++++++++++++++
 include/linux/clk-provider.h |   15 +++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/drivers/clk/clk-fixed-rate.c b/drivers/clk/clk-fixed-rate.c
index 1ed591a..d7aa01e 100644
--- a/drivers/clk/clk-fixed-rate.c
+++ b/drivers/clk/clk-fixed-rate.c
@@ -26,8 +26,12 @@
  * parent - fixed parent.  No clk_set_parent support
  */
 
+/* resolve struct clk_fixed_rate from inner struct clk_hw member */
 #define to_clk_fixed_rate(_hw) container_of(_hw, struct clk_fixed_rate, hw)
 
+/* resolve struct clk_fixed_rate_desc from inner struct clk_desc member */
+#define to_hw_desc(_desc) container_of(_desc, struct clk_fixed_rate_desc, desc)
+
 static unsigned long clk_fixed_rate_recalc_rate(struct clk_hw *hw,
 		unsigned long parent_rate)
 {
@@ -82,6 +86,26 @@ struct clk *clk_register_fixed_rate(struct device *dev, const char *name,
 }
 EXPORT_SYMBOL_GPL(clk_register_fixed_rate);
 
+struct clk_hw *clk_register_fixed_rate_desc(struct device *dev,
+					    struct clk_desc *desc)
+{
+	struct clk_fixed_rate *fixed;
+	struct clk_fixed_rate_desc *hw_desc;
+
+	hw_desc = to_hw_desc(desc);
+
+	/* allocate fixed-rate clock */
+	fixed = kzalloc(sizeof(*fixed), GFP_KERNEL);
+	if (!fixed)
+		return ERR_PTR(-ENOMEM);
+
+	/* populate struct clk_fixed_rate assignments */
+	fixed->fixed_rate = hw_desc->fixed_rate;
+
+	return &fixed->hw;
+}
+EXPORT_SYMBOL_GPL(clk_register_fixed_rate_desc);
+
 #ifdef CONFIG_OF
 /**
  * of_fixed_clk_setup() - Setup function for simple fixed rate clock
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 7fddcb3..82dfe84 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -219,6 +219,21 @@ struct clk_fixed_rate {
 	u8		flags;
 };
 
+/**
+ * struct clk_fixed_rate_desc - fixed-rate clock description
+ * @desc:	handle between common and hardware-specific interfaces
+ * @fixed_rate: constant frequency of clock
+ * @flags:	hardware-specific flags
+ */
+struct clk_fixed_rate_desc {
+	struct clk_desc	desc;
+	unsigned long	fixed_rate;
+	u8		flags;
+};
+
+struct clk_hw *clk_register_fixed_rate_desc(struct device *dev,
+					    struct clk_desc *desc);
+
 extern const struct clk_ops clk_fixed_rate_ops;
 struct clk *clk_register_fixed_rate(struct device *dev, const char *name,
 		const char *parent_name, unsigned long flags,
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
