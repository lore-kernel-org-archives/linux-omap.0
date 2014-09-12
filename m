From: Suman Anna <s-anna@ti.com>
Subject: [RFC PATCHv2 1/3] hwspinlock/core: prepare unregister code to support reserved locks
Date: Fri, 12 Sep 2014 15:56:46 -0500
Message-ID: <1410555408-56954-2-git-send-email-s-anna@ti.com>
References: <1410555408-56954-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1410555408-56954-1-git-send-email-s-anna@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>, Kumar Gala <galak@codeaurora.org>
Cc: Josh Cartwright <joshc@codeaurora.org>, Bjorn Andersson <bjorn@kryo.se>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Suman Anna <s-anna@ti.com>
List-Id: linux-omap@vger.kernel.org

Rearrange the code between hwspin_lock_unregister() and the underlying
hwspin_lock_unregister_single() functions so that the semantics are
similar to the _register_ functions. This change prepares the hwspinlock
driver core to support unregistration of reserved locks better.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/hwspinlock/hwspinlock_core.c | 37 +++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/hwspinlock/hwspinlock_core.c b/drivers/hwspinlock/hwspinlock_core.c
index 7d9f749..5fad292 100644
--- a/drivers/hwspinlock/hwspinlock_core.c
+++ b/drivers/hwspinlock/hwspinlock_core.c
@@ -409,29 +409,33 @@ out:
 	return 0;
 }
 
-static struct hwspinlock *hwspin_lock_unregister_single(unsigned int id)
+static int hwspin_lock_unregister_single(struct hwspinlock *hwlock, int id)
 {
-	struct hwspinlock *hwlock = NULL;
-	int ret;
+	struct hwspinlock *tmp = NULL;
+	int ret = 0;
 
 	mutex_lock(&hwspinlock_tree_lock);
 
 	/* make sure the hwspinlock is not in use (tag is set) */
-	ret = radix_tree_tag_get(&hwspinlock_tree, id, HWSPINLOCK_UNUSED);
-	if (ret == 0) {
+	if (!radix_tree_tag_get(&hwspinlock_tree, id, HWSPINLOCK_UNUSED)) {
 		pr_err("hwspinlock %d still in use (or not present)\n", id);
+		ret = -EBUSY;
 		goto out;
 	}
 
-	hwlock = radix_tree_delete(&hwspinlock_tree, id);
-	if (!hwlock) {
+	tmp = radix_tree_delete(&hwspinlock_tree, id);
+	if (!tmp) {
 		pr_err("failed to delete hwspinlock %d\n", id);
+		ret = -EIO;
 		goto out;
 	}
 
+	/* self-sanity check that should never fail */
+	WARN_ON(tmp != hwlock);
+
 out:
 	mutex_unlock(&hwspinlock_tree_lock);
-	return hwlock;
+	return ret;
 }
 
 /*
@@ -520,8 +524,10 @@ int hwspin_lock_register(struct hwspinlock_device *bank, struct device *dev,
 	return 0;
 
 reg_failed:
-	while (--i >= 0)
-		hwspin_lock_unregister_single(base_id + i);
+	while (--i >= 0) {
+		hwlock =  &bank->lock[i];
+		hwspin_lock_unregister_single(hwlock, base_id + i);
+	}
 	mutex_lock(&hwspinlock_tree_lock);
 	list_del(&bank->list);
 	mutex_unlock(&hwspinlock_tree_lock);
@@ -542,18 +548,15 @@ EXPORT_SYMBOL_GPL(hwspin_lock_register);
  */
 int hwspin_lock_unregister(struct hwspinlock_device *bank)
 {
-	struct hwspinlock *hwlock, *tmp;
-	int i;
+	struct hwspinlock *hwlock;
+	int i, ret;
 
 	for (i = 0; i < bank->num_locks; i++) {
 		hwlock = &bank->lock[i];
 
-		tmp = hwspin_lock_unregister_single(bank->base_id + i);
-		if (!tmp)
+		ret = hwspin_lock_unregister_single(hwlock, bank->base_id + i);
+		if (ret)
 			return -EBUSY;
-
-		/* self-sanity check that should never fail */
-		WARN_ON(tmp != hwlock);
 	}
 
 	mutex_lock(&hwspinlock_tree_lock);
-- 
2.0.4
