From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.29-rc7 regulator-next] regulator: refcount fixes
Date: Wed, 11 Mar 2009 16:43:34 -0800
Message-ID: <200903111743.34708.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp128.sbc.mail.sp1.yahoo.com ([69.147.65.187]:33904 "HELO
	smtp128.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751920AbZCLAnh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Mar 2009 20:43:37 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@sirena.org.uk>
Cc: lkml <linux-kernel@vger.kernel.org>, OMAP <linux-omap@vger.kernel.org>

From: David Brownell <dbrownell@users.sourceforge.net>

Fix some refcounting issues in the regulator framework, supporting
regulator_disable() for regulators that were enabled at boot time
via machine constraints:

 - Update those regulators' usecounts after enabling, so they
   can cleanly be disabled at that level.

 - Remove the problematic per-consumer usecount, so there's
   only one level of enable/disable.

Buggy consumers could notice different bug symptoms.  The main
example would be refcounting bugs; also, any (out-of-tree) users
of the experimental regulator_set_optimum_mode() stuff which
don't call it when they're done using a regulator.

This is a net minor codeshrink.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
Against the regulator-next tree; mainline has similar issues.

 drivers/regulator/core.c |   30 ++++++++----------------------
 1 file changed, 8 insertions(+), 22 deletions(-)

--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -52,7 +52,6 @@ struct regulator {
 	int uA_load;
 	int min_uV;
 	int max_uV;
-	int enabled; /* count of client enables */
 	char *supply_name;
 	struct device_attribute dev_attr;
 	struct regulator_dev *rdev;
@@ -811,6 +810,7 @@ static int set_machine_constraints(struc
 			rdev->constraints = NULL;
 			goto out;
 		}
+		rdev->use_count = 1;
 	}
 
 	print_constraints(rdev);
@@ -1066,10 +1066,6 @@ void regulator_put(struct regulator *reg
 	mutex_lock(&regulator_list_mutex);
 	rdev = regulator->rdev;
 
-	if (WARN(regulator->enabled, "Releasing supply %s while enabled\n",
-			       regulator->supply_name))
-		_regulator_disable(rdev);
-
 	/* remove any sysfs entries */
 	if (regulator->dev) {
 		sysfs_remove_link(&rdev->dev.kobj, regulator->supply_name);
@@ -1144,12 +1140,7 @@ int regulator_enable(struct regulator *r
 	int ret = 0;
 
 	mutex_lock(&rdev->mutex);
-	if (regulator->enabled == 0)
-		ret = _regulator_enable(rdev);
-	else if (regulator->enabled < 0)
-		ret = -EIO;
-	if (ret == 0)
-		regulator->enabled++;
+	ret = _regulator_enable(rdev);
 	mutex_unlock(&rdev->mutex);
 	return ret;
 }
@@ -1160,6 +1151,11 @@ static int _regulator_disable(struct reg
 {
 	int ret = 0;
 
+	if (WARN(rdev->use_count <= 0,
+			"unbalanced disables for %s\n",
+			rdev->desc->name))
+		return -EIO;
+
 	/* are we the last user and permitted to disable ? */
 	if (rdev->use_count == 1 && !rdev->constraints->always_on) {
 
@@ -1208,16 +1204,7 @@ int regulator_disable(struct regulator *
 	int ret = 0;
 
 	mutex_lock(&rdev->mutex);
-	if (regulator->enabled == 1) {
-		ret = _regulator_disable(rdev);
-		if (ret == 0)
-			regulator->uA_load = 0;
-	} else if (WARN(regulator->enabled <= 0,
-			"unbalanced disables for supply %s\n",
-			regulator->supply_name))
-		ret = -EIO;
-	if (ret == 0)
-		regulator->enabled--;
+	ret = _regulator_disable(rdev);
 	mutex_unlock(&rdev->mutex);
 	return ret;
 }
@@ -1264,7 +1251,6 @@ int regulator_force_disable(struct regul
 	int ret;
 
 	mutex_lock(&regulator->rdev->mutex);
-	regulator->enabled = 0;
 	regulator->uA_load = 0;
 	ret = _regulator_force_disable(regulator->rdev);
 	mutex_unlock(&regulator->rdev->mutex);
