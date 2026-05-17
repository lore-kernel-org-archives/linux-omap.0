Received: from mail-244107.protonmail.ch (mail-244107.protonmail.ch [109.224.244.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032B3299A84;
	Sun, 17 May 2026 15:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779030989; cv=none; b=r6AplrlbA7GtDllocWRfAzvZs21FMN0hD2zA+WbhtXZ0zz0vKyBf39HngaN48YxtuCY2tAseb8uxnyxiZqPWG/KAcCGcMj4MQXnik17ZUQOr0PE9W0qttgQ9E106ochSsMP7XLZBrILbne3BmcZ0f9Oj71d41ueySo1MEtMKzLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779030989; c=relaxed/simple;
	bh=iKoWjFoumDzU83662ZU2qlYoicofSlY+S6AkomCAcWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m/H68yBZmTS8YyNggP/ACkGOEhD0JwgH+eIzqMntnJSR/Y89k5nRGAW7cHhIeIQ82ve3JKZbQ9k2+d21SpoOM8P9Jpz2O6tva4kbLRpSuMWNpbwFXMfMUlD6O9qZ2w2FkLj4Yotxw2MqhgZyNQSDzOlCumdWl5mk9GGQZUJkpo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vassilevski.com; spf=pass smtp.mailfrom=vassilevski.com; dkim=pass (1024-bit key) header.d=vassilevski.com header.i=@vassilevski.com header.b=LxPlL6Nz; arc=none smtp.client-ip=109.224.244.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vassilevski.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vassilevski.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vassilevski.com header.i=@vassilevski.com header.b="LxPlL6Nz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vassilevski.com;
	s=protonmail; t=1779030983; x=1779290183;
	bh=nTuZeJsw+iCXzqp0R7o7Vg2ADgoYOa361E1gmqMhiNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=LxPlL6NzxUvGQWEUh3ho0zlX9qqMCJ7wCObFMzYmhR1d7VDgnNxAAgQ10UcQaSoIW
	 PDhICQQJ9Ov1B6wNlclHx1C8kYBMGCZntfYSLRVI3gwOTU7G3WCfOPbvfWl+Eou/Hj
	 /VrOq3JnF9y67RDmWfTR2ZPEKR6Xf7O731e841UU=
X-Pm-Submission-Id: 4gJPf65WVsz2Scpx
From: Alexander Vassilevski <oss@vassilevski.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Chintan Vankar <c-vankar@ti.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	netdev@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Alexander Vassilevski <oss@vassilevski.com>
Subject: [PATCH v2] net: ethernet: ti: am65-cpsw-nuss: remove dead vid check in slave_add_vid()
Date: Sun, 17 May 2026 08:16:11 -0700
Message-ID: <20260517151611.393789-1-oss@vassilevski.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515225715.3641804-1-oss@vassilevski.com>
References: <20260515225715.3641804-1-oss@vassilevski.com>
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

is therefore unreachable. Drop the dead branch.

With that branch gone, unreg_mcast is only ever its initializer value
of zero, so drop the variable and pass 0 directly to
cpsw_ale_vlan_add_modify().

No functional change.

Found by Smatch.

Fixes: 7bcffde02152 ("net: ethernet: ti: am65-cpsw-nuss: restore vlan configuration while down/up")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/kernel-janitors/aS_lhMwppbDHoEcX@stanley.mountain/
Suggested-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Alexander Vassilevski <oss@vassilevski.com>
---
I agree, Christophe.

 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 77f59996a0..434a310808 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -302,7 +302,7 @@ static int am65_cpsw_nuss_ndo_slave_add_vid(struct net_device *ndev,
 {
 	struct am65_cpsw_common *common = am65_ndev_to_common(ndev);
 	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
-	u32 port_mask, unreg_mcast = 0;
+	u32 port_mask;
 	int ret;
 
 	if (!common->is_emac_mode)
@@ -318,7 +318,7 @@ static int am65_cpsw_nuss_ndo_slave_add_vid(struct net_device *ndev,
 	port_mask = BIT(port->port_id) | ALE_PORT_HOST;
 	dev_info(common->dev, "Adding vlan %d to vlan filter\n", vid);
 	ret = cpsw_ale_vlan_add_modify(common->ale, vid, port_mask,
-				       unreg_mcast, port_mask, 0);
+				       0, port_mask, 0);
 
 	pm_runtime_put(common->dev);
 	return ret;
-- 
2.43.0

