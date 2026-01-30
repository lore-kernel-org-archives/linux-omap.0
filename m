Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB9E36CDF1
	for <linux-omap@vger.kernel.org>; Fri, 30 Jan 2026 05:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769751260; cv=none; b=WrKNIpAAlofelLGwcxv4ziNvbjk3ZNrDEFAH0yZEVCHg3GwTS463FLs5HPa3WRDXvs62UWjHhARtca1Cv6d0sqlSqtq+2iv94u9czQuk+ox1Z4qqaz2vM5KLmnRncgopN0aoj19c7IxDQFiu0oQOBIVyJC+UZ4rUYR8TX/O6adw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769751260; c=relaxed/simple;
	bh=0h7xP6A49Jgeo/0GDXqLFRTApRe+v4rNX4sEgCnoL5M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Pe9+MtfKUb34Gh42xJAdN0/FEUZcCtk/xa91Gljmr+18orm9bPReXgloQXN4KPmG+YS05raMEUpMDnoaxHn1W5c9mFybPRvgqsbnyia5iyIUgeMm2I+3OrCAZ5pX1fCY9qE+aFNJXCT03VO0wW106qTStOYyrY9l0IBZWxA1dDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DmtKyMmh; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DmtKyMmh"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8c530866cf0so175483985a.1
        for <linux-omap@vger.kernel.org>; Thu, 29 Jan 2026 21:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769751258; x=1770356058; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UKpVoG4fkiASguZlTDW91/9jV9J6kBfvakyqskZ0dmo=;
        b=DmtKyMmhD0F6RW5pebHUNE+KewYZhUOVILAlykZGiHaD/rB0LujTG6wr/87Rxn0riD
         Fcx/18UGC7b/ElxVBp8YC2hSO6PLgEEdUvw9u+OytAY86MuR5I2W/eQ8yH5OwvDyr2GM
         A1gUyb76DtxzwiFPq56fu51PqZvYxaUP/u80TTS4GHqpu4um4KoM4LfVDtYReKqdvv7f
         lfU3YHfZNyybf7tqgI6F1sV9pjrDeFP3YGUvBV567Kas6oG0M0HjBZmToAE7GaGlqD4V
         zy8N5eDoE4h82jML2uyI1tmMXw+HvuzBJFVpOc3crSvZcE69lcq6Zv+0u8/6US9S9eKJ
         bd1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769751258; x=1770356058;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UKpVoG4fkiASguZlTDW91/9jV9J6kBfvakyqskZ0dmo=;
        b=CfFOxe2ns0Bv/v1s9cyEFxXq7RibEzjuKEI6DGV6xa1ef0ql7L+Jt809u3zxPqeIAh
         bqmOVy8fEw89RPswkbxRZ+H7eKEP54jKFDRi9GYfFpsX91Z2w4GuZDQf8OPwzVrjsVv4
         MgkdUC+6VF57EuvFoJLYRM4D1M8Ot6soZ00413RUv2ZVB/tncz2cT2dgxf0QALgAsc7E
         NCfV9EnCbjAVwASRZEtdoKxZ9yIvyyJwC6G1CyU18VluvLFBe/DAYSdPB2hXsCBLsq0n
         hBZgwH40fksYN1TpkcI/qZmOQxYJbBrRG02yESrl8N8bVMiOXeNcUciY3uA4KmLWmfTi
         0ZcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGqpTq5YHDK7UPuymVOmU2C8P7U4j1P6Sxz0QP/I87epF6YYlKP/8izplAuaMufOr0LZ90/pgdPedL@vger.kernel.org
X-Gm-Message-State: AOJu0YymARt33iu73fkxF7ntdj5N02S3gx+tsBW6tzYCMeU9kdAycAN1
	rkMB3KDVm5JpEriOdYx6rk9URAxEP3PIVmYgcPW1LjYVYw7bPMuLYOdP
X-Gm-Gg: AZuq6aL9o9Z0i6f4F3h54QqlCnZSbZckgpsJT1n0DK7YhH30o1MtGXEmBRSoiEOdiea
	LfBZogi7pqFdJHtidmsSmFczKmIwYcQPYcuXGnW5eSq5c6FftXYcc3bNQh4AzbMGLg6BPi21Cr/
	n65sTiI+hDesdMyHl4Zi58gZX9+pgQZ7g2bJdvWaOh+50O659vAaCiCBnMlZaWdR3LrWd137O2p
	W3WFCb8H+FoTKfTKEoW+gSYcbiXCjvRtVzTq0E02VcHypYUbG53WJhSLn4kcRhOIrFKRpWxeRR3
	jADMSp44fPstDP2xAHoOvjKrxQ5zcfcJJ3XjKE+uk7QL+pNp2sdru7YS6HoOQ8jYiRmghWgcR9n
	vi2mA+8XYmiJ8CJCAB44XEyKabMKoA+dDMZsqtfPwhuLy1RdYaNRLmEva+eV9QaVExWwUke5jjo
	GoTrZBydcESKVzBwoBUPZO
