From: Suman Anna <s-anna@ti.com>
Subject: [PATCHv6 3/5] hwspinlock/core: maintain a list of registered
 hwspinlock banks
Date: Fri, 12 Sep 2014 15:24:57 -0500
Message-ID: <1410553499-55951-4-git-send-email-s-anna@ti.com>
References: <1410553499-55951-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1410553499-55951-1-git-send-email-s-anna@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ohad Ben-Cohen <ohad@wizery.com>, Mark Rutland <mark.rutland@arm.com>, Kumar Gala <galak@codeaurora.org>
Cc: devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Josh Cartwright <joshc@codeaurora.org>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Bjorn Andersson <bjorn@kryo.se>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The hwspinlock_device structure is used for registering a bank of
locks with the driver core. The structure already contains the
necessary members to identify the bank of locks. The core does not
maintain the hwspinlock_devices itself, but maintains only a radix
tree for all the registered locks. A specific lock can be requested
by users using a global lock id, and any device-specific fields
can be retrieved through a reference to the hwspinlock_device in
each lock.

The global lock id, however, is not friendly to be requested for
users using the device-tree model. The device-tree representation
will typically have each of the hwspinlock devices represented as
a DT node, and a specific lock can be requested using the device's
phandle and a lock specifier. Add support to the core therefore to
maintain all the registered hwspinlock_devices, so that a device
can be looked up and a specific lock belonging to the device
requested through a phandle + args approach.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 Documentation/hwspinlock.txt             |  2 ++
 drivers/hwspinlock/hwspinlock_core.c     | 51 ++++++++++++++++++++++++++++++++
 drivers/hwspinlock/hwspinlock_internal.h |  2 ++
 3 files changed, 55 insertions(+)

diff --git a/Documentation/hwspinlock.txt b/Documentation/hwspinlock.txt
index 62f7d4e..640ae47 100644
--- a/Documentation/hwspinlock.txt
+++ b/Documentation/hwspinlock.txt
@@ -251,6 +251,7 @@ implementation using the hwspin_lock_register() API.
 
 /**
  * struct hwspinlock_device - a device which usually spans numerous hwspinlocks
+ * @list: list element to link hwspinlock devices together
  * @dev: underlying device, will be used to invoke runtime PM api
  * @ops: platform-specific hwspinlock handlers
  * @base_id: id index of the first lock in this device
@@ -258,6 +259,7 @@ implementation using the hwspin_lock_register() API.
  * @lock: dynamically allocated array of 'struct hwspinlock'
  */
 struct hwspinlock_device {
+	struct list_head list;
 	struct device *dev;
 	const struct hwspinlock_ops *ops;
 	int base_id;
diff --git a/drivers/hwspinlock/hwspinlock_core.c b/drivers/hwspinlock/hwspinlock_core.c
index 461a0d7..48f7866 100644
--- a/drivers/hwspinlock/hwspinlock_core.c
+++ b/drivers/hwspinlock/hwspinlock_core.c
@@ -59,6 +59,11 @@ static RADIX_TREE(hwspinlock_tree, GFP_KERNEL);
  */
 static DEFINE_MUTEX(hwspinlock_tree_lock);
 
+/*
+ * A linked list for maintaining all the registered hwspinlock devices.
+ * The list is maintained in an ordered-list of the supported locks group.
+ */
+static LIST_HEAD(hwspinlock_devices);
 
 /**
  * __hwspin_trylock() - attempt to lock a specific hwspinlock
@@ -307,6 +312,40 @@ out:
 	return hwlock;
 }
 
+/*
+ * Add a new hwspinlock device to the global list, keeping the list of
+ * devices sorted by base order.
+ *
+ * Returns 0 on success, or -EBUSY if the new device overlaps with some
+ * other device's lock space.
+ */
+static int hwspinlock_device_add(struct hwspinlock_device *bank)
+{
+	struct list_head *entry = &hwspinlock_devices;
+	struct hwspinlock_device *_bank;
+	int ret = 0;
+
+	list_for_each(entry, &hwspinlock_devices) {
+		_bank = list_entry(entry, struct hwspinlock_device, list);
+		if (_bank->base_id >= bank->base_id + bank->num_locks)
+			break;
+	}
+
+	if (entry != &hwspinlock_devices &&
+	    entry->prev != &hwspinlock_devices) {
+		_bank = list_entry(entry->prev, struct hwspinlock_device, list);
+		if (_bank->base_id + _bank->num_locks > bank->base_id) {
+			dev_err(bank->dev, "hwlock space overlap, cannot add device\n");
+			ret = -EBUSY;
+		}
+	}
+
+	if (!ret)
+		list_add_tail(&bank->list, entry);
+
+	return ret;
+}
+
 /**
  * hwspin_lock_register() - register a new hw spinlock device
  * @bank: the hwspinlock device, which usually provides numerous hw locks
@@ -339,6 +378,12 @@ int hwspin_lock_register(struct hwspinlock_device *bank, struct device *dev,
 	bank->base_id = base_id;
 	bank->num_locks = num_locks;
 
+	mutex_lock(&hwspinlock_tree_lock);
+	ret = hwspinlock_device_add(bank);
+	mutex_unlock(&hwspinlock_tree_lock);
+	if (ret)
+		return ret;
+
 	for (i = 0; i < num_locks; i++) {
 		hwlock = &bank->lock[i];
 
@@ -355,6 +400,9 @@ int hwspin_lock_register(struct hwspinlock_device *bank, struct device *dev,
 reg_failed:
 	while (--i >= 0)
 		hwspin_lock_unregister_single(base_id + i);
+	mutex_lock(&hwspinlock_tree_lock);
+	list_del(&bank->list);
+	mutex_unlock(&hwspinlock_tree_lock);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(hwspin_lock_register);
@@ -386,6 +434,9 @@ int hwspin_lock_unregister(struct hwspinlock_device *bank)
 		WARN_ON(tmp != hwlock);
 	}
 
+	mutex_lock(&hwspinlock_tree_lock);
+	list_del(&bank->list);
+	mutex_unlock(&hwspinlock_tree_lock);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(hwspin_lock_unregister);
diff --git a/drivers/hwspinlock/hwspinlock_internal.h b/drivers/hwspinlock/hwspinlock_internal.h
index d26f78b..aff560c 100644
--- a/drivers/hwspinlock/hwspinlock_internal.h
+++ b/drivers/hwspinlock/hwspinlock_internal.h
@@ -53,6 +53,7 @@ struct hwspinlock {
 
 /**
  * struct hwspinlock_device - a device which usually spans numerous hwspinlocks
+ * @list: list element to link hwspinlock devices together
  * @dev: underlying device, will be used to invoke runtime PM api
  * @ops: platform-specific hwspinlock handlers
  * @base_id: id index of the first lock in this device
@@ -60,6 +61,7 @@ struct hwspinlock {
  * @lock: dynamically allocated array of 'struct hwspinlock'
  */
 struct hwspinlock_device {
+	struct list_head list;
 	struct device *dev;
 	const struct hwspinlock_ops *ops;
 	int base_id;
-- 
2.0.4
