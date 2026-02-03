Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC9D1C5F27
	for <linux-omap@vger.kernel.org>; Tue,  3 Feb 2026 02:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770085150; cv=none; b=WhJ0VLqfQ8rc/AStX19HdnBjtxL1v3tRq4P/LUE8hbKLRP/b/noAj15ouTJbwg91spyzWmCBXuiuVn3jpdw1Nf29yMFd1UQnG2S76oOj2082E5zFARliYBXbsEy2Y+mgJlzlRAug8ZhuuQ6w0qf3w+aOQWTYQ7iFabnksYTluWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770085150; c=relaxed/simple;
	bh=PwlO+5tJ1Z658R3+kpEyrC8Bi6r9M0IwKU98dcsWaCU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=abJjWjPrc06YnlejdO5RIrKUIxol0Xa19iliCcJeL6HvHROO/+JmaAG7OFrBTzMeULv07KKAiwT8ri+mwwhRnqLU/jxgWvtkEVS9UZBzLcFbwRNId8vjyPLY2VQwJt4vDHymH9plweUots12t1T7YCjs6Wly/heaJX+Deow/PUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QwEskGGZ; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QwEskGGZ"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5014600ad12so38027751cf.2
        for <linux-omap@vger.kernel.org>; Mon, 02 Feb 2026 18:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770085148; x=1770689948; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ylf/wxb0zUUywRHu+X/57l5JJ2yWVJWbffw9Iqhdass=;
        b=QwEskGGZMS8r2/Bi6yuZR5NZKU/T6YmWTXXwA+1HBbSqOA/3Ebm24Th8M2hyy0naAh
         f3ZpRJtUcklhKkTe9Yf4ygI48u4is6Uf+oowsTqWq5C0jQErkGlImqjG6du3CDUTv6Vq
         qtXbpYdBkGn80prDPF4LUtY1i2Q27peRGMa18Hwqr4zUUAoTZ343yu2Ti0wWje5BaQds
         TrE+E/TJFVUNJm5bLfTtzEOKm5cy19eLtcaa9B+uSNNfWFs+B3h1rBRoqdPvAwZqPFtp
         0KJb0G4WUYN+ViM2Kk+G4ImNYBNlM+xcoQaoYyL+XGdGZLP9jj30Llc5oSkZ/g5JuF6O
         2mLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770085148; x=1770689948;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ylf/wxb0zUUywRHu+X/57l5JJ2yWVJWbffw9Iqhdass=;
        b=J1Lv0/Z9QtjlGLyuPVaIEUjf98AHOWPQWtSZ6cS3jKARIZq8DSdTPz3hEis4tAGh2h
         uWrFxf5dr0m5O2UZDH4eeMbEna8QPjZOP7zk/NQDQX4wcPDhOc97bdxbPoSZ0WwPKslp
         PLzUV4YKHsMrJSoZgvvi3QpIrbvlUeZMXi7sccQUYvFWtkmgi1N+fl4sJiXb7PsNsxKg
         rJuoVJ7Yz3mF/3Q4w0M1qCgzsQMwJph2qGXcGhgyH+57MCcxnKxi1xegngEkLwpz2dP9
         L5U4o9qdrputgdgWwHj8wTsJ0R8F6tVnkvhT0fNoVz/PwKwnJosU/VyNMhtf8dwkxzkm
         tENQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWU1XD1qFaOe0w4BZiIVvQt3/p2U7yovUWVMLw+6iKF8I0W0jhPkpyLwd0SqW70GayXJyTDoyc2P7T@vger.kernel.org
X-Gm-Message-State: AOJu0YytEq3Tz1jdCk6TIWqJxxGQv8CGYAyH8vPaADOUGyh7gXb155gR
	kvTIUntaNRtpA83m8PJABuGhLhlpU10lEVITT6nQznGtVp4pJvVB7VSg
