From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/8] OMAP clock: add omap_clk_get_by_name()
Date: Fri, 05 Jun 2009 04:19:39 -0600
Message-ID: <20090605101938.32500.86880.stgit@localhost.localdomain>
References: <20090605101635.32500.63083.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47668 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752157AbZFEKUc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Jun 2009 06:20:32 -0400
In-Reply-To: <20090605101635.32500.63083.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

After the recent clkdev conversion, struct clks are no longer
locatable located by the struct clk name via clk_get().  Core code
separate from the platform_device system needs to do this.  This patch
adds an omap_clk_get_by_name() function for this purpose.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/plat-omap/clock.c              |   27 +++++++++++++++++++++++++++
 arch/arm/plat-omap/include/mach/clock.h |    1 +
 2 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index 29efc27..37db231 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -300,6 +300,33 @@ void clk_enable_init_clocks(void)
 }
 EXPORT_SYMBOL(clk_enable_init_clocks);
 
+/**
+ * omap_clk_get_by_name - locate OMAP struct clk by its name
+ * @name: name of the struct clk to locate
+ *
+ * Locate an OMAP struct clk by its name.  Assumes that struct clk
+ * names are unique.  Returns NULL if not found or a pointer to the
+ * struct clk if found.
+ */
+struct clk *omap_clk_get_by_name(const char *name)
+{
+	struct clk *c;
+	struct clk *ret = NULL;
+
+	mutex_lock(&clocks_mutex);
+
+	list_for_each_entry(c, &clocks, node) {
+		if (!strcmp(c->name, name)) {
+			ret = c;
+			break;
+		}
+	}
+
+	mutex_unlock(&clocks_mutex);
+
+	return ret;
+}
+
 /*
  * Low level helpers
  */
diff --git a/arch/arm/plat-omap/include/mach/clock.h b/arch/arm/plat-omap/include/mach/clock.h
index 073a2c5..38e32d8 100644
--- a/arch/arm/plat-omap/include/mach/clock.h
+++ b/arch/arm/plat-omap/include/mach/clock.h
@@ -130,6 +130,7 @@ extern void clk_enable_init_clocks(void);
 #ifdef CONFIG_CPU_FREQ
 extern void clk_init_cpufreq_table(struct cpufreq_frequency_table **table);
 #endif
+extern struct clk *omap_clk_get_by_name(const char *name);
 
 extern const struct clkops clkops_null;
 


