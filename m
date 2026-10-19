Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F2036B913
	for <linux-omap@vger.kernel.org>; Mon, 19 Oct 2026 06:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792389891; cv=none; b=RHExgQBCc36dzMAhi67ENQwBuV2F1GaIa4vwhmaRIRpetIPiBMGPFW1xfd4HEfvNKDZeccIxwUMBVGLO4smU5xPunwLtIY4aSWaIuQlBPENWpFd2tLX8HmOBeKnt6fkHYUh/psk3DWMDI3ZCaSPiUa5kay5sh6ogVDaHyb84hY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792389891; c=relaxed/simple;
	bh=ZoKS4HP8jTfUqvKjHQCOygjufJp7O7UXxSy9Xj+WYgY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tbEBGcS5LxKH6kzoeVUY7E2/t4SlOV5/XwWTAMQtw75KkIzli2TcUda59+ePF2BHzKnL9TzApxQi6TApo8Y2a0F0NWpHUGpAySQvPd5GWqbpoovtsg1NrEKKIRsRIEigfigTdhwK6JsGlNnp8TiQGjiQomWM+M/FBe4g8iDQPtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gOkIrzOx; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOkIrzOx"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48e0d885929so1118616f8f.3
        for <linux-omap@vger.kernel.org>; Sun, 18 Oct 2026 23:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792389888; x=1792994688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CQrs1A/lHyQmEHN3tDaDTbTCRAYkGfogMiGTVBwsan4=;
        b=gOkIrzOxoN4M/K3anAqO10bMOK5rqVz/YMCphbDCbp2MpmtXiJUdkrMajXml/tvRID
         6H/ZhDx2/OLneevo5f3fB5Cl3WkxU7BxArQO6wtGfXVSTuDyg59qXQYZGqjGJP//egdi
         0ldSCcB3aeF5k0qLoc9WWpMrY+p7wqEZBcOMtcXUMa8OQYHD1i1qZR0XedXiCAuvVAsM
         wf6oJfW4Kcs28YPp/roB4xxgwgYXD4YmFKe5W7m8rR9BpiJrvIOMnYKNYm3tKch3TtNe
         v9s179e0oWn2IQ0hroTtC3QvAGKHbUKG9PlbhomrcnIjLVYcQ7ijn03iqi8EGfkt0+8Y
         aiBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792389888; x=1792994688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CQrs1A/lHyQmEHN3tDaDTbTCRAYkGfogMiGTVBwsan4=;
        b=iuWPdMfgihclPmQFbimBZZAWN02FBHXKzSnshz9f+1C1OEtLuZ9ZYrBgz5nL4aGlCQ
         gjve7BS880b6iMfLPTRjVN+awXDvQxKowyUW6LyW+x8Pbk/syueyH5t/LRsZsJh9kM2y
         D85QCruov5X0mHJlSVzE9QJQgjLHLd4beYQ4v3qkAHYKH8iXK6CYB9cDUp5BrPlXZA+B
         ZTbpuWyFEBr5FS5qESzzVcW1wK22o6m6YRcJnjv4ddKaQFFw063oKMnw5ySIhqW4K4m+
         edFzXpiIOfM6xuYsh1glh+orxoNP1GlOUzNhxqETPvldvnUQfNn/tjTtX9t1J+Og4Nl9
         FFhw==
X-Forwarded-Encrypted: i=1; AKwUvBwIKA1ws8OQHD+jlwjG7doUC46Mz5g8rCZmToPY1uR45MKTB9b9ydCefBRXuu1wFJ5V1wugtQXFh2RA@vger.kernel.org
X-Gm-Message-State: AFq9FYJ+lX5jXivFqISFdbdOuc3ktZn3dCQXUhHvKg4ztLSPsvgTe1n2
	nkdSkrElbkYF5ldCp0ssYbtJlPQqKiNvcllEG3rYx478+nuN6tJa5lJS
X-Gm-Gg: AYBFou2orIPj6f8TTV1d/Yz1rjZOcejOuc+9pZcwjMXuvz4BJ4MjVCd4hqlhFMFMnqp
	Q2pZ2qsaCRONLzIc0BAgwenL+GDZe/2KblJpzFrCO+az3z/kV8/s6iT4hZyqQx6ZcGGpuWsALd3
	CAp+4eQKwr3Z5Pjj8rMRemme/usWLQ3wbEXRAE/uMaqt5FLy98pRo32a2bpUqDkmyAC9yebAVXn
	K/0s26E/52QfYWGfbqv2QI5LxtX+96bLeUwZPeadr4uSdN6SFO7oq0AozaRABlCb1N38SfD70bg
	Dxbmy2CuwjB7KtzdjHSbuaDgz+htcZ/AAbj4DL3aJbKj/LqBF61ui7zjYBhd22sZJU65YaCcdOk
	jsxcsvKu4EOUCJkjnAmnghkrYGPZ+qDkFHpPyg0UtDdGDL441FrF90pUsnr9aUmAy+NUzEXyKas
	9Ww0b2f4ebW2A71Y1c1OwYYX4xPEX1uM7HptMF8W52b/R0ZJnKtlgaoHE+Xn+1fIv1UJoiKOzES
	QOiV1744P2Hh1eSSBg8bRJrR55xAEKs+Qu0ILqSruwt/vzuwjJdM2Drzj0R6Q0DPI62zOq+bf+N
	0d+Fg9RljZied7+E+frnWoHrbQCTOL10Adp+iS2hVu5UGMzMkOmlDJ3J2yd4tSS4H7WR+vXlL0a
	t
