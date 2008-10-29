From: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
Subject: [PATCH] OMAP: SRF: Fixes to shared resource framework (Ver.2)
Date: Wed, 29 Oct 2008 13:12:41 +0200
Message-ID: <1225278761-22298-1-git-send-email-ext-kalle.jokiniemi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:50573 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753463AbYJ2LLf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Oct 2008 07:11:35 -0400
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: rnayak@ti.com, khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org, Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>

This patch corrects some problems found in shared resource
framwork patches sent by Rajendra Nayak. This patch requires
also the omapdev patchset sent by Paul walmsley.

Fixes include:

1. Use omapdev to get correct power domain for a device in
omap_pm_set_max_dev_wakeup_lat function. A compatibility issue
remains, as omap_pm_set_max_dev_wakeup_lat takes device pointer,
but omapdev_find_pdev requires platform_device pointer.

2. Add support for devices in CORE power domain to set latency
requirements through the omap_pm_set_max_dev_wakeup_lat interface.

3. Move update_resource_level call out of spin_lock as the underlying
pm_qos_add_requirement calls kzalloc. The point of the spin locks
according to comments is to protect adding and removing users, which
remains inside the spin_lock.

4. Added resource_refresh function into generic resource fw to
support enable_off_mode swithcing with SRF.

Signed-off-by: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c               |    7 ++++-
 arch/arm/mach-omap2/resource34xx.c         |   10 +++++++-
 arch/arm/mach-omap2/resource34xx.h         |    8 ++++++
 arch/arm/plat-omap/include/mach/resource.h |    1 +
 arch/arm/plat-omap/omap-pm-srf.c           |   36 +++++++++++++++++++++-------
 arch/arm/plat-omap/resource.c              |   31 ++++++++++++++++++++++-
 6 files changed, 80 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 3506b26..69a009c 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -33,6 +33,7 @@
 #include <mach/prcm.h>
 #include <mach/clockdomain.h>
 #include <mach/powerdomain.h>
+#include <mach/resource.h>
 #include <mach/common.h>
 #include <mach/control.h>
 #include <mach/serial.h>
@@ -768,6 +769,10 @@ void omap3_pm_off_mode_enable(int enable)
 	else
 		state = PWRDM_POWER_RET;
 
+#ifdef CONFIG_OMAP_PM_SRF
+	if (resource_refresh())
+		printk(KERN_ERR "Error: could not refresh resources\n");
+#endif
 	list_for_each_entry(pwrst, &pwrst_list, node) {
 		pwrst->next_state = state;
 
@@ -912,7 +917,7 @@ int __init omap3_pm_init(void)
 		local_irq_enable();
 		local_fiq_enable();
 	}
-	
+
 err1:
 	return ret;
 err2:
diff --git a/arch/arm/mach-omap2/resource34xx.c b/arch/arm/mach-omap2/resource34xx.c
index 54032fd..9bcfb4f 100644
--- a/arch/arm/mach-omap2/resource34xx.c
+++ b/arch/arm/mach-omap2/resource34xx.c
@@ -20,6 +20,7 @@
 #include <mach/powerdomain.h>
 #include <mach/clockdomain.h>
 #include "resource34xx.h"
+#include "pm.h"
 
 int set_pwrdm_state(struct powerdomain *pwrdm, u32 state);
 
@@ -86,10 +87,14 @@ void init_pd_latency(struct shared_resource *resp)
 	struct pd_latency_db *pd_lat_db;
 
 	resp->no_of_users = 0;
-	resp->curr_level = PD_LATENCY_OFF;
+	if (enable_off_mode)
+		resp->curr_level = PD_LATENCY_OFF;
+	else
+		resp->curr_level = PD_LATENCY_RET;
 	pd_lat_db = resp->resource_data;
 	/* Populate the power domain associated with the latency resource */
 	pd_lat_db->pd = pwrdm_lookup(pd_lat_db->pwrdm_name);
+	set_pwrdm_state(pd_lat_db->pd, resp->curr_level);
 	return;
 }
 
@@ -120,6 +125,9 @@ int set_pd_latency(struct shared_resource *resp, u32 latency)
 		}
 	}
 
+	if (!enable_off_mode && pd_lat_level == PD_LATENCY_OFF)
+		pd_lat_level = PD_LATENCY_RET;
+
 	resp->curr_level = pd_lat_level;
 	set_pwrdm_state(pwrdm, pd_lat_level);
 	return 0;
diff --git a/arch/arm/mach-omap2/resource34xx.h b/arch/arm/mach-omap2/resource34xx.h
index b6db1fc..9f905f6 100644
--- a/arch/arm/mach-omap2/resource34xx.h
+++ b/arch/arm/mach-omap2/resource34xx.h
@@ -80,6 +80,13 @@ static struct shared_resource_ops pd_lat_res_ops = {
 	.change_level 	= set_pd_latency,
 };
 
