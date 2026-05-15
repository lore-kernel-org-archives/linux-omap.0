Received: from mail-08.mail-europe.com (mail-08.mail-europe.com [57.129.93.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A894239A076;
	Fri, 15 May 2026 22:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.129.93.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778885859; cv=none; b=qZDxNSxB8HypGM5SZqKQ+wKIcrKrL8bAOn8M871RiIj51kEtg4J0/349GxrDOQmv2pbaX+T0h5gHBc+yI3zyTX1vV9M/BPJdDORt0BY8Yz0Y6h/ULLrvxQWIBeRStMN+REe8cgJmUOA4UUwJNDU5uoiDyJyyTswhUyKDKen9MuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778885859; c=relaxed/simple;
	bh=qnnHmeuD4B3ib6QErbfOiGA3ssD2oWWRu2a05LVDhNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BY7sKY5olhbelgdhv/yLZqm2YdlvAXXlEGT3vvmtZg5UJHEEvW5vFopFZbEgblpm5ODSkEgD7kMcjEmYt+lvKEXqCNLchC+WKCfyQ7o7eni5h7DAGgsMd8u1naH01oqySabA/mlMYz2RtAt8MENvha5UiJdoFs3zBAii3UAso94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vassilevski.com; spf=pass smtp.mailfrom=vassilevski.com; dkim=pass (1024-bit key) header.d=vassilevski.com header.i=@vassilevski.com header.b=OR/0cKyS; arc=none smtp.client-ip=57.129.93.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vassilevski.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vassilevski.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vassilevski.com header.i=@vassilevski.com header.b="OR/0cKyS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vassilevski.com;
	s=protonmail; t=1778885842; x=1779145042;
	bh=74bsjubzgflcd9M7LjMJofPlrdTcXGeyKv5HA4b8SOs=;
	h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=OR/0cKySMrmMkZXYWAVWLylTjxT1+D22HHKf5w0yq3hhkiZ8rO21O7zE/UsOYV6uV
	 71uDlCvoBwT4zPf5cKP47mKJBCIWsQFA9+9GaDThqGv3EBBxEjNHgH4GsGxGinNHCP
	 HqnQFU9H2AjKSpH3tFTtgK4ZkSLA8s2huJu7bjyA=
X-Pm-Submission-Id: 4gHMz06syrz2Schs
From: Alexander Vassilevski <oss@vassilevski.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Chintan Vankar <c-vankar@ti.com>,
	netdev@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] net: ethernet: ti: am65-cpsw-nuss: remove dead vid check in slave_add_vid()
Date: Fri, 15 May 2026 15:57:14 -0700
Message-ID: <20260515225715.3641804-1-oss@vassilevski.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

am65_cpsw_nuss_ndo_slave_add_vid() returns early at the top with:

    if (!netif_running(ndev) || !vid)
        return 0;

so vid is guaranteed to be non-zero in the rest of the function. The
subsequent

    if (!vid)
        unreg_mcast = port_mask;

is therefore unreachable. unreg_mcast stays at its initialized value of
zero and is passed as the unreg_mcast argument to
cpsw_ale_vlan_add_modify().

Drop the dead branch. No functional change.

Found by Smatch.

Fixes: 7bcffde02152 ("net: ethernet: ti: am65-cpsw-nuss: restore vlan configuration while down/up")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/kernel-janitors/aS_lhMwppbDHoEcX@stanley.mountain/
Signed-off-by: Alexander Vassilevski <oss@vassilevski.com>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 7ac75fc8cd..77f59996a0 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -316,8 +316,6 @@ static int am65_cpsw_nuss_ndo_slave_add_vid(struct net_device *ndev,
 		return ret;
 
 	port_mask = BIT(port->port_id) | ALE_PORT_HOST;
-	if (!vid)
-		unreg_mcast = port_mask;
 	dev_info(common->dev, "Adding vlan %d to vlan filter\n", vid);
 	ret = cpsw_ale_vlan_add_modify(common->ale, vid, port_mask,
 				       unreg_mcast, port_mask, 0);
-- 
2.43.0

