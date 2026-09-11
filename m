Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877D33D4118
	for <linux-omap@vger.kernel.org>; Fri, 11 Sep 2026 08:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789114245; cv=none; b=RnDNbBzdEXnkfTldfDqmmd9Z3SoFIkOtu0rz3IB2Br7HfnVQOy7Sqy0vamQewGTPuawEqMtKrl549dIKqfhBFdv0MV5BdxSxnIAc0v0fxcrnN2dHfToAS8VzMGkaW9JJxZw18PpF/AwxJL6cZlQnpvQsouO4mEZpLKGVDtUKKVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789114245; c=relaxed/simple;
	bh=Hjn5D/KsOBnj/6SzCxyIYYhw+PVj8k1aY5xVPxRy8fU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q3DlABnhFcaSHMLq6M6BroyceaXLvm6oA/3RuZFLR/WLEJj/XNth15v4KYNhJGjl35UcRQ0RaQeV5H9POu6mkt32+q5lK8V1/06GzUPmOilvlsV29VgAv0rUq08Mf2EzECpAriTqSySU7rxvB6yaOprI2erTFgrBc7kyrN1sVlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZbSaRGsg; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZbSaRGsg"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38dfe7eb825so593452a91.0
        for <linux-omap@vger.kernel.org>; Fri, 11 Sep 2026 01:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789114242; x=1789719042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=u7Qx43bG49fe/sQM/Uno0+GUNPMxqPw+3RuQb5XIhZY=;
        b=ZbSaRGsg0uy8OyWI0eaD4sFkSEjXwwdqd1vAMgV7+/wRZJT1TrnYhrekDZDX7BWTv5
         CIyDUFXi+nD06MLoDz/Q6tLgw6iU2smgX9Ry+vPrwLJ9akCorBX9yo1wYNDJJUOwav9k
         mYKjdJc6f5mD1inlCWZP+fttco/RZB5/6Y9barqDg2oqZGaQbysMuRPCZj3eebMVnp1G
         GAOm6lTWuu+rkJyIe5uyzMMFilHUqvgjx4upbvCoOcl4u/hHEQeeTkUnhRIREVB/JA42
         9l5MPjh7JZOwcmNQGUSBAQ3ghqpVpj5T7McaKskg+kbMimrCVTBMEpVyhZt1QFGzjADQ
         2OsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789114242; x=1789719042;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u7Qx43bG49fe/sQM/Uno0+GUNPMxqPw+3RuQb5XIhZY=;
        b=Gfdp1x4vfkw7M2FR3fz1976M6P+hgTeowf7HPF6zdfgR5S/Pl2zOnhfylN54GiEnIM
         4yt1BwE5xgsggUowyNZ6k0cLMwMsWpc0CVv512JiWP50w2I7tSYCOfXpyDkq7bvvgG8Z
         P1xEGSkJKbMsnabPBg6gE9N09wcaPWpvVzsINULeg7hi9W3O0SSw2VUVWBCjUYT4DeGb
         Ulxf850fowAZMtWYpYnxhn/XL0V7CcEPNE1sTru6MODtvv1leeSlk8r1DlBsR6E0DT5h
         vmveKjqoI+rYcOpyOAdPundx/fPFraPGVL6rJwnH5YfwXI5PznLgaKpTVT9FXREk2bbi
         A7tA==
X-Forwarded-Encrypted: i=1; AKwUvByJGWtNsa+Gz2hja4Gl3qUkYDXJ97i6BE5FEACxDeJI2RW4PJWtYUiNjftBHNZeo624MP78MdwQSijG@vger.kernel.org
X-Gm-Message-State: AFuF++m3vEm5+LM1PeJ4bplcMxpJb1h5oR9khwyaRND8zs4JYN4+opue
	bBcNCZxlCDWvnMbgaN3DapLB0ktNS8FtlirHP7tkABvQak+F9ZOi6r0=
