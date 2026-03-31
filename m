Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A703DD507;
	Tue, 31 Mar 2026 16:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774973901; cv=none; b=RtHru8ozLgQrJ56YLEPq55vrpZSVWez/D/7baqWEaBo8QNk8L+b0wdlVc3ask+xKU6OhGCwwfbUA+Pkil3kuejtMswvT8jklN/zPaNQBCb0vaeGXbyPiilCJS8rfqtxjz7QxMkHgVFwz37Wl4mmJql6XDLbImqlVOBa7YDCls94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774973901; c=relaxed/simple;
	bh=QGd9bXDzKpQ2GF/Ov8bQV6HuUtENYRncgw6rFFREsy0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VmXeXCZrsDhh5DcDkDrAlT3UlDHruscj7IcaQ6NQMyo8SFJwUFGRzpEpxVV9pu2nuERlAkn2lUhUFn8GySOZy7RQ1Uyd87k3TTy20xIhS6j764cX9DCr/851PfRnR3VtSbfKX6+L0NsfmGSMEug2QRjDKIKVeTYGhi4/rYLRqcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D9cxP4Ay; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D9cxP4Ay"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 383EFC19423;
	Tue, 31 Mar 2026 16:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774973901;
	bh=QGd9bXDzKpQ2GF/Ov8bQV6HuUtENYRncgw6rFFREsy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D9cxP4Ay67UytxvhF1vYbtKrxvVA57uUQzG9h/OgqdlbqnPGFvn3dKh0GraANmm+K
	 kC2ndZaJd2q9M7DXR2EHaOGoUdssyY80uKKpkGHwEFeIRmEr0z2ZXG/v14VgvvK8Oi
	 N9YY4eMN1Qrd0HDwQh2xWX7AK1b3T0AH8+CW/ZHxO8yaMaOd/3Gehdc4sxievA4qo2
	 oiH1ktktfvl45JUrperOz0b0GU71d2k7xjq01RLr50UGZFFo7ZHfFnzvEP/SJlTyZ6
	 bzXS+IBV3jNZKSxE5A+AFW6G7fZjb1vVKfMJbXOSAgCzlqrlD/BrxdUiqKwqeH3Gsu
	 Yw2fqgf/h4Snw==
From: Arnd Bergmann <arnd@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Kevin Hao <haokexin@gmail.com>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	linux-omap@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [RESEND, net-next] net: ethernet: ti-cpsw:: rename soft_reset() function
Date: Tue, 31 Mar 2026 18:17:55 +0200
Message-Id: <20260331161814.3725730-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260331161254.3450606-1-arnd@kernel.org>
References: <20260331161254.3450606-1-arnd@kernel.org>
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
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I just realized that this patch needs to come before
https://lore.kernel.org/netdev/20260331161254.3450606-1-arnd@kernel.org/T/#u

The change itself is not important, but it renames a symbol that
gets exported under the new name by the other patch, so either
this gets applied first, or the other one needs a trivial change
to fix the export.
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
index 9062de64f6bf..1f6f374551cb 100644
--- a/drivers/net/ethernet/ti/cpsw_priv.c
+++ b/drivers/net/ethernet/ti/cpsw_priv.c
@@ -288,7 +288,7 @@ void cpsw_set_slave_mac(struct cpsw_slave *slave, struct cpsw_priv *priv)
 }
 EXPORT_SYMBOL_GPL(cpsw_set_slave_mac);
 
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

