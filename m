Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242F1314A60;
	Thu,  2 Apr 2026 18:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775155738; cv=none; b=TMBOrXZHxsDzD+Y5wRvD1w5u7aO0AzYO/bGM3xYx+13uXnPjxt3MZUKdTslVaD2TKnv5hXupu3sqaG61Bsyjd92HzpjtjuR4GNJ8TnZIG2+eax3DbGbX1C82WG6++LEqT7Xw7gjB29RIOpOMSSQoQz3Fww7Jc1J3vwkG7k6bBkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775155738; c=relaxed/simple;
	bh=lyS5QMvT0kZXsl8fR1ISlH93yHXC/MQdVlrEF0Agmfk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mmur32/xAB3hbkaKSRF90PgKatx8O/p8SHbOiptuPdZi/xICqQK2nKBEGa+zGxn7esAPuMuKelKN0jTr4+ZqsVRfnOJgk0/Zf1DZ+cf1As1hoU56onNDYUuE7YI4qnL4Ky4JWD/ORg0AE+cC3WVTvd7NSjd0TGS4KegMRzbpPV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AC7baZDu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AC7baZDu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09A6BC19424;
	Thu,  2 Apr 2026 18:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775155737;
	bh=lyS5QMvT0kZXsl8fR1ISlH93yHXC/MQdVlrEF0Agmfk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AC7baZDupL0QHOXXxiM0v3ee9ai2qs7PDhYjC3+gQGedNxeBHT7+dRjqGP5LtZyHx
	 6tenCrRzan8YMuPq0TDRvIwDlwKy0Oc/G0Wkgw1aRIDwytsBByX4YaTpgNvMuJ34E0
	 NfnxkJXu5DjHJsZLGM2uhA9dKQGiP48EihJSI74zwGvqATGRcIiZSBWvcer9/ACnhf
	 68rgCaFm9WnSHgISxtxwV07q6k5pn/8c/WtKNNKbG2z+8bEplfAUPjXSlzHgJ7wMxa
	 H114gGwZmjwwm61CBt7yF68YakkamM5aJ9yfgHqvWV1j3Qa4ZnWl1lKnhhn0Z5H+hS
	 XSucpa5ifsGyg==
From: Arnd Bergmann <arnd@kernel.org>
To: netdev@vger.kernel.org,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	linux-omap@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] [v4, net-next] dpaa2: avoid linking objects into multiple modules
Date: Thu,  2 Apr 2026 20:46:55 +0200
Message-Id: <20260402184726.3746487-3-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260402184726.3746487-1-arnd@kernel.org>
References: <20260402184726.3746487-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Each object file contains information about which module it gets linked
into, so linking the same file into multiple modules now causes a warning:

scripts/Makefile.build:254: drivers/net/ethernet/freescale/dpaa2/Makefile: dpaa2-mac.o is added to multiple modules: fsl-dpaa2-eth fsl-dpaa2-switch
scripts/Makefile.build:254: drivers/net/ethernet/freescale/dpaa2/Makefile: dpmac.o is added to multiple modules: fsl-dpaa2-eth fsl-dpaa2-switch

Change the way that dpaa2 is built by moving the two common files into a
separate module with exported symbols instead.

Tested-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: add missing module description
v3: rename "common" to "mac"
    drop Kconfig change
    rebase to linux-next
v4: fix changlog comment
    post along with the corresponding ti-cpsw driver change
---
 drivers/net/ethernet/freescale/dpaa2/Makefile    |  9 +++++----
 drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c | 16 ++++++++++++++++
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/Makefile b/drivers/net/ethernet/freescale/dpaa2/Makefile
index 1b05ba8d1cbf..5f74be76434f 100644
--- a/drivers/net/ethernet/freescale/dpaa2/Makefile
+++ b/drivers/net/ethernet/freescale/dpaa2/Makefile
@@ -3,15 +3,16 @@
 # Makefile for the Freescale DPAA2 Ethernet controller
 #
 
-obj-$(CONFIG_FSL_DPAA2_ETH)		+= fsl-dpaa2-eth.o
+obj-$(CONFIG_FSL_DPAA2_ETH)		+= fsl-dpaa2-eth.o fsl-dpaa2-mac.o
 obj-$(CONFIG_FSL_DPAA2_PTP_CLOCK)	+= fsl-dpaa2-ptp.o
-obj-$(CONFIG_FSL_DPAA2_SWITCH)		+= fsl-dpaa2-switch.o
+obj-$(CONFIG_FSL_DPAA2_SWITCH)		+= fsl-dpaa2-switch.o fsl-dpaa2-mac.o
 
-fsl-dpaa2-eth-objs	:= dpaa2-eth.o dpaa2-ethtool.o dpni.o dpaa2-mac.o dpmac.o dpaa2-eth-devlink.o dpaa2-xsk.o
+fsl-dpaa2-eth-objs	:= dpaa2-eth.o dpaa2-ethtool.o dpni.o dpaa2-eth-devlink.o dpaa2-xsk.o
 fsl-dpaa2-eth-${CONFIG_FSL_DPAA2_ETH_DCB} += dpaa2-eth-dcb.o
 fsl-dpaa2-eth-${CONFIG_DEBUG_FS} += dpaa2-eth-debugfs.o
 fsl-dpaa2-ptp-objs	:= dpaa2-ptp.o dprtc.o
