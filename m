Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDA42EBBA9;
	Sun,  1 Mar 2026 01:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772330032; cv=none; b=B4aRt7Q4uChJOM2ifxxwRcv76467V2Wx4YP//g1F/rVfDcz0tLALCuTVhVK9C+FdlI8RVHZswfG82xPLb1oxTUlM+RuBef0fUzwVDdRp1m+PrwOLZmHnhB9YzSrdJ0DS5GCl19RNnMz1Qj9TmHATM3nPtGb+7yZt8iDQBCmqVYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772330032; c=relaxed/simple;
	bh=wFc3eqkLKnXa9Xcuu9+1/PbiJsbfOPhi5b6zFMDWKwA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BfWJlx9LVuu0iOgr+MVRLo6Fy2krs7K3hiF2tpkqNLa/0dv3cPVqjImnNA+gs9SGKSQQOXTtnBBPb8K78+zSQxPfc06ljeL8LzK+3gzxBg4a/I9HLZlr9SzfCNhrf/iFW3ygighoGFu2Mr1PcxkGL0pE1qwEUu/t1uhmTNIR07g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gn0lnQXE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gn0lnQXE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDECCC19421;
	Sun,  1 Mar 2026 01:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772330032;
	bh=wFc3eqkLKnXa9Xcuu9+1/PbiJsbfOPhi5b6zFMDWKwA=;
	h=From:To:Cc:Subject:Date:From;
	b=Gn0lnQXEdDytQa5N1P+ZIknU+DdhjQ4GDI4/pZ/CNUhVHQSNb0lSgPqOT94ksxlJG
	 cInAIA1iLCjY8J8NTG6S1Kj657Qiw9X3vP/H0rgxyMeNhhuJi0ULBMyv8i5OAlcHS8
	 NAZI9ueT5S20mC55xLtSJM99IzI+0C+cpAvrnfDbx/XlkQz3Ro0+1n6S4u4vi6ma79
	 NCW7fmPDMme+N/ZDd9fTFKqsGFUjs7/k0B4NYwAFyV9QAAHWhnI1tEb0ODa5WsqHI9
	 VBRKy3CtxwJZxF7PK68NypY9g8Cfn52lcF7H5r0od8DJJuQjT2MjYK0zxTpq+W4+n2
	 oWBGVPg4K59+w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	haokexin@gmail.com
Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-omap@vger.kernel.org,
	netdev@vger.kernel.org
Subject: FAILED: Patch "net: cpsw_new: Fix unnecessary netdev unregistration in cpsw_probe() error path" failed to apply to 5.15-stable tree
Date: Sat, 28 Feb 2026 20:53:50 -0500
Message-ID: <20260301015350.1720710-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 62db84b7efa63b78aed9fdbdae90f198771be94c Mon Sep 17 00:00:00 2001
From: Kevin Hao <haokexin@gmail.com>
Date: Thu, 5 Feb 2026 10:47:02 +0800
Subject: [PATCH] net: cpsw_new: Fix unnecessary netdev unregistration in
 cpsw_probe() error path

The current error handling in cpsw_probe() has two issues:
- cpsw_unregister_ports() may be called before cpsw_register_ports() has
  been executed.

- cpsw_unregister_ports() is already invoked within cpsw_register_ports()
  in case of a register_netdev() failure, but the error path would call
  it again.

Fixes: ed3525eda4c4 ("net: ethernet: ti: introduce cpsw switchdev based driver part 1 - dual-emac")
Signed-off-by: Kevin Hao <haokexin@gmail.com>
Cc: stable@vger.kernel.org
Reviewed-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Link: https://patch.msgid.link/20260205-cpsw-error-path-v1-1-6e58bae6b299@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/ti/cpsw_new.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw_new.c b/drivers/net/ethernet/ti/cpsw_new.c
index 21af0a10626aa..b9fc31eb06134 100644
--- a/drivers/net/ethernet/ti/cpsw_new.c
+++ b/drivers/net/ethernet/ti/cpsw_new.c
@@ -2003,7 +2003,7 @@ static int cpsw_probe(struct platform_device *pdev)
 	/* setup netdevs */
 	ret = cpsw_create_ports(cpsw);
 	if (ret)
-		goto clean_unregister_netdev;
+		goto clean_cpts;
 
 	/* Grab RX and TX IRQs. Note that we also have RX_THRESHOLD and
 	 * MISC IRQs which are always kept disabled with this driver so
@@ -2017,14 +2017,14 @@ static int cpsw_probe(struct platform_device *pdev)
 			       0, dev_name(dev), cpsw);
 	if (ret < 0) {
 		dev_err(dev, "error attaching irq (%d)\n", ret);
-		goto clean_unregister_netdev;
+		goto clean_cpts;
 	}
 
 	ret = devm_request_irq(dev, cpsw->irqs_table[1], cpsw_tx_interrupt,
 			       0, dev_name(dev), cpsw);
 	if (ret < 0) {
 		dev_err(dev, "error attaching irq (%d)\n", ret);
-		goto clean_unregister_netdev;
+		goto clean_cpts;
 	}
 
 	if (!cpsw->cpts)
@@ -2034,7 +2034,7 @@ static int cpsw_probe(struct platform_device *pdev)
 			       0, dev_name(&pdev->dev), cpsw);
 	if (ret < 0) {
 		dev_err(dev, "error attaching misc irq (%d)\n", ret);
-		goto clean_unregister_netdev;
+		goto clean_cpts;
 	}
 
 	/* Enable misc CPTS evnt_pend IRQ */
@@ -2043,7 +2043,7 @@ static int cpsw_probe(struct platform_device *pdev)
 skip_cpts:
 	ret = cpsw_register_notifiers(cpsw);
 	if (ret)
-		goto clean_unregister_netdev;
+		goto clean_cpts;
 
 	ret = cpsw_register_devlink(cpsw);
 	if (ret)
@@ -2065,8 +2065,6 @@ static int cpsw_probe(struct platform_device *pdev)
 
 clean_unregister_notifiers:
 	cpsw_unregister_notifiers(cpsw);
-clean_unregister_netdev:
-	cpsw_unregister_ports(cpsw);
 clean_cpts:
 	cpts_release(cpsw->cpts);
 	cpdma_ctlr_destroy(cpsw->dma);
-- 
2.51.0




