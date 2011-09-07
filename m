From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH v4 01/11] OMAP2+: hwmod: Add API to enable IO ring wakeup.
Date: Wed, 7 Sep 2011 18:23:23 +0530
Message-ID: <1315400013-4849-2-git-send-email-govindraj.raja@ti.com>
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

Add API to enable IO pad wakeup capability based on mux dynamic pad and
wake_up enable flag available from hwmod_mux initialization.

Use the wakeup_enable flag and enable wakeup capability
for the given pads. Wakeup capability will be enabled/disabled
during hwmod idle transition based on whether wakeup_flag is
set or cleared.

Map the enable/disable pad wakeup API's to hwmod_wakeup_enable/disable.

Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   59 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 59 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 84cc0bd..e751dd9 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2062,6 +2062,34 @@ static int __init omap_hwmod_setup_all(void)
 core_initcall(omap_hwmod_setup_all);
 
 /**
+ * omap_hwmod_set_ioring_wakeup - enable io pad wakeup flag.
+ * @oh: struct omap_hwmod *
+ * @set: bool value indicating to set or clear wakeup status.
+ *
+ * Set or Clear wakeup flag for the io_pad.
+ */
+static int omap_hwmod_set_ioring_wakeup(struct omap_hwmod *oh, bool set_wake)
+{
+	struct omap_device_pad *pad;
+	int ret = -EINVAL, j;
+
+	if (oh->mux && oh->mux->enabled) {
+		for (j = 0; j < oh->mux->nr_pads_dynamic; j++) {
+			pad = oh->mux->pads_dynamic[j];
+			if (pad->flags & OMAP_DEVICE_PAD_WAKEUP) {
+				if (set_wake)
+					pad->idle |= OMAP_WAKEUP_EN;
+				else
+					pad->idle &= ~OMAP_WAKEUP_EN;
+				ret = 0;
+			}
+		}
+	}
+
+	return ret;
+}
+
+/**
  * omap_hwmod_enable - enable an omap_hwmod
  * @oh: struct omap_hwmod *
  *
@@ -2393,6 +2421,35 @@ int omap_hwmod_del_initiator_dep(struct omap_hwmod *oh,
 {
 	return _del_initiator_dep(oh, init_oh);
 }
+/**
+ * omap_hwmod_enable_ioring_wakeup - Set wakeup flag for iopad.
+ * @oh: struct omap_hwmod *
+ *
+ * Traverse through dynamic pads, if pad is enabled then
+ * set wakeup enable bit flag for the mux pin. Wakeup pad bit
+ * will be set during hwmod idle transistion.
+ * Return error if pads are not enabled or not available.
+ */
+int omap_hwmod_enable_ioring_wakeup(struct omap_hwmod *oh)
+{
+	/* Enable pad wake-up capability */
+	return omap_hwmod_set_ioring_wakeup(oh, true);
+}
+
+/**
+ * omap_hwmod_disable_ioring_wakeup - Clear wakeup flag for iopad.
+ * @oh: struct omap_hwmod *
+ *
+ * Traverse through dynamic pads, if pad is enabled then
+ * clear wakeup enable bit flag for the mux pin. Wakeup pad bit
+ * will be set during hwmod idle transistion.
+ * Return error if pads are not enabled or not available.
+ */
+int omap_hwmod_disable_ioring_wakeup(struct omap_hwmod *oh)
+{
+	/* Disable pad wakeup capability */
+	return omap_hwmod_set_ioring_wakeup(oh, false);
+}
 
 /**
  * omap_hwmod_enable_wakeup - allow device to wake up the system
@@ -2419,6 +2476,7 @@ int omap_hwmod_enable_wakeup(struct omap_hwmod *oh)
 	v = oh->_sysc_cache;
 	_enable_wakeup(oh, &v);
 	_write_sysconfig(v, oh);
+	omap_hwmod_enable_ioring_wakeup(oh);
 	spin_unlock_irqrestore(&oh->_lock, flags);
 
 	return 0;
@@ -2449,6 +2507,7 @@ int omap_hwmod_disable_wakeup(struct omap_hwmod *oh)
 	v = oh->_sysc_cache;
 	_disable_wakeup(oh, &v);
 	_write_sysconfig(v, oh);
+	omap_hwmod_disable_ioring_wakeup(oh);
 	spin_unlock_irqrestore(&oh->_lock, flags);
 
 	return 0;
-- 
1.7.4.1
