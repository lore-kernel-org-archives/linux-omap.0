From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v1 11/11] regulator: core: Properly handle case where supply is the couple
Date: Fri,  5 Oct 2018 18:36:38 +0300
Message-ID: <20181005153638.1886-12-digetx@gmail.com>
References: <20181005153638.1886-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181005153638.1886-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Maciej Purski <m.purski@samsung.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, Lucas Stach <l.stach@pengutronix.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Check whether supply regulator is the couple to avoid infinite recursion
during of locking.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/regulator/core.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index a3448636f334..46e816cb80b5 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -233,6 +233,21 @@ static void regulator_unlock(struct regulator_dev *rdev)
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
2.19.0
