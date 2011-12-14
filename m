From: jean.pihet@newoldbits.com
Subject: [PATCH 2/6] OMAP2+: omap_hwmod: manage the wake-up
	latency constraints
Date: Wed, 14 Dec 2011 15:51:40 +0100
Message-ID: <1323874304-5001-3-git-send-email-j-pihet@ti.com>
References: <1323874304-5001-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1323874304-5001-1-git-send-email-j-pihet@ti.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kevin Hilman <khilman@ti.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, magnus.damm@gmail.com, Todd Poynor <toddpoynor@google.com>
Cc: Jean Pihet <j-pihet@ti.com>, linux-arm <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

From: Jean Pihet <j-pihet@ti.com>

The OMAP PM code implements a handler for the per-device PM QoS framework.
The handler queries the omap_hwmod layer in order to manage the power domains
wake-up latency constraints. Hwmod retrieves the correct power domain
and if it exists it calls the corresponding power domain function.

Tested on OMAP3 Beagleboard and OMAP4 Pandaboard in RET/OFF using wake-up
latency constraints on MPU, CORE and PER.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
Reviewed-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |   27 +++++++++++++++++++++++++-
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    2 +
 2 files changed, 28 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 529142a..c3a4cc4 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -143,6 +143,7 @@
 #include "powerdomain.h"
 #include <plat/clock.h>
 #include <plat/omap_hwmod.h>
+#include <plat/omap_device.h>
 #include <plat/prcm.h>
 
 #include "cm2xxx_3xxx.h"
@@ -2616,10 +2617,34 @@ ohsps_unlock:
 }
 
 /**
+ * omap_hwmod_set_wkup_constraint- set/release a wake-up latency constraint
+ *
+ * @oh: struct omap_hwmod* to which the target device belongs to.
+ * @cookie: identifier of the constraints list for @oh.
+ * @min_latency: the minimum allowed wake-up latency for @oh.
+ *
+ * Returns 0 upon success, -EINVAL in case of invalid parameters, or
+ * the return value from pwrdm_set_wkup_lat_constraint.
+ */
+int omap_hwmod_set_wkup_lat_constraint(struct omap_hwmod *oh,
+				       void *cookie, long min_latency)
+{
+	struct powerdomain *pwrdm = omap_hwmod_get_pwrdm(oh);
+
+	if (!pwrdm) {
+		pr_err("%s: Error: could not find powerdomain "
+		       "for %s\n", __func__, oh->name);
+		return -EINVAL;
+	}
+
+	return pwrdm_set_wkup_lat_constraint(pwrdm, cookie, min_latency);
+}
+
+/**
  * omap_hwmod_get_context_loss_count - get lost context count
  * @oh: struct omap_hwmod *
  *
- * Query the powerdomain of of @oh to get the context loss
+ * Query the powerdomain of @oh to get the context loss
  * count for this device.
  *
  * Returns the context loss count of the powerdomain assocated with @oh
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 8b372ed..222f792 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -600,6 +600,8 @@ int omap_hwmod_for_each_by_class(const char *classname,
 				 void *user);
 
 int omap_hwmod_set_postsetup_state(struct omap_hwmod *oh, u8 state);
+int omap_hwmod_set_wkup_lat_constraint(struct omap_hwmod *oh, void *cookie,
+				       long min_latency);
 int omap_hwmod_get_context_loss_count(struct omap_hwmod *oh);
 
 int omap_hwmod_no_setup_reset(struct omap_hwmod *oh);
-- 
1.7.5.4
