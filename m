From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH/RFC 12/19] OMAP2+: powerdomain: add voltage domain lookup during register
Date: Wed, 23 Mar 2011 17:00:26 -0700
Message-ID: <1300924833-26745-13-git-send-email-khilman@ti.com>
References: <1300924833-26745-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:36137 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933394Ab1CXAAg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Mar 2011 20:00:36 -0400
Received: by mail-iw0-f180.google.com with SMTP id 6so12607199iwn.11
        for <linux-omap@vger.kernel.org>; Wed, 23 Mar 2011 17:00:35 -0700 (PDT)
In-Reply-To: <1300924833-26745-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsely <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>

When a powerdomain is registered, lookup the voltage domain by name
and keep a pointer to the containing voltagedomain in the powerdomain
structure.

Modeled after similar method between powerdomain and clockdomain layers.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/powerdomain.c |   21 +++++++++++++++++++++
 arch/arm/mach-omap2/powerdomain.h |    1 +
 arch/arm/mach-omap2/voltage.h     |    1 +
 3 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 49c6513..8fccd4b 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -77,6 +77,7 @@ static struct powerdomain *_pwrdm_lookup(const char *name)
 static int _pwrdm_register(struct powerdomain *pwrdm)
 {
 	int i;
+	struct voltagedomain *voltdm;
 
 	if (!pwrdm || !pwrdm->name)
 		return -EINVAL;
@@ -94,6 +95,14 @@ static int _pwrdm_register(struct powerdomain *pwrdm)
 	if (_pwrdm_lookup(pwrdm->name))
 		return -EEXIST;
 
+	voltdm = voltdm_lookup(pwrdm->voltdm.name);
+	if (!voltdm) {
+		pr_err("powerdomain: %s: voltagedomain %s does not exist\n",
+		       pwrdm->name, pwrdm->voltdm.name);
+		return -EINVAL;
+	}
+	pwrdm->voltdm.ptr = voltdm;
+
 	list_add(&pwrdm->node, &pwrdm_list);
 
 	/* Initialize the powerdomain's state counter */
@@ -383,6 +392,18 @@ int pwrdm_for_each_clkdm(struct powerdomain *pwrdm,
 }
 
 /**
+ * pwrdm_get_voltdm - return a ptr to the voltdm that this pwrdm resides in
+ * @pwrdm: struct powerdomain *
+ *
+ * Return a pointer to the struct voltageomain that the specified powerdomain
+ * @pwrdm exists in.
+ */
+struct voltagedomain *pwrdm_get_voltdm(struct powerdomain *pwrdm)
+{
+	return pwrdm->voltdm.ptr;
+}
+
+/**
  * pwrdm_get_mem_bank_count - get number of memory banks in this powerdomain
  * @pwrdm: struct powerdomain *
  *
diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
index cc03a0d..3a1ec37 100644
--- a/arch/arm/mach-omap2/powerdomain.h
+++ b/arch/arm/mach-omap2/powerdomain.h
@@ -183,6 +183,7 @@ int pwrdm_del_clkdm(struct powerdomain *pwrdm, struct clockdomain *clkdm);
 int pwrdm_for_each_clkdm(struct powerdomain *pwrdm,
 			 int (*fn)(struct powerdomain *pwrdm,
 				   struct clockdomain *clkdm));
+struct voltagedomain *pwrdm_get_voltdm(struct powerdomain *pwrdm);
 
 int pwrdm_get_mem_bank_count(struct powerdomain *pwrdm);
 
diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
index cacd76e..966aa88 100644
--- a/arch/arm/mach-omap2/voltage.h
+++ b/arch/arm/mach-omap2/voltage.h
@@ -186,4 +186,5 @@ extern void omap44xx_voltagedomains_init(void);
 
 struct voltagedomain *voltdm_lookup(const char *name);
 void voltdm_init(struct voltagedomain **voltdm_list);
+int voltdm_add_pwrdm(struct voltagedomain *voltdm, struct powerdomain *pwrdm);
 #endif
-- 
1.7.4

