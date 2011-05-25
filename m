From: Nishanth Menon <nm@ti.com>
Subject: [PATCH V2] PM: OPP: introduce function to free cpufreq table
Date: Wed, 25 May 2011 00:43:26 -0700
Message-ID: <1306309406-3299-1-git-send-email-nm@ti.com>
References: <[PATCH] PM: OPP: introduce function to free cpufreq table>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:53813 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755235Ab1EYHnc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 May 2011 03:43:32 -0400
Received: by mail-px0-f175.google.com with SMTP id 17so4995157pxi.20
        for <linux-omap@vger.kernel.org>; Wed, 25 May 2011 00:43:32 -0700 (PDT)
In-Reply-To: <[PATCH] PM: OPP: introduce function to free cpufreq table>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-pm <linux-pm@lists.linux-foundation.org>
Cc: Todd <toddpoynor@google.com>, Rafael <rjw@sisk.pl>, linux-omap <linux-omap@vger.kernel.org>, Nishanth Menon <nm@ti.com>

cpufreq table allocated by opp_init_cpufreq_table is better
freed by OPP layer itself. This allows future modifications to
the table handling to be transparent to the users.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
V2: removed lock of free.
V1: http://marc.info/?t=130619241700001&r=1&w=2

Example discussion: http://marc.info/?t=130570440600005&r=1&w=2
 Documentation/power/opp.txt |    2 ++
 drivers/base/power/opp.c    |   17 +++++++++++++++++
 include/linux/opp.h         |    8 ++++++++
 3 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/Documentation/power/opp.txt b/Documentation/power/opp.txt
index 5ae70a1..3035d00 100644
--- a/Documentation/power/opp.txt
+++ b/Documentation/power/opp.txt
@@ -321,6 +321,8 @@ opp_init_cpufreq_table - cpufreq framework typically is initialized with
 	addition to CONFIG_PM as power management feature is required to
 	dynamically scale voltage and frequency in a system.
 
+opp_free_cpufreq_table - Free up the table allocated by opp_init_cpufreq_table
+
 7. Data Structures
 ==================
 Typically an SoC contains multiple voltage domains which are variable. Each
diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index 56a6899..5cc1232 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -625,4 +625,21 @@ int opp_init_cpufreq_table(struct device *dev,
 
 	return 0;
 }
+
+/**
+ * opp_free_cpufreq_table() - free the cpufreq table
+ * @dev:	device for which we do this operation
+ * @table:	table to free
+ *
+ * Free up the table allocated by opp_init_cpufreq_table
+ */
+void opp_free_cpufreq_table(struct device *dev,
+				struct cpufreq_frequency_table **table)
+{
+	if (!table)
+		return;
+
+	kfree(*table);
+	*table = NULL;
+}
 #endif		/* CONFIG_CPU_FREQ */
diff --git a/include/linux/opp.h b/include/linux/opp.h
index 5449945..7020e97 100644
--- a/include/linux/opp.h
+++ b/include/linux/opp.h
@@ -94,12 +94,20 @@ static inline int opp_disable(struct device *dev, unsigned long freq)
 #if defined(CONFIG_CPU_FREQ) && defined(CONFIG_PM_OPP)
 int opp_init_cpufreq_table(struct device *dev,
 			    struct cpufreq_frequency_table **table);
+void opp_free_cpufreq_table(struct device *dev,
+				struct cpufreq_frequency_table **table);
 #else
 static inline int opp_init_cpufreq_table(struct device *dev,
 			    struct cpufreq_frequency_table **table)
 {
 	return -EINVAL;
 }
+
+static inline
+void opp_free_cpufreq_table(struct device *dev,
+				struct cpufreq_frequency_table **table)
+{
+}
 #endif		/* CONFIG_CPU_FREQ */
 
 #endif		/* __LINUX_OPP_H__ */
-- 
1.7.1

