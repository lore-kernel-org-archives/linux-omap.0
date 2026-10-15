Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE977412BF3
	for <linux-omap@vger.kernel.org>; Thu, 15 Oct 2026 10:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792059828; cv=none; b=GOsB/V/WR47RpRVUBevdwlgI8gEv1isFyVhASDk9YsqYTrnUuvnPMpmvFi4Rq1SdoRRVznMVS4TZGNzXeacuQN6rNfjDsSGFgBs5IiHw91bwK9qVb1JPweyHnLMDi+j0KRNuW48+H5nSJLf63f5vc8Olc0y+jGqwqxrgM65PoNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792059828; c=relaxed/simple;
	bh=2mZK2ZGotEARFWTHG636eo19/tYUBtXMmGNm1GwyEfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VY3+poHgvJtEgF9t/kA9CmI7ovSk8NSB/sxNdgXHDZH0SSMepr4krzwc7DFxWrFKkPV+MoCzRpw9pG+99KUBW3UWVSHeO9xzEmgPzvY/kp3YN7zzxzJilGMoYeWpmbSN1GV9p0CrYy8hNx+PZQfyvDvuetsr08dhHK7lc/87nOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dbRbe2Zy; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbRbe2Zy"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48df8fe8513so193283f8f.0
        for <linux-omap@vger.kernel.org>; Thu, 15 Oct 2026 03:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792059825; x=1792664625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=80gvmjFzYYUW2PKFCzsQYCTYe0k3yn4h1BOFa26pPsA=;
        b=dbRbe2Zy/mD8zzudxgXoVsd/DveG0kHWEkOINZ6/5SBMxBXPvRRcuJ8ZB0dSa+NJ5b
         54bwp2DtH9lo6UR5wxk+EnQeCPq6Z8fy4wLi3nUTdHRs5Kxrv9I4hGaMhkJHcIbB7VLQ
         p4P43bYl/kYlNkf7F9mKCVnreZgSk7UJ0tQuukJ0e6HAFZIzMErCxzViYC4MfXsjn+pH
         PV0an3WxwK3Umzq8ae0e6ibdRJ8LgpzmPJo0CHPk2KahQGOjPa7GENOaUBNruoNzerTP
         gpleihA4mBk+A+1EvdMocVfRPstpps8psoXsn40CUCuWmEKht632sWBkbi+CzY5T/AXz
         J6xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792059825; x=1792664625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=80gvmjFzYYUW2PKFCzsQYCTYe0k3yn4h1BOFa26pPsA=;
        b=b2zKDsacUroX5xxFGB/23mOACs32ksp1M1r3JkNXYyR8ZEpi77Lc4w4eR2iUKxSLt0
         gxphMRBdJUkN6F3zmF0pwg+XnCSOy09Eem+mEHYX3vHAgNlRlX1dJ0KwHdYue2i6zASm
         CWhSBLH+QHQD68p8aE1ru55muGgFY0wYdYajUNfvlg4/tU/o11VUY+PfXuCVHWfmw0es
         +7NmywlJ386NllVCURABaRCJcPzEx/2EG8WxfKf25Rr4Joi9lW+wfYvA2Haprv+NNc0s
         MgEsV4Rn5QBpqwVdvRvmSQe5QBZ4FQ5VJWHAwctVMTp/iEs54ClHONslbV+Nn/gN4OyE
         Aj7A==
X-Gm-Message-State: AFq9FYKIGXEZNkDyxHL3joCEeIVKzHkVSnmruqNeZkj3Q59vmsaDEGPU
	tFruml4Am4ye7znUVtBJ615FCMepr6VkceD05ivqhNY9gNVHmtM/bK6z
