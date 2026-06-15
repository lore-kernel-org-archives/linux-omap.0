Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA33C3B6370
	for <linux-omap@vger.kernel.org>; Mon, 15 Jun 2026 20:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781553948; cv=none; b=aT65vhyJfDnkf6NSQn7wyUouaipesVT2vY0K7orRuBLd0+MKpJUDRm8WKwqlrmeFofx4AwrnuV+3+SP851JZCTPjTTWvM83kz9jjDMPTkG9lk2ydwKFFMhnCM8fpIaV+ykBJEuPwcF++h1WQ0q2DI0Uodj6A+LeDoTT4NKGquZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781553948; c=relaxed/simple;
	bh=9axWdOaIkqRMNU09y6jTxTgTHkd+mvEHBlnY8k5td8g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JbWa44m05pbQCmjFpROG61EoVqY2cwVbgBznQbgYirh56u4imwI4r7OwVqqnFh1S58ViG40KuQT+YBO1hWRGo11PpzAWIhRhT+8KDiFfx5u9kUgRXzsZpyt0ajzNN3pc2FlBYavSj3swPz5euEKRH7RJ5FsFqtJWGu/wX6zBUl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/52TFUT; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/52TFUT"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5176465a4a4so55895791cf.2
        for <linux-omap@vger.kernel.org>; Mon, 15 Jun 2026 13:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781553946; x=1782158746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VzFm9TsiOk5XpcZicvYi+kCCpGBya7QC/I+a6kV9QxQ=;
        b=J/52TFUTSjZ1OaMKqiw63vYeykYd9Gzt+7rI1QUNG1AOEiL/zxXVEMxYaFdLzZm5sl
         CJsBnOjUw6OcuLpfUH+avTlsKZl2HdGD1ng/7F+fEM/spPRGV9m6mse3L6Uy6buqV4wo
         fw44E1OXz7jq2Op56LwBG0h9dqhs2m0jKIwolBq2WZhNZLCdEEh/610SfzghsCJ29sVo
         ZlCxeDtf2tG6nTL/I2SWs78ydxE9ikWVUuFrRSzvngBmRO9At1cAtykCiYsrWYujlsWK
         rPEBuT294wjLFGmNE86ZheI2RE+3d8OUUwMVOhc1lA3zv32hLQbrJB0oS0THx0wvD4jC
         2z2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781553946; x=1782158746;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VzFm9TsiOk5XpcZicvYi+kCCpGBya7QC/I+a6kV9QxQ=;
        b=nJmO1MtHEu7qR2itU0P6koYWP6hgj7auSGSU1PRTxPuJt+SzRbs2Ua0ZBDRT9Iv40O
         X5WFtOMe2QNAT3dniPEB9AeP9ooS5GBjmXppwiHCrRUo9T0Yb4q8vKulWmw83HWfBxsR
         WeN0fxGjK8A+dfiu1mYABRhXLOuHWArSF0phDQFjyE/D6ASaYb9VvMSYiLrHEBNKXQk3
         O6D7rDfQGv55pcLc6BuGgTXzvTg0aTa6YAhmEhB9wB0MTwdoWjAuYqJ2m/fDuJaYRwUI
         we3vsKYzrK1ljS2tAtapVK3kdz7WGeC4cCoKM0CteaVhGQoCVTwgz5lTp0O8b5GTPaw1
         DcyQ==
X-Gm-Message-State: AOJu0YxApYV9hS3htPes3uLTTIf8WP47pAMIXOnC7TbxuQJYApd9kEtZ
	mvFFXcSJzd+Ing9qKiO4i7oOFRWe3E13w5WWS4eT6UlViwkd0FQt2s8d
X-Gm-Gg: Acq92OEf+mng9KnGM5PZMJWb1Yr591jA4wkQusmsFbREPtk776DvOzy+6FcMwwwZJWH
	hGi4vAYAn5NbLZ7vmdAUBMvuQUNswYO3zV+veELb2c4KOmwDZkAsOkoJBuRmeraX3xbttbvCeUN
	Nrfk8EjNTBOVbuTd06mod6MFXQv33I2E+SbOd0f/i0ebhBDx7Ckdi9gZzSnn8kWv7saNOfMysrH
	9OmSAzwQov/Rg2G3wLovvysv5DI1W/nNVNRDAz4bFwmoqB4H15l65KTG1+9XQ5Jh5q+CRZ9gK9J
	Ne5WX/HeFzJPDsEU9wddLMUcKKyqD7YRMOU9seNAHzp1oZnxqndCWpqfBGtrsUJhJob94LmZ1v7
	DSf4KsHkn+Y4M58ChU5sZ1zLYq1Teh6bq843g87oBr88DFazr2/9KoibTfaNMtemQzLGnPMGHve
	vruKdxSkRJwTp7omI0mNseC0jH8Xp4Hb47CD+z2jQK
X-Received: by 2002:a05:622a:41ce:b0:517:7590:228e with SMTP id d75a77b69052e-51953248409mr144988601cf.0.1781553945916;
        Mon, 15 Jun 2026 13:05:45 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb63e594sm118752911cf.8.2026.06.15.13.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 13:05:45 -0700 (PDT)
From: Yuho Choi <dbgh9129@gmail.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuho Choi <dbgh9129@gmail.com>
Subject: [PATCH v1] bus: ti-sysc: Fix /chosen node reference leak
Date: Mon, 15 Jun 2026 16:05:40 -0400
Message-ID: <20260615200540.770205-1-dbgh9129@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sysc_init_stdout_path() gets the /chosen node with
of_find_node_by_path() to read stdout-path. The function then overwrites
the local node pointer with the stdout-path lookup result, or exits on
error, without dropping the /chosen reference.

Keep the /chosen node in a separate variable and put it after the
stdout-path value has been used for the lookup. The successful stdout
node lookup remains referenced by the cached stdout_path pointer.

Fixes: 3bb37c8e6e6a ("bus: ti-sysc: Handle stdout-path for debug console")
Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
---
 drivers/bus/ti-sysc.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index a5b9507de37c..e118b900c9ac 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -682,6 +682,7 @@ static struct device_node *stdout_path;
 
 static void sysc_init_stdout_path(struct sysc *ddata)
 {
+	struct device_node *chosen;
 	struct device_node *np = NULL;
 	const char *uart;
 
@@ -691,15 +692,18 @@ static void sysc_init_stdout_path(struct sysc *ddata)
 	if (stdout_path)
 		return;
 
-	np = of_find_node_by_path("/chosen");
-	if (!np)
+	chosen = of_find_node_by_path("/chosen");
+	if (!chosen)
 		goto err;
 
-	uart = of_get_property(np, "stdout-path", NULL);
-	if (!uart)
+	uart = of_get_property(chosen, "stdout-path", NULL);
+	if (!uart) {
+		of_node_put(chosen);
 		goto err;
+	}
 
 	np = of_find_node_by_path(uart);
+	of_node_put(chosen);
 	if (!np)
 		goto err;
 
-- 
2.43.0

