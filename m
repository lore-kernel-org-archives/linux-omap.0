Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDD6366065
	for <linux-omap@vger.kernel.org>; Tue, 10 Mar 2026 07:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773129372; cv=none; b=o3I/A52Uah74Z29YMMIWMbmqNg9MIGfBGLpr5lq8kXWBS6GnqSJ2BGPqKga1LFhfEbV4buTD0jTKyQRxCEV26E7AeacExidolGZfoAaBwttxN8mVa2Vn+MfPEfA/iOMfLDpnCY2adsi6DpR5HUB7ABfGIRsG+h1LBh1GkRKqUPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773129372; c=relaxed/simple;
	bh=nX/JNUQsoIsZPgc0eQr9bDwyuSjW/BHNg7TEpnt7i0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sj96J4hAa4H/M2oWXkuyprmiQGVCePXLKEJ6joSgvwFuqj866esq1oBwHTvFLkQ+54hylUVMghE4rZambeAOct6a/lIXlYxIP094pAG96pNwc99F9PGr4/0o29H6Xl9P+8p8h6qG7xztaqiSEmPHwsz3ewF7EeOQkDW1Y0btGXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=ScLpMk9Q; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="ScLpMk9Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=m6b17guF4mqY7MErq38twR8NUyAOvnb/eht594gA9L4=; b=ScLpMk
	9Q7n5ID/L/JRa1+hzrXUvaaiGAaQO9dgi/mIlkNt63SflDot19QzhM55nZpIaRJR
	Xxw7dLSTBOZhfKOJ4qEeR9xcbrHqX5HjPnzWUf0zYhJScyInYTcjtv0jaKTHhjaY
	JPgzeFOYEUUOxwOcQ6iLST/GT1aBOn1C9JZRNbH290yXXNxUl3sgAwSKdfkCIwjL
	dnz6ZhMKBGCHsHBSCC+J37mt8FlMUlmwQEw7/ZQ24IaU7m2SAEmiR2pCwBv+NX+y
	iCDZlHn1pBz91MmQieqNPwFvWpCYw5ncZyfjURlGtBVyelScfpXy/PfSZpoRq6k5
	NivpAtH8tcMGyFOQ==
Received: (qmail 3112659 invoked from network); 10 Mar 2026 08:55:52 +0100
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 10 Mar 2026 08:55:52 +0100
X-UD-Smtp-Session: l3s3148p1@CQky2aZMwJAujntP
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	linux-omap@vger.kernel.org,
	linux-remoteproc@vger.kernel.org
Subject: [PATCH v4 05/15] hwspinlock: omap: use new callback to initialize hwspinlock priv
Date: Tue, 10 Mar 2026 08:55:20 +0100
Message-ID: <20260310075539.11701-6-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260310075539.11701-1-wsa+renesas@sang-engineering.com>
References: <20260310075539.11701-1-wsa+renesas@sang-engineering.com>
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
2.47.3

