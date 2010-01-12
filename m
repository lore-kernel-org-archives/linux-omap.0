From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 04/10] OMAP clockdomain/powerdomain: remove runtime
	register/unregister
Date: Mon, 11 Jan 2010 18:05:37 -0700
Message-ID: <20100112010536.6275.36524.stgit@localhost.localdomain>
References: <20100112010258.6275.97999.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45285 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754660Ab0ALBQW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jan 2010 20:16:22 -0500
In-Reply-To: <20100112010258.6275.97999.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Dmitry Baryshkov <dbaryshkov@gmail.com>

OMAP clockdomains and powerdomains are currently defined statically,
only registered at boot, and never unregistered, so we can remove the
unregister function and the locking.   A variant of this was originally
suggested a while ago by Dmitry Baryshkov <dbaryshkov@gmail.com>.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Dmitry Baryshkov <dbaryshkov@gmail.com>
---
 arch/arm/mach-omap2/clockdomain.c             |  118 ++++++-----------
 arch/arm/mach-omap2/powerdomain.c             |  178 ++++++-------------------
 arch/arm/plat-omap/include/plat/clockdomain.h |    2 
 arch/arm/plat-omap/include/plat/powerdomain.h |    2 
 4 files changed, 85 insertions(+), 215 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index a70ba29..2af9996 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -39,9 +39,6 @@
 /* clkdm_list contains all registered struct clockdomains */
 static LIST_HEAD(clkdm_list);
 
-/* clkdm_mutex protects clkdm_list add and del ops */
-static DEFINE_MUTEX(clkdm_mutex);
-
 /* array of clockdomain deps to be added/removed when clkdm in hwsup mode */
 static struct clkdm_autodep *autodeps;
 
@@ -67,6 +64,45 @@ static struct clockdomain *_clkdm_lookup(const char *name)
 	return clkdm;
 }
 
+/**
+ * _clkdm_register - register a clockdomain
+ * @clkdm: struct clockdomain * to register
+ *
+ * Adds a clockdomain to the internal clockdomain list.
+ * Returns -EINVAL if given a null pointer, -EEXIST if a clockdomain is
+ * already registered by the provided name, or 0 upon success.
+ */
+static int _clkdm_register(struct clockdomain *clkdm)
+{
+	struct powerdomain *pwrdm;
+
+	if (!clkdm || !clkdm->name)
+		return -EINVAL;
+
+	if (!omap_chip_is(clkdm->omap_chip))
+		return -EINVAL;
+
+	pwrdm = pwrdm_lookup(clkdm->pwrdm.name);
+	if (!pwrdm) {
+		pr_err("clockdomain: %s: powerdomain %s does not exist\n",
+			clkdm->name, clkdm->pwrdm.name);
+		return -EINVAL;
+	}
+	clkdm->pwrdm.ptr = pwrdm;
+
+	/* Verify that the clockdomain is not already registered */
+	if (_clkdm_lookup(clkdm->name))
+		return -EEXIST;
+
+	list_add(&clkdm->node, &clkdm_list);
+
+	pwrdm_add_clkdm(pwrdm, clkdm);
+
+	pr_debug("clockdomain: registered %s\n", clkdm->name);
+
+	return 0;
+}
+
 /* _clkdm_deps_lookup - look up the specified clockdomain in a clkdm list */
 static struct clkdm_dep *_clkdm_deps_lookup(struct clockdomain *clkdm,
 					    struct clkdm_dep *deps)
