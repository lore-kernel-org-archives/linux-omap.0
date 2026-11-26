Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.71.155.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795699689;
	b=ZbxTo33oj9EtWJrhqaEIkpQC1NtXvRn8cGtmvoJhxyluEimylMZuYJGOWKvyijxxCps2
	 T9s2xNLlHRr6qWrZZj0nZ/ehovZMT0sME1HE5h7bEKRo3qbL6nceGZ+5DVck8kTv4MqwV
	 5wnHc8QuI+Zl4gCCU8tvsxrZMCKVNCZPZh2tRZxcMN1j8vW3IBzfN6MLnvCPd4Jmd7xs6
	 BAM93gVw/U8bYuTzB+Aeu/CIoSGlFQX2RiPrO/qH8sfez6esiOQMWU6omJAvF4AEY1ZWL
	 1p9PxgO/5EtA5CqJME4rykDZOcZO68F9WHUgcn37yr37Out6/7iV4VpdZ7cNXubHNog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795699689;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-HM-Tid:X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=OACxoaftaV42FyDy68F9cJqMQyaLPhGFgARyBLGjzJo=;
	b=YZ0Qb5KGfPrs6t7v3KK56PG+0y2e4aVLLYZvj6bAhU+E6/FCsu1HENyv55g4iTCTEm3m
	 OItPe4k9KjQtvFiCwk2EJdudVfnqvuobJ2sVuxEh2h6G1xDaykWxcOzdfmpReVbB0gvkY
	 STTEjTSMrwMaOZa0g6AP/vWgj/crHHA/oHnvVOP6oXZrnYzGj9lnfNDn7YFBFrtDuu1TF
	 eLFunw5NkrwhpTHwTRLhzh5v1yZgoTibewDKSdNIn0NMOkwXuHMayeyv4QtDaGQXbhZm4
	 p0BPUN3MYOyJ3iFPH3uTmXgsK9IGEotErhtrEx51/Pb3uvmrHqjnOR9O5cv8E7ec8tQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=Z9CeI5zW;
	arc=none smtp.remote-ip=101.71.155.101
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C404D606A32A
	for <linux-omap@vger.kernel.org>; Thu, 26 Nov 2026 13:28:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C404D606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=Z9CeI5zW
Received: from user.localdomain (unknown [223.80.110.101])
	by smtp.qiye.163.com (Hmail) with ESMTP id 561f6fcb4;
	Thu, 26 Nov 2026 21:28:05 +0800 (GMT+08:00)
From: Tian Xuechen <202300460064@mail.sdu.edu.cn>
To: lee@kernel.org,
	aaro.koskinen@iki.fi,
	andreas@kemnade.info,
	khilman@baylibre.com,
	rogerq@kernel.org,
	tony@atomide.com,
	j-keerthy@ti.com
Cc: mfd@lists.linux.dev,
	linux-omap@vger.kernel.org,
	liguangshuo@mail.sdu.edu.cn
Subject: [PATCH 1/2] mfd: lp873x: Remove the child devices on unbind
Date: Thu, 26 Nov 2026 21:28:02 +0800
Message-Id: <20261126132803.4091137-2-202300460064@mail.sdu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261126132803.4091137-1-202300460064@mail.sdu.edu.cn>
References: <20261126132803.4091137-1-202300460064@mail.sdu.edu.cn>
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa2180ab6b303a2kunmf8b0a91135d955
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZH0JKVkpMTR5KTk5JS0xMGVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVQ0tVSkpLVUpLSllXWRYaDxIVHRRZQVlLVUtVS1VLWQ
	Y+
DKIM-Signature: a=rsa-sha256;
	b=Z9CeI5zW5cmC4aFKHzIv/WH9M4b6ayNqJYF8pDiYXLnHs1fz0XvR/S8+j/Xx6wUX0Xd7EFvyQeFvMMxT2QyHsa+QgxmQsQqS7MZ/Y/lCe0fIm1zMvWX5Z4ILsp1uhEZ/EoD6X0Q0QAZqqMaR3HYm4cPRQhWnn+bbGxDfY1Waz1k=; s=default; c=relaxed/relaxed; d=mail.sdu.edu.cn; v=1;
	bh=OACxoaftaV42FyDy68F9cJqMQyaLPhGFgARyBLGjzJo=;
	h=date:mime-version:subject:message-id:from;

From: Tian Xuechen <202300460064@mail.sdu.edu.cn>

The regulator and GPIO children stay registered when the I2C driver
is unbound, although they use the parent's managed data. Use managed
MFD registration so the children are removed first.

This issue was found by our static analysis tool under development.

Fixes: dc21c7ad3a8a ("mfd: lp873x: Add lp873x PMIC support")
Signed-off-by: Tian Xuechen <202300460064@mail.sdu.edu.cn>
---
 drivers/mfd/lp873x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/lp873x.c b/drivers/mfd/lp873x.c
index ab7bd46d9ff7..6b2badab4f2d 100644
--- a/drivers/mfd/lp873x.c
+++ b/drivers/mfd/lp873x.c
@@ -53,8 +53,8 @@ static int lp873x_probe(struct i2c_client *client)
 
 	i2c_set_clientdata(client, lp873);
 
-	ret = mfd_add_devices(lp873->dev, PLATFORM_DEVID_AUTO, lp873x_cells,
-			      ARRAY_SIZE(lp873x_cells), NULL, 0, NULL);
+	ret = devm_mfd_add_devices(lp873->dev, PLATFORM_DEVID_AUTO, lp873x_cells,
+				   ARRAY_SIZE(lp873x_cells), NULL, 0, NULL);
 
 	return ret;
 }

-- 
2.43.0

