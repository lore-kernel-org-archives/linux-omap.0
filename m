From: Dan Murphy <dmurphy@ti.com>
Subject: [PATCH] OMAP MUX framework changes
Date: Wed, 17 Nov 2010 12:06:50 -0600
Message-ID: <1290017211-2217-1-git-send-email-dmurphy@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55460 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934809Ab0KQSHy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Nov 2010 13:07:54 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: b-cousson@ti.com, paul@pwsan.com, tony@atomide.com, khilman@deeprootsystems.com, Dan Murphy <dmurphy@ti.com>

Added APIs to get and set the mux setting via the MUX
name.  In doing this the omap_mux_read and omap_mux_write can
be made static as these interfaces should be called indirectly.

Added a check in the omap_write_array to test the partition pointer
is valid prior to dereferencing.

Tested the new interfaces with a test file.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 arch/arm/mach-omap2/mux.c |   73 +++++++++++++++++++++++++++++++++++++++++----
 arch/arm/mach-omap2/mux.h |   23 ++++++--------
 2 files changed, 77 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 3d71d93..e53d6a3 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -61,7 +61,7 @@ struct omap_mux_partition *omap_mux_get(const char *name)
 	return NULL;
 }
 
-u16 omap_mux_read(struct omap_mux_partition *partition, u16 reg)
+static u16 omap_mux_read(struct omap_mux_partition *partition, u16 reg)
 {
 	if (partition->flags & OMAP_MUX_REG_8BIT)
 		return __raw_readb(partition->base + reg);
@@ -69,7 +69,7 @@ u16 omap_mux_read(struct omap_mux_partition *partition, u16 reg)
 		return __raw_readw(partition->base + reg);
 }
 
-void omap_mux_write(struct omap_mux_partition *partition, u16 val,
+static void omap_mux_write(struct omap_mux_partition *partition, u16 val,
 			   u16 reg)
 {
 	if (partition->flags & OMAP_MUX_REG_8BIT)
@@ -81,10 +81,14 @@ void omap_mux_write(struct omap_mux_partition *partition, u16 val,
 void omap_mux_write_array(struct omap_mux_partition *partition,
 				 struct omap_board_mux *board_mux)
 {
-	while (board_mux->reg_offset != OMAP_MUX_TERMINATOR) {
-		omap_mux_write(partition, board_mux->value,
-			       board_mux->reg_offset);
-		board_mux++;
+	if (partition) {
+		while (board_mux->reg_offset != OMAP_MUX_TERMINATOR) {
+			omap_mux_write(partition, board_mux->value,
+				       board_mux->reg_offset);
+			board_mux++;
+		}
+	} else {
+		pr_err("%s: Partition was NULL\n", __func__);
 	}
 }
 
@@ -745,6 +749,63 @@ void omap_mux_set_gpio(u16 val, int gpio)
 		pr_err("%s: Could not set gpio%i\n", __func__, gpio);
 }
 
+static struct omap_mux *omap_mux_get_by_mux(struct omap_mux_partition *partition,
+					char *name)
+{
+	struct omap_mux_entry *e;
+	int i = 0;
+
+	list_for_each_entry(e, &partition->muxmodes, node) {
+		struct omap_mux *m = &e->mux;
+		for (i = 0; i < OMAP_MUX_NR_MODES; i++) {
+			if (m->muxnames[i] == NULL)
+				break;
+			else if (!strcmp(name, m->muxnames[i]))
+				return m;
+		}
+	}
+
+	return NULL;
+}
+
+/* Needed for dynamic muxing of pins for off-idle */
+u16 omap_mux_get_mux(char *mux_name)
+{
+	struct omap_mux_partition *partition;
+	struct omap_mux *m;
+
+	list_for_each_entry(partition, &mux_partitions, node) {
+		m = omap_mux_get_by_mux(partition, mux_name);
+		if (m)
+			return omap_mux_read(partition, m->reg_offset);
+	}
+
+	if (!m || m->reg_offset == OMAP_MUX_TERMINATOR)
+		pr_err("%s: Could not get mux %s\n",
+			__func__, mux_name);
+
+	return OMAP_MUX_TERMINATOR;
+}
+
+/* Needed for dynamic muxing pins for off-idle */
+void omap_mux_set_mux(u16 val, char *mux_name)
+{
+	struct omap_mux_partition *partition;
+	struct omap_mux *m = NULL;
+
+	list_for_each_entry(partition, &mux_partitions, node) {
+		m = omap_mux_get_by_mux(partition, mux_name);
+		if (m) {
+			omap_mux_write(partition, val, m->reg_offset);
+			return;
+		}
+	}
+
+	if (!m || m->reg_offset == OMAP_MUX_TERMINATOR)
+		pr_err("%s: Could not set mux %s\n",
+			__func__, mux_name);
+}
+
 static struct omap_mux * __init omap_mux_list_add(
 					struct omap_mux_partition *partition,
 					struct omap_mux *src)
diff --git a/arch/arm/mach-omap2/mux.h b/arch/arm/mach-omap2/mux.h
index 79076d6..27ce55a 100644
--- a/arch/arm/mach-omap2/mux.h
+++ b/arch/arm/mach-omap2/mux.h
@@ -190,29 +190,26 @@ u16 omap_mux_get_gpio(int gpio);
 void omap_mux_set_gpio(u16 val, int gpio);
 
 /**
- * omap_mux_get() - get a mux partition by name
- * @name:		Name of the mux partition
+ * omap_mux_get_mux() - set mux register value based on mux name
+ * @mux_name:		Mux name
  *
  */
-struct omap_mux_partition *omap_mux_get(const char *name);
+u16 omap_mux_get_mux(char *mux_name);
 
 /**
- * omap_mux_read() - read mux register
- * @partition:		Mux partition
- * @mux_offset:		Offset of the mux register
+ * omap_mux_set_mux() - set mux register value based on mux name
+ * @val:		New mux register value
+ * @mux_name:		Mux name
  *
  */
-u16 omap_mux_read(struct omap_mux_partition *p, u16 mux_offset);
+void omap_mux_set_mux(u16 val, char *mux_name);
 
 /**
- * omap_mux_write() - write mux register
- * @partition:		Mux partition
- * @val:		New mux register value
- * @mux_offset:		Offset of the mux register
+ * omap_mux_get() - get a mux partition by name
+ * @name:		Name of the mux partition
  *
- * This should be only needed for dynamic remuxing of non-gpio signals.
  */
-void omap_mux_write(struct omap_mux_partition *p, u16 val, u16 mux_offset);
+struct omap_mux_partition *omap_mux_get(const char *name);
 
 /**
  * omap_mux_write_array() - write an array of mux registers
-- 
1.7.0.4