X-Gm-Gg: AYBFou1FHUhOGa9o9yjy7s/cMlFb6OSVwBrXWotdrfSso57TpeCrIsRS3quDcIXl0sb
	uhK7Ovwlpu9sp4/7+dgOzFqV1oeddZSYe4xIjb1XfxhagGeou0lSH5HZk8n/krkGZ1enEW82d+H
	slzFPzNE5a02wnM96mvS/GjoYwmUi3Jxc5+zQhlGlWJd47C7V/xLeLse63Lh1dn5+WGS9u6AXgo
	WUnpX+z0LEojh/eGxHppPE8/1BSVBpynor4hSxbLnY5kYgc/pBIfcv4TRP/JffeH2wmsVMnD5VI
	FaRpod1G5CY3wnYaGhqhL4o6CLLCdHBRSDfwDC9Y2YirGpSqOva7NoIiv8Vlb/pIvRo9rXXWFr5
	defhNAehds+Er1kq5RARDSgZYcSjJMit+fNp+VFyiSZJUbqvfL368HndPnDquxnuTbKuwcQzcq9
	g+Z7Wwohsf4fhZn8jgmorhDBTDhMftXTip2nHACKcwhWkwvg82bJJ50qeJV+KQdQLv5+BoZXj6h
	33Zwc6WjH/aif6IyCE=
X-Received: by 2002:a05:6000:220b:b0:488:8ad2:e169 with SMTP id ffacd0b85a97d-48dbacf039cmr33593925f8f.56.1792059825131;
        Thu, 15 Oct 2026 03:23:45 -0700 (PDT)
Received: from xeon ([188.163.112.62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0ab6361sm14952542f8f.32.2026.10.15.03.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 03:23:44 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Lee Jones <lee@kernel.org>,
	Dmitry Osipenko <digetx@gmail.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-omap@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] mfd: tps65910: Use devm_register_power_off_handler()
Date: Thu, 15 Oct 2026 13:23:19 +0300
Message-ID: <20261015102320.23760-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015102320.23760-1-clamor95@gmail.com>
References: <20261015102320.23760-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dmitry Osipenko <digetx@gmail.com>

Use devm_register_power_off_handler() that replaces global pm_power_off
variable and allows to register multiple power-off handlers.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/mfd/tps65910.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/tps65910.c b/drivers/mfd/tps65910.c
index 6243b66b1b6f2..18b76359046b8 100644
--- a/drivers/mfd/tps65910.c
+++ b/drivers/mfd/tps65910.c
@@ -16,6 +16,7 @@
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
 #include <linux/mfd/core.h>
+#include <linux/reboot.h>
 #include <linux/regmap.h>
 #include <linux/mfd/tps65910.h>
 #include <linux/of.h>
@@ -425,9 +426,9 @@ struct tps65910_board *tps65910_parse_dt(struct i2c_client *client,
 }
 #endif
 
-static struct i2c_client *tps65910_i2c_client;
-static void tps65910_power_off(void)
+static int tps65910_power_off(struct sys_off_data *data)
 {
+	struct i2c_client *tps65910_i2c_client = data->cb_data;
 	struct tps65910 *tps65910;
 
 	tps65910 = dev_get_drvdata(&tps65910_i2c_client->dev);
@@ -435,6 +436,8 @@ static void tps65910_power_off(void)
 	regmap_update_bits(tps65910->regmap, TPS65910_DEVCTRL,
 			   DEVCTRL_DEV_OFF_MASK | DEVCTRL_DEV_ON_MASK,
 			   DEVCTRL_DEV_OFF_MASK);
+
+	return NOTIFY_DONE;
 }
 
 static int tps65910_i2c_probe(struct i2c_client *i2c)
@@ -501,7 +504,7 @@ static int tps65910_i2c_probe(struct i2c_client *i2c)
 	tps65910_ck32k_init(tps65910, pmic_plat_data);
 	tps65910_sleepinit(tps65910, pmic_plat_data);
 
-	if (pmic_plat_data->pm_off && !pm_power_off) {
+	if (pmic_plat_data->pm_off) {
 		/*
 		 * The PWR_OFF bit needs to be set separately, before
 		 * transitioning to the OFF state. It enables the "sequential"
@@ -515,8 +518,13 @@ static int tps65910_i2c_probe(struct i2c_client *i2c)
 			return ret;
 		}
 
-		tps65910_i2c_client = i2c;
-		pm_power_off = tps65910_power_off;
+		ret = devm_register_power_off_handler(&i2c->dev,
+						      tps65910_power_off, i2c);
+		if (ret) {
+			dev_err(&i2c->dev,
+				"failed to register power-off handler: %d\n", ret);
+			return ret;
+		}
 	}
 
 	ret = devm_mfd_add_devices(tps65910->dev, -1,
-- 
2.53.0

