Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBCE2868A9
	for <linux-omap@vger.kernel.org>; Wed, 13 May 2026 16:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778688497; cv=none; b=bED7H9NABMcmp7mXzQ2tdBLJ/Hxlxv++CRw8n6RFn1i2Gnfmh499ZS/8Tve8oix0oxAxa8lfcMKBrf+UjyV5dyqKvCJ+qLpGZcRiN7itcqv/qkai99uRojraH+cMYOPC53tjhfnisSz1qmuHJBQ9A1bFF/qX0lNaOjImngFJXX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778688497; c=relaxed/simple;
	bh=xXvYTOvzNy7ZmR6fVy1PsfeWHlINhdne2EWweRgwP90=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A9gx4y/PdurRPA4N23I6ktCJIUckr7/kgRegXHMRDhRgevTGIUKqeKA4/lQh4iSg3B/GgKfE63luDNfakTc06MpcxwTlz5DMyXEHAiIj0Qb4xSzvRvsWgdf099RYEJ9zIGnpkgm+aou5o1fMQl4LKMH53dGKPWes90VM1u4ofpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=dHNTI6Iz; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="dHNTI6Iz"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20260513160810bbdd1a912d0002078e
        for <linux-omap@vger.kernel.org>;
        Wed, 13 May 2026 18:08:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=3uz3F6TBt6f2VFmsMJA9C0gI/MCYLVF6onIiW0p2hjY=;
 b=dHNTI6IzBXS7S5LUTFpD8YBcsJxSaWBmrusL6LLJ++64KEQVQk69SqGXAkEIHLfEkWdCYj
 /1NSIf+MYQI14aiOEQQ6kcKMwmop5ZjIrb4PkXgj7erb7/GjS+VMaIuyto5auGHgX5AnOAQ5
 jTplgIetlvgT3gy+Y702TlPV87bzQ8HyAPoeyazUBI+ejFzYDGCfqooCAv3bDmGdOFx2nH+Z
 UBQkUWUvzdzlJG05j8GFODvcX9qNEqggbidguNSvbVijO7PoBYg7K5e7D551F14dpZk139RG
 cLzpOIpFzS8wwDua8SI9anA9s03QgUI+JV06gbOBeg2mAcn4pkTf58fw==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Shree Ramamoorthy <s-ramamoorthy@ti.com>,
	Francesco Dolcini <francesco@dolcini.it>,
	Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH] regulator: tps65219: fix irq_data.rdev not being assigned
Date: Wed, 13 May 2026 18:07:04 +0200
Message-ID: <20260513160706.1096845-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

Commit 64a6b577490c ("regulator: tps65219: Remove debugging helper
function") removed the tps65219_get_rdev_by_name() helper along with
the irq_data.rdev assignment that depended on it. This left
irq_data.rdev uninitialized for all IRQs, causing undefined behavior
when regulator_notifier_call_chain() is called from the IRQ handler:

  Internal error: Oops: 0000000096000004
  pc : regulator_notifier_call_chain
  lr : tps65219_regulator_irq_handler
  Call trace:
   regulator_notifier_call_chain
   tps65219_regulator_irq_handler
   handle_nested_irq
   regmap_irq_thread
   irq_thread_fn
   irq_thread
   kthread
   ret_from_fork

Instead of restoring a dedicated lookup array, restructure the probe
function to combine regulator registration with IRQ registration in
the same loop. This way the rdev returned by devm_regulator_register()
is naturally available for assigning to irq_data.rdev without any
auxiliary data structure.

Non-regulator IRQs (SENSOR, TIMEOUT) that don't correspond to any
registered regulator are registered with rdev=NULL, and the IRQ handler
is protected with a NULL check to avoid crashing.

Link: https://lore.kernel.org/all/aBDSTxALaOc-PD7X@gaggiata.pivistrello.it/
Fixes: 64a6b577490c ("regulator: tps65219: Remove debugging helper function")
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
 drivers/regulator/tps65219-regulator.c | 135 +++++++++++++++++--------
 1 file changed, 95 insertions(+), 40 deletions(-)

diff --git a/drivers/regulator/tps65219-regulator.c b/drivers/regulator/tps65219-regulator.c
index d77ca486879fd..324c3a33af8a4 100644
--- a/drivers/regulator/tps65219-regulator.c
+++ b/drivers/regulator/tps65219-regulator.c
@@ -346,8 +346,9 @@ static irqreturn_t tps65219_regulator_irq_handler(int irq, void *data)
 		return IRQ_HANDLED;
 	}
 
-	regulator_notifier_call_chain(irq_data->rdev,
-				      irq_data->type->event, NULL);
+	if (irq_data->rdev)
+		regulator_notifier_call_chain(irq_data->rdev,
+					      irq_data->type->event, NULL);
 
 	dev_err(irq_data->dev, "Error IRQ trap %s for %s\n",
 		irq_data->type->event_name, irq_data->type->regulator_name);
@@ -398,14 +399,65 @@ static struct tps65219_chip_data chip_info_table[] = {
 	},
 };
 