@@ -240,7 +276,7 @@ void clkdm_init(struct clockdomain **clkdms,
 
 	if (clkdms)
 		for (c = clkdms; *c; c++)
-			clkdm_register(*c);
+			_clkdm_register(*c);
 
 	autodeps = init_autodeps;
 	if (autodeps)
@@ -249,76 +285,6 @@ void clkdm_init(struct clockdomain **clkdms,
 }
 
 /**
- * clkdm_register - register a clockdomain
- * @clkdm: struct clockdomain * to register
- *
- * Adds a clockdomain to the internal clockdomain list.
- * Returns -EINVAL if given a null pointer, -EEXIST if a clockdomain is
- * already registered by the provided name, or 0 upon success.
- */
-int clkdm_register(struct clockdomain *clkdm)
-{
-	int ret = -EINVAL;
-	struct powerdomain *pwrdm;
-
-	if (!clkdm || !clkdm->name)
-		return -EINVAL;
-
-	if (!omap_chip_is(clkdm->omap_chip))
-		return -EINVAL;
-
-	pwrdm = pwrdm_lookup(clkdm->pwrdm.name);
-	if (!pwrdm) {
-		pr_err("clockdomain: %s: powerdomain %s does not exist\n",
-			clkdm->name, clkdm->pwrdm.name);
-		return -EINVAL;
-	}
-	clkdm->pwrdm.ptr = pwrdm;
-
-	mutex_lock(&clkdm_mutex);
-	/* Verify that the clockdomain is not already registered */
-	if (_clkdm_lookup(clkdm->name)) {
-		ret = -EEXIST;
-		goto cr_unlock;
-	}
-
-	list_add(&clkdm->node, &clkdm_list);
-
-	pwrdm_add_clkdm(pwrdm, clkdm);
-
-	pr_debug("clockdomain: registered %s\n", clkdm->name);
-	ret = 0;
-
-cr_unlock:
-	mutex_unlock(&clkdm_mutex);
-
-	return ret;
-}
-
-/**
- * clkdm_unregister - unregister a clockdomain
- * @clkdm: struct clockdomain * to unregister
- *
- * Removes a clockdomain from the internal clockdomain list.  Returns
- * -EINVAL if clkdm argument is NULL.
- */
-int clkdm_unregister(struct clockdomain *clkdm)
-{
-	if (!clkdm)
-		return -EINVAL;
-
-	pwrdm_del_clkdm(clkdm->pwrdm.ptr, clkdm);
-
-	mutex_lock(&clkdm_mutex);
-	list_del(&clkdm->node);
-	mutex_unlock(&clkdm_mutex);
-
-	pr_debug("clockdomain: unregistered %s\n", clkdm->name);
-
-	return 0;
-}
-
-/**
  * clkdm_lookup - look up a clockdomain by name, return a pointer
  * @name: name of clockdomain
  *
@@ -334,14 +300,12 @@ struct clockdomain *clkdm_lookup(const char *name)
 
 	clkdm = NULL;
 
-	mutex_lock(&clkdm_mutex);
 	list_for_each_entry(temp_clkdm, &clkdm_list, node) {
 		if (!strcmp(name, temp_clkdm->name)) {
 			clkdm = temp_clkdm;
 			break;
 		}
 	}
-	mutex_unlock(&clkdm_mutex);
 
 	return clkdm;
 }
@@ -369,13 +333,11 @@ int clkdm_for_each(int (*fn)(struct clockdomain *clkdm, void *user),
 	if (!fn)
 		return -EINVAL;
 
-	mutex_lock(&clkdm_mutex);
 	list_for_each_entry(clkdm, &clkdm_list, node) {
 		ret = (*fn)(clkdm, user);
 		if (ret)
 			break;
 	}
-	mutex_unlock(&clkdm_mutex);
 
 	return ret;
 }
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index e8e8d88..411361f 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -80,13 +80,6 @@ static u16 pwrstst_reg_offs;
 /* pwrdm_list contains all registered struct powerdomains */
 static LIST_HEAD(pwrdm_list);
 
-/*
- * pwrdm_rwlock protects pwrdm_list add and del ops - also reused to
- * protect pwrdm_clkdms[] during clkdm add/del ops
- */
-static DEFINE_RWLOCK(pwrdm_rwlock);
-
-
 /* Private functions */
 
 static struct powerdomain *_pwrdm_lookup(const char *name)
@@ -105,6 +98,42 @@ static struct powerdomain *_pwrdm_lookup(const char *name)
 	return pwrdm;
 }
 
