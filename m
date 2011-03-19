From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 5/7] OMAP2+: voltage: keep track of powerdomains in each voltagedomain
Date: Fri, 18 Mar 2011 17:18:50 -0700
Message-ID: <1300493932-17362-6-git-send-email-khilman@ti.com>
References: <1300493932-17362-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:52120 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757684Ab1CSASq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Mar 2011 20:18:46 -0400
Received: by mail-iy0-f177.google.com with SMTP id 40so5035545iyf.36
        for <linux-omap@vger.kernel.org>; Fri, 18 Mar 2011 17:18:45 -0700 (PDT)
In-Reply-To: <1300493932-17362-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsely <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>

When a powerdomain is registered and it has an associated voltage domain,
add the powerdomain to the voltagedomain using voltdm_add_pwrdm().

Modeled after a similar relationship between clockdomains and powerdomains.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/powerdomain.c |    1 +
 arch/arm/mach-omap2/voltage.c     |   77 +++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/voltage.h     |   11 +++++
 3 files changed, 89 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index da86c72..2f16b43 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -103,6 +103,7 @@ static int _pwrdm_register(struct powerdomain *pwrdm)
 			return -EINVAL;
 		}
 		pwrdm->voltdm.ptr = voltdm;
+		voltdm_add_pwrdm(voltdm, pwrdm);
 	}
 
 	list_add(&pwrdm->node, &pwrdm_list);
diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index 1dc6967..c25df81 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -36,6 +36,7 @@
 #include "control.h"
 
 #include "voltage.h"
+#include "powerdomain.h"
 
 #include "vc.h"
 #include "vp.h"
@@ -1081,6 +1082,82 @@ static struct voltagedomain *_voltdm_lookup(const char *name)
 	return voltdm;
 }
 
+/**
+ * voltdm_add_pwrdm - add a powerdomain to a voltagedomain
+ * @voltdm: struct voltagedomain * to add the powerdomain to
+ * @pwrdm: struct powerdomain * to associate with a voltagedomain
+ *
+ * Associate the powerdomain @pwrdm with a voltagedomain @voltdm.  This
+ * enables the use of voltdm_for_each_pwrdm().  Returns -EINVAL if
+ * presented with invalid pointers; -ENOMEM if memory could not be allocated;
+ * or 0 upon success.
+ */
+int voltdm_add_pwrdm(struct voltagedomain *voltdm, struct powerdomain *pwrdm)
+{
+	int i;
+	int ret = -EINVAL;
+
+	if (!voltdm || !pwrdm)
+		return -EINVAL;
+
+	pr_debug("voltagedomain: associating powerdomain %s with voltagedomain "
+		 "%s\n", pwrdm->name, voltdm->name);
+
+	for (i = 0; i < VOLTDM_MAX_PWRDMS; i++) {
+		if (!voltdm->voltdm_pwrdms[i])
+			break;
+#ifdef DEBUG
+		if (voltdm->voltdm_pwrdms[i] == pwrdm) {
+			ret = -EINVAL;
+			goto vap_exit;
+		}
+#endif
+	}
+
+	if (i == VOLTDM_MAX_PWRDMS) {
+		pr_debug("voltagedomain: increase VOLTDM_MAX_PWRDMS for "
+			 "voltdm %s pwrdm %s\n", voltdm->name, pwrdm->name);
+		WARN_ON(1);
+		ret = -ENOMEM;
+		goto vap_exit;
+	}
+
+	voltdm->voltdm_pwrdms[i] = pwrdm;
+
+	ret = 0;
+
+vap_exit:
+	return ret;
+}
+
+/**
+ * voltdm_for_each_pwrdm - call function on each pwrdm in a voltdm
+ * @voltdm: struct voltagedomain * to iterate over
+ * @fn: callback function *
+ *
+ * Call the supplied function @fn for each powerdomain in the voltagedomain
+ * @voltdm.  The callback function can return anything but 0 to bail
+ * out early from the iterator.  Returns -EINVAL if presented with
+ * invalid pointers; or passes along the last return value of the
+ * callback function, which should be 0 for success or anything else
+ * to indicate failure.
+ */
+int voltdm_for_each_pwrdm(struct voltagedomain *voltdm,
+			  int (*fn)(struct voltagedomain *voltdm,
+				    struct powerdomain *pwrdm))
+{
+	int ret = 0;
+	int i;
+
+	if (!fn)
+		return -EINVAL;
+
+	for (i = 0; i < VOLTDM_MAX_PWRDMS && !ret; i++)
+		ret = (*fn)(voltdm, voltdm->voltdm_pwrdms[i]);
+
+	return ret;
+}
+
 static int _voltdm_register(struct voltagedomain *voltdm)
 {
 	if (!voltdm || !voltdm->name)
diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
index 13e5ed9..8e25126 100644
--- a/arch/arm/mach-omap2/voltage.h
+++ b/arch/arm/mach-omap2/voltage.h
@@ -19,6 +19,11 @@
 #include "vc.h"
 #include "vp.h"
 
+/*
+ * Maximum number of powerdomains that can be associated with a voltagedomain.
+ */
+#define VOLTDM_MAX_PWRDMS	       10
+
 /* XXX document */
 #define VOLTSCALE_VPFORCEUPDATE		1
 #define VOLTSCALE_VCBYPASS		2
@@ -55,11 +60,14 @@ struct omap_vfsm_instance_data {
  * @name: Name of the voltage domain which can be used as a unique identifier.
  * @node: list_head linking all voltage domains
  * @vdd: to be removed
+ * @voltdm_pwrdms: powerdomains in this voltagedomain
  */
 struct voltagedomain {
 	char *name;
 	struct list_head node;
 	struct omap_vdd_info *vdd;
+
+	struct powerdomain *voltdm_pwrdms[VOLTDM_MAX_PWRDMS];
 };
 
 /**
@@ -183,4 +191,7 @@ extern void omap44xx_voltagedomains_init(void);
 struct voltagedomain *voltdm_lookup(const char *name);
 void voltdm_init(struct voltagedomain **voltdm_list);
 int voltdm_add_pwrdm(struct voltagedomain *voltdm, struct powerdomain *pwrdm);
+int voltdm_for_each_pwrdm(struct voltagedomain *voltdm,
+			  int (*fn)(struct voltagedomain *voltdm,
+				    struct powerdomain *pwrdm));
 #endif
-- 
1.7.4

