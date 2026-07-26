Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792CD37649B
	for <linux-omap@vger.kernel.org>; Sun, 26 Jul 2026 21:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785103066; cv=none; b=svw7yCTG/JZi+8yQSZA3+abc2TykW+CyMgCW6IlqRsz8lZGQzKXuac33ErfpuL/aNLo+wWyAzbiucnrM2QaDT2LJrPUN+k7slPVgpgRxWMzcDEl318pmOMJB4770ajwJzJjnCXDRD5S2aHZ5ZmxnYy706dwveo6w3QwHZZO8kVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785103066; c=relaxed/simple;
	bh=ISbei8wuwbwd+qsDwqxaJvR+/sHMQY8pYWaHZpMoAdE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P/WmL0sM/ezcO/tUzv3ugHRCz6g+SC4HIpVfCEVb0+mqVsRusjvBRkQfcpwMEY1zg1qZiT5+ZkAMEa1GkYsE1xdPurIA7Op0O6JZENNHVieE+3disyXWKRVXvEHEIiCScMgyoIIgcZ3AitN36R83a5R22ElE8qsAVbPqs8C21xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GmQQTK04; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmQQTK04"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-382ef647e20so2066681a91.1
        for <linux-omap@vger.kernel.org>; Sun, 26 Jul 2026 14:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785103065; x=1785707865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tqWCtESQQ2bWbP4HQOrXWNhHPb+LXu076IiCVmal7Vw=;
        b=GmQQTK04Im+bO4fjyi2mpEi32fSnN7aTF9fyGlfYp9K3mqemtaeK+jMuWVI3OXUkUD
         ISEBDGxuHg4gcDDwgqULTKRCx53M2MTxuXh9QDImQdWwodgGbcT65GUpQyNtcqg/ycx/
         hUE4J3+g5jz0eHsw8D7eaGHDcTf8VQMbghOEKGdsTgN2TDAR3uDeY0R9J3rwPBAOfr/c
         xjk6kWFJUj14OCfknthbH9G0I/MwLZZRugboadUdtlaBTz8aJcN2WK9fMlTEKoDDTrBc
         Hj0yjWzZsPUuQbWuvYaPi5kp/iDVNCmFh15YwYD6kWNtWMMHIuYwa8oIMTK/DsP4aQ42
         3hTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785103065; x=1785707865;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tqWCtESQQ2bWbP4HQOrXWNhHPb+LXu076IiCVmal7Vw=;
        b=dQdxbrdtIHb749Ln7U6Fhlrsfi8y6QYOn0+iX1A8n3EoEk3v3mkKzQuCGIAXUojMU8
         BdlEkjIuM6N6JPIBqmdnL7YEW0TCbez+7UC8Hp2MPG/rA7+ihlIaeQKOlHH8jbcCEYEX
         E6L4ju8ExhPOw0Y2kVXDAI7OXVN/g9Pr/nEKOXiuYNas+uW64sGnH8sPzOalyNe6Wc1G
         V2YLxvBScQ3Un8Ckb2H7InU7QRylDXYGFkAgkvTPJ4S19GuoFjmh8DcV6m5kGkxzIjgZ
         f+f3vRUJEAL/SHFckTBSl5QQT+F6izFaUvMcUep0VEQZD3PnDrChwUXOkA64yEGq5Q/I
         0lrg==
X-Forwarded-Encrypted: i=1; AHgh+RongoqxzwG/2/TrgYvliL+1aoQzYrBga7h/EolD7s3GZebJfFykRljpSjVp9o0CJBG/QsclYp4nRZxJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwzQaRcTv7ENqlmh5elk9B4jkD2rpn2Sez0n58vkxTsPw1jYXq5
	p/lv7kcj6jzs90q96y4pX2ayC/scb2hqlCy5VH4SPZYt07983XzvaoUy
X-Gm-Gg: AR+sD13LXlOtCYzJNqzlUJPTbDKVrtSPVaZT3PWkvmVVzYlXMdn4J+oDwvjRKWE2Z8f
	m0Wwhj2NoJ5Bk008ZVn640Dsh184e+KsuOQ09ZR+PiQdn0YIhqG4pvmgwRZOdyAOML5dA2oLeTI
	WTtDp2vH8ULUiI3hFSho1pTLM48PCyGjSDNyWyOCjQ+shDsy8lYcDQkKbvNZ5qSwhGPUO377GeI
	Q8j5/e974zi+YCbtkUM6QHCy0wkV6c0uSdWIkNGp0tD0XIFNXq2CdOQA6vzBHzbX+8lDb+SudxB
	83s72eMe6blBF2railyHrqvve9yiFBvPMCqd4BxD05HcdBcfD2lN7ELaBAJEzOaJT5vATuLf+fD
	jF6NZwg3N9mo5YTFt60ikrptJOkYtwKwTPswauUZaOj9vNHke+akDWh95xlGvFIgCSY6d+tFtHU
	SNwPV+X+Qw3WIbdLh8TiexTTpgN1TfFSWag+/cOeODrb95vm7+0mFK79MMsF1I/KoMgGono45YU
	rC+MflweMVfVtjeI6PBU6Buz+OfMMtemQqglt8BY2PPY4qduoLpoT0=
X-Received: by 2002:a17:90b:53ce:b0:38d:a150:ee04 with SMTP id 98e67ed59e1d1-38f2965eb5emr5493758a91.30.1785103064721;
        Sun, 26 Jul 2026 14:57:44 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f2913c891sm2022788a91.0.2026.07.26.14.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 14:57:42 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulfh@kernel.org>,
	linux-omap@vger.kernel.org (open list:OMAP HS MMC SUPPORT),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] mmc: omap_hsmmc: use platform_get_irq_optional for wake IRQ
Date: Sun, 26 Jul 2026 14:57:40 -0700
Message-ID: <20260726215740.34574-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace irq_of_parse_and_map() with platform_get_irq_optional() to
get the wake IRQ. This is a more portable approach that works with
both DT and non-DT platforms, and follows the modern platform API
conventions for optional IRQ resources.

The wake IRQ is now fetched earlier in the probe function alongside
the main IRQ, and the -EPROBE_DEFER case is handled properly before
the deferred probe can be triggered.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/mmc/host/omap_hsmmc.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 58c881f2725b..4b5589157c59 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1764,7 +1764,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	struct mmc_host *mmc;
 	struct omap_hsmmc_host *host = NULL;
 	struct resource *res;
-	int ret, irq;
+	int ret, irq, wake_irq;
 	const struct of_device_id *match;
 	const struct omap_mmc_of_data *data;
 	void __iomem *base;
@@ -1792,6 +1792,11 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
+	wake_irq = platform_get_irq_optional(pdev, 1);
+	if (wake_irq == -EPROBE_DEFER)
+		return wake_irq;
+	wake_irq = max(wake_irq, 0);
+
 	base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
@@ -1811,6 +1816,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	host->use_dma	= 1;
 	host->dma_ch	= -1;
 	host->irq	= irq;
+	host->wake_irq	= wake_irq;
 	host->mapbase	= res->start + pdata->reg_offset;
 	host->base	= base + pdata->reg_offset;
 	host->power_mode = MMC_POWER_OFF;
@@ -1820,9 +1826,6 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, host);
 
-	if (pdev->dev.of_node)
-		host->wake_irq = irq_of_parse_and_map(pdev->dev.of_node, 1);
-
 	mmc->ops	= &omap_hsmmc_ops;
 
 	mmc->f_min = OMAP_MMC_MIN_CLOCK;
-- 
2.55.0

