From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 13/17] OMAP2+: voltage: keep track of powerdomains in each voltagedomain
Date: Wed, 30 Mar 2011 17:16:16 -0700
Message-ID: <1301530580-12046-14-git-send-email-khilman@ti.com>
References: <1301530580-12046-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:51345 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933119Ab1CaAQd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 Mar 2011 20:16:33 -0400
Received: by mail-gx0-f178.google.com with SMTP id 8so868062gxk.37
        for <linux-omap@vger.kernel.org>; Wed, 30 Mar 2011 17:16:32 -0700 (PDT)
In-Reply-To: <1301530580-12046-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

When a powerdomain is registered and it has an associated voltage domain,
add the powerdomain to the voltagedomain using voltdm_add_pwrdm().

Also add voltagedomain iterator helper functions to iterate over all
registered voltagedomains and all powerdomains associated with a
voltagedomain.

Modeled after a similar relationship between clockdomains and powerdomains.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/powerdomain.c |    2 +
 arch/arm/mach-omap2/powerdomain.h |    2 +
 arch/arm/mach-omap2/voltage.c     |   80 +++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/voltage.h     |   10 +++++
 4 files changed, 94 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 8fccd4b..224272e 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -102,6 +102,8 @@ static int _pwrdm_register(struct powerdomain *pwrdm)
 		return -EINVAL;
 	}
 	pwrdm->voltdm.ptr = voltdm;
+	INIT_LIST_HEAD(&pwrdm->voltdm_node);
+	voltdm_add_pwrdm(voltdm, pwrdm);
 
 	list_add(&pwrdm->node, &pwrdm_list);
 
diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
index 3a1ec37..6a4f71a 100644
--- a/arch/arm/mach-omap2/powerdomain.h
+++ b/arch/arm/mach-omap2/powerdomain.h
@@ -92,6 +92,7 @@ struct powerdomain;
  * @pwrsts_mem_on: Possible memory bank pwrstates when pwrdm in ON
  * @pwrdm_clkdms: Clockdomains in this powerdomain
  * @node: list_head linking all powerdomains
+ * @voltdm_node: list_head linking all powerdomains in a voltagedomain
  * @state:
  * @state_counter:
  * @timer:
@@ -116,6 +117,7 @@ struct powerdomain {
 	const u8 prcm_partition;
 	struct clockdomain *pwrdm_clkdms[PWRDM_MAX_CLKDMS];
 	struct list_head node;
+	struct list_head voltdm_node;
 	int state;
 	unsigned state_counter[PWRDM_MAX_PWRSTS];
 	unsigned ret_logic_off_counter;
diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index bc944ff..b1b5e38 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -36,6 +36,7 @@
 #include "control.h"
 
 #include "voltage.h"
+#include "powerdomain.h"
 
 #include "vc.h"
 #include "vp.h"
@@ -1085,11 +1086,90 @@ static struct voltagedomain *_voltdm_lookup(const char *name)
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
+	if (!voltdm || !pwrdm)
+		return -EINVAL;
+
+	pr_debug("voltagedomain: associating powerdomain %s with voltagedomain "
+		 "%s\n", pwrdm->name, voltdm->name);
+
+	list_add(&pwrdm->voltdm_node, &voltdm->pwrdm_list);
+
+	return 0;
+}
+
+/**
+ * voltdm_for_each_pwrdm - call function for each pwrdm in a voltdm
+ * @voltdm: struct voltagedomain * to iterate over
+ * @fn: callback function *
+ *
+ * Call the supplied function @fn for each powerdomain in the
+ * voltagedomain @voltdm.  Returns -EINVAL if presented with invalid
+ * pointers; or passes along the last return value of the callback
+ * function, which should be 0 for success or anything else to
+ * indicate failure.
+ */
+int voltdm_for_each_pwrdm(struct voltagedomain *voltdm,
+			  int (*fn)(struct voltagedomain *voltdm,
+				    struct powerdomain *pwrdm))
+{
+	struct powerdomain *pwrdm;
+	int ret = 0;
+
+	if (!fn)
+		return -EINVAL;
+
+	list_for_each_entry(pwrdm, &voltdm->pwrdm_list, voltdm_node)
+		ret = (*fn)(voltdm, pwrdm);
+
+	return ret;
+}
+
+/**
+ * voltdm_for_each - call function on each registered voltagedomain
+ * @fn: callback function *
+ *
+ * Call the supplied function @fn for each registered voltagedomain.
+ * The callback function @fn can return anything but 0 to bail out
+ * early from the iterator.  Returns the last return value of the
+ * callback function, which should be 0 for success or anything else
+ * to indicate failure; or -EINVAL if the function pointer is null.
+ */
+int voltdm_for_each(int (*fn)(struct voltagedomain *voltdm, void *user),
+		    void *user)
+{
+	struct voltagedomain *temp_voltdm;
+	int ret = 0;
+
+	if (!fn)
+		return -EINVAL;
+
+	list_for_each_entry(temp_voltdm, &voltdm_list, node) {
+		ret = (*fn)(temp_voltdm, user);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
 static int _voltdm_register(struct voltagedomain *voltdm)
 {
 	if (!voltdm || !voltdm->name)
 		return -EINVAL;
 
+	INIT_LIST_HEAD(&voltdm->pwrdm_list);
 	list_add(&voltdm->node, &voltdm_list);
 
 	pr_debug("voltagedomain: registered %s\n", voltdm->name);
diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
index 966aa88..b41d9f1 100644
--- a/arch/arm/mach-omap2/voltage.h
+++ b/arch/arm/mach-omap2/voltage.h
@@ -19,6 +19,8 @@
 #include "vc.h"
 #include "vp.h"
 
+struct powerdomain;
+
 /* XXX document */
 #define VOLTSCALE_VPFORCEUPDATE		1
 #define VOLTSCALE_VCBYPASS		2
@@ -55,12 +57,15 @@ struct omap_vfsm_instance_data {
  * @name: Name of the voltage domain which can be used as a unique identifier.
  * @scalable: Whether or not this voltage domain is scalable
  * @node: list_head linking all voltage domains
+ * @pwrdm_node: list_head linking all powerdomains in this voltagedomain
  * @vdd: to be removed
+ * @pwrdms: powerdomains in this voltagedomain
  */
 struct voltagedomain {
 	char *name;
 	bool scalable;
 	struct list_head node;
+	struct list_head pwrdm_list;
 	struct omap_vdd_info *vdd;
 };
 
@@ -187,4 +192,9 @@ extern void omap44xx_voltagedomains_init(void);
 struct voltagedomain *voltdm_lookup(const char *name);
 void voltdm_init(struct voltagedomain **voltdm_list);
 int voltdm_add_pwrdm(struct voltagedomain *voltdm, struct powerdomain *pwrdm);
+int voltdm_for_each(int (*fn)(struct voltagedomain *voltdm, void *user),
+		    void *user);
+int voltdm_for_each_pwrdm(struct voltagedomain *voltdm,
+			  int (*fn)(struct voltagedomain *voltdm,
+				    struct powerdomain *pwrdm));
 #endif
-- 
1.7.4

