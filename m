From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V3 3/5] ARM: OMAP: Add function to request a timer by capability
Date: Wed, 17 Oct 2012 13:01:11 -0500
Message-ID: <1350496873-21337-4-git-send-email-jon-hunter@ti.com>
References: <1350496873-21337-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54952 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932397Ab2JQSBm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Oct 2012 14:01:42 -0400
In-Reply-To: <1350496873-21337-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Vaibhav Hiremath <hvaibhav@ti.com>, Jon Hunter <jon-hunter@ti.com>

Currently OMAP timers can be requested by requesting any available or by a
numerical device ID. If a specific timer is required because it has a particular
capability, such as can interrupt the on-chip DSP in addition to the ARM CPU,
then the user needs to know the device ID of the timer with this feature.
Therefore, add a new API called omap_dm_timer_request_by_cap() that allows
drivers to request a timer by capability.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/plat-omap/dmtimer.c              |   52 +++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/dmtimer.h |    1 +
 2 files changed, 53 insertions(+)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 938b50a..2574b86 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -237,6 +237,58 @@ struct omap_dm_timer *omap_dm_timer_request_specific(int id)
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_request_specific);
 
+/**
+ * omap_dm_timer_request_by_cap - Request a timer by capability
+ * @cap:	Bit mask of capabilities to match
+ *
+ * Find a timer based upon capabilities bit mask. Callers of this function
+ * should use the definitions found in the plat/dmtimer.h file under the
+ * comment "timer capabilities used in hwmod database". Returns pointer to
+ * timer handle on success and a NULL pointer on failure.
+ */
+struct omap_dm_timer *omap_dm_timer_request_by_cap(u32 cap)
+{
+	struct omap_dm_timer *timer = NULL, *t;
+	unsigned long flags;
+
+	if (!cap)
+		return NULL;
+
+	spin_lock_irqsave(&dm_timer_lock, flags);
+	list_for_each_entry(t, &omap_timer_list, node) {
+		if ((!t->reserved) && ((t->capability & cap) == cap)) {
+			/*
+			 * If timer is not NULL, we have already found one timer
+			 * but it was not an exact match because it had more
+			 * capabilites that what was required. Therefore,
+			 * unreserve the last timer found and see if this one
+			 * is a better match.
+			 */
+			if (timer)
+				timer->reserved = 0;
+
+			timer = t;
+			timer->reserved = 1;
+
+			/* Exit loop early if we find an exact match */
+			if (t->capability == cap)
+				break;
+		}
+	}
+	spin_unlock_irqrestore(&dm_timer_lock, flags);
+
+	if (timer && omap_dm_timer_prepare(timer)) {
+		timer->reserved = 0;
+		timer = NULL;
+	}
+
+	if (!timer)
+		pr_debug("%s: timer request failed!\n", __func__);
+
+	return timer;
+}
+EXPORT_SYMBOL_GPL(omap_dm_timer_request_by_cap);
+
 int omap_dm_timer_free(struct omap_dm_timer *timer)
 {
 	if (unlikely(!timer))
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index 85868e9..348f855 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -99,6 +99,7 @@ struct dmtimer_platform_data {
 int omap_dm_timer_reserve_systimer(int id);
 struct omap_dm_timer *omap_dm_timer_request(void);
 struct omap_dm_timer *omap_dm_timer_request_specific(int timer_id);
+struct omap_dm_timer *omap_dm_timer_request_by_cap(u32 cap);
 int omap_dm_timer_free(struct omap_dm_timer *timer);
 void omap_dm_timer_enable(struct omap_dm_timer *timer);
 void omap_dm_timer_disable(struct omap_dm_timer *timer);
-- 
1.7.9.5

