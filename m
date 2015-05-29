From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 4/5] [RFC] clk: Provide dummy of_clk_get_parent_count() for !OF/!CCF
Date: Fri, 29 May 2015 11:25:48 +0200
Message-ID: <1432891549-23295-5-git-send-email-geert+renesas@glider.be>
References: <1432891549-23295-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from laurent.telenet-ops.be ([195.130.137.89]:53577 "EHLO
	laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755546AbbE2J0I (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 May 2015 05:26:08 -0400
In-Reply-To: <1432891549-23295-1-git-send-email-geert+renesas@glider.be>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>, Maxime Coquelin <maxime.coquelin@st.com>, Patrice Chotard <patrice.chotard@st.com>, Tero Kristo <t-kristo@ti.com>, Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Russell King <linux@arm.linux.org.uk>
Cc: linux-clk@vger.kernel.org, kernel@stlinux.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Geert Uytterhoeven <geert+renesas@glider.be>

Provide dummy implementations of of_clk_get_parent_count() for the
cases where CONFIG_OF or CONFIG_COMMON_CLK are not set.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This is an RFC, as
  1. Dummies are needed in two places,
  2. We don't have any dummies yet for the !CCF case.
---
 include/linux/clk-provider.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 5378c2aba4d2eaec..d56bb0c6dd982c32 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -651,6 +651,10 @@ static inline struct clk *of_clk_src_onecell_get(
 {
 	return ERR_PTR(-ENOENT);
 }
+static inline int of_clk_get_parent_count(struct device_node *np)
+{
+	return -ENOENT;
+}
 static inline const char *of_clk_get_parent_name(struct device_node *np,
 						 int index)
 {
@@ -696,5 +700,10 @@ struct dentry *clk_debugfs_add_file(struct clk_hw *hw, char *name, umode_t mode,
 				void *data, const struct file_operations *fops);
 #endif
 
-#endif /* CONFIG_COMMON_CLK */
+#else /* !CONFIG_COMMON_CLK */
+static inline int of_clk_get_parent_count(struct device_node *np)
+{
+	return -ENOENT;
+}
+#endif /* !CONFIG_COMMON_CLK */
 #endif /* CLK_PROVIDER_H */
-- 
1.9.1

