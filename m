Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8593890F2
	for <linux-omap@vger.kernel.org>; Tue,  3 Mar 2026 19:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772566312; cv=none; b=M5W0M5fGAqi0T8yEKG+GDXuc5ZWe9Co9j43MFZ6mh8fv0a0P76DPmQCC6f1BbxfTgc3bXu3iquX0Q+YRcoQn+laPSSNvCqOmJ8vLd1Xknh1awMaRyH9D9Eu/eQWoEp+fANWU6RJ4Jz1XryxX3vDeye++lKoSMyLB29CSe9gBBFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772566312; c=relaxed/simple;
	bh=NQhzFPnhvDT7H608lK0YkvhIe1Wnm9jDBN/Mog6YZ14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=li7xmTNbZlv3oTAqj+rcGLf0wiXYB/TvNl60in/OvJTdGCPP5/JIHyaxKRiDrHFDU+CBU+YJQr0493CMI8fThDKOhxoJ//0B/9lQ5ho5cjZ+Vwk18dzp2ojczcbX/anL8eoiXnK6y9uJe4il76IU5WbVfJZwEmvdfn2mJShvNHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=QCmgyaIa; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="QCmgyaIa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=wuaGGcGzaS2IaPKApvffnT5mOe0N/0OwbJ4Ny2ad2Jk=; b=QCmgya
	Ia7SPftQYeGZRtCywsLDZCStg0epZjfFPXHw22CYNiY8hE9JRwb66VlX90hyTnqt
	lREZiCC9SsBaZcWtdFlUqnKkTtkRqO4t8FUpA+EK/yPnc7RIMfqW1HZb4qRqBrzZ
	Mv/zWriCmKsfXDYrIndXHwzCstrEuR6M6YXWGVeQwdkVMQtTTWpEM++v7PzlYkMM
	/y0OLTgoz/HybGsgPLkpFQNaBMc0+migmvddco2fvxY8g+wlcTE0lX7lkmx7WDTf
	ygdbovs9Zui6044sQ0ZiDh6HhIqXo75lHOc/5hJz+k0cN8rYnYuQngS4CqJ+F13y
	0HMSvkoM1N8f4m2g==
Received: (qmail 430566 invoked from network); 3 Mar 2026 20:31:31 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 3 Mar 2026 20:31:31 +0100
X-UD-Smtp-Session: l3s3148p1@zAMewCNMTpEujnu+
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	linux-omap@vger.kernel.org,
	linux-remoteproc@vger.kernel.org
Subject: [PATCH v3 05/15] hwspinlock: omap: use new callback to initialize hwspinlock priv
Date: Tue,  3 Mar 2026 20:25:57 +0100
Message-ID: <20260303192600.7224-22-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260303192600.7224-17-wsa+renesas@sang-engineering.com>
References: <20260303192600.7224-17-wsa+renesas@sang-engineering.com>
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
index adff502bcbc4..9a9cb3692348 100644
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
-						base_id, num_locks, NULL);
+					 base_id, num_locks, io_base + LOCK_BASE_OFFSET);
 }
 
 static const struct of_device_id omap_hwspinlock_of_match[] = {
-- 
2.51.0