X-Gm-Gg: AYBFou2UR7RRWBdc+aWUHkUjF36FIxaNEz6n3kF3cr/ceqtp7egSs6Te5HNFBukE5dZ
	wxlJM8P4HmYh4hL45u1BQHQAVVLI5zQ3bUHPtG2gcxv4tSvrp7RsrXDCsG9w1W6fcy1JLIURvBp
	wyL+33+Mdjo3qbOiYkQJbIxoWaeDnoz1Pk2bAWri5hSwqufEOgzHPPYM/bN9oYvqtg9cMQ/PHSY
	O7kxj0pk6o+MOQX2BtiL093IuGjvmRvQo0Y4py+JtZbWXMnae1bC9o6I6HnoEo1rvdr60DfDCdK
	WNPteADU9X7M0kO+ORt3tO5IBfGema97UPqlRVBCMqgcoWmltJ3+2V5wyZCknE4gub1T8/X5cYN
	KND0pLk3/4EkHAXkKBbidgRJPf6/n2lAQejbAfVV+Y+ZXdQHP1B7FW17/9lKHs0tocPLz684JtG
	fxLivgm0UpVa1/NO4IEra186isKmCIX+Zh4Gi/6UI8QQOfSAfQt0e0vgbfe2AWgSVmmT5hpxK14
	lXNLKNiB3lf
X-Received: by 2002:a17:90b:3c89:b0:398:ba9e:75ff with SMTP id 98e67ed59e1d1-39d9c35047emr5120013a91.21.1789114241653;
        Fri, 11 Sep 2026 01:10:41 -0700 (PDT)
Received: from DL2XHKPB4.dl.net ([103.63.104.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d994872e0sm3514967a91.8.2026.09.11.01.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 01:10:40 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
To: Lee Jones <lee@kernel.org>
Cc: Chanwoo Choi <cw00.choi@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	mfd@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Triet Hoang <triet.hoang.dev@gmail.com>
Subject: [PATCH v2 RESEND] mfd: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Date: Fri, 11 Sep 2026 15:10:22 +0700
Message-ID: <20260911081022.3475479-1-triet.hoang.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the deprecated SIMPLE_DEV_PM_OPS() to DEFINE_SIMPLE_DEV_PM_OPS()
and pm_sleep_ptr().

This allows us to drop the __maybe_unused annotations from PM callbacks.
This is a straightforward cleanup with no functional change intended.

Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>
---
Changes in v2:
- Change commit message prefix from "drivers/mfd: " to "mfd: ".
- Wrap to 75 ish chars for commit messages.

Link to v1: https://lore.kernel.org/all/20260821092508.324787-1-triet.hoang.dev@gmail.com/
Link to v2: https://lore.kernel.org/all/20260829050228.42638-1-triet.hoang.dev@gmail.com/
---
 drivers/mfd/iqs62x.c           | 8 ++++----
 drivers/mfd/max77843.c         | 8 ++++----
 drivers/mfd/mt6360-core.c      | 8 ++++----
 drivers/mfd/rk8xx-i2c.c        | 4 ++--
 drivers/mfd/rn5t618.c          | 8 ++++----
 drivers/mfd/ti_am335x_tscadc.c | 8 ++++----
 drivers/mfd/tps6586x.c         | 8 ++++----
 drivers/mfd/twl-core.c         | 8 ++++----
 8 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/mfd/iqs62x.c b/drivers/mfd/iqs62x.c
index ee017617d1d1..bea1ebdca9e7 100644
--- a/drivers/mfd/iqs62x.c
+++ b/drivers/mfd/iqs62x.c
@@ -1015,7 +1015,7 @@ static void iqs62x_remove(struct i2c_client *client)
 	wait_for_completion(&iqs62x->fw_done);
 }
 
-static int __maybe_unused iqs62x_suspend(struct device *dev)
+static int iqs62x_suspend(struct device *dev)
 {
 	struct iqs62x_core *iqs62x = dev_get_drvdata(dev);
 	int ret;
@@ -1036,7 +1036,7 @@ static int __maybe_unused iqs62x_suspend(struct device *dev)
 				  IQS62X_PWR_SETTINGS_PWR_MODE_HALT);
 }
 
