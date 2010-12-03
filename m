From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/6] omap2+: Add support for hwmod specific muxing of devices
Date: Thu, 02 Dec 2010 16:45:22 -0800
Message-ID: <20101203004522.31687.53934.stgit@baageli.muru.com>
References: <20101203004040.31687.9476.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:19777 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758299Ab0LCAp3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Dec 2010 19:45:29 -0500
In-Reply-To: <20101203004040.31687.9476.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

This allows adding hwmod specific pads dynamically during the
platform device init.

Note that we don't currently have the hwmod specific signals
listed in the hwmod data, but struct omap_hwmod_mux_info will
make that possible if necessary.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/mux.c                    |   67 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/mux.h                    |   24 +++++++++
 arch/arm/plat-omap/include/plat/omap_hwmod.h |   32 ++++++++++++
 3 files changed, 123 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 0fa3d74..4008814 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -35,6 +35,8 @@
 
 #include <asm/system.h>
 
+#include <plat/omap_hwmod.h>
+
 #include "control.h"
 #include "mux.h"
 
@@ -49,6 +51,8 @@ struct omap_mux_entry {
 static LIST_HEAD(mux_partitions);
 static DEFINE_MUTEX(muxmode_mutex);
 
+static struct omap_mux_partition *omap_mux_get_partition(struct omap_mux *mux);
+
 struct omap_mux_partition *omap_mux_get(const char *name)
 {
 	struct omap_mux_partition *partition;
@@ -252,6 +256,69 @@ int __init omap_mux_init_signal(const char *muxname, int val)
 	return 0;
 }
 
+struct omap_hwmod_mux_info * __init
+omap_hwmod_mux_init(struct omap_device_pad *bpads, int nr_pads)
+{
+	struct omap_hwmod_mux_info *hmux;
+	int i;
+
+	if (!bpads || nr_pads < 1)
+		return NULL;
+
+	hmux = kzalloc(sizeof(struct omap_hwmod_mux_info), GFP_KERNEL);
+	if (!hmux)
+		goto err1;
+
+	hmux->nr_pads = nr_pads;
+
+	hmux->pads = kzalloc(sizeof(struct omap_device_pad) *
+				nr_pads, GFP_KERNEL);
+	if (!hmux->pads)
+		goto err2;
+
+	for (i = 0; i < hmux->nr_pads; i++) {
+		struct omap_mux_partition *partition;
+		struct omap_device_pad *bpad = &bpads[i], *pad = &hmux->pads[i];
+		struct omap_mux *mux;
+		int mux_mode;
+
+		mux_mode = omap_mux_get_by_name(bpad->name, &partition, &mux);
+		if (mux_mode < 0)
+			goto err3;
+		if (!pad->partition)
+			pad->partition = partition;
+		if (!pad->mux)
+			pad->mux = mux;
+
+		pad->name = kzalloc(strlen(bpad->name) + 1, GFP_KERNEL);
+		if (!pad->name) {
+			int j;
+
+			for (j = i - 1; j >= 0; j--)
+				kfree(hmux->pads[j].name);
+			goto err3;
+		}
+		strcpy(pad->name, bpad->name);
+
+		pad->flags = bpad->flags;
+		pad->enable = bpad->enable;
+		pad->idle = bpad->idle;
+		pad->off = bpad->off;
+		pr_debug("%s: Initialized %s\n", __func__, pad->name);
+	}
+
+	return hmux;
+
+err3:
+	kfree(hmux->pads);
+err2:
+	kfree(hmux);
+err1:
+	pr_err("%s: Could not allocate device mux entry\n", __func__);
+
+	return NULL;
+}
+
 #ifdef CONFIG_DEBUG_FS
 
 #define OMAP_MUX_MAX_NR_FLAGS	10
diff --git a/arch/arm/mach-omap2/mux.h b/arch/arm/mach-omap2/mux.h
index 79076d6..8c78bed 100644
--- a/arch/arm/mach-omap2/mux.h
+++ b/arch/arm/mach-omap2/mux.h
@@ -145,6 +145,30 @@ struct omap_board_mux {
 	u16	value;
 };
 
+#define OMAP_DEVICE_PAD_ENABLED		BIT(7)	/* Should not be needed in board-*.c files */
+#define OMAP_DEVICE_PAD_REMUX		BIT(1)	/* Dynamically remux a pad, needs enable, idle and off */
+#define OMAP_DEVICE_PAD_WAKEUP		BIT(0)	/* Flag a pad as wake-up capable */
+
+/**
+ * struct omap_device_pad - device specific pad configuration
+ * @name:		signal name
+ * @flags:		pad specific runtime flags
+ * @enable:		runtime value for a pad
+ * @idle:		idle value for a pad
+ * @off:		off value for a pad, defaults to safe mode
+ * @partition:		mux partition
+ * @mux:		mux register
+ */
+struct omap_device_pad {
+	char				*name;
+	u8				flags;
+	u16				enable;
+	u16				idle;
+	u16				off;
+	struct omap_mux_partition	*partition;
+	struct omap_mux			*mux;
+};
+
 #if defined(CONFIG_OMAP_MUX)
 
 /**
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 7eaa8ed..7616007 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -78,6 +78,18 @@ extern struct omap_hwmod_sysc_fields omap_hwmod_sysc_type2;
 #define HWMOD_IDLEMODE_SMART		(1 << 2)
 
 /**
+ * struct omap_hwmod_mux_info - hwmod specific mux configuration
+ * @pads:              array of omap_device_pad entries
+ * @nr_pads:           number of omap_device_pad entries
+ *
+ * Note that this is currently built during init as needed.
+ */
+struct omap_hwmod_mux_info {
+	int				nr_pads;
+	struct omap_device_pad		*pads;
+};
+
+/**
  * struct omap_hwmod_irq_info - MPU IRQs used by the hwmod
  * @name: name of the IRQ channel (module local name)
  * @irq_ch: IRQ channel ID
@@ -469,6 +481,7 @@ struct omap_hwmod {
 	const char			*name;
 	struct omap_hwmod_class		*class;
 	struct omap_device		*od;
+	struct omap_hwmod_mux_info	*mux;
 	struct omap_hwmod_irq_info	*mpu_irqs;
 	struct omap_hwmod_dma_info	*sdma_reqs;
 	struct omap_hwmod_rst_info	*rst_lines;
@@ -504,6 +517,25 @@ struct omap_hwmod {
 };
 
 int omap_hwmod_init(struct omap_hwmod **ohs);
+
+/**
+ * omap_hwmod_mux_init - initialize hwmod specific mux data
+ * @bpads:		Board specific device signal names
+ * @nr_pads:		Number of signal names for the device
+ *
+ * Called only from omap_device_build, do not use.
+ */
+#ifdef CONFIG_OMAP_MUX
+extern struct omap_hwmod_mux_info *
+omap_hwmod_mux_init(struct omap_device_pad *bpads, int nr_pads);
+#else
+static inline omap_hwmod_mux_info *
+omap_hwmod_mux_init(struct omap_device_pad *bpads, int nr_pads)
+{
+	return NULL;
+}
+#endif
+
 int omap_hwmod_register(struct omap_hwmod *oh);
 int omap_hwmod_unregister(struct omap_hwmod *oh);
 struct omap_hwmod *omap_hwmod_lookup(const char *name);

