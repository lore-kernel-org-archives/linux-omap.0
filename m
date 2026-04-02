Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA04035C1B0;
	Thu,  2 Apr 2026 18:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775155669; cv=none; b=e+Ij77URMzOOjoEwnv8uFr1kv8rA6HM34ePLUDWZEak3KFMwc0d2YZHD8IVw6olFc3PyUMh3lox6S3VPiMkI52o8WliG9U2DcMiZSQTZy7n3IKHgXVVvTpiUmsUWRuwqjXLhi64ZctUhSFPTdFcmv3usI7bUQ/U//+EnbkeoejI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775155669; c=relaxed/simple;
	bh=k7dMYkSfBDWbDN8CIrbOQD3A2aHiby1Q3JQDtmPxsPI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rVundxRM+ejKociRGQsfpOHiGFlmyO7jxhMf+bf1OCFTYUOUPsY/rMMi5gwHT7U4f63wJ0RlQCve0dMaBedONJOAPfttK3vFOhFfdF0F3O5pWDF0dVy1d4WB4z5d0uzpHxhQtDkmEWrBh0rWsB0J48TSBJ4XEHUDnAEZKlwcGBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hPMZQqCI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hPMZQqCI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EF66C116C6;
	Thu,  2 Apr 2026 18:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775155668;
	bh=k7dMYkSfBDWbDN8CIrbOQD3A2aHiby1Q3JQDtmPxsPI=;
	h=From:To:Cc:Subject:Date:From;
	b=hPMZQqCIDQvAqnLZ4UuYSHtihgPJiB6NzIrxKHyAVs00SsB7LCXoexeaZP245ke/q
	 OvOGTvSO0VV4MvHtoJ7d5D3XwKYaXXJ5wlmmVWTF2LMBahbE8iU0VbfV39jNP9JZgz
	 rUeGIAnCHbhTMvzTSrAky+mVBmHy161L1KOe6s1z1/AYofy4Ty3URjP6YMs2XQAlsI
	 jFVKDmiD6irQtiRv4GNkOREBbYCajfx3v0s/p8ARx9HzoU6chkChFVBy1wRMgc5/5C
	 Lie5C4XSLhOayKYThhxjf43HxQ19oAWN9TTttR4jMbhrIpzSUOhiL7h4Akkt2VDN5l
	 aZqy3YVIQltBQ==
From: Arnd Bergmann <arnd@kernel.org>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Murali Karicheri <m-karicheri2@ti.com>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	linux-omap@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Kevin Hao <haokexin@gmail.com>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] [v4, net-next] net: ethernet: ti-cpsw:: rename soft_reset() function
Date: Thu,  2 Apr 2026 20:46:53 +0200
Message-Id: <20260402184726.3746487-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

While looking at the glob symbols shared between the cpsw drivers,
I noticed that soft_reset() is the only one that is missing a proper
namespace prefix, and will pollute the kernel namespace, so rename
it to be consistent with the other symbols.

Fixes: c5013ac1dd0e1 ("net: ethernet: ti: cpsw: move set of common functions in cpsw_priv")
Reviewed-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/ti/cpsw.c      | 2 +-
 drivers/net/ethernet/ti/cpsw_new.c  | 2 +-
 drivers/net/ethernet/ti/cpsw_priv.c | 2 +-
 drivers/net/ethernet/ti/cpsw_priv.h | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index b0e18bdc2c85..aa3531e844e8 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -706,7 +706,7 @@ static void cpsw_init_host_port(struct cpsw_priv *priv)
 	struct cpsw_common *cpsw = priv->cpsw;
 
 	/* soft reset the controller and initialize ale */
-	soft_reset("cpsw", &cpsw->regs->soft_reset);
+	cpsw_soft_reset("cpsw", &cpsw->regs->soft_reset);
 	cpsw_ale_start(cpsw->ale);
 
 	/* switch to vlan aware mode */
diff --git a/drivers/net/ethernet/ti/cpsw_new.c b/drivers/net/ethernet/ti/cpsw_new.c
index 7f42f58a4b03..c5be359f3c66 100644
--- a/drivers/net/ethernet/ti/cpsw_new.c
+++ b/drivers/net/ethernet/ti/cpsw_new.c
@@ -573,7 +573,7 @@ static void cpsw_init_host_port(struct cpsw_priv *priv)
 	u32 control_reg;
 
 	/* soft reset the controller and initialize ale */
-	soft_reset("cpsw", &cpsw->regs->soft_reset);
+	cpsw_soft_reset("cpsw", &cpsw->regs->soft_reset);
 	cpsw_ale_start(cpsw->ale);
 
 	/* switch to vlan aware mode */
diff --git a/drivers/net/ethernet/ti/cpsw_priv.c b/drivers/net/ethernet/ti/cpsw_priv.c
index bc4fdf17a99e..c6eb6b785b0b 100644
--- a/drivers/net/ethernet/ti/cpsw_priv.c
+++ b/drivers/net/ethernet/ti/cpsw_priv.c
@@ -275,7 +275,7 @@ void cpsw_set_slave_mac(struct cpsw_slave *slave, struct cpsw_priv *priv)
 	slave_write(slave, mac_lo(priv->mac_addr), SA_LO);
 }
 
-void soft_reset(const char *module, void __iomem *reg)
+void cpsw_soft_reset(const char *module, void __iomem *reg)
 {
 	unsigned long timeout = jiffies + HZ;
 
diff --git a/drivers/net/ethernet/ti/cpsw_priv.h b/drivers/net/ethernet/ti/cpsw_priv.h
index acb6181c5c9e..fddd7a79f4b0 100644
--- a/drivers/net/ethernet/ti/cpsw_priv.h
+++ b/drivers/net/ethernet/ti/cpsw_priv.h
@@ -458,7 +458,7 @@ int cpsw_tx_poll(struct napi_struct *napi_tx, int budget);
 int cpsw_rx_mq_poll(struct napi_struct *napi_rx, int budget);
 int cpsw_rx_poll(struct napi_struct *napi_rx, int budget);
 void cpsw_rx_vlan_encap(struct sk_buff *skb);
-void soft_reset(const char *module, void __iomem *reg);
+void cpsw_soft_reset(const char *module, void __iomem *reg);
 void cpsw_set_slave_mac(struct cpsw_slave *slave, struct cpsw_priv *priv);
 void cpsw_ndo_tx_timeout(struct net_device *ndev, unsigned int txqueue);
 int cpsw_need_resplit(struct cpsw_common *cpsw);
-- 
2.39.5

