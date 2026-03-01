Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029521F9F70;
	Sun,  1 Mar 2026 01:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328371; cv=none; b=MoqXJq5URYuQOLsvx5vcSwDL8ow/YnLdJbwWBFwS3orUDQgxqMmRiv6PUbZL4zBbPwFU+TTlg9FGXcI4Pv2U2LW9wFWAj1h+KGvfN90s2nk4vzVbh2voWJi+Agw9EB9mtWoqJehnpjSyg8UPYXZrUHmTcFVVUXwQiWH5zQZbQDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328371; c=relaxed/simple;
	bh=JIvsk/L1B2U9zZ6RBYcoahkhBp1ymOtESQW00Fx8vMc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FM80PIAMWcgM1yOtGHaUH8Icb2kAeYeiKKgpVF1VOBAbZ09nEIcr0Lf5mQLXbI0gRUBABNO2P8wXb6329FuAmQ9RYMjkxjXCGXaev1WI+k8aCO+F4GaVq/Z9rJGBaVcL7wkOlxmgjPcj2RXpY2bDMg91fwNeBaWeBS1EwLcdAvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DL7Rarlw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DL7Rarlw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39129C19421;
	Sun,  1 Mar 2026 01:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328370;
	bh=JIvsk/L1B2U9zZ6RBYcoahkhBp1ymOtESQW00Fx8vMc=;
	h=From:To:Cc:Subject:Date:From;
	b=DL7RarlwCvt9+7VgsbZdTON6lL/u9CCy7TvPE88nmlJ4BR4NupRW7QZllNs8XV7UC
	 AvO5ahkbrSgYCbAO1sVupLQvm+mDiZZAilNT5QXxXpyCSrAELze1E+4jmtUNewYCgE
	 iIZurNSwypdyCvDm5cAyNZ3DlpSYtxiFEzxDsESuIxra73ykSMupzHa/inwicxa+Z2
	 wCzNGSUeq5DdR5BgNdRzpXknLfEnzmE7Tu/VDep8l89wryMRDgz4FWqm18397J2dWE
	 CYqviJlf1oFsjx7TfQAKr+69yt25FLNE2u4QHVScrJ0CqU5LcHcgfKR1na0XG9EdMV
	 rcEzL3hrdWbyQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	haokexin@gmail.com
Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-omap@vger.kernel.org,
	netdev@vger.kernel.org
Subject: FAILED: Patch "net: cpsw_new: Fix unnecessary netdev unregistration in cpsw_probe() error path" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:26:08 -0500
Message-ID: <20260301012609.1683482-1-sashal@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
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




