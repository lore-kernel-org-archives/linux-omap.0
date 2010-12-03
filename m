From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/6] omap2+: Add omap_mux_get_by_name
Date: Thu, 02 Dec 2010 16:45:18 -0800
Message-ID: <20101203004518.31687.99560.stgit@baageli.muru.com>
References: <20101203004040.31687.9476.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:33813 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758281Ab0LCAp1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Dec 2010 19:45:27 -0500
In-Reply-To: <20101203004040.31687.9476.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Dan Murphy <dmurphy@ti.com>

Do this by splitting _omap_mux_init_signal as it already has most
of the necessary features.

Based on an earlier patch by Dan Murphy <dmurphy@ti.com>.

Cc: Dan Murphy <dmurphy@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/mux.c |   73 ++++++++++++++++++++++++++++++---------------
 1 files changed, 48 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 3d71d93..0fa3d74 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -151,12 +151,14 @@ int __init omap_mux_init_gpio(int gpio, int val)
 	return -ENODEV;
 }
 
-static int __init _omap_mux_init_signal(struct omap_mux_partition *partition,
-					const char *muxname, int val)
+static int __init _omap_mux_get_by_name(struct omap_mux_partition *partition,
+					const char *muxname,
+					struct omap_mux **found_mux)
 {
+	struct omap_mux *mux = NULL;
 	struct omap_mux_entry *e;
 	const char *mode_name;
-	int found = 0, mode0_len = 0;
+	int found = 0, found_mode, mode0_len = 0;
 	struct list_head *muxmodes = &partition->muxmodes;
 
 	mode_name = strchr(muxname, '.');
@@ -168,40 +170,34 @@ static int __init _omap_mux_init_signal(struct omap_mux_partition *partition,
 	}
 
 	list_for_each_entry(e, muxmodes, node) {
-		struct omap_mux *m = &e->mux;
-		char *m0_entry = m->muxnames[0];
+		char *m0_entry;
 		int i;
 
+		mux = &e->mux;
+		m0_entry = mux->muxnames[0];
+
 		/* First check for full name in mode0.muxmode format */
 		if (mode0_len && strncmp(muxname, m0_entry, mode0_len))
 			continue;
 
 		/* Then check for muxmode only */
 		for (i = 0; i < OMAP_MUX_NR_MODES; i++) {
-			char *mode_cur = m->muxnames[i];
+			char *mode_cur = mux->muxnames[i];
 
 			if (!mode_cur)
 				continue;
 
 			if (!strcmp(mode_name, mode_cur)) {
-				u16 old_mode;
-				u16 mux_mode;
-
-				old_mode = omap_mux_read(partition,
-							 m->reg_offset);
-				mux_mode = val | i;
-				pr_debug("%s: Setting signal "
-					 "%s.%s 0x%04x -> 0x%04x\n", __func__,
-					 m0_entry, muxname, old_mode, mux_mode);
-				omap_mux_write(partition, mux_mode,
-					       m->reg_offset);
+				*found_mux = mux;
 				found++;
+				found_mode = i;
 			}
 		}
 	}
 
-	if (found == 1)
-		return 0;
+	if (found == 1) {
+		return found_mode;
+	}
 
 	if (found > 1) {
 		pr_err("%s: Multiple signal paths (%i) for %s\n", __func__,
@@ -209,24 +205,51 @@ static int __init _omap_mux_init_signal(struct omap_mux_partition *partition,
 		return -EINVAL;
 	}
 
-	pr_err("%s: Could not set signal %s\n", __func__, muxname);
+	pr_err("%s: Could not find signal %s\n", __func__, muxname);
 
 	return -ENODEV;
 }
 
-int __init omap_mux_init_signal(const char *muxname, int val)
+static int __init
+omap_mux_get_by_name(const char *muxname,
+			struct omap_mux_partition **found_partition,
+			struct omap_mux **found_mux)
 {
 	struct omap_mux_partition *partition;
-	int ret;
 
 	list_for_each_entry(partition, &mux_partitions, node) {
-		ret = _omap_mux_init_signal(partition, muxname, val);
-		if (!ret)
-			return ret;
+		struct omap_mux *mux = NULL;
+		int mux_mode = _omap_mux_get_by_name(partition, muxname, &mux);
+		if (mux_mode < 0)
+			continue;
+
+		*found_partition = partition;
+		*found_mux = mux;
+
+		return mux_mode;
 	}
 
 	return -ENODEV;
+}
 
+int __init omap_mux_init_signal(const char *muxname, int val)
+{
+	struct omap_mux_partition *partition = NULL;
+	struct omap_mux *mux = NULL;
+	u16 old_mode;
+	int mux_mode;
+
+	mux_mode = omap_mux_get_by_name(muxname, &partition, &mux);
+	if (mux_mode < 0)
+		return mux_mode;
+
+	old_mode = omap_mux_read(partition, mux->reg_offset);
+	mux_mode |= val;
+	pr_debug("%s: Setting signal %s 0x%04x -> 0x%04x\n",
+			 __func__, muxname, old_mode, mux_mode);
+	omap_mux_write(partition, mux_mode, mux->reg_offset);
+
+	return 0;
 }
 
 #ifdef CONFIG_DEBUG_FS

