From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v2 2/3] regulator: core: Properly handle case where supply is the couple
Date: Mon, 19 Nov 2018 00:56:18 +0300
Message-ID: <20181118215619.21518-4-digetx@gmail.com>
References: <20181118215619.21518-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181118215619.21518-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc: linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Check whether supply regulator is the couple to avoid infinite recursion
during of locking.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/regulator/core.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index c58e76a37e5f..a3ab419a3aa6 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -233,6 +233,21 @@ void regulator_unlock(struct regulator_dev *rdev)
 	mutex_unlock(&regulator_nesting_mutex);
 }
 
+static bool regulator_supply_is_couple(struct regulator_dev *rdev)
+{
+	struct regulator_dev *c_rdev;
+	int i;
+
+	for (i = 1; i < rdev->coupling_desc.n_coupled; i++) {
+		c_rdev = rdev->coupling_desc.coupled_rdevs[i];
+
+		if (rdev->supply->rdev == c_rdev)
+			return true;
+	}
+
+	return false;
+}
+
 static void regulator_unlock_recursive(struct regulator_dev *rdev,
 				       unsigned int n_coupled)
 {
@@ -245,7 +260,7 @@ static void regulator_unlock_recursive(struct regulator_dev *rdev,
 		if (!c_rdev)
 			continue;
 
-		if (c_rdev->supply)
+		if (c_rdev->supply && !regulator_supply_is_couple(c_rdev))
 			regulator_unlock_recursive(
 					c_rdev->supply->rdev,
 					c_rdev->coupling_desc.n_coupled);
@@ -283,7 +298,7 @@ static int regulator_lock_recursive(struct regulator_dev *rdev,
 			*old_contended_rdev = NULL;
 		}
 
-		if (c_rdev->supply) {
+		if (c_rdev->supply && !regulator_supply_is_couple(c_rdev)) {
 			err = regulator_lock_recursive(c_rdev->supply->rdev,
 						       new_contended_rdev,
 						       old_contended_rdev,
-- 
2.19.1