+/**
+ * _pwrdm_register - register a powerdomain
+ * @pwrdm: struct powerdomain * to register
+ *
+ * Adds a powerdomain to the internal powerdomain list.  Returns
+ * -EINVAL if given a null pointer, -EEXIST if a powerdomain is
+ * already registered by the provided name, or 0 upon success.
+ */
+static int _pwrdm_register(struct powerdomain *pwrdm)
+{
+	int i;
+
+	if (!pwrdm)
+		return -EINVAL;
+
+	if (!omap_chip_is(pwrdm->omap_chip))
+		return -EINVAL;
+
+	if (_pwrdm_lookup(pwrdm->name))
+		return -EEXIST;
+
+	list_add(&pwrdm->node, &pwrdm_list);
+
+	/* Initialize the powerdomain's state counter */
+	for (i = 0; i < 4; i++)
+		pwrdm->state_counter[i] = 0;
+
+	pwrdm_wait_transition(pwrdm);
+	pwrdm->state = pwrdm_read_pwrst(pwrdm);
+	pwrdm->state_counter[pwrdm->state] = 1;
+
+	pr_debug("powerdomain: registered %s\n", pwrdm->name);
+
+	return 0;
+}
+
 static int _pwrdm_state_switch(struct powerdomain *pwrdm, int flag)
 {
 
@@ -152,19 +181,6 @@ static int _pwrdm_post_transition_cb(struct powerdomain *pwrdm, void *unused)
 	return 0;
 }
 
-static __init void _pwrdm_setup(struct powerdomain *pwrdm)
-{
-	int i;
-
-	for (i = 0; i < PWRDM_MAX_PWRSTS; i++)
-		pwrdm->state_counter[i] = 0;
-
-	pwrdm_wait_transition(pwrdm);
-	pwrdm->state = pwrdm_read_pwrst(pwrdm);
-	pwrdm->state_counter[pwrdm->state] = 1;
-
-}
-
 /* Public functions */
 
 /**
@@ -192,73 +208,12 @@ void pwrdm_init(struct powerdomain **pwrdm_list)
 	}
 
 	if (pwrdm_list) {
-		for (p = pwrdm_list; *p; p++) {
-			pwrdm_register(*p);
-			_pwrdm_setup(*p);
-		}
+		for (p = pwrdm_list; *p; p++)
+			_pwrdm_register(*p);
 	}
 }
 
 /**
- * pwrdm_register - register a powerdomain
- * @pwrdm: struct powerdomain * to register
- *
- * Adds a powerdomain to the internal powerdomain list.  Returns
- * -EINVAL if given a null pointer, -EEXIST if a powerdomain is
- * already registered by the provided name, or 0 upon success.
- */
-int pwrdm_register(struct powerdomain *pwrdm)
-{
-	unsigned long flags;
-	int ret = -EINVAL;
-
-	if (!pwrdm)
-		return -EINVAL;
-
-	if (!omap_chip_is(pwrdm->omap_chip))
-		return -EINVAL;
-
-	write_lock_irqsave(&pwrdm_rwlock, flags);
-	if (_pwrdm_lookup(pwrdm->name)) {
-		ret = -EEXIST;
-		goto pr_unlock;
-	}
-
-	list_add(&pwrdm->node, &pwrdm_list);
-
-	pr_debug("powerdomain: registered %s\n", pwrdm->name);
-	ret = 0;
-
-pr_unlock:
-	write_unlock_irqrestore(&pwrdm_rwlock, flags);
-
-	return ret;
-}
-
-/**
- * pwrdm_unregister - unregister a powerdomain
- * @pwrdm: struct powerdomain * to unregister
- *
- * Removes a powerdomain from the internal powerdomain list.  Returns
- * -EINVAL if pwrdm argument is NULL.
- */
-int pwrdm_unregister(struct powerdomain *pwrdm)
-{
-	unsigned long flags;
-
-	if (!pwrdm)
-		return -EINVAL;
-
-	write_lock_irqsave(&pwrdm_rwlock, flags);
-	list_del(&pwrdm->node);
-	write_unlock_irqrestore(&pwrdm_rwlock, flags);
-
-	pr_debug("powerdomain: unregistered %s\n", pwrdm->name);
-
-	return 0;
-}
-
-/**
  * pwrdm_lookup - look up a powerdomain by name, return a pointer
  * @name: name of powerdomain
  *
@@ -268,20 +223,17 @@ int pwrdm_unregister(struct powerdomain *pwrdm)
 struct powerdomain *pwrdm_lookup(const char *name)
 {
 	struct powerdomain *pwrdm;
-	unsigned long flags;
 
 	if (!name)
 		return NULL;
 
-	read_lock_irqsave(&pwrdm_rwlock, flags);
 	pwrdm = _pwrdm_lookup(name);
-	read_unlock_irqrestore(&pwrdm_rwlock, flags);
 
 	return pwrdm;
 }
 
 /**
- * pwrdm_for_each_nolock - call function on each registered clockdomain
+ * pwrdm_for_each - call function on each registered clockdomain
  * @fn: callback function *
  *
  * Call the supplied function for each registered powerdomain.  The
@@ -290,8 +242,8 @@ struct powerdomain *pwrdm_lookup(const char *name)
  * should be 0 for success or anything else to indicate failure; or -EINVAL if
  * the function pointer is null.
  */
