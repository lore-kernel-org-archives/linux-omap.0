From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/6] OMAP2+: omap_hwmod: manage the wake-up
 latency constraints
Date: Mon, 19 Dec 2011 14:11:03 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1112191407380.12660@utopia.booyaka.com>
References: <1323874304-5001-1-git-send-email-j-pihet@ti.com>
	<1323874304-5001-3-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1323874304-5001-3-git-send-email-j-pihet@ti.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: jean.pihet@newoldbits.com
Cc: Kevin Hilman <khilman@ti.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>, linux-arm <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi

On Wed, 14 Dec 2011, jean.pihet@newoldbits.com wrote:

> From: Jean Pihet <j-pihet@ti.com>
> 
> The OMAP PM code implements a handler for the per-device PM QoS framework.
> The handler queries the omap_hwmod layer in order to manage the power domains
> wake-up latency constraints. Hwmod retrieves the correct power domain
> and if it exists it calls the corresponding power domain function.
> 
> Tested on OMAP3 Beagleboard and OMAP4 Pandaboard in RET/OFF using wake-up
> latency constraints on MPU, CORE and PER.
> 
> Signed-off-by: Jean Pihet <j-pihet@ti.com>
> Reviewed-by: Kevin Hilman <khilman@ti.com>

I've modified this patch to split the omap_hwmod constraint functions into 
a set-constraint function and a remove-constraint function.  This removes 
the dependency on the use of a magic value to indicate constraint removal.  
It also removes the dependency on the Linux device PM layer's magic value, 
which is not really related to this code.

Since the underlying powerdomain code isn't ready yet for the reasons 
described in 

    http://marc.info/?l=linux-omap&m=132432863401849&w=2

those calls have been removed from this patch.  They'll be added back in a 
later series.


- Paul

From: Jean Pihet <j-pihet@ti.com>
Date: Sun, 18 Dec 2011 16:42:07 -0700
Subject: [PATCH] ARM: OMAP2+: hwmod: manage the wake-up latency constraints

The OMAP PM code implements a handler for the per-device PM QoS framework.
The handler queries the omap_hwmod layer in order to manage the power domains
wake-up latency constraints. Hwmod retrieves the correct power domain
and if it exists it calls the corresponding power domain function.

Tested on OMAP3 Beagleboard and OMAP4 Pandaboard in RET/OFF using wake-up
latency constraints on MPU, CORE and PER.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
Reviewed-by: Kevin Hilman <khilman@ti.com>
[paul@pwsan.com: cleaned some documentation; split set/remove constraint
 functions; modified to return -EINVAL until underlying code is ready]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |   54 +++++++++++++++++++++++++-
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    5 ++
 2 files changed, 58 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 207a2ff..f28cad2 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -143,6 +143,7 @@
 #include "powerdomain.h"
 #include <plat/clock.h>
 #include <plat/omap_hwmod.h>
+#include <plat/omap_device.h>
 #include <plat/prcm.h>
 
 #include "cm2xxx_3xxx.h"
@@ -2616,10 +2617,61 @@ ohsps_unlock:
 }
 
 /**
+ * omap_hwmod_set_wakeuplat_constraint - set/release a wake-up latency
+ * constraint
+ * @oh: struct omap_hwmod* to which the target device belongs to.
+ * @cookie: identifier of the constraints list for @oh.
+ * @min_latency: the minimum allowed wake-up latency for @oh.
+ *
+ * Sets a wakeup latency contraint.  (To remove a wakeup latency
+ * constraint, call omap_hwmod_remove_wakeuplat_constraint()).
+ * Returns the return value from pwrdm_wakeuplat_remove_constraint(),
+ * or -EINVAL in case of invalid parameters.
+ */
+int omap_hwmod_set_wakeuplat_constraint(struct omap_hwmod *oh, void *cookie,
+					long min_latency)
+{
+	struct powerdomain *pwrdm = omap_hwmod_get_pwrdm(oh);
+
+	if (!pwrdm)
+		return -EINVAL;
+
+	/*
+	 * XXX Update to use pwrdm_wakeuplat_update_constraint() when
+	 * that code is ready
+	 */
+	return -EINVAL;
+}
+
+/**
+ * omap_hwmod_remove_wakeuplat_constraint - release a wake-up latency
+ * constraint
+ * @oh: struct omap_hwmod* to which the target device belongs to.
+ * @cookie: identifier of the constraints list for @oh.
+ *
+ * Removes a wakeup latency contraint.  Returns the return value from
+ * pwrdm_wakeuplat_update_constraint(), or -EINVAL in case of invalid
+ * parameters.
+ */
+int omap_hwmod_remove_wakeuplat_constraint(struct omap_hwmod *oh, void *cookie)
+{
+	struct powerdomain *pwrdm = omap_hwmod_get_pwrdm(oh);
+
+	if (!pwrdm)
+		return -EINVAL;
+
+	/*
+	 * XXX Update to use pwrdm_wakeuplat_remove_constraint() when
+	 * that code is ready
+	 */
+	return -EINVAL;
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
index 8b372ed..ff60532 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -600,6 +600,11 @@ int omap_hwmod_for_each_by_class(const char *classname,
 				 void *user);
 
 int omap_hwmod_set_postsetup_state(struct omap_hwmod *oh, u8 state);
+
+int omap_hwmod_set_wakeuplat_constraint(struct omap_hwmod *oh, void *cookie,
+					long min_latency);
+int omap_hwmod_remove_wakeuplat_constraint(struct omap_hwmod *oh, void *cookie);
+
 int omap_hwmod_get_context_loss_count(struct omap_hwmod *oh);
 
 int omap_hwmod_no_setup_reset(struct omap_hwmod *oh);
-- 
1.7.7.3