-static int __maybe_unused iqs62x_resume(struct device *dev)
+static int iqs62x_resume(struct device *dev)
 {
 	struct iqs62x_core *iqs62x = dev_get_drvdata(dev);
 	int ret;
@@ -1051,7 +1051,7 @@ static int __maybe_unused iqs62x_resume(struct device *dev)
 				  IQS62X_PWR_SETTINGS_DIS_AUTO, 0);
 }
 
-static SIMPLE_DEV_PM_OPS(iqs62x_pm, iqs62x_suspend, iqs62x_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(iqs62x_pm, iqs62x_suspend, iqs62x_resume);
 
 static const struct of_device_id iqs62x_of_match[] = {
 	{ .compatible = "azoteq,iqs620a" },
@@ -1067,7 +1067,7 @@ static struct i2c_driver iqs62x_i2c_driver = {
 	.driver = {
 		.name = "iqs62x",
 		.of_match_table = iqs62x_of_match,
-		.pm = &iqs62x_pm,
+		.pm = pm_sleep_ptr(&iqs62x_pm),
 	},
 	.probe = iqs62x_probe,
 	.remove = iqs62x_remove,
diff --git a/drivers/mfd/max77843.c b/drivers/mfd/max77843.c
index 2a48577b1a79..9ae6715642ae 100644
--- a/drivers/mfd/max77843.c
+++ b/drivers/mfd/max77843.c
@@ -173,7 +173,7 @@ static const struct i2c_device_id max77843_id[] = {
 	{ },
 };
 
-static int __maybe_unused max77843_suspend(struct device *dev)
+static int max77843_suspend(struct device *dev)
 {
 	struct i2c_client *i2c = to_i2c_client(dev);
 	struct max77693_dev *max77843 = i2c_get_clientdata(i2c);
@@ -185,7 +185,7 @@ static int __maybe_unused max77843_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused max77843_resume(struct device *dev)
+static int max77843_resume(struct device *dev)
 {
 	struct i2c_client *i2c = to_i2c_client(dev);
 	struct max77693_dev *max77843 = i2c_get_clientdata(i2c);
@@ -197,12 +197,12 @@ static int __maybe_unused max77843_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(max77843_pm, max77843_suspend, max77843_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(max77843_pm, max77843_suspend, max77843_resume);
 
 static struct i2c_driver max77843_i2c_driver = {
 	.driver	= {
 		.name = "max77843",
-		.pm = &max77843_pm,
+		.pm = pm_sleep_ptr(&max77843_pm),
 		.of_match_table = max77843_dt_match,
 		.suppress_bind_attrs = true,
 	},
diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
index b9b1036c8ff4..8a97c30cad3f 100644
--- a/drivers/mfd/mt6360-core.c
+++ b/drivers/mfd/mt6360-core.c
@@ -583,7 +583,7 @@ static int mt6360_probe(struct i2c_client *client)
 	return 0;
 }
 
-static int __maybe_unused mt6360_suspend(struct device *dev)
+static int mt6360_suspend(struct device *dev)
 {
 	struct i2c_client *i2c = to_i2c_client(dev);
 
@@ -593,7 +593,7 @@ static int __maybe_unused mt6360_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused mt6360_resume(struct device *dev)
+static int mt6360_resume(struct device *dev)
 {
 
 	struct i2c_client *i2c = to_i2c_client(dev);
@@ -604,7 +604,7 @@ static int __maybe_unused mt6360_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(mt6360_pm_ops, mt6360_suspend, mt6360_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(mt6360_pm_ops, mt6360_suspend, mt6360_resume);
 
 static const struct of_device_id __maybe_unused mt6360_of_id[] = {
 	{ .compatible = "mediatek,mt6360", },
@@ -615,7 +615,7 @@ MODULE_DEVICE_TABLE(of, mt6360_of_id);
 static struct i2c_driver mt6360_driver = {
 	.driver = {
 		.name = "mt6360",
-		.pm = &mt6360_pm_ops,
+		.pm = pm_sleep_ptr(&mt6360_pm_ops),
 		.of_match_table = of_match_ptr(mt6360_of_id),
 	},
 	.probe = mt6360_probe,
diff --git a/drivers/mfd/rk8xx-i2c.c b/drivers/mfd/rk8xx-i2c.c
index 2951b2911a37..161b25fbe146 100644
--- a/drivers/mfd/rk8xx-i2c.c
+++ b/drivers/mfd/rk8xx-i2c.c
@@ -251,7 +251,7 @@ static void rk8xx_i2c_shutdown(struct i2c_client *client)
 	rk8xx_shutdown(&client->dev);
 }
 
-static SIMPLE_DEV_PM_OPS(rk8xx_i2c_pm_ops, rk8xx_suspend, rk8xx_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(rk8xx_i2c_pm_ops, rk8xx_suspend, rk8xx_resume);
 
 static const struct of_device_id rk8xx_i2c_of_match[] = {
 	{ .compatible = "rockchip,rk801", .data = &rk801_data },
@@ -270,7 +270,7 @@ static struct i2c_driver rk8xx_i2c_driver = {
 	.driver = {
 		.name = "rk8xx-i2c",
 		.of_match_table = rk8xx_i2c_of_match,
-		.pm = &rk8xx_i2c_pm_ops,
+		.pm = pm_sleep_ptr(&rk8xx_i2c_pm_ops),
 	},
 	.probe = rk8xx_i2c_probe,
 	.shutdown  = rk8xx_i2c_shutdown,
diff --git a/drivers/mfd/rn5t618.c b/drivers/mfd/rn5t618.c
index 23ca00d2c624..8c68dd16bb9e 100644
--- a/drivers/mfd/rn5t618.c
+++ b/drivers/mfd/rn5t618.c
@@ -243,7 +243,7 @@ static void rn5t618_i2c_remove(struct i2c_client *i2c)
 	unregister_restart_handler(&rn5t618_restart_handler);
 }
 
-static int __maybe_unused rn5t618_i2c_suspend(struct device *dev)
+static int rn5t618_i2c_suspend(struct device *dev)
 {
 	struct rn5t618 *priv = dev_get_drvdata(dev);
 
@@ -253,7 +253,7 @@ static int __maybe_unused rn5t618_i2c_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused rn5t618_i2c_resume(struct device *dev)
+static int rn5t618_i2c_resume(struct device *dev)
 {
 	struct rn5t618 *priv = dev_get_drvdata(dev);
 
@@ -263,7 +263,7 @@ static int __maybe_unused rn5t618_i2c_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(rn5t618_i2c_dev_pm_ops,
+static DEFINE_SIMPLE_DEV_PM_OPS(rn5t618_i2c_dev_pm_ops,
 			rn5t618_i2c_suspend,
 			rn5t618_i2c_resume);
 
@@ -271,7 +271,7 @@ static struct i2c_driver rn5t618_i2c_driver = {
 	.driver = {
 		.name = "rn5t618",
 		.of_match_table = rn5t618_of_match,
-		.pm = &rn5t618_i2c_dev_pm_ops,
+		.pm = pm_sleep_ptr(&rn5t618_i2c_dev_pm_ops),
 	},
 	.probe = rn5t618_i2c_probe,
 	.remove = rn5t618_i2c_remove,
diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index 068c25401c6c..81f07a1d780c 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -313,7 +313,7 @@ static int __maybe_unused ti_tscadc_can_wakeup(struct device *dev, void *data)
 	return device_may_wakeup(dev);
 }
 
-static int __maybe_unused tscadc_suspend(struct device *dev)
+static int tscadc_suspend(struct device *dev)
 {
 	struct ti_tscadc_dev *tscadc = dev_get_drvdata(dev);
 
@@ -331,7 +331,7 @@ static int __maybe_unused tscadc_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused tscadc_resume(struct device *dev)
+static int tscadc_resume(struct device *dev)
 {
 	struct ti_tscadc_dev *tscadc = dev_get_drvdata(dev);
 
@@ -345,7 +345,7 @@ static int __maybe_unused tscadc_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(tscadc_pm_ops, tscadc_suspend, tscadc_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(tscadc_pm_ops, tscadc_suspend, tscadc_resume);
 
 static const struct ti_tscadc_data tscdata = {
 	.adc_feature_name = "TI-am335x-adc",
@@ -373,7 +373,7 @@ MODULE_DEVICE_TABLE(of, ti_tscadc_dt_ids);
 static struct platform_driver ti_tscadc_driver = {
 	.driver = {
 		.name   = "ti_am3359-tscadc",
-		.pm	= &tscadc_pm_ops,
+		.pm	= pm_sleep_ptr(&tscadc_pm_ops),
 		.of_match_table = ti_tscadc_dt_ids,
 	},
 	.probe	= ti_tscadc_probe,
diff --git a/drivers/mfd/tps6586x.c b/drivers/mfd/tps6586x.c
index 3cfd2f02b62f..600186b1e8cb 100644
--- a/drivers/mfd/tps6586x.c
+++ b/drivers/mfd/tps6586x.c
@@ -618,7 +618,7 @@ static void tps6586x_i2c_remove(struct i2c_client *client)
 		free_irq(client->irq, tps6586x);
 }
 
-static int __maybe_unused tps6586x_i2c_suspend(struct device *dev)
+static int tps6586x_i2c_suspend(struct device *dev)
 {
 	struct tps6586x *tps6586x = dev_get_drvdata(dev);
 
@@ -628,7 +628,7 @@ static int __maybe_unused tps6586x_i2c_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused tps6586x_i2c_resume(struct device *dev)
+static int tps6586x_i2c_resume(struct device *dev)
 {
 	struct tps6586x *tps6586x = dev_get_drvdata(dev);
 
@@ -638,7 +638,7 @@ static int __maybe_unused tps6586x_i2c_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(tps6586x_pm_ops, tps6586x_i2c_suspend,
+static DEFINE_SIMPLE_DEV_PM_OPS(tps6586x_pm_ops, tps6586x_i2c_suspend,
 			 tps6586x_i2c_resume);
 
 static const struct i2c_device_id tps6586x_id_table[] = {
@@ -651,7 +651,7 @@ static struct i2c_driver tps6586x_driver = {
 	.driver	= {
 		.name	= "tps6586x",
 		.of_match_table = of_match_ptr(tps6586x_of_match),
-		.pm	= &tps6586x_pm_ops,
+		.pm	= pm_sleep_ptr(&tps6586x_pm_ops),
 	},
 	.probe		= tps6586x_i2c_probe,
 	.remove		= tps6586x_i2c_remove,
diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index c024a28b057e..b7d749208131 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -903,7 +903,7 @@ twl_probe(struct i2c_client *client)
 	return status;
 }
 
-static int __maybe_unused twl_suspend(struct device *dev)
+static int twl_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 
@@ -913,7 +913,7 @@ static int __maybe_unused twl_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused twl_resume(struct device *dev)
+static int twl_resume(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 
@@ -923,7 +923,7 @@ static int __maybe_unused twl_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(twl_dev_pm_ops, twl_suspend, twl_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(twl_dev_pm_ops, twl_suspend, twl_resume);
 
 static const struct i2c_device_id twl_ids[] = {
 	{ "twl4030", TWL4030_VAUX2 },	/* "Triton 2" */
@@ -942,7 +942,7 @@ static const struct i2c_device_id twl_ids[] = {
 /* One Client Driver , 4 Clients */
 static struct i2c_driver twl_driver = {
 	.driver.name	= DRIVER_NAME,
-	.driver.pm	= &twl_dev_pm_ops,
+	.driver.pm	= pm_sleep_ptr(&twl_dev_pm_ops),
 	.id_table	= twl_ids,
 	.probe		= twl_probe,
 	.remove		= twl_remove,
-- 
2.53.0

