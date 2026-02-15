Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9184730BF6C
	for <linux-omap@vger.kernel.org>; Sun, 15 Feb 2026 22:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771196124; cv=none; b=Vqmq8Q4vdrdSDfJNKUMwTBuy7AG32xAepzYbcEQZg/OQHJpwMczTMHHXn/wxdBBPZUPZUs+oRJmhbkfvBN29nxnf1Y1n5takrhIcaKtkkjcex+dEeJ3uWxzU6hB6QfdzvBr4AALl6XeoRfqSQswdFutcnp9jnsDQCvahxzHaqgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771196124; c=relaxed/simple;
	bh=ddU4wbNylHvxROfmh7fidExmdePi/u1yhM+HBZZ+Yrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FIUvxjJVH5k29EkcWa2PE3NoBGE2rQzvM6KGVknad3vhpxlzytBhmlga8Z/4blmEfqcHzaOcHfgDhQx351e0CRUmr3qpwRaZxSUUigC2Spru2553FTE0Egp3iRJM+Kv+Q3jviHnv7skrLg1St5bVAx+WOA3DPF3+4F1cuELLQ1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=jrpVXEP2; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="jrpVXEP2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=0dol+NHPLVxGBr7EwvvNg45Z62kDSE3DsrG/8LSLc64=; b=jrpVXE
	P2V4+0gOuzeaBVEVegS/MACha0j3v0mfLtRZFfOHftDT6MPGlnFmHZn24f2Xue2c
	Iie7NZkDxmzzP96pPRqHNDQBEaiEGjeeeK1+tv4XDeOnnm7p4CPVRHEwVPLuTtm4
	LXpMlGAyZOUmwjZ9ZJycTrzowCtoFawe2o+XmFkX35RDcVtum1Ikou17zWWh+m91
	Pxls5i64DncEY0+oqyMT0zrors+iuwsYMId+FEmOGEtFCRfrJykZbUTt10z8AvAw
	WoiG/AQRqwVQZ3vltK4IytxwG1NcB8/BC2SWyaR27Zioz/kNDuD+FMN/nLaGG6JS
	4hKe6CnZ1oUTQtnA==
Received: (qmail 3011387 invoked from network); 15 Feb 2026 23:55:07 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 15 Feb 2026 23:55:07 +0100
X-UD-Smtp-Session: l3s3148p1@6tnRuuRKeIQujns5
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	linux-arm-kernel@lists.infradead.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	linux-omap@vger.kernel.org,
	linux-remoteproc@vger.kernel.org
Subject: [RFC PATCH v2 03/13] hwspinlock: omap: use new callback to initialize hwspinlock priv
Date: Sun, 15 Feb 2026 23:54:43 +0100
Message-ID: <20260215225501.6365-4-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260215225501.6365-1-wsa+renesas@sang-engineering.com>
References: <20260215225501.6365-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Apply the new helper to avoid using internal structures from the core.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/hwspinlock/omap_hwspinlock.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/hwspinlock/omap_hwspinlock.c b/drivers/hwspinlock/omap_hwspinlock.c
index 5bf0061d3fd6..9a9cb3692348 100644
--- a/drivers/hwspinlock/omap_hwspinlock.c
+++ b/drivers/hwspinlock/omap_hwspinlock.c
@@ -66,10 +66,18 @@ static void omap_hwspinlock_relax(struct hwspinlock *lock)
 	ndelay(50);
 }
 
+static void *omap_hwspinlock_init_priv(int local_id, void *init_data)
+{
+	void __iomem *io_base_ofs = init_data;
+
+	return io_base_ofs + sizeof(u32) * local_id;
+}
+
 static const struct hwspinlock_ops omap_hwspinlock_ops = {
 	.trylock = omap_hwspinlock_trylock,
 	.unlock = omap_hwspinlock_unlock,
 	.relax = omap_hwspinlock_relax,
+	.init_priv = omap_hwspinlock_init_priv,
 };
 
 static int omap_hwspinlock_probe(struct platform_device *pdev)
@@ -116,11 +124,8 @@ static int omap_hwspinlock_probe(struct platform_device *pdev)
 	if (!bank)
 		return -ENOMEM;
 
-	for (i = 0; i < num_locks; i++)
-		bank->lock[i].priv = io_base + LOCK_BASE_OFFSET + sizeof(u32) * i;
-
 	return devm_hwspin_lock_register(&pdev->dev, bank, &omap_hwspinlock_ops,
-						base_id, num_locks);
+					 base_id, num_locks, io_base + LOCK_BASE_OFFSET);
 }
 
 static const struct of_device_id omap_hwspinlock_of_match[] = {
-- 
2.51.0

