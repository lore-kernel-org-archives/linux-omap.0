From: NeilBrown <neilb@suse.de>
Subject: [PATCH 01/15] power_supply core: support use of devres to
 register/unregister a power supply.
Date: Tue, 24 Feb 2015 15:33:50 +1100
Message-ID: <20150224043350.4243.92949.stgit@notabene.brown>
References: <20150224043341.4243.23291.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150224043341.4243.23291.stgit@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: GTA04 owners <gta04-owner@goldelico.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Using devm_power_supply_register allows the unregister to happen
automatically on error or final put.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 drivers/power/power_supply_core.c |   45 +++++++++++++++++++++++++++++++++++++
 include/linux/power_supply.h      |    4 +++
 2 files changed, 49 insertions(+)

diff --git a/drivers/power/power_supply_core.c b/drivers/power/power_supply_core.c
index 694e8cddd5c1..44c810456212 100644
--- a/drivers/power/power_supply_core.c
+++ b/drivers/power/power_supply_core.c
@@ -617,6 +617,51 @@ int power_supply_register_no_ws(struct device *parent, struct power_supply *psy)
 }
 EXPORT_SYMBOL_GPL(power_supply_register_no_ws);
 
+static void devm_power_supply_release(struct device *dev, void *res)
+{
+	struct power_supply **psy = res;
+
+	power_supply_unregister(*psy);
+}
+
+int devm_power_supply_register(struct device *parent, struct power_supply *psy)
+{
+	struct power_supply **ptr = devres_alloc(devm_power_supply_release,
+						 sizeof(*ptr), GFP_KERNEL);
+	int ret;
+
+	if (!ptr)
+		return -ENOMEM;
+	ret = __power_supply_register(parent, psy, true);
+	if (ret < 0)
+		devres_free(ptr);
+	else {
+		*ptr = psy;
+		devres_add(parent, ptr);
+	}
+	return ret;
+}
+EXPORT_SYMBOL_GPL(devm_power_supply_register);
+
+int devm_power_supply_register_no_ws(struct device *parent, struct power_supply *psy)
+{
+	struct power_supply **ptr = devres_alloc(devm_power_supply_release,
+						 sizeof(*ptr), GFP_KERNEL);
+	int ret;
+
+	if (!ptr)
+		return -ENOMEM;
+	ret = __power_supply_register(parent, psy, false);
+	if (ret < 0)
+		devres_free(ptr);
+	else {
+		*ptr = psy;
+		devres_add(parent, ptr);
+	}
+	return ret;
+}
+EXPORT_SYMBOL_GPL(devm_power_supply_register_no_ws);
+
 void power_supply_unregister(struct power_supply *psy)
 {
 	cancel_work_sync(&psy->changed_work);
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 096dbced02ac..f606d6b4bd56 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -278,6 +278,10 @@ extern int power_supply_register(struct device *parent,
 				 struct power_supply *psy);
 extern int power_supply_register_no_ws(struct device *parent,
 				 struct power_supply *psy);
+extern int devm_power_supply_register(struct device *parent,
+				 struct power_supply *psy);
+extern int devm_power_supply_register_no_ws(struct device *parent,
+				 struct power_supply *psy);
 extern void power_supply_unregister(struct power_supply *psy);
 extern int power_supply_powers(struct power_supply *psy, struct device *dev);
 
