From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v2 3/3] regulator: core: Keep regulators-list locked while traversing the list
Date: Mon, 19 Nov 2018 00:56:19 +0300
Message-ID: <20181118215619.21518-5-digetx@gmail.com>
References: <20181118215619.21518-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181118215619.21518-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc: linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

It's unlikely that regulators may disappear/appear while regulators
debug-summary is being prepared, but let's be consistent and avoid that
situation.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/regulator/core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index a3ab419a3aa6..7bb5bc16babf 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -4971,7 +4971,9 @@ void regulator_unregister(struct regulator_dev *rdev)
 			regulator_disable(rdev->supply);
 		regulator_put(rdev->supply);
 	}
+
 	mutex_lock(&regulator_list_mutex);
+
 	debugfs_remove_recursive(rdev->debugfs);
 	flush_work(&rdev->disable_work.work);
 	WARN_ON(rdev->open_count);
@@ -4979,8 +4981,9 @@ void regulator_unregister(struct regulator_dev *rdev)
 	unset_regulator_supplies(rdev);
 	list_del(&rdev->list);
 	regulator_ena_gpio_free(rdev);
-	mutex_unlock(&regulator_list_mutex);
 	device_unregister(&rdev->dev);
+
+	mutex_unlock(&regulator_list_mutex);
 }
 EXPORT_SYMBOL_GPL(regulator_unregister);
 
@@ -5313,6 +5316,8 @@ static void regulator_summary_lock(struct ww_acquire_ctx *ww_ctx)
 	struct regulator_dev *old_contended_rdev = NULL;
 	int err;
 
+	mutex_lock(&regulator_list_mutex);
+
 	ww_acquire_init(ww_ctx, &regulator_ww_class);
 
 	do {
@@ -5339,6 +5344,8 @@ static void regulator_summary_unlock(struct ww_acquire_ctx *ww_ctx)
 	class_for_each_device(&regulator_class, NULL, NULL,
 			      regulator_summary_unlock_one);
 	ww_acquire_fini(ww_ctx);
+
+	mutex_unlock(&regulator_list_mutex);
 }
 
 static int regulator_summary_show_roots(struct device *dev, void *data)
-- 
2.19.1
