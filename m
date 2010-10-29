From: Thara Gopinath <thara@ti.com>
Subject: [PATCH v2 02/14] OMAP: Introduce API in the OPP layer to find the opp entry corresponding to a voltage.
Date: Fri, 29 Oct 2010 21:08:16 +0530
Message-ID: <1288366708-32302-3-git-send-email-thara@ti.com>
References: <1288366708-32302-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34604 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932704Ab0J2Pij (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Oct 2010 11:38:39 -0400
In-Reply-To: <1288366708-32302-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, khilman@deeprootsystems.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

This patch adds an API in the opp layer to get the opp table entry
corresponding to the voltage passed as the parameter.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 drivers/base/power/opp.c |   28 ++++++++++++++++++++++++++++
 include/linux/opp.h      |    8 ++++++++
 2 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index 2bb9b4c..60b4478 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -354,6 +354,34 @@ struct opp *opp_find_freq_floor(struct device *dev, unsigned long *freq)
 }
 
 /**
+ * opp_find_voltage() - search for an exact voltage
+ * @dev:	device pointer associated with the opp type
+ * @volt:	voltage to search for
+ *
+ * Searches for exact match in the opp list and returns handle to the matching
+ * opp if found, else returns ERR_PTR in case of error and should be handled
+ * using IS_ERR.
+ */
+struct opp *opp_find_voltage(struct device *dev, unsigned long volt)
+{
+	struct device_opp *dev_opp;
+	struct opp *temp_opp, *opp = ERR_PTR(-ENODEV);
+
+	dev_opp = find_device_opp(dev);
+	if (IS_ERR(dev_opp))
+		return opp;
+
+	list_for_each_entry_rcu(temp_opp, &dev_opp->opp_list, node) {
+		if (temp_opp->available && temp_opp->u_volt == volt) {
+			opp = temp_opp;
+			break;
+		}
+	}
+
+	return opp;
+}
+
+/**
  * opp_add()  - Add an OPP table from a table definitions
  * @dev:	device for which we do this operation
  * @freq:	Frequency in Hz for this OPP
diff --git a/include/linux/opp.h b/include/linux/opp.h
index 5449945..4977d5c 100644
--- a/include/linux/opp.h
+++ b/include/linux/opp.h
@@ -34,6 +34,8 @@ struct opp *opp_find_freq_floor(struct device *dev, unsigned long *freq);
 
 struct opp *opp_find_freq_ceil(struct device *dev, unsigned long *freq);
 
+struct opp *opp_find_voltage(struct device *dev, unsigned long volt);
+
 int opp_add(struct device *dev, unsigned long freq, unsigned long u_volt);
 
 int opp_enable(struct device *dev, unsigned long freq);
@@ -74,6 +76,12 @@ static inline struct opp *opp_find_freq_ceil(struct device *dev,
 	return ERR_PTR(-EINVAL);
 }
 
+static inline struct opp *opp_find_voltage(struct device *dev,
+						unsigned long volt)
+{
+	return ERR_PTR(-EINVAL);
+}
+
 static inline int opp_add(struct device *dev, unsigned long freq,
 					unsigned long u_volt)
 {
-- 
1.7.0.4

