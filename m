From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v1 09/11] regulator: core: Decouple regulators on regulator_unregister()
Date: Fri,  5 Oct 2018 18:36:36 +0300
Message-ID: <20181005153638.1886-10-digetx@gmail.com>
References: <20181005153638.1886-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181005153638.1886-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Maciej Purski <m.purski@samsung.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, Lucas Stach <l.stach@pengutronix.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Regulators shall be uncoupled if one of the couples disappear.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/regulator/core.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index ba03bdf3716f..783ec9c74104 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -4518,6 +4518,43 @@ static void regulator_resolve_coupling(struct regulator_dev *rdev)
 	}
 }
 
+static void regulator_remove_coupling(struct regulator_dev *rdev)
+{
+	struct coupling_desc *__c_desc, *c_desc = &rdev->coupling_desc;
+	struct regulator_dev *__c_rdev, *c_rdev;
+	unsigned int __n_coupled, n_coupled;
+	int i, k;
+
+	n_coupled = c_desc->n_coupled;
+
+	for (i = 1; i < n_coupled; i++) {
+		c_rdev = c_desc->coupled_rdevs[i];
+
+		if (!c_rdev)
+			continue;
+
+		regulator_lock(c_rdev);
+
+		__c_desc = &c_rdev->coupling_desc;
+		__n_coupled = __c_desc->n_coupled;
+
+		for (k = 1; k < __n_coupled; k++) {
+			__c_rdev = __c_desc->coupled_rdevs[k];
+
+			if (__c_rdev == rdev) {
+				__c_desc->coupled_rdevs[k] = NULL;
+				__c_desc->n_resolved--;
+				break;
+			}
+		}
+
+		regulator_unlock(c_rdev);
+
+		c_desc->coupled_rdevs[i] = NULL;
+		c_desc->n_resolved--;
+	}
+}
+
 static int regulator_init_coupling(struct regulator_dev *rdev)
 {
 	int n_phandles;
@@ -4776,6 +4813,7 @@ void regulator_unregister(struct regulator_dev *rdev)
 	debugfs_remove_recursive(rdev->debugfs);
 	flush_work(&rdev->disable_work.work);
 	WARN_ON(rdev->open_count);
+	regulator_remove_coupling(rdev);
 	unset_regulator_supplies(rdev);
 	list_del(&rdev->list);
 	regulator_ena_gpio_free(rdev);
-- 
2.19.0
