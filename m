From: Thara Gopinath <thara@ti.com>
Subject: [PATCH 02/13] OMAP: Introduce API in the OPP layer to find the opp entry corresponding to a voltage.
Date: Wed, 18 Aug 2010 16:50:01 +0530
Message-ID: <1282130412-12027-3-git-send-email-thara@ti.com>
References: <1282130412-12027-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41227 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752790Ab0HRLUY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Aug 2010 07:20:24 -0400
In-Reply-To: <1282130412-12027-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, vishwanath.bs@ti.com, sawant@ti.com, b-cousson@ti.com, Thara Gopinath <thara@ti.com>

This patch adds an API in the opp layer to get the opp table entry
corresponding to the voltage passed as the parameter.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/plat-omap/include/plat/opp.h |    8 ++++++++
 arch/arm/plat-omap/opp.c              |   28 ++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/opp.h b/arch/arm/plat-omap/include/plat/opp.h
index 997b56e..0e580ed 100644
--- a/arch/arm/plat-omap/include/plat/opp.h
+++ b/arch/arm/plat-omap/include/plat/opp.h
@@ -76,6 +76,8 @@ struct omap_opp *opp_find_freq_floor(struct device *dev, unsigned long *freq);
 
 struct omap_opp *opp_find_freq_ceil(struct device *dev, unsigned long *freq);
 
+struct omap_opp *opp_find_voltage(struct device *dev, unsigned long volt);
+
 int opp_add(const struct omap_opp_def *opp_def);
 
 int opp_enable(struct omap_opp *opp);
@@ -119,6 +121,12 @@ static inline struct omap_opp *opp_find_freq_ceil(struct omap_opp *oppl,
 	return ERR_PTR(-EINVAL);
 }
 
+static inline struct omap_opp *opp_find_voltage(struct device *dev,
+						unsigned long volt)
+{
+	return ERR_PTR(-EINVAL);
+}
+
 static inline struct omap_opp *opp_add(struct omap_opp *oppl,
 				       const struct omap_opp_def *opp_def)
 {
diff --git a/arch/arm/plat-omap/opp.c b/arch/arm/plat-omap/opp.c
index 5a86bdd..a3dea82 100644
--- a/arch/arm/plat-omap/opp.c
+++ b/arch/arm/plat-omap/opp.c
@@ -290,6 +290,34 @@ struct omap_opp *opp_find_freq_floor(struct device *dev, unsigned long *freq)
 	return opp;
 }
 
+/**
+ * opp_find_voltage() - search for an exact voltage
+ * @dev:	device pointer associated with the opp type
+ * @volt:	voltage to search for
+ *
+ * Searches for exact match in the opp list and returns handle to the matching
+ * opp if found, else returns ERR_PTR in case of error and should be handled
+ * using IS_ERR.
+ */
+struct omap_opp *opp_find_voltage(struct device *dev, unsigned long volt)
+{
+	struct device_opp *dev_opp;
+	struct omap_opp *temp_opp, *opp = ERR_PTR(-ENODEV);
+
+	dev_opp = find_device_opp(dev);
+	if (IS_ERR(dev_opp))
+		return opp;
+
+	list_for_each_entry(temp_opp, &dev_opp->opp_list, node) {
+		if (temp_opp->enabled && temp_opp->u_volt == volt) {
+			opp = temp_opp;
+			break;
+		}
+	}
+
+	return opp;
+}
+
 /* wrapper to reuse converting opp_def to opp struct */
 static void omap_opp_populate(struct omap_opp *opp,
 			      const struct omap_opp_def *opp_def)
-- 
1.7.1.GIT