X-Gm-Gg: AZuq6aL6PNHV/xd7SqrmIVZIUW1kuC9/i3FkEyXD3b0G57filI4AyTI/pObd5Fh7E0T
	UutKTrFfvXoq+Jcp7ftgwEeOT2pJ5dkNkVw/TK92o4hqNpQiQFpB8owJKYtkLUTWO/9ygGxpkpI
	ZIJLr4zS8Mm9+DucabLppMwp5LLUvVftj+pPJteRH+9uOvaBecT+VVWejAjY70pZEfVANoCkDPH
	O8vL6Ub4/kFuRMj6LjJ5TKmyExvMPGm/A6RhcslwZeY8hlm8lDfiyGpX+VempKbufRMEA7f7R1V
	oLk4nIQwLwKaM7DdZoRlUgR4PM1JIAI0eM4f5J2vHlCd+ALTET8jlRAiqAk/xkw+BFLcA4286nH
	/OLdZXa/aKHZ6mH3oAlIsM1XHQiovPZHwxz8+wX4HpgWU8UeXFEcEx1OmKmYhupT1nNkFY9g0VX
	k1MAYzny9ztHUKk6/DHwd1
X-Received: by 2002:ac8:5d89:0:b0:501:4701:e9f9 with SMTP id d75a77b69052e-505d2184a51mr174064431cf.26.1770085147611;
        Mon, 02 Feb 2026 18:19:07 -0800 (PST)
Received: from localhost.localdomain ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711d5c34asm1337199885a.50.2026.02.02.18.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 18:19:07 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
Date: Tue, 03 Feb 2026 10:18:30 +0800
Subject: [PATCH net v5 1/2] net: cpsw_new: Execute ndo_set_rx_mode callback
 in a work queue
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260203-bbb-v5-1-ea0ea217a85c@gmail.com>
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
  WARNING: net/8021q/vlan_core.c:236 at vlan_for_each+0x120/0x124, CPU#0: rpcbind/496
  RTNL: assertion failed at net/8021q/vlan_core.c (236)
  Modules linked in:
  CPU: 0 UID: 997 PID: 496 Comm: rpcbind Not tainted 6.19.0-rc6-next-20260122-yocto-standard+ #8 PREEMPT
  Hardware name: Generic AM33XX (Flattened Device Tree)
  Call trace:
   unwind_backtrace from show_stack+0x28/0x2c
   show_stack from dump_stack_lvl+0x30/0x38
   dump_stack_lvl from __warn+0xb8/0x11c
   __warn from warn_slowpath_fmt+0x130/0x194
   warn_slowpath_fmt from vlan_for_each+0x120/0x124
   vlan_for_each from cpsw_add_mc_addr+0x54/0xd8
   cpsw_add_mc_addr from __hw_addr_ref_sync_dev+0xc4/0xec
   __hw_addr_ref_sync_dev from __dev_mc_add+0x78/0x88
   __dev_mc_add from igmp6_group_added+0x84/0xec
   igmp6_group_added from __ipv6_dev_mc_inc+0x1fc/0x2f0
   __ipv6_dev_mc_inc from __ipv6_sock_mc_join+0x124/0x1b4
   __ipv6_sock_mc_join from do_ipv6_setsockopt+0x84c/0x1168
   do_ipv6_setsockopt from ipv6_setsockopt+0x88/0xc8
   ipv6_setsockopt from do_sock_setsockopt+0xe8/0x19c
   do_sock_setsockopt from __sys_setsockopt+0x84/0xac
   __sys_setsockopt from ret_fast_syscall+0x0/0x5

This trace occurs because vlan_for_each() is called within
cpsw_ndo_set_rx_mode(), which expects the RTNL lock to be held.
Since modifying vlan_for_each() to operate without the RTNL lock is not
straightforward, and because ndo_set_rx_mode() is invoked both with and
without the RTNL lock across different code paths, simply adding
rtnl_lock() in cpsw_ndo_set_rx_mode() is not a viable solution.

