From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH v4 02/11] OMAP2+: hwmod: Add API to check IO PAD wakeup status
Date: Wed, 7 Sep 2011 18:23:24 +0530
Message-ID: <1315400013-4849-3-git-send-email-govindraj.raja@ti.com>
References: <1315400013-4849-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1315400013-4849-1-git-send-email-govindraj.raja@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, linux-serial@vger.kernel.org, Vishwanath Sripathy <vishwanath.bs@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Add API to determine IO-PAD wakeup event status for a given
hwmod dynamic_mux pad.

Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/mux.c                    |   30 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/mux.h                    |   13 +++++++++++
 arch/arm/mach-omap2/omap_hwmod.c             |    7 ++++++
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    1 +
 4 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 655e948..5f15ab8 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -351,6 +351,36 @@ err1:
 	return NULL;
 }
 
+/**
+ * omap_hwmod_mux_get_wake_status - omap hwmod check pad wakeup
+ * @hmux:		Pads for a hwmod
+ *
+ * Gets the wakeup status of given pad from omap-hwmod.
+ * Returns true if wakeup event is set for pad else false
+ * if wakeup is not occured or pads are not avialable.
+ */
+bool omap_hwmod_mux_get_wake_status(struct omap_hwmod_mux_info *hmux)
+{
+	int i;
+	unsigned int val;
+	u8 ret = false;
+
+	for (i = 0; i < hmux->nr_pads; i++) {
+		struct omap_device_pad *pad = &hmux->pads[i];
+
+		if (pad->flags & OMAP_DEVICE_PAD_WAKEUP) {
+			val = omap_mux_read(pad->partition,
+					pad->mux->reg_offset);
+			if (val & OMAP_WAKEUP_EVENT) {
+				ret = true;
+				break;
+			}
+		}
+	}
+
+	return ret;
+}
+
 /* Assumes the calling function takes care of locking */
 void omap_hwmod_mux(struct omap_hwmod_mux_info *hmux, u8 state)
 {
diff --git a/arch/arm/mach-omap2/mux.h b/arch/arm/mach-omap2/mux.h
index 2132308..8b2150a 100644
--- a/arch/arm/mach-omap2/mux.h
+++ b/arch/arm/mach-omap2/mux.h
@@ -225,8 +225,21 @@ omap_hwmod_mux_init(struct omap_device_pad *bpads, int nr_pads);
  */
 void omap_hwmod_mux(struct omap_hwmod_mux_info *hmux, u8 state);
 
+/**
+ * omap_hwmod_mux_get_wake_status - omap hwmod check pad wakeup
+ * @hmux:		Pads for a hwmod
+ *
+ * Called only from omap_hwmod.c, do not use.
+ */
+bool omap_hwmod_mux_get_wake_status(struct omap_hwmod_mux_info *hmux);
 #else
 
+static inline bool
+omap_hwmod_mux_get_wake_status(struct omap_hwmod_mux_info *hmux)
+{
+	return 0;
+}
+
 static inline int omap_mux_init_gpio(int gpio, int val)
 {
 	return 0;
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index e751dd9..a8b24d7 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2724,3 +2724,10 @@ int omap_hwmod_no_setup_reset(struct omap_hwmod *oh)
 
 	return 0;
 }
+
+int omap_hwmod_pad_get_wakeup_status(struct omap_hwmod *oh)
+{
+	if (oh && oh->mux)
+		return omap_hwmod_mux_get_wake_status(oh->mux);
+	return -EINVAL;
+}
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 0e329ca..9a6195c 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -607,6 +607,7 @@ u32 omap_hwmod_get_context_loss_count(struct omap_hwmod *oh);
 
 int omap_hwmod_no_setup_reset(struct omap_hwmod *oh);
 
+int omap_hwmod_pad_get_wakeup_status(struct omap_hwmod *oh);
 /*
  * Chip variant-specific hwmod init routines - XXX should be converted
  * to use initcalls once the initial boot ordering is straightened out
-- 
1.7.4.1
