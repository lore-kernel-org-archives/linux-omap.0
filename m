Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC8D29ACDB
	for <linux-omap@vger.kernel.org>; Tue,  3 Feb 2026 02:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770085155; cv=none; b=E1I8MIe9MkdhZVwDeT8TeV1EplN5usEP5VYwfXjHsApkDLVGcFjimrKqlcPB5nUhUD4XnmefSRELqqE8AXdVwL2mp+wknCWaU7jP49k+a7mRZVMRicu3lqv5avVZu41ta8nlXHTfotXrUaWmAL6wF95umtMSWKNMdNYM3IiwmKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770085155; c=relaxed/simple;
	bh=YFdR/exoj2HPus84yYYEmp5YFMYBWPstIXz2rcdAMDE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ApAlMN/Wp7T2S3hqsCM3WGE5FHE57q7d3NSqXmBmUTEQausr2+mSHU5hLr+wLrcegX1pUjCu67Civ4nS8XSQduiFevH6pSM3mjalawnwm3FklLCmzB+/B+Onszq5xSZmYzX/ReN+PdXrlXLt837uJArCgCjetji8FL/QfhDG+LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mn8FukeZ; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mn8FukeZ"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8c711959442so37932085a.0
        for <linux-omap@vger.kernel.org>; Mon, 02 Feb 2026 18:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770085152; x=1770689952; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NCLj1WVf/iEPR6Pe1CdNCEP13TWMPR4w0oDQlKVXg8g=;
        b=mn8FukeZPqXJkTLb85pSXDYyIuoBwMN4PwRo4IZ1++AgivOZxv8s/6dkEnYegsdLlF
         VfDez3RRPkrfe4dcyhXCJbP7McgbDc5ull6EqoXE8VjIns/evdr604qii/FimQ+gla6y
         zaILkOXISrNLqYGTWuWaswgeDKE/tZTKkVtRlkv6iYO+vMNsaNIsqDqsAcnI1QOpzxr+
         +jgStNBn0M9g6NUUF8tbVjlcj0YuEiPEKd4Gbb8dIwXH2lutpm5PUO8DfrARQOimr/y0
         wp49B7vujurVfkgxfxOW5X3xHsyx6if2/ylEKIaCjsKqmp3gQoew/S3MiVnIR2iF4PH1
         205Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770085152; x=1770689952;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NCLj1WVf/iEPR6Pe1CdNCEP13TWMPR4w0oDQlKVXg8g=;
        b=eib/zMc1mVUQIavaChjF4tO2cxDLzLGzCyZbBhwMAoLlPyj0JkfqlKphleUw0YBTft
         FUpZQNa4mQXVQNngi3d3mzfV3fbP6TpYcipKTjWZph0VTrawMbbUNSwvpNtIXdWv8fuP
         NFtoqqfKDkML3hWEVMsax2iBPcvSW8xNYgnfIiniVMYNakFa9v59vRq+s01m8ly9QTMm
         Tv6lkitCKfCk5PZXGFe2FFXQWHrxNNlk9Iee5yZfFTr/AFd93e9Geh17S5MqESOK1fL7
         jEDqm6WGuXCZuCtKa8sH8+qpsK9s914aon9SeGKnSZptAq7GFQuQqfvV9nrgrIIVSr7L
         cvxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUO0fq844kY2B2TBmKaqgKmK11EGhIAhmhMV3OjxsJamVJwPnY5AiPnw+QthwRlxz0IzFxUYhMdWGEg@vger.kernel.org
X-Gm-Message-State: AOJu0YzrUFc2ioTMAFX1Dpeqa+eMJrKOhYLaXce0I4HbzOKFg7KLCF3o
	T9TOz5v8MiCb8D9pu12sxn07G8mEl3WyOgqbrrl6Y26U/PRFHUzQzLjg
X-Gm-Gg: AZuq6aJuje5Wcm8kPiYvhwpRUTei1APHo1ptitNH37nSl8FycuYKBtcR5UOU3wF+k7k
	pBP8B1VqFpKg0uVIby2DiItRfJk/cCfwa5Kh97l9Fje1psKwAbU77VD6aSzBHr4BTeW1HboE3do
	hosdiTPrLevQIi6xraTu7zCGdOjCvhb58/VrkOuEzNJgyLPKAoUluiYLZo4D4RgwhmmghnKNg6T
	JUhz2gk/YoN5HvkkQYO8U35sjVNHqga4dFvx/NzyJSqjSdCQ5w9RND3rUrcsspHyLdifurecsCP
	WSnD/uzymSMuDwuTpMeFKDCwNf07LyIKZPuh6n6sPUnMFWBY8LiJtH106FoD7o0ton2dciM+lTL
	xkCQ/SCpKigA4DlSLyQoptTfYWxFVvU/pXD1Nf3pCJkny9iRhLg6vsGGz1484crWPyVZpRJyMZF
	UBU/9yiD1jtd6czVeNaCCP
