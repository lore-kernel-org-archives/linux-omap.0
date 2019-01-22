From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 3/4] arm: omap1: no need to check return value of debugfs_create functions
Date: Tue, 22 Jan 2019 15:41:13 +0100
Message-ID: <20190122144114.9816-4-gregkh@linuxfoundation.org>
References: <20190122144114.9816-1-gregkh@linuxfoundation.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190122144114.9816-1-gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Will Deacon <will.deacon@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Paul Walmsley <paul@pwsan.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: Paul Walmsley <paul@pwsan.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Kevin Hilman <khilman@kernel.org>
Cc: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/mach-omap1/clock.c | 63 +++++++------------------------------
 arch/arm/mach-omap1/pm.c    |  7 ++---
 2 files changed, 14 insertions(+), 56 deletions(-)

diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
index c8c6fe88b2d6..3d7ab2bcf46c 100644
--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -990,84 +990,45 @@ static int debug_clock_show(struct seq_file *s, void *unused)
 
 DEFINE_SHOW_ATTRIBUTE(debug_clock);
 
-static int clk_debugfs_register_one(struct clk *c)
+static void clk_debugfs_register_one(struct clk *c)
 {
-	int err;
 	struct dentry *d;
 	struct clk *pa = c->parent;
 
 	d = debugfs_create_dir(c->name, pa ? pa->dent : clk_debugfs_root);
-	if (!d)
-		return -ENOMEM;
 	c->dent = d;
 
-	d = debugfs_create_u8("usecount", S_IRUGO, c->dent, &c->usecount);
-	if (!d) {
-		err = -ENOMEM;
-		goto err_out;
-	}
-	d = debugfs_create_ulong("rate", S_IRUGO, c->dent, &c->rate);
-	if (!d) {
-		err = -ENOMEM;
-		goto err_out;
-	}
-	d = debugfs_create_x8("flags", S_IRUGO, c->dent, &c->flags);
-	if (!d) {
-		err = -ENOMEM;
-		goto err_out;
-	}
-	return 0;
-
-err_out:
-	debugfs_remove_recursive(c->dent);
-	return err;
+	debugfs_create_u8("usecount", S_IRUGO, c->dent, &c->usecount);
+	debugfs_create_ulong("rate", S_IRUGO, c->dent, &c->rate);
+	debugfs_create_x8("flags", S_IRUGO, c->dent, &c->flags);
 }
 
-static int clk_debugfs_register(struct clk *c)
+static void clk_debugfs_register(struct clk *c)
 {
 	int err;
 	struct clk *pa = c->parent;
 
-	if (pa && !pa->dent) {
-		err = clk_debugfs_register(pa);
-		if (err)
-			return err;
-	}
+	if (pa && !pa->dent)
+		clk_debugfs_register(pa);
 
-	if (!c->dent) {
-		err = clk_debugfs_register_one(c);
-		if (err)
-			return err;
-	}
-	return 0;
+	if (!c->dent)
+		clk_debugfs_register_one(c);
 }
 
 static int __init clk_debugfs_init(void)
 {
 	struct clk *c;
 	struct dentry *d;
-	int err;
 
 	d = debugfs_create_dir("clock", NULL);
-	if (!d)
-		return -ENOMEM;
 	clk_debugfs_root = d;
 
-	list_for_each_entry(c, &clocks, node) {
-		err = clk_debugfs_register(c);
-		if (err)
-			goto err_out;
-	}
+	list_for_each_entry(c, &clocks, node)
+		clk_debugfs_register(c);
 
-	d = debugfs_create_file("summary", S_IRUGO,
-		d, NULL, &debug_clock_fops);
-	if (!d)
-		return -ENOMEM;
+	debugfs_create_file("summary", S_IRUGO, d, NULL, &debug_clock_fops);
 
 	return 0;
-err_out:
-	debugfs_remove_recursive(clk_debugfs_root);
-	return err;
 }
 late_initcall(clk_debugfs_init);
 
diff --git a/arch/arm/mach-omap1/pm.c b/arch/arm/mach-omap1/pm.c
index 998075d3ef86..d068958d6f8a 100644
--- a/arch/arm/mach-omap1/pm.c
+++ b/arch/arm/mach-omap1/pm.c
@@ -539,11 +539,8 @@ static void omap_pm_init_debugfs(void)
 	struct dentry *d;
 
 	d = debugfs_create_dir("pm_debug", NULL);
-	if (!d)
-		return;
-
-	(void) debugfs_create_file("omap_pm", S_IWUSR | S_IRUGO,
-					d, NULL, &omap_pm_debug_fops);
+	debugfs_create_file("omap_pm", S_IWUSR | S_IRUGO, d, NULL,
+			    &omap_pm_debug_fops);
 }
 
 #endif /* CONFIG_DEBUG_FS */
-- 
2.20.1