-fsl-dpaa2-switch-objs	:= dpaa2-switch.o dpaa2-switch-ethtool.o dpsw.o dpaa2-switch-flower.o dpaa2-mac.o dpmac.o
+fsl-dpaa2-switch-objs	:= dpaa2-switch.o dpaa2-switch-ethtool.o dpsw.o dpaa2-switch-flower.o
+fsl-dpaa2-mac-objs	+= dpaa2-mac.o dpmac.o
 
 # Needed by the tracing framework
 CFLAGS_dpaa2-eth.o := -I$(src)
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c
index ad812ebf3139..1f80a527264a 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c
@@ -544,6 +544,7 @@ void dpaa2_mac_start(struct dpaa2_mac *mac)
 
 	phylink_start(mac->phylink);
 }
+EXPORT_SYMBOL_GPL(dpaa2_mac_start);
 
 void dpaa2_mac_stop(struct dpaa2_mac *mac)
 {
@@ -554,6 +555,7 @@ void dpaa2_mac_stop(struct dpaa2_mac *mac)
 	if (mac->serdes_phy)
 		phy_power_off(mac->serdes_phy);
 }
+EXPORT_SYMBOL_GPL(dpaa2_mac_stop);
 
 int dpaa2_mac_connect(struct dpaa2_mac *mac)
 {
@@ -646,6 +648,7 @@ int dpaa2_mac_connect(struct dpaa2_mac *mac)
 
 	return err;
 }
+EXPORT_SYMBOL_GPL(dpaa2_mac_connect);
 
 void dpaa2_mac_disconnect(struct dpaa2_mac *mac)
 {
@@ -658,6 +661,7 @@ void dpaa2_mac_disconnect(struct dpaa2_mac *mac)
 	of_phy_put(mac->serdes_phy);
 	mac->serdes_phy = NULL;
 }
+EXPORT_SYMBOL_GPL(dpaa2_mac_disconnect);
 
 int dpaa2_mac_open(struct dpaa2_mac *mac)
 {
@@ -729,6 +733,7 @@ int dpaa2_mac_open(struct dpaa2_mac *mac)
 	dpmac_close(mac->mc_io, 0, dpmac_dev->mc_handle);
 	return err;
 }
+EXPORT_SYMBOL_GPL(dpaa2_mac_open);
 
 void dpaa2_mac_close(struct dpaa2_mac *mac)
 {
@@ -753,6 +758,7 @@ void dpaa2_mac_close(struct dpaa2_mac *mac)
 	if (mac->fw_node)
 		fwnode_handle_put(mac->fw_node);
 }
+EXPORT_SYMBOL_GPL(dpaa2_mac_close);
 
 static void dpaa2_mac_transfer_stats(const struct dpmac_counter *counters,
 				     size_t num_counters, void *s,
@@ -824,6 +830,7 @@ void dpaa2_mac_get_rmon_stats(struct dpaa2_mac *mac,
 
 	*ranges = dpaa2_mac_rmon_ranges;
 }
+EXPORT_SYMBOL_GPL(dpaa2_mac_get_rmon_stats);
 
 void dpaa2_mac_get_pause_stats(struct dpaa2_mac *mac,
 			       struct ethtool_pause_stats *s)
@@ -835,6 +842,7 @@ void dpaa2_mac_get_pause_stats(struct dpaa2_mac *mac,
 				     DPAA2_MAC_NUM_PAUSE_STATS,
 				     dpaa2_mac_pause_stats, s);
 }
+EXPORT_SYMBOL_GPL(dpaa2_mac_get_pause_stats);
 
 void dpaa2_mac_get_ctrl_stats(struct dpaa2_mac *mac,
 			      struct ethtool_eth_ctrl_stats *s)
@@ -846,6 +854,7 @@ void dpaa2_mac_get_ctrl_stats(struct dpaa2_mac *mac,
 				     DPAA2_MAC_NUM_ETH_CTRL_STATS,
 				     dpaa2_mac_eth_ctrl_stats, s);
 }
+EXPORT_SYMBOL_GPL(dpaa2_mac_get_ctrl_stats);
 
 void dpaa2_mac_get_eth_mac_stats(struct dpaa2_mac *mac,
 				 struct ethtool_eth_mac_stats *s)
@@ -857,11 +866,13 @@ void dpaa2_mac_get_eth_mac_stats(struct dpaa2_mac *mac,
 				     DPAA2_MAC_NUM_ETH_MAC_STATS,
 				     dpaa2_mac_eth_mac_stats, s);
 }
+EXPORT_SYMBOL_GPL(dpaa2_mac_get_eth_mac_stats);
 
 int dpaa2_mac_get_sset_count(void)
 {
 	return DPAA2_MAC_NUM_ETHTOOL_STATS;
 }
+EXPORT_SYMBOL_GPL(dpaa2_mac_get_sset_count);
 
 void dpaa2_mac_get_strings(u8 **data)
 {
@@ -870,6 +881,7 @@ void dpaa2_mac_get_strings(u8 **data)
 	for (i = 0; i < DPAA2_MAC_NUM_ETHTOOL_STATS; i++)
 		ethtool_puts(data, dpaa2_mac_ethtool_stats[i].name);
 }
+EXPORT_SYMBOL_GPL(dpaa2_mac_get_strings);
 
 void dpaa2_mac_get_ethtool_stats(struct dpaa2_mac *mac, u64 *data)
 {
@@ -921,3 +933,7 @@ void dpaa2_mac_get_ethtool_stats(struct dpaa2_mac *mac, u64 *data)
 		*(data + i) = value;
 	}
 }
+EXPORT_SYMBOL_GPL(dpaa2_mac_get_ethtool_stats);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("DPAA2 Ethernet MAC library");
-- 
2.39.5

