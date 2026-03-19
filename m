Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581653C6A5B
	for <linux-omap@vger.kernel.org>; Thu, 19 Mar 2026 11:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773918020; cv=none; b=FSgN15z0AQlKJ0UR6VmJrOH8IqgtRY8/H+Vsvg8HBFLPOfEW3daHPggbomZlpLB8E4iw4HG+0D3RSXfeVglbwULFDKV4+VHFKtkYFh/vPRZZrXVOjFm+wgfGtybYkEvo7r5eF3pq9QG5XyYiRssr55cAV29GK2oD79aKy36RD+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773918020; c=relaxed/simple;
	bh=t92OnzR8r6jZTrmncLKGrwgpIYknSeg4sMgdsW8KWSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JLaipKiqcomUDvII+E7gkk9w5Xt0VZFZTUqB0neQct20pWAbInFw0L2yVUs6CdBKl56CYiqd0h3j9DbZSSKEBh7wfAsGU3+KhE7Fw9WxQduFye7saQMD79RRiq1YqJX8AfZB1K2Lgk36CgK6L202W0+g2UcnQ0oG4cpW/LCQi8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=ILkU8tuU; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="ILkU8tuU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=zNZ7iTl8FDE7U49MCjuBLAc4mKVqh5ltMfRvYgVFysQ=; b=ILkU8t
	uUUHii2DM03wCl3vUY2c8tVF6EcVvnHuP66XcrfE26HhVEnV+FwR0I0/ZnyoGVSt
	gjqTsVr7AAH/AeTwLgsjtE6Ce+RA+TzUmuLc3YoRJL3UX+Z9nkVZbzXz8pLli+rt
	9c6K+w1EgwMPl9Ic0aGmjqldH5Vkr+HX4wVPxvoL4bOInO6hpvmxdfcE1yL6BPra
	rlE2Iuo64oQbWMIMkqAQnDPSrlsy9FxpNEGcb1cmBCIyZWAliRjtKcnySND+sJnr
	c1PdWgrp6aq4pCCTW90/XpalzLDwLUpF2SNBhDWOb7GyviXAa9vFKWzhjQ+yIObq
	UzSyNVdpFtOW5urw==
Received: (qmail 1099555 invoked from network); 19 Mar 2026 11:59:57 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 19 Mar 2026 11:59:57 +0100
X-UD-Smtp-Session: l3s3148p1@Im4XeF5N7N0gAwDPXzF+ANZpdrMKUeLI
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	linux-omap@vger.kernel.org,
	linux-remoteproc@vger.kernel.org
Subject: [PATCH v5 05/15] hwspinlock: omap: use new callback to initialize hwspinlock priv
Date: Thu, 19 Mar 2026 11:59:27 +0100
Message-ID: <20260319105947.6237-6-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260319105947.6237-1-wsa+renesas@sang-engineering.com>
References: <20260319105947.6237-1-wsa+renesas@sang-engineering.com>
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
 drivers/hwspinlock/omap_hwspinlock.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/hwspinlock/omap_hwspinlock.c b/drivers/hwspinlock/omap_hwspinlock.c
index adff502bcbc4..868b93131796 100644
--- a/drivers/hwspinlock/omap_hwspinlock.c
+++ b/drivers/hwspinlock/omap_hwspinlock.c
@@ -66,10 +66,16 @@ static void omap_hwspinlock_relax(struct hwspinlock *lock)
 	ndelay(50);
 }
 
+static void *omap_hwspinlock_init_priv(int local_id, void *init_data)
+{
+	return init_data + sizeof(u32) * local_id;
+}
+
 static const struct hwspinlock_ops omap_hwspinlock_ops = {
 	.trylock = omap_hwspinlock_trylock,
 	.unlock = omap_hwspinlock_unlock,
 	.relax = omap_hwspinlock_relax,
+	.init_priv = omap_hwspinlock_init_priv,
 };
 
 static int omap_hwspinlock_probe(struct platform_device *pdev)
@@ -116,11 +122,8 @@ static int omap_hwspinlock_probe(struct platform_device *pdev)
 	if (!bank)
 		return -ENOMEM;
 
-	for (i = 0; i < num_locks; i++)
-		bank->lock[i].priv = io_base + LOCK_BASE_OFFSET + sizeof(u32) * i;
-
 	return devm_hwspin_lock_register(&pdev->dev, bank, &omap_hwspinlock_ops,
-						base_id, num_locks, NULL);
+					 base_id, num_locks, io_base + LOCK_BASE_OFFSET);
 }
 
 static const struct of_device_id omap_hwspinlock_of_match[] = {
-- 
2.51.0