To resolve this issue, we opt to execute the actual processing within
a work queue, following the approach used by the icssg-prueth driver.

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
 drivers/net/ethernet/ti/cpsw_new.c  | 34 +++++++++++++++++++++++++++++-----
 drivers/net/ethernet/ti/cpsw_priv.h |  1 +
 2 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw_new.c b/drivers/net/ethernet/ti/cpsw_new.c
index ab88d4c02cbde76207f89cf433e2b383dcde6a83..21af0a10626aaf0ce6ecb04837899801743f3894 100644
--- a/drivers/net/ethernet/ti/cpsw_new.c
+++ b/drivers/net/ethernet/ti/cpsw_new.c
@@ -248,16 +248,22 @@ static int cpsw_purge_all_mc(struct net_device *ndev, const u8 *addr, int num)
 	return 0;
 }
 
-static void cpsw_ndo_set_rx_mode(struct net_device *ndev)
+static void cpsw_ndo_set_rx_mode_work(struct work_struct *work)
 {
-	struct cpsw_priv *priv = netdev_priv(ndev);
+	struct cpsw_priv *priv = container_of(work, struct cpsw_priv, rx_mode_work);
 	struct cpsw_common *cpsw = priv->cpsw;
+	struct net_device *ndev = priv->ndev;
 
+	rtnl_lock();
+	if (!netif_running(ndev))
+		goto unlock_rtnl;
+
+	netif_addr_lock_bh(ndev);
 	if (ndev->flags & IFF_PROMISC) {
 		/* Enable promiscuous mode */
 		cpsw_set_promiscious(ndev, true);
 		cpsw_ale_set_allmulti(cpsw->ale, IFF_ALLMULTI, priv->emac_port);
-		return;
+		goto unlock_addr;
 	}
 
 	/* Disable promiscuous mode */
@@ -270,6 +276,18 @@ static void cpsw_ndo_set_rx_mode(struct net_device *ndev)
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
@@ -1398,6 +1416,7 @@ static int cpsw_create_ports(struct cpsw_common *cpsw)
 		priv->msg_enable = netif_msg_init(debug_level, CPSW_DEBUG);
 		priv->emac_port = i + 1;
 		priv->tx_packet_min = CPSW_MIN_PACKET_SIZE;
+		INIT_WORK(&priv->rx_mode_work, cpsw_ndo_set_rx_mode_work);
 
 		if (is_valid_ether_addr(slave_data->mac_addr)) {
 			ether_addr_copy(priv->mac_addr, slave_data->mac_addr);
@@ -1447,13 +1466,18 @@ static int cpsw_create_ports(struct cpsw_common *cpsw)
 
 static void cpsw_unregister_ports(struct cpsw_common *cpsw)
 {
+	struct net_device *ndev;
+	struct cpsw_priv *priv;
 	int i = 0;
 
 	for (i = 0; i < cpsw->data.slaves; i++) {
-		if (!cpsw->slaves[i].ndev)
+		ndev = cpsw->slaves[i].ndev;
+		if (!ndev)
 			continue;
 
-		unregister_netdev(cpsw->slaves[i].ndev);
+		priv = netdev_priv(ndev);
+		unregister_netdev(ndev);
+		disable_work_sync(&priv->rx_mode_work);
 	}
 }
 
diff --git a/drivers/net/ethernet/ti/cpsw_priv.h b/drivers/net/ethernet/ti/cpsw_priv.h
index 91add8925e235c6cf5542fde11f3383b9234c872..acb6181c5c9e1bf6ed46a7fd14ce422efc0b724e 100644
--- a/drivers/net/ethernet/ti/cpsw_priv.h
+++ b/drivers/net/ethernet/ti/cpsw_priv.h
@@ -391,6 +391,7 @@ struct cpsw_priv {
 	u32 tx_packet_min;
 	struct cpsw_ale_ratelimit ale_bc_ratelimit;
 	struct cpsw_ale_ratelimit ale_mc_ratelimit;
+	struct work_struct rx_mode_work;
 };
 
 #define ndev_to_cpsw(ndev) (((struct cpsw_priv *)netdev_priv(ndev))->cpsw)

-- 
2.52.0