+static struct shared_resource core_pwrdm_latency = {
+	.name		= "core_pwrdm_latency",
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.resource_data	= &core_qos_req_added,
+	.ops		= &lat_res_ops,
+};
+
 static struct pd_latency_db iva2_pwrdm_lat_db = {
 	.pwrdm_name = "iva2_pwrdm",
 	.latency[PD_LATENCY_OFF] = 1100,
@@ -211,6 +218,7 @@ struct shared_resource *resources_omap[] __initdata = {
 	&mpu_latency,
 	&core_latency,
 	/* Power Domain Latency resources */
+	&core_pwrdm_latency,
 	&iva2_pwrdm_latency,
 	&gfx_pwrdm_latency,
 	&sgx_pwrdm_latency,
diff --git a/arch/arm/plat-omap/include/mach/resource.h b/arch/arm/plat-omap/include/mach/resource.h
index 470cb67..bedd1ab 100644
--- a/arch/arm/plat-omap/include/mach/resource.h
+++ b/arch/arm/plat-omap/include/mach/resource.h
@@ -70,6 +70,7 @@ struct users_list {
 extern struct shared_resource *resources_omap[];
 /* Shared resource Framework API's */
 void resource_init(struct shared_resource **resources);
+int resource_refresh(void);
 int resource_register(struct shared_resource *res);
 int resource_unregister(struct shared_resource *res);
 int resource_request(const char *name, struct device *dev,
diff --git a/arch/arm/plat-omap/omap-pm-srf.c b/arch/arm/plat-omap/omap-pm-srf.c
index 427fc9d..d01b000 100644
--- a/arch/arm/plat-omap/omap-pm-srf.c
+++ b/arch/arm/plat-omap/omap-pm-srf.c
@@ -25,10 +25,7 @@
 #include <mach/omap-pm.h>
 #include <mach/powerdomain.h>
 #include <mach/resource.h>
-/* TODO: Put this back in once tiocp layer is available */
-/*
-#include <asm/arch/tiocp.h>
-*/
+#include <mach/omapdev.h>
 
 static struct omap_opp *dsp_opps;
 static struct omap_opp *mpu_opps;
@@ -102,8 +99,9 @@ void omap_pm_set_min_bus_tput(struct device *dev, u8 agent_id, unsigned long r)
 
 void omap_pm_set_max_dev_wakeup_lat(struct device *dev, long t)
 {
-	/* struct tiocp *tiocp_dev; */
+	struct omapdev *odev;
 	struct powerdomain *pwrdm_dev;
+	struct platform_device *pdev;
 	char *lat_res_name;
 
 	if (!dev || t < -1) {
@@ -111,10 +109,30 @@ void omap_pm_set_max_dev_wakeup_lat(struct device *dev, long t)
 		return;
 	};
 	/* Look for the devices Power Domain */
-	/* TODO: Put this back in once tiocp layer is available
-	tiocp_dev = container_of(dev, struct tiocp, dev);
-	pwrdm_dev = tiocp_dev->pwrdm;
-	*/
+	/*
+	 * WARNING! If device is not a platform device, container_of will
+	 * return a pointer to unknown memory!
+	 * TODO: Either change omap-pm interface to support only platform
+	 * devices, or change the underlying omapdev implementation to
+	 * support normal devices.
+	 */
+	pdev = container_of(dev, struct platform_device, dev);
+
+	/* Try to catch non platform devices. */
+	if (pdev->name == NULL) {
+		printk(KERN_ERR "OMAP-PM: Error: platform device not valid\n");
+		return;
+	}
+
+	odev = omapdev_find_pdev(pdev);
+	if (odev) {
+		pwrdm_dev = omapdev_get_pwrdm(odev);
+	} else {
+		printk(KERN_ERR "OMAP-PM: Error: Could not find omapdev "
+						"for %s\n", pdev->name);
+		return;
+	}
+
 	lat_res_name = kmalloc(MAX_LATENCY_RES_NAME, GFP_KERNEL);
 	if (!lat_res_name) {
 		printk(KERN_ERR "OMAP-PM: FATAL ERROR: kmalloc failed\n");
diff --git a/arch/arm/plat-omap/resource.c b/arch/arm/plat-omap/resource.c
index 9f01fb1..5b3d3a4 100644
--- a/arch/arm/plat-omap/resource.c
+++ b/arch/arm/plat-omap/resource.c
@@ -223,6 +223,27 @@ void resource_init(struct shared_resource **resources)
 }
 
 /**
+ * resource_refresh - Refresh the states of all current resources
+ *
+ * If a condition in power domains has changed that requires refreshing
+ * power domain states, this function can be used to restore correct
+ * states according to shared resources.
+ * Returns 0 on success, non-zero, if some resource cannot be refreshed.
+ */
+int resource_refresh(void)
+{
+	struct shared_resource *resp = NULL;
+	int ret = 0;
+
+	list_for_each_entry(resp, &res_list, node) {
+		ret = update_resource_level(resp);
+		if (ret)
+			break;
+	}
+	return ret;
+}
+
+/**
  * resource_register - registers and initializes a resource
  * @res: struct shared_resource * to register
  *
@@ -346,10 +367,16 @@ int resource_request(const char *name, struct device *dev,
 	}
 	user->level = level;
 
-	/* Recompute and set the current level for the resource */
-	ret = update_resource_level(resp);
 res_unlock:
 	spin_unlock_irqrestore(&res_lock, flags);
+	/*
+	 * Recompute and set the current level for the resource.
+	 * NOTE: update_resource level moved out of spin_lock, as it may call
+	 * pm_qos_add_requirement, which does a kzmalloc. This won't be allowed
+	 * in iterrupt context. The spin_lock still protects add/remove users.
+	 */
+	if (!ret)
+		ret = update_resource_level(resp);
 	return ret;
 }
 EXPORT_SYMBOL(resource_request);
-- 
1.5.4.3