X-Received: by 2002:a05:6000:ac4:b0:48d:c29e:40c3 with SMTP id ffacd0b85a97d-48e07f9e4b5mr10301709f8f.33.1792389888187;
        Sun, 18 Oct 2026 23:04:48 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4e0-4601-c43a-536a-04a3-af7d.310.pool.telefonica.de. [2a02:3100:a4e0:4601:c43a:536a:4a3:af7d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfe4d2321sm24820878f8f.19.2026.10.18.23.04.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 18 Oct 2026 23:04:47 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: netdev@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Keerthy <j-keerthy@ti.com>,
	Kevin Hao <haokexin@gmail.com>,
	Alexander Sverdlin <alex@sverdlin.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2] net: cpsw: fix netdev cleanup on probe failure
Date: Mon, 19 Oct 2026 08:04:30 +0200
Message-Id: <20261019060430.33254-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The legacy CPSW driver registers its netdevs before requesting IRQs. If
a later IRQ request fails in dual-EMAC mode, the probe error path
unregisters only the primary netdev. Devres then calls free_netdev() on
the still-registered secondary netdev, triggering the reg_state BUG_ON.

Once registered, either interface can queue rx_mode_work through
dev_set_rx_mode(). The error path does not drain the work before devres
releases the netdev and its private data, allowing the worker to access
freed memory.

Use the same per-port cleanup for probe failure and remove. Unregister
each netdev whose reg_state is NETREG_REGISTERED, then drain its
rx_mode_work. The state check is needed because cpsw_probe_dual_emac()
stores the secondary pointer before register_netdev() succeeds.

The workqueue lifetime issue was found during an LLM-assisted review of
the 6.12.112-rc1 stable series. Inspecting the same path then exposed
the dual-EMAC cleanup bug.

An instrumented KASAN ARM kernel and a QEMU CPSW probe stub reproduced
both failures by forcing the TX IRQ request to return -EBUSY. Not tested
on real hardware.

Fixes: 070f9c658a59 ("net: ethernet: ti: cpsw: Push the request_irq function to the end of probe")
Fixes: 0b8c878d1173 ("net: cpsw: Execute ndo_set_rx_mode callback in a work queue")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
v2:
  - fold the two fixes into one patch (Jakub)
  - share registered-port cleanup between probe unwind and remove (Jakub)
  - check NETREG_REGISTERED instead of adding a local flag (Jakub)
  - add the requested discovery context (netdev bot)
  - rebase on net

v1: https://lore.kernel.org/netdev/cover.1791035789.git.kmehltretter@gmail.com/

Tested:
  - ARM W=1 cpsw.o builds with TI_CPSW=y and TI_CPSW=m
  - KASAN ARM runs with a QEMU CPSW probe stub. A test hook held
    rx_mode_work pending while the TX IRQ request failed with -EBUSY.
    Both failures reproduced without the combined fix; v2 completed
    single- and dual-EMAC cleanup without KASAN or BUG reports in two
    runs per mode.

 drivers/net/ethernet/ti/cpsw.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index aa3531e844e87..01296c0582bf0 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -1524,6 +1524,23 @@ static int cpsw_probe_dual_emac(struct cpsw_priv *priv)
 	return ret;
 }
 
+static void cpsw_unregister_ports(struct cpsw_common *cpsw)
+{
+	struct net_device *ndev;
+	struct cpsw_priv *priv;
+	int i;
+
+	for (i = 0; i < cpsw->data.slaves; i++) {
+		ndev = cpsw->slaves[i].ndev;
+		if (!ndev || ndev->reg_state != NETREG_REGISTERED)
+			continue;
+
+		priv = netdev_priv(ndev);
+		unregister_netdev(ndev);
+		disable_work_sync(&priv->rx_mode_work);
+	}
+}
+
 static const struct of_device_id cpsw_of_mtable[] = {
 	{ .compatible = "ti,cpsw"},
 	{ .compatible = "ti,am335x-cpsw"},
@@ -1764,7 +1781,7 @@ static int cpsw_probe(struct platform_device *pdev)
 	return 0;
 
 clean_unregister_netdev_ret:
-	unregister_netdev(ndev);
+	cpsw_unregister_ports(cpsw);
 clean_cpts:
 	cpts_release(cpsw->cpts);
 	cpdma_ctlr_destroy(cpsw->dma);
@@ -1779,9 +1796,7 @@ static int cpsw_probe(struct platform_device *pdev)
 static void cpsw_remove(struct platform_device *pdev)
 {
 	struct cpsw_common *cpsw = platform_get_drvdata(pdev);
-	struct net_device *ndev;
-	struct cpsw_priv *priv;
-	int i, ret;
+	int ret;
 
 	ret = pm_runtime_resume_and_get(&pdev->dev);
 	if (ret < 0) {
@@ -1793,15 +1808,7 @@ static void cpsw_remove(struct platform_device *pdev)
 		return;
 	}
 
-	for (i = 0; i < cpsw->data.slaves; i++) {
-		ndev = cpsw->slaves[i].ndev;
-		if (!ndev)
-			continue;
-
-		priv = netdev_priv(ndev);
-		unregister_netdev(ndev);
-		disable_work_sync(&priv->rx_mode_work);
-	}
+	cpsw_unregister_ports(cpsw);
 
 	cpts_release(cpsw->cpts);
 	cpdma_ctlr_destroy(cpsw->dma);

base-commit: 7ec48f396a1d89532c0537bc38b408b8c31ee37f
-- 
2.39.5 (Apple Git-154)