X-Received: by 2002:a05:620a:3723:b0:8b2:e9e1:4023 with SMTP id af79cd13be357-8ca20483bc7mr194871785a.27.1770085152190;
        Mon, 02 Feb 2026 18:19:12 -0800 (PST)
Received: from localhost.localdomain ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711d5c34asm1337199885a.50.2026.02.02.18.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 18:19:11 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
Date: Tue, 03 Feb 2026 10:18:31 +0800
Subject: [PATCH net v5 2/2] net: cpsw: Execute ndo_set_rx_mode callback in
 a work queue
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260203-bbb-v5-2-ea0ea217a85c@gmail.com>
References: <20260203-bbb-v5-0-ea0ea217a85c@gmail.com>
In-Reply-To: <20260203-bbb-v5-0-ea0ea217a85c@gmail.com>
To: netdev@vger.kernel.org
Cc: Kevin Hao <haokexin@gmail.com>, stable@vger.kernel.org, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, linux-omap@vger.kernel.org
X-Mailer: b4 0.14.2

Commit 1767bb2d47b7 ("ipv6: mcast: Don't hold RTNL for
IPV6_ADD_MEMBERSHIP and MCAST_JOIN_GROUP.") removed the RTNL lock for
IPV6_ADD_MEMBERSHIP and MCAST_JOIN_GROUP operations. However, this
change triggered the following call trace on my BeagleBone Black board:
  WARNING: net/8021q/vlan_core.c:236 at vlan_for_each+0x120/0x124, CPU#0: rpcbind/481
  RTNL: assertion failed at net/8021q/vlan_core.c (236)
  Modules linked in:
  CPU: 0 UID: 997 PID: 481 Comm: rpcbind Not tainted 6.19.0-rc7-next-20260130-yocto-standard+ #35 PREEMPT
  Hardware name: Generic AM33XX (Flattened Device Tree)
  Call trace:
   unwind_backtrace from show_stack+0x28/0x2c
   show_stack from dump_stack_lvl+0x30/0x38
   dump_stack_lvl from __warn+0xb8/0x11c
   __warn from warn_slowpath_fmt+0x130/0x194
   warn_slowpath_fmt from vlan_for_each+0x120/0x124
   vlan_for_each from cpsw_add_mc_addr+0x54/0x98
   cpsw_add_mc_addr from __hw_addr_ref_sync_dev+0xc4/0xec
   __hw_addr_ref_sync_dev from __dev_mc_add+0x78/0x88
   __dev_mc_add from igmp6_group_added+0x84/0xec
   igmp6_group_added from __ipv6_dev_mc_inc+0x1fc/0x2f0
   __ipv6_dev_mc_inc from __ipv6_sock_mc_join+0x124/0x1b4
   __ipv6_sock_mc_join from do_ipv6_setsockopt+0x84c/0x1168
   do_ipv6_setsockopt from ipv6_setsockopt+0x88/0xc8
   ipv6_setsockopt from do_sock_setsockopt+0xe8/0x19c
   do_sock_setsockopt from __sys_setsockopt+0x84/0xac
   __sys_setsockopt from ret_fast_syscall+0x0/0x54

This trace occurs because vlan_for_each() is called within
cpsw_ndo_set_rx_mode(), which expects the RTNL lock to be held.
Since modifying vlan_for_each() to operate without the RTNL lock is not
straightforward, and because ndo_set_rx_mode() is invoked both with and
without the RTNL lock across different code paths, simply adding
rtnl_lock() in cpsw_ndo_set_rx_mode() is not a viable solution.

To resolve this issue, we opt to execute the actual processing within
a work queue, following the approach used by the icssg-prueth driver.

Please note: To reproduce this issue, I manually reverted the changes to
am335x-bone-common.dtsi from commit c477358e66a3 ("ARM: dts: am335x-bone:
switch to new cpsw switch drv") in order to revert to the legacy cpsw
driver.

Fixes: 1767bb2d47b7 ("ipv6: mcast: Don't hold RTNL for IPV6_ADD_MEMBERSHIP and MCAST_JOIN_GROUP.")
Signed-off-by: Kevin Hao <haokexin@gmail.com>
Cc: stable@vger.kernel.org
---
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: Roger Quadros <rogerq@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>
Cc: linux-omap@vger.kernel.org
---
 drivers/net/ethernet/ti/cpsw.c | 41 +++++++++++++++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 54c24cd3d3be639c90111856efaf154cd77f7ee4..b0e18bdc2c851086d6db6a3d7b9659c23c73b969 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -305,12 +305,19 @@ static int cpsw_purge_all_mc(struct net_device *ndev, const u8 *addr, int num)
 	return 0;
 }
 
-static void cpsw_ndo_set_rx_mode(struct net_device *ndev)
+static void cpsw_ndo_set_rx_mode_work(struct work_struct *work)
 {
-	struct cpsw_priv *priv = netdev_priv(ndev);
+	struct cpsw_priv *priv = container_of(work, struct cpsw_priv, rx_mode_work);
 	struct cpsw_common *cpsw = priv->cpsw;
+	struct net_device *ndev = priv->ndev;
 	int slave_port = -1;
 
+	rtnl_lock();
+	if (!netif_running(ndev))
+		goto unlock_rtnl;
+
+	netif_addr_lock_bh(ndev);
+
 	if (cpsw->data.dual_emac)
 		slave_port = priv->emac_port + 1;
 
@@ -318,7 +325,7 @@ static void cpsw_ndo_set_rx_mode(struct net_device *ndev)
 		/* Enable promiscuous mode */
 		cpsw_set_promiscious(ndev, true);
 		cpsw_ale_set_allmulti(cpsw->ale, IFF_ALLMULTI, slave_port);
-		return;
+		goto unlock_addr;
 	} else {
 		/* Disable promiscuous mode */
 		cpsw_set_promiscious(ndev, false);
@@ -331,6 +338,18 @@ static void cpsw_ndo_set_rx_mode(struct net_device *ndev)
 	/* add/remove mcast address either for real netdev or for vlan */
 	__hw_addr_ref_sync_dev(&ndev->mc, ndev, cpsw_add_mc_addr,
 			       cpsw_del_mc_addr);
+
+unlock_addr:
+	netif_addr_unlock_bh(ndev);
+unlock_rtnl:
+	rtnl_unlock();
+}
+
+static void cpsw_ndo_set_rx_mode(struct net_device *ndev)
+{
+	struct cpsw_priv *priv = netdev_priv(ndev);
+
+	schedule_work(&priv->rx_mode_work);
 }
 
 static unsigned int cpsw_rxbuf_total_len(unsigned int len)
@@ -1472,6 +1491,7 @@ static int cpsw_probe_dual_emac(struct cpsw_priv *priv)
 	priv_sl2->ndev = ndev;
 	priv_sl2->dev  = &ndev->dev;
 	priv_sl2->msg_enable = netif_msg_init(debug_level, CPSW_DEBUG);
+	INIT_WORK(&priv_sl2->rx_mode_work, cpsw_ndo_set_rx_mode_work);
 
 	if (is_valid_ether_addr(data->slave_data[1].mac_addr)) {
 		memcpy(priv_sl2->mac_addr, data->slave_data[1].mac_addr,
@@ -1653,6 +1673,7 @@ static int cpsw_probe(struct platform_device *pdev)
 	priv->dev  = dev;
 	priv->msg_enable = netif_msg_init(debug_level, CPSW_DEBUG);
 	priv->emac_port = 0;
+	INIT_WORK(&priv->rx_mode_work, cpsw_ndo_set_rx_mode_work);
 
 	if (is_valid_ether_addr(data->slave_data[0].mac_addr)) {
 		memcpy(priv->mac_addr, data->slave_data[0].mac_addr, ETH_ALEN);
@@ -1758,6 +1779,8 @@ static int cpsw_probe(struct platform_device *pdev)
 static void cpsw_remove(struct platform_device *pdev)
 {
 	struct cpsw_common *cpsw = platform_get_drvdata(pdev);
+	struct net_device *ndev;
+	struct cpsw_priv *priv;
 	int i, ret;
 
 	ret = pm_runtime_resume_and_get(&pdev->dev);
@@ -1770,9 +1793,15 @@ static void cpsw_remove(struct platform_device *pdev)
 		return;
 	}
 
-	for (i = 0; i < cpsw->data.slaves; i++)
-		if (cpsw->slaves[i].ndev)
-			unregister_netdev(cpsw->slaves[i].ndev);
+	for (i = 0; i < cpsw->data.slaves; i++) {
+		ndev = cpsw->slaves[i].ndev;
+		if (!ndev)
+			continue;
+
+		priv = netdev_priv(ndev);
+		unregister_netdev(ndev);
+		disable_work_sync(&priv->rx_mode_work);
+	}
 
 	cpts_release(cpsw->cpts);
 	cpdma_ctlr_destroy(cpsw->dma);

-- 
2.52.0