X-Received: by 2002:a05:620a:4542:b0:8c6:b14e:655d with SMTP id af79cd13be357-8c9eb30e4a9mr249559585a.74.1769751257701;
        Thu, 29 Jan 2026 21:34:17 -0800 (PST)
Received: from localhost.localdomain ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711d2847asm551232885a.34.2026.01.29.21.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 21:34:17 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
Date: Fri, 30 Jan 2026 13:34:07 +0800
Subject: [PATCH net v4] net: cpsw_new: Execute ndo_set_rx_mode callback in
 a work queue
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260130-bbb-v4-1-2bd000a15c34@gmail.com>
X-B4-Tracking: v=1; b=H4sIAM5CfGkC/13MTQ7CIBAF4Ks0rMXwj7ryHsZFgaElsa2Bhmia3
 l2km2pm9WbmewtKEAMkdGkWFCGHFKaxBHFokO3bsQMcXMmIEaYIZRwbY7CzXGnplaaOoPL5jOD
 Dq7bc0AgzupdlH9I8xXdtzrSefkoyxWW0MsRoeuLCXbuhDY+jnYbqM9sbuRn2NVJo71tjz47/G
 743ejO8GAmaei6IpXDem3VdP/xw/1UDAQAA
X-Change-ID: 20260123-bbb-dc3675f671d0
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
Changes in v4:
- Using schedule_work() instead of creating a dedicated workqueue.

- Link to v3: https://lore.kernel.org/r/20260127-bbb-v3-1-5e71f340c1e9@gmail.com

Changes in v3:
- Resolve the deadlock issue identified in the AI review [2]
  by moving the netif_running() check under the RTNL lock and removing the
  cancel_work_sync() call in cpsw_ndo_stop().

- Link to v2: https://lore.kernel.org/r/20260125-bbb-v2-1-1547ffabc9d3@gmail.com

Changes in v2:
- Addresses the issue identified in the AI review [1]:
  - Adds a netif_running() check in cpsw_ndo_set_rx_mode_work()
  - Cancels the rx_mode_work in cpsw_ndo_stop()

- Link to v1: https://lore.kernel.org/r/20260123-bbb-v1-1-176b0b71834d@gmail.com

[1] https://netdev-ai.bots.linux.dev/ai-review.html?id=bd885e1e-1aed-4755-ad60-7150737ad0f5
[2] https://netdev-ai.bots.linux.dev/ai-review.html?id=c9fc3cf8-a06c-4cb8-b26b-910e775951a0
---
Please note that the cpsw driver also has the same issue. If this resolution
is acceptable, I will create another patch to fix the issue in cpsw.

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
 drivers/net/ethernet/ti/cpsw_new.c  | 33 +++++++++++++++++++++++++++++----
 drivers/net/ethernet/ti/cpsw_priv.h |  1 +
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw_new.c b/drivers/net/ethernet/ti/cpsw_new.c
index ab88d4c02cbde76207f89cf433e2b383dcde6a83..744657cad0927da21232969d07c15e68f44811e3 100644
--- a/drivers/net/ethernet/ti/cpsw_new.c
+++ b/drivers/net/ethernet/ti/cpsw_new.c
@@ -248,15 +248,25 @@ static int cpsw_purge_all_mc(struct net_device *ndev, const u8 *addr, int num)
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
+	if (!netif_running(ndev)) {
+		rtnl_unlock();
+		return;
+	}
+
+	netif_addr_lock_bh(ndev);
 	if (ndev->flags & IFF_PROMISC) {
 		/* Enable promiscuous mode */
 		cpsw_set_promiscious(ndev, true);
 		cpsw_ale_set_allmulti(cpsw->ale, IFF_ALLMULTI, priv->emac_port);
+		netif_addr_unlock_bh(ndev);
+		rtnl_unlock();
 		return;
 	}
 
@@ -270,6 +280,15 @@ static void cpsw_ndo_set_rx_mode(struct net_device *ndev)
 	/* add/remove mcast address either for real netdev or for vlan */
 	__hw_addr_ref_sync_dev(&ndev->mc, ndev, cpsw_add_mc_addr,
 			       cpsw_del_mc_addr);
+	netif_addr_unlock_bh(ndev);
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
@@ -1398,6 +1417,7 @@ static int cpsw_create_ports(struct cpsw_common *cpsw)
 		priv->msg_enable = netif_msg_init(debug_level, CPSW_DEBUG);
 		priv->emac_port = i + 1;
 		priv->tx_packet_min = CPSW_MIN_PACKET_SIZE;
+		INIT_WORK(&priv->rx_mode_work, cpsw_ndo_set_rx_mode_work);
 
 		if (is_valid_ether_addr(slave_data->mac_addr)) {
 			ether_addr_copy(priv->mac_addr, slave_data->mac_addr);
@@ -1447,13 +1467,18 @@ static int cpsw_create_ports(struct cpsw_common *cpsw)
 
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
+		disable_work_sync(&priv->rx_mode_work);
+		unregister_netdev(ndev);
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

---
base-commit: 33a647c659ffa5bdb94abc345c8c86768ff96215
change-id: 20260123-bbb-dc3675f671d0

Best regards,
-- 
Kevin Hao <haokexin@gmail.com>