-int pwrdm_for_each_nolock(int (*fn)(struct powerdomain *pwrdm, void *user),
-				void *user)
+int pwrdm_for_each(int (*fn)(struct powerdomain *pwrdm, void *user),
+		   void *user)
 {
 	struct powerdomain *temp_pwrdm;
 	int ret = 0;
@@ -309,28 +261,6 @@ int pwrdm_for_each_nolock(int (*fn)(struct powerdomain *pwrdm, void *user),
 }
 
 /**
- * pwrdm_for_each - call function on each registered clockdomain
- * @fn: callback function *
- *
- * This function is the same as 'pwrdm_for_each_nolock()', but keeps the
- * &pwrdm_rwlock locked for reading, so no powerdomain structure manipulation
- * functions should be called from the callback, although hardware powerdomain
- * control functions are fine.
- */
-int pwrdm_for_each(int (*fn)(struct powerdomain *pwrdm, void *user),
-			void *user)
-{
-	unsigned long flags;
-	int ret;
-
-	read_lock_irqsave(&pwrdm_rwlock, flags);
-	ret = pwrdm_for_each_nolock(fn, user);
-	read_unlock_irqrestore(&pwrdm_rwlock, flags);
-
-	return ret;
-}
-
-/**
  * pwrdm_add_clkdm - add a clockdomain to a powerdomain
  * @pwrdm: struct powerdomain * to add the clockdomain to
  * @clkdm: struct clockdomain * to associate with a powerdomain
@@ -342,7 +272,6 @@ int pwrdm_for_each(int (*fn)(struct powerdomain *pwrdm, void *user),
  */
 int pwrdm_add_clkdm(struct powerdomain *pwrdm, struct clockdomain *clkdm)
 {
-	unsigned long flags;
 	int i;
 	int ret = -EINVAL;
 
@@ -352,8 +281,6 @@ int pwrdm_add_clkdm(struct powerdomain *pwrdm, struct clockdomain *clkdm)
 	pr_debug("powerdomain: associating clockdomain %s with powerdomain "
 		 "%s\n", clkdm->name, pwrdm->name);
 
-	write_lock_irqsave(&pwrdm_rwlock, flags);
-
 	for (i = 0; i < PWRDM_MAX_CLKDMS; i++) {
 		if (!pwrdm->pwrdm_clkdms[i])
 			break;
@@ -378,8 +305,6 @@ int pwrdm_add_clkdm(struct powerdomain *pwrdm, struct clockdomain *clkdm)
 	ret = 0;
 
 pac_exit:
-	write_unlock_irqrestore(&pwrdm_rwlock, flags);
-
 	return ret;
 }
 
@@ -395,7 +320,6 @@ pac_exit:
  */
 int pwrdm_del_clkdm(struct powerdomain *pwrdm, struct clockdomain *clkdm)
 {
-	unsigned long flags;
 	int ret = -EINVAL;
 	int i;
 
@@ -405,8 +329,6 @@ int pwrdm_del_clkdm(struct powerdomain *pwrdm, struct clockdomain *clkdm)
 	pr_debug("powerdomain: dissociating clockdomain %s from powerdomain "
 		 "%s\n", clkdm->name, pwrdm->name);
 
-	write_lock_irqsave(&pwrdm_rwlock, flags);
-
 	for (i = 0; i < PWRDM_MAX_CLKDMS; i++)
 		if (pwrdm->pwrdm_clkdms[i] == clkdm)
 			break;
@@ -423,8 +345,6 @@ int pwrdm_del_clkdm(struct powerdomain *pwrdm, struct clockdomain *clkdm)
 	ret = 0;
 
 pdc_exit:
-	write_unlock_irqrestore(&pwrdm_rwlock, flags);
-
 	return ret;
 }
 
@@ -435,32 +355,24 @@ pdc_exit:
  *
  * Call the supplied function for each clockdomain in the powerdomain
  * 'pwrdm'.  The callback function can return anything but 0 to bail
- * out early from the iterator.  The callback function is called with
- * the pwrdm_rwlock held for reading, so no powerdomain structure
- * manipulation functions should be called from the callback, although
- * hardware powerdomain control functions are fine.  Returns -EINVAL
- * if presented with invalid pointers; or passes along the last return
- * value of the callback function, which should be 0 for success or
- * anything else to indicate failure.
+ * out early from the iterator.  Returns -EINVAL if presented with
+ * invalid pointers; or passes along the last return value of the
+ * callback function, which should be 0 for success or anything else
+ * to indicate failure.
  */
 int pwrdm_for_each_clkdm(struct powerdomain *pwrdm,
 			 int (*fn)(struct powerdomain *pwrdm,
 				   struct clockdomain *clkdm))
 {
-	unsigned long flags;
 	int ret = 0;
 	int i;
 
 	if (!fn)
 		return -EINVAL;
 
-	read_lock_irqsave(&pwrdm_rwlock, flags);
-
 	for (i = 0; i < PWRDM_MAX_CLKDMS && !ret; i++)
 		ret = (*fn)(pwrdm, pwrdm->pwrdm_clkdms[i]);
 
-	read_unlock_irqrestore(&pwrdm_rwlock, flags);
-
 	return ret;
 }
 
diff --git a/arch/arm/plat-omap/include/plat/clockdomain.h b/arch/arm/plat-omap/include/plat/clockdomain.h
index f77ca72..2286971 100644
--- a/arch/arm/plat-omap/include/plat/clockdomain.h
+++ b/arch/arm/plat-omap/include/plat/clockdomain.h
@@ -117,8 +117,6 @@ struct clockdomain {
 };
 
 void clkdm_init(struct clockdomain **clkdms, struct clkdm_autodep *autodeps);
-int clkdm_register(struct clockdomain *clkdm);
-int clkdm_unregister(struct clockdomain *clkdm);
 struct clockdomain *clkdm_lookup(const char *name);
 
 int clkdm_for_each(int (*fn)(struct clockdomain *clkdm, void *user),
diff --git a/arch/arm/plat-omap/include/plat/powerdomain.h b/arch/arm/plat-omap/include/plat/powerdomain.h
index dd5f79d..c590e2f 100644
--- a/arch/arm/plat-omap/include/plat/powerdomain.h
+++ b/arch/arm/plat-omap/include/plat/powerdomain.h
@@ -114,8 +114,6 @@ struct powerdomain {
 
 void pwrdm_init(struct powerdomain **pwrdm_list);
 
-int pwrdm_register(struct powerdomain *pwrdm);
-int pwrdm_unregister(struct powerdomain *pwrdm);
 struct powerdomain *pwrdm_lookup(const char *name);
 
 int pwrdm_for_each(int (*fn)(struct powerdomain *pwrdm, void *user),