-static int tps65219_regulator_probe(struct platform_device *pdev)
+static bool tps65219_is_regulator_name(const struct tps65219_chip_data *pmic,
+				       const char *name)
+{
+	int i;
+
+	for (i = 0; i < pmic->common_rdesc_size; i++)
+		if (!strcmp(pmic->common_rdesc[i].name, name))
+			return true;
+	for (i = 0; i < pmic->rdesc_size; i++)
+		if (!strcmp(pmic->rdesc[i].name, name))
+			return true;
+	return false;
+}
+
+static int tps65219_register_irqs(struct platform_device *pdev,
+				  struct tps65219 *tps,
+				  struct regulator_dev *rdev,
+				  struct tps65219_regulator_irq_type *irq_types,
+				  int nirqs,
+				  const char *regulator_name)
 {
 	struct tps65219_regulator_irq_data *irq_data;
+	int i, irq, error;
+
+	for (i = 0; i < nirqs; i++) {
+		if (strcmp(irq_types[i].regulator_name, regulator_name))
+			continue;
+
+		irq = platform_get_irq_byname(pdev, irq_types[i].irq_name);
+		if (irq < 0)
+			return -EINVAL;
+
+		irq_data = devm_kmalloc(tps->dev, sizeof(*irq_data), GFP_KERNEL);
+		if (!irq_data)
+			return -ENOMEM;
+
+		irq_data->dev = tps->dev;
+		irq_data->type = &irq_types[i];
+		irq_data->rdev = rdev;
+
+		error = devm_request_threaded_irq(tps->dev, irq, NULL,
+						  tps65219_regulator_irq_handler,
+						  IRQF_ONESHOT,
+						  irq_types[i].irq_name,
+						  irq_data);
+		if (error)
+			return dev_err_probe(tps->dev, error,
+					     "Failed to request %s IRQ %d\n",
+					     irq_types[i].irq_name, irq);
+	}
+	return 0;
+}
+
+static int tps65219_regulator_probe(struct platform_device *pdev)
+{
 	struct tps65219_regulator_irq_type *irq_type;
 	struct tps65219_chip_data *pmic;
 	struct regulator_dev *rdev;
 	int error;
-	int irq;
 	int i;
 
 	struct tps65219 *tps = dev_get_drvdata(pdev->dev.parent);
@@ -425,6 +477,19 @@ static int tps65219_regulator_probe(struct platform_device *pdev)
 			return dev_err_probe(tps->dev, PTR_ERR(rdev),
 					      "Failed to register %s regulator\n",
 					      pmic->common_rdesc[i].name);
+
+		error = tps65219_register_irqs(pdev, tps, rdev,
+					       pmic->common_irq_types,
+					       pmic->common_irq_size,
+					       pmic->common_rdesc[i].name);
+		if (error)
+			return error;
+		error = tps65219_register_irqs(pdev, tps, rdev,
+					       pmic->irq_types,
+					       pmic->dev_irq_size,
+					       pmic->common_rdesc[i].name);
+		if (error)
+			return error;
 	}
 
 	for (i = 0; i <  pmic->rdesc_size; i++) {
@@ -434,52 +499,42 @@ static int tps65219_regulator_probe(struct platform_device *pdev)
 			return dev_err_probe(tps->dev, PTR_ERR(rdev),
 					     "Failed to register %s regulator\n",
 					     pmic->rdesc[i].name);
+
+		error = tps65219_register_irqs(pdev, tps, rdev,
+					       pmic->common_irq_types,
+					       pmic->common_irq_size,
+					       pmic->rdesc[i].name);
+		if (error)
+			return error;
+		error = tps65219_register_irqs(pdev, tps, rdev,
+					       pmic->irq_types,
+					       pmic->dev_irq_size,
+					       pmic->rdesc[i].name);
+		if (error)
+			return error;
 	}
 
+	/* Register non-regulator IRQs (TIMEOUT, SENSOR) with rdev=NULL */
 	for (i = 0; i < pmic->common_irq_size; ++i) {
 		irq_type = &pmic->common_irq_types[i];
-		irq = platform_get_irq_byname(pdev, irq_type->irq_name);
-		if (irq < 0)
-			return -EINVAL;
-
-		irq_data = devm_kmalloc(tps->dev, sizeof(*irq_data), GFP_KERNEL);
-		if (!irq_data)
-			return -ENOMEM;
-
-		irq_data->dev = tps->dev;
-		irq_data->type = irq_type;
-		error = devm_request_threaded_irq(tps->dev, irq, NULL,
-						  tps65219_regulator_irq_handler,
-						  IRQF_ONESHOT,
-						  irq_type->irq_name,
-						  irq_data);
+		if (tps65219_is_regulator_name(pmic, irq_type->regulator_name))
+			continue;
+		error = tps65219_register_irqs(pdev, tps, NULL,
+					       irq_type, 1,
+					       irq_type->regulator_name);
 		if (error)
-			return dev_err_probe(tps->dev, error,
-					     "Failed to request %s IRQ %d\n",
-					     irq_type->irq_name, irq);
+			return error;
 	}
 
 	for (i = 0; i < pmic->dev_irq_size; ++i) {
 		irq_type = &pmic->irq_types[i];
-		irq = platform_get_irq_byname(pdev, irq_type->irq_name);
-		if (irq < 0)
-			return -EINVAL;
-
-		irq_data = devm_kmalloc(tps->dev, sizeof(*irq_data), GFP_KERNEL);
-		if (!irq_data)
-			return -ENOMEM;
-
-		irq_data->dev = tps->dev;
-		irq_data->type = irq_type;
-		error = devm_request_threaded_irq(tps->dev, irq, NULL,
-						  tps65219_regulator_irq_handler,
-						  IRQF_ONESHOT,
-						  irq_type->irq_name,
-						  irq_data);
+		if (tps65219_is_regulator_name(pmic, irq_type->regulator_name))
+			continue;
+		error = tps65219_register_irqs(pdev, tps, NULL,
+					       irq_type, 1,
+					       irq_type->regulator_name);
 		if (error)
-			return dev_err_probe(tps->dev, error,
-					     "Failed to request %s IRQ %d\n",
-					     irq_type->irq_name, irq);
+			return error;
 	}
 
 	return 0;
-- 
2.52.0

