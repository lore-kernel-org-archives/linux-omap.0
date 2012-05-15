From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 4/9] ARM: OMAP: Represent timer features using HWMOD flags
Date: Tue, 15 May 2012 18:35:43 -0500
Message-ID: <1337124943-20062-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42044 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966132Ab2EOXfm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 May 2012 19:35:42 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Jon Hunter <jon-hunter@ti.com>

From: Jon Hunter <jon-hunter@ti.com>

Although the OMAP timers share a common hardware design, there are some
differences between the timer instances in a given device. For example, a timer
maybe in a power domain that can be powered-of, so can lose its logic state and
need restoring where as another may be in power domain that is always be on.
Another example, is a timer may support different clock sources to drive the
timer. This information is passed to the dmtimer via the following platform data
structure.

struct dmtimer_platform_data {
	int (*set_timer_src)(struct platform_device *pdev, int source);
	int timer_ip_version;
	u32 needs_manual_reset:1;
	bool loses_context;
	int (*get_context_loss_count)(struct device *dev);
};

The above structure uses multiple variables to represent the timer features.
HWMOD also stores the timer capabilities using a bit-mask that represents the
features supported. By using the same format for representing the timer
features in the platform data as used by HWMOD, we can ...

1. Use the flags defined in the plat/dmtimer.h to represent the features
   supported.
2. For devices using HWMOD, we can retrieve the features supported from HWMOD.
3. Eventually, simplify the platform data structure to be ...

struct dmtimer_platform_data {
	int (*set_timer_src)(struct platform_device *pdev, int source);
	u32 timer_capability;
}

Another benefit from doing this, is that it will simplify the migration of the
dmtimer driver to device-tree. For example, in the current OMAP2+ timer code the
"loses_context" variable is configured at runtime by calling an architecture
specific function. For device tree this creates a problem, because we would need
to call the architecture specific function from within the dmtimer driver.
However, such attributes do not need to be queried at runtime and we can look up
the attributes via HWMOD or device-tree.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/timer.c               |    3 +++
 arch/arm/plat-omap/dmtimer.c              |    1 +
 arch/arm/plat-omap/include/plat/dmtimer.h |    2 ++
 3 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index b0b2080..d8a5dc3 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -500,6 +500,9 @@ static int __init omap_timer_init(struct omap_hwmod *oh, void *unused)
 	pdata->set_timer_src = omap2_dm_timer_set_src;
 	pdata->timer_ip_version = oh->class->rev;
 
+	if (timer_dev_attr)
+		pdata->timer_capability = timer_dev_attr->timer_capability;
+
 	pwrdm = omap_hwmod_get_pwrdm(oh);
 	pdata->loses_context = pwrdm_can_ever_lose_context(pwrdm);
 #ifdef CONFIG_PM
diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index f5b5c89..30742d8e6 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -694,6 +694,7 @@ static int __devinit omap_dm_timer_probe(struct platform_device *pdev)
 	timer->pdev = pdev;
 	timer->loses_context = pdata->loses_context;
 	timer->get_context_loss_count = pdata->get_context_loss_count;
+	timer->capability = pdata->timer_capability;
 
 	/* Skip pm_runtime_enable for OMAP1 */
 	if (!pdata->needs_manual_reset) {
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index 1e5ce5d..48e54ca 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -101,6 +101,7 @@ struct dmtimer_platform_data {
 	bool loses_context;
 
 	int (*get_context_loss_count)(struct device *dev);
+	u32 timer_capability;
 };
 
 int omap_dm_timer_reserve_systimer(int id);
@@ -273,6 +274,7 @@ struct omap_dm_timer {
 	bool loses_context;
 	int ctx_loss_count;
 	int revision;
+	u32 capability;
 	struct platform_device *pdev;
 	struct list_head node;
 
-- 
1.7.5.4

