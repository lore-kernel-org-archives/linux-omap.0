Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FB53A7F70
	for <linux-omap@vger.kernel.org>; Fri,  7 Aug 2026 03:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786074898; cv=none; b=hItJJ62GtpMzLzfZaIVdjbRHxv8JHfi1uPpBi2v9FvZQZo2oYQw3KDnZf0RH4qO9oGkJHVER27DpLdgeuyIhNZqOV17akosiMQVEAXsuc45tayf3DBeyhLURfIM5RAXgMA5z53HMUYmgAnG3Lf5fKaI65fyYpe7neb9+wf6qdK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786074898; c=relaxed/simple;
	bh=urJKRS4nkm2bfOmYvvDKgabL9LEo8/9eE7IfW9T6/a0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qReZ/12JAeRULfL2IKQtG/UChD0iSIIjzLJRJpoiDt6sOV7jEIda+lce/M6U5VVX6CDyU4yLP1mfmZxTBmo7sdWZYFTU2NtoaS38FsnDWpoLYJA9RVaJHkk+uq7LPuRVg/PwfRe6D+vgQb0g1LsCZ5PyQ/3OlS65t0C+5R09HuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LpJINB2l; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LpJINB2l"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7ee37dc91f5so1905283a34.3
        for <linux-omap@vger.kernel.org>; Thu, 06 Aug 2026 20:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786074888; x=1786679688; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OXJkPo/CoVJ+XVdgEWXyycv7lfOXrpB/Ske012W9nQM=;
        b=LpJINB2lcmt0BuaOWIZ0yx2lQYXa0pN8Q6tkOrq4fyzY/bht2TG9xmpcwET7vFlVzz
         0iF0OfLi8YFB9MlAHEi3yGLcbhO7CcfIrpImMF/fC0zXDLyR35mwoqpPZk7TnNjKKLjX
         OSIfQgM0MvIbl3wrztm4WQUff1npoBVwRiv9d/YJAyxSHnQ7JF38X9dd2Uyk8khIx2Cr
         RnCUe+WbTqA4A6VFSvHhkWxNAV4H08UHGMHKJEz9iG9UpGDEGb70MzDUriFj41MbACrq
         s0iOW/9hPaYYuo8GlClXM8P9PoY1/o3+FbtAP++KoW/7ncR0I8JqGukrVYGOsaIJcxRj
         eT5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786074888; x=1786679688;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OXJkPo/CoVJ+XVdgEWXyycv7lfOXrpB/Ske012W9nQM=;
        b=jZqFjZYezLpJNxImJ4Y+CYKHWsmHOaYOnLNoUf+FcETgtsUyAUDrV0IJmUi9JgiS7a
         RaiDceUW43CPSBa+ySKZAO4jd/NjFSXSx7W5fHyCi/C2OlGG9aC1ZMkT8L3rp9B1Us19
         z6/um0jRoRkDOzvrMsJug1jvV7jqIzZoHZYuMLi7CDvq4LkMUTX/AhNW117qc7UHaKTG
         XJRi0cOTE4I3fq3FGgzo6A1nxTx5vrEhBSfpb2lC+AAu31ty/YLe44bi7SA/ly/3a/+Y
         Sxpekp93rW/nJgbon661iWKI2KuemX3PdU9rIHI2N9763rSi2f4HZqHQRWJiKnuyvxt2
         tIcQ==
X-Forwarded-Encrypted: i=1; AHgh+RrE6B6Dgm4h0FuxIynjY/MUV8C27qpTuo8DHE8EhUxSqwNRs2SGpitwhPFUXbK2dsyMeR/URYdwr0l/@vger.kernel.org
X-Gm-Message-State: AOJu0YzxdLCIK8lcbzR1mFvuncTSA27NVmdQt+wEt58WPwhvdmnHYn0n
	osb4SpM9QWDpIt4hqtbgRfrIITYC+ckW5a4LxeuBtAzTkuxoVX5CnkAg
X-Gm-Gg: AR+sD121dKUM/WwdcClf1jG9u+b1KoZgv9GVDKq7fRvw8F5ADXBmcgEHXaV3LHNgp+E
	Xhvu3htOLQxfClA16DaY+b2X0EVV6D60xZhDcNtJV16gqoCCAbGOxjmz8qFYskF2GPQ3o+2nGTm
	q+ZCQ50kR/8nLu52xDcvjSnUf9OFpFudQ/1/8k73NZFykZzmUmbbyH5x5rJBPr+5cx9s61g4TzL
	eFc54GLy2DxmgCHJu6tN+9v5QLUWE5rK/fqPJswBAfqz2T6Rza8RLvcBy5tnQuIAskJGLperwtT
	wbFPfLitEddZ+eInsGs6cKgTcm4iDGnHvNk4D2tEqu/lFW/hCk3c7sBX6ofcYEn3lcqDsfvW67t
	dvNJRBasXLASJv5Kq0/P5lqLF/uMhGw7zMziIBkcvu353vzDtvKduDjJ/PsTNVXGFgRQT2+Gf4z
	oaYoX3v8GKJUQ1nuRtnC35ZuZ3QkjwiaCPcpc0UnbI5ec9Ow9q0aZ/TvL8oCkZwqTlu7hgPZKxJ
	SENZePIL9Kklw4tC9tQOabQtFl5klatXbnt1+FCRCt6KNEquVxwLICdaHvxA7jaCJk0U50nSRr3
	oHUgPy2WoyOu7HUXMJsNglKkIFoQzlKOSQc5D9Ei1fRkU4JLhzRgVGPHqox5Jz9IQ8sc/mAchkg
	KAH5M1+sVDcY6q2P2
X-Received: by 2002:a05:6820:4414:b0:6b0:1ba4:dcd0 with SMTP id 006d021491bc7-6b01ba50a1dmr3849042eaf.27.1786074887783;
        Thu, 06 Aug 2026 20:54:47 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b02bbc41bbsm1329339eaf.3.2026.08.06.20.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 20:54:47 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 06 Aug 2026 21:54:22 -0600
Subject: [PATCH net-next v4 3/4] net: mdio: make device map changes
 hotplug-safe
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-submit-mdio-of-dynamic-v2-v4-3-4beb0c50d5ba@gmail.com>
References: <20260806-submit-mdio-of-dynamic-v2-v4-0-4beb0c50d5ba@gmail.com>
In-Reply-To: <20260806-submit-mdio-of-dynamic-v2-v4-0-4beb0c50d5ba@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 Richard Cochran <richardcochran@gmail.com>, Rob Herring <robh@kernel.org>, 
 Saravana Kannan <saravanak@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Jonas Gorski <jonas.gorski@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, 
 Ciprian Regus <ciprian.regus@analog.com>, 
 Andreas Larsson <andreas@gaisler.com>, Mark Einon <mark.einon@gmail.com>, 
 Iyappan Subramanian <iyappan@os.amperecomputing.com>, 
 Keyur Chudgar <keyur@os.amperecomputing.com>, 
 Michael Chan <michael.chan@broadcom.com>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Doug Berger <opendmb@gmail.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Conor Dooley <conor.dooley@microchip.com>, Wei Fang <wei.fang@nxp.com>, 
 Frank Li <frank.li@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
 Jijie Shao <shaojijie@huawei.com>, Jian Shen <shenjian15@huawei.com>, 
 Bryan Whitehead <bryan.whitehead@microchip.com>, 
 UNGLinuxDriver@microchip.com, Vladimir Zapolskiy <vz@mleia.com>, 
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>, 
 Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Timur Tabi <timur@kernel.org>, nic_swsd@realtek.com, 
 Byungho An <bh74.an@samsung.com>, 
 Steve Glendinning <steve.glendinning@shawell.net>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, 
 Jiawen Wu <jiawenwu@trustnetic.com>, 
 Mengyuan Lou <mengyuanlou@net-swift.com>, 
 Thangaraj Samynathan <Thangaraj.S@microchip.com>, 
 Sebastian Reichel <sre@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, linux-omap@vger.kernel.org, 
 linux-usb@vger.kernel.org, linux-pm@vger.kernel.org
X-Mailer: b4 0.15.2

MDIO device registration currently publishes directly into mdio_map
without serializing address ownership, and removal frees the object
immediately. That is sufficient while bus population is static, but
dynamic firmware changes can race registration, PHY attachment and bus
teardown.

Serialize device-map state and reserve addresses while registration is
in progress. Track active scans, registrations and firmware changes so
bus teardown first blocks new work and waits for existing work before
consuming the final map. Make firmware removal transactions exclusive
with registration, scanning and other firmware changes: start one only
when no tracked map operation is active, then block new firmware changes,
registrations and PHY attachment until it ends.

Keep an address reserved while device_add() and driver probing run, then
publish the fully registered device. A device becomes visible through the
driver core before map publication completes, so make PHY attachment wait
for another task's pending registration. Return -EPROBE_DEFER instead of
waiting when registration and attachment recurse in the same task.

Protect published map entries with RCU and make mdiobus_get_phy() return a
reference to its PHY. Give phy_find_first() and phy_find_next() the same
ownership rule. Make the bus iterator release each reference and update
every in-tree caller. Unpublish a removed device before device_del(), then
wait for an RCU grace period before the registration reference can be
dropped. Readers can therefore acquire their own reference safely, while
repeated dynamic remove/re-add cycles release old PHY generations once
their real users are done instead of retaining them until bus teardown.

Make PHY attachment atomic with map removal, including standalone PHY
users. Have address scans atomically claim a matching OF node as well, so
explicit OF population cannot instantiate the same device concurrently.
Check the Microsemi timestamping driver's base-PHY lookup before using its
private data.

Make the internal removal callback report whether it unpublished the
device. Bus teardown holds a temporary reference while dropping the map
lock and releases the device's registration reference only when its
removal attempt succeeded. When a concurrent normal removal has already
unpublished the device, teardown therefore does not release the same
registration reference again. Drop a dynamically removed device's
firmware-node reference after device_del() so it does not keep an overlay
node alive.

Clear an error-valued optional reset GPIO before the common registration
rollback uses the reset helpers.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v3 -> v4:
  - make PHY map lookups reference-counted and RCU-protected
  - update all in-tree mdiobus_get_phy() and PHY iterator callers
  - reclaim dynamically removed PHY generations after their users release
    them instead of retaining every generation until bus teardown
  - wait for concurrent map publication before attaching a PHY and defer
    same-task recursive attachment
  - handle a missing VSC8584 base PHY without dereferencing NULL

Changes v2 -> v3:
  - hold a device reference across unlocked teardown removal
  - free only devices successfully claimed by the teardown path
  - consolidate normal and dynamic internal removal callbacks
  - publish map entries only after device registration completes
  - route the remaining direct map reader through mdiobus_get_phy()
  - retire only PHY devices which have a borrowed-pointer lookup API
  - make firmware removal exclusive with registration, scanning and other
    firmware changes
  - propagate only population conflicts from recursive package lookup

Changes v1 -> v2:
  - split from the ACx00 series
  - rebase onto net-next after <linux/mdio.h> stopped including
    <linux/mod_devicetable.h>
  - move touched declarations to function scope for netdev style
---
 drivers/net/dsa/b53/b53_common.c                   |   9 +-
 drivers/net/ethernet/8390/ax88796.c                |   2 +
 drivers/net/ethernet/adi/adin1140.c                |   6 +-
 drivers/net/ethernet/aeroflex/greth.c              |   2 +
 drivers/net/ethernet/agere/et131x.c                |  10 +-
 drivers/net/ethernet/amd/au1000_eth.c              |  27 ++-
 drivers/net/ethernet/apm/xgene-v2/mdio.c           |   8 +-
 drivers/net/ethernet/broadcom/b44.c                |   6 +
 drivers/net/ethernet/broadcom/bgmac-bcma.c         |   1 +
 drivers/net/ethernet/broadcom/genet/bcmmii.c       |   4 +
 drivers/net/ethernet/broadcom/sb1250-mac.c         |   8 +-
 drivers/net/ethernet/broadcom/tg3.c                |  32 +--
 drivers/net/ethernet/broadcom/tg3.h                |   1 +
 drivers/net/ethernet/cadence/macb_main.c           |   1 +
 drivers/net/ethernet/engleder/tsnep_main.c         |   4 +
 drivers/net/ethernet/ethoc.c                       |  14 +-
 drivers/net/ethernet/faraday/ftgmac100.c           |   8 +-
 drivers/net/ethernet/freescale/fec_main.c          |  14 +-
 drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c  |   8 +
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |  10 +-
 drivers/net/ethernet/lantiq_etop.c                 |   8 +-
 .../ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c |   2 +
 drivers/net/ethernet/microchip/lan743x_main.c      |   1 +
 drivers/net/ethernet/nxp/lpc_eth.c                 |  10 +-
 drivers/net/ethernet/oa_tc6.c                      |   3 +
 drivers/net/ethernet/qualcomm/emac/emac-phy.c      |   7 -
 drivers/net/ethernet/rdc/r6040.c                   |  10 +-
 drivers/net/ethernet/realtek/r8169_main.c          |  15 +-
 drivers/net/ethernet/samsung/sxgbe/sxgbe_mdio.c    |   1 +
 drivers/net/ethernet/smsc/smsc911x.c               |   6 +-
 drivers/net/ethernet/smsc/smsc9420.c               |  10 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   1 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c  |   2 +
 drivers/net/ethernet/tehuti/tn40_phy.c             |   5 +-
 drivers/net/ethernet/ti/davinci_emac.c             |  20 +-
 drivers/net/ethernet/toshiba/tc35815.c             |   8 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c      |   8 +
 drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c     |   8 +
 drivers/net/phy/mdio_bus.c                         |  46 ++--
 drivers/net/phy/mdio_bus_provider.c                | 141 ++++++++----
 drivers/net/phy/mdio_device.c                      | 238 ++++++++++++++++++---
 drivers/net/phy/mscc/mscc_ptp.c                    |  50 ++---
 drivers/net/phy/phy_device.c                       | 130 ++++++++---
 drivers/net/phy/phylib-internal.h                  |   4 +-
 drivers/net/usb/asix_devices.c                     |   4 +
 drivers/net/usb/lan78xx.c                          |   7 +-
 drivers/net/usb/smsc95xx.c                         |   2 +
 drivers/power/reset/linkstation-poweroff.c         |   1 +
 include/linux/mdio.h                               |   4 +-
 include/linux/phy.h                                |  34 ++-
 net/dsa/user.c                                     |  12 +-
 51 files changed, 748 insertions(+), 225 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 3f5b9592794d..2c79b3d03bf7 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1156,6 +1156,7 @@ void b53_get_strings(struct dsa_switch *ds, int port, u32 stringset,
 			return;
 
 		phy_ethtool_get_strings(phydev, data);
+		phy_device_put(phydev);
 	}
 }
 EXPORT_SYMBOL(b53_get_strings);
@@ -1202,6 +1203,7 @@ void b53_get_ethtool_phy_stats(struct dsa_switch *ds, int port, uint64_t *data)
 		return;
 
 	phy_ethtool_get_stats(phydev, NULL, data);
+	phy_device_put(phydev);
 }
 EXPORT_SYMBOL(b53_get_ethtool_phy_stats);
 
@@ -1213,11 +1215,16 @@ int b53_get_sset_count(struct dsa_switch *ds, int port, int sset)
 	if (sset == ETH_SS_STATS) {
 		return b53_get_mib_size(dev);
 	} else if (sset == ETH_SS_PHY_STATS) {
+		int count;
+
 		phydev = b53_get_phy_device(ds, port);
 		if (!phydev)
 			return 0;
 
-		return phy_ethtool_get_sset_count(phydev);
+		count = phy_ethtool_get_sset_count(phydev);
+		phy_device_put(phydev);
+
+		return count;
 	}
 
 	return 0;
diff --git a/drivers/net/ethernet/8390/ax88796.c b/drivers/net/ethernet/8390/ax88796.c
index e1695d0fbd8b..f36f742e4c02 100644
--- a/drivers/net/ethernet/8390/ax88796.c
+++ b/drivers/net/ethernet/8390/ax88796.c
@@ -377,6 +377,7 @@ static int ax_mii_probe(struct net_device *dev)
 	ret = phy_connect_direct(dev, phy_dev, ax_handle_link_change,
 				 PHY_INTERFACE_MODE_MII);
 	if (ret) {
+		phy_device_put(phy_dev);
 		netdev_err(dev, "Could not attach to PHY\n");
 		return ret;
 	}
@@ -385,6 +386,7 @@ static int ax_mii_probe(struct net_device *dev)
 
 	netdev_info(dev, "PHY driver [%s] (mii_bus:phy_addr=%s, irq=%d)\n",
 		    phy_dev->drv->name, phydev_name(phy_dev), phy_dev->irq);
+	phy_device_put(phy_dev);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/adi/adin1140.c b/drivers/net/ethernet/adi/adin1140.c
index 93710baca151..5dc4c4d70dfc 100644
--- a/drivers/net/ethernet/adi/adin1140.c
+++ b/drivers/net/ethernet/adi/adin1140.c
@@ -664,13 +664,17 @@ static int adin1140_phy_init(struct adin1140_priv *priv,
 	ret = phy_connect_direct(priv->netdev, priv->phydev,
 				 &adin1140_handle_link_change,
 				 PHY_INTERFACE_MODE_INTERNAL);
-	if (ret)
+	if (ret) {
+		phy_device_put(priv->phydev);
+		priv->phydev = NULL;
 		return dev_err_probe(&spidev->dev, ret,
 				     "Can't attach PHY to %s\n",
 				     priv->mdiobus->id);
+	}
 
 	ret = devm_add_action_or_reset(&spidev->dev, adin1140_phy_remove,
 				       priv->phydev);
+	phy_device_put(priv->phydev);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/ethernet/aeroflex/greth.c b/drivers/net/ethernet/aeroflex/greth.c
index a593adc16c78..7a9528195a0a 100644
--- a/drivers/net/ethernet/aeroflex/greth.c
+++ b/drivers/net/ethernet/aeroflex/greth.c
@@ -1268,6 +1268,7 @@ static int greth_mdio_probe(struct net_device *dev)
 	ret = phy_connect_direct(dev, phy, &greth_link_change,
 				 greth->gbit_mac ? PHY_INTERFACE_MODE_GMII : PHY_INTERFACE_MODE_MII);
 	if (ret) {
+		phy_device_put(phy);
 		if (netif_msg_ifup(greth))
 			dev_err(&dev->dev, "could not attach to PHY\n");
 		return ret;
@@ -1279,6 +1280,7 @@ static int greth_mdio_probe(struct net_device *dev)
 		phy_set_max_speed(phy, SPEED_100);
 
 	linkmode_copy(phy->advertising, phy->supported);
+	phy_device_put(phy);
 
 	greth->link = 0;
 	greth->speed = 0;
diff --git a/drivers/net/ethernet/agere/et131x.c b/drivers/net/ethernet/agere/et131x.c
index 1b465a167672..bfefb367a6b5 100644
--- a/drivers/net/ethernet/agere/et131x.c
+++ b/drivers/net/ethernet/agere/et131x.c
@@ -3273,16 +3273,18 @@ static void et131x_adjust_link(struct net_device *netdev)
 static int et131x_mii_probe(struct net_device *netdev)
 {
 	struct et131x_adapter *adapter = netdev_priv(netdev);
-	struct  phy_device *phydev = NULL;
+	struct phy_device *found;
+	struct phy_device *phydev;
 
-	phydev = phy_find_first(adapter->mii_bus);
-	if (!phydev) {
+	found = phy_find_first(adapter->mii_bus);
+	if (!found) {
 		dev_err(&adapter->pdev->dev, "no PHY found\n");
 		return -ENODEV;
 	}
 
-	phydev = phy_connect(netdev, phydev_name(phydev),
+	phydev = phy_connect(netdev, phydev_name(found),
 			     &et131x_adjust_link, PHY_INTERFACE_MODE_MII);
+	phy_device_put(found);
 
 	if (IS_ERR(phydev)) {
 		dev_err(&adapter->pdev->dev, "Could not attach to PHY\n");
diff --git a/drivers/net/ethernet/amd/au1000_eth.c b/drivers/net/ethernet/amd/au1000_eth.c
index 5a04056e38fa..e9a9667e19ba 100644
--- a/drivers/net/ethernet/amd/au1000_eth.c
+++ b/drivers/net/ethernet/amd/au1000_eth.c
@@ -473,6 +473,7 @@ static int au1000_mii_probe(struct net_device *dev)
 {
 	struct au1000_private *const aup = netdev_priv(dev);
 	struct phy_device *phydev = NULL;
+	struct phy_device *found;
 	int phy_addr;
 
 	if (aup->phy_static_config) {
@@ -482,19 +483,25 @@ static int au1000_mii_probe(struct net_device *dev)
 			phydev = mdiobus_get_phy(aup->mii_bus, aup->phy_addr);
 		else
 			netdev_info(dev, "using PHY-less setup\n");
+		phy_device_put(phydev);
 		return 0;
 	}
 
 	/* find the first (lowest address) PHY
 	 * on the current MAC's MII bus
 	 */
-	for (phy_addr = 0; phy_addr < PHY_MAX_ADDR; phy_addr++)
-		if (mdiobus_get_phy(aup->mii_bus, phy_addr)) {
-			phydev = mdiobus_get_phy(aup->mii_bus, phy_addr);
+	for (phy_addr = 0; phy_addr < PHY_MAX_ADDR; phy_addr++) {
+		struct phy_device *candidate;
+
+		candidate = mdiobus_get_phy(aup->mii_bus, phy_addr);
+		if (candidate) {
+			phy_device_put(phydev);
+			phydev = candidate;
 			if (!aup->phy_search_highest_addr)
 				/* break out with first one found */
 				break;
 		}
+	}
 
 	if (aup->phy1_search_mac0) {
 		/* try harder to find a PHY */
@@ -511,16 +518,20 @@ static int au1000_mii_probe(struct net_device *dev)
 					mdiobus_get_phy(aup->mii_bus,
 							phy_addr);
 
-				if (aup->mac_id == 1)
+				if (aup->mac_id == 1) {
+					phy_device_put(tmp_phydev);
 					break;
+				}
 
 				/* no PHY here... */
 				if (!tmp_phydev)
 					continue;
 
 				/* already claimed by MAC0 */
-				if (tmp_phydev->attached_dev)
+				if (tmp_phydev->attached_dev) {
+					phy_device_put(tmp_phydev);
 					continue;
+				}
 
 				phydev = tmp_phydev;
 				break; /* found it */
@@ -536,8 +547,10 @@ static int au1000_mii_probe(struct net_device *dev)
 	/* now we are supposed to have a proper phydev, to attach to... */
 	BUG_ON(phydev->attached_dev);
 
-	phydev = phy_connect(dev, phydev_name(phydev),
-			     &au1000_adjust_link, PHY_INTERFACE_MODE_MII);
+	found = phydev;
+	phydev = phy_connect(dev, phydev_name(found), &au1000_adjust_link,
+			     PHY_INTERFACE_MODE_MII);
+	phy_device_put(found);
 
 	if (IS_ERR(phydev)) {
 		netdev_err(dev, "Could not attach to PHY\n");
diff --git a/drivers/net/ethernet/apm/xgene-v2/mdio.c b/drivers/net/ethernet/apm/xgene-v2/mdio.c
index 6a17045a5f62..cca25136f6f7 100644
--- a/drivers/net/ethernet/apm/xgene-v2/mdio.c
+++ b/drivers/net/ethernet/apm/xgene-v2/mdio.c
@@ -100,6 +100,7 @@ int xge_mdio_config(struct net_device *ndev)
 	struct xge_pdata *pdata = netdev_priv(ndev);
 	struct device *dev = &pdata->pdev->dev;
 	struct mii_bus *mdio_bus;
+	struct phy_device *found;
 	struct phy_device *phydev;
 	int ret;
 
@@ -120,15 +121,16 @@ int xge_mdio_config(struct net_device *ndev)
 	if (ret)
 		goto err;
 
-	phydev = phy_find_first(mdio_bus);
-	if (!phydev) {
+	found = phy_find_first(mdio_bus);
+	if (!found) {
 		dev_err(dev, "no PHY found\n");
 		ret = -ENODEV;
 		goto err;
 	}
-	phydev = phy_connect(ndev, phydev_name(phydev),
+	phydev = phy_connect(ndev, phydev_name(found),
 			     &xge_adjust_link,
 			     pdata->resources.phy_mode);
+	phy_device_put(found);
 
 	if (IS_ERR(phydev)) {
 		netdev_err(ndev, "Could not attach to PHY\n");
diff --git a/drivers/net/ethernet/broadcom/b44.c b/drivers/net/ethernet/broadcom/b44.c
index f994636fbd5f..be2c5786afca 100644
--- a/drivers/net/ethernet/broadcom/b44.c
+++ b/drivers/net/ethernet/broadcom/b44.c
@@ -2238,6 +2238,7 @@ static int b44_register_phy_one(struct b44 *bp)
 	struct ssb_device *sdev = bp->sdev;
 	struct phy_device *phydev;
 	struct ssb_sprom *sprom = &sdev->bus->sprom;
+	bool phydev_ref = false;
 	int err;
 
 	mii_bus = mdiobus_alloc();
@@ -2264,6 +2265,7 @@ static int b44_register_phy_one(struct b44 *bp)
 	}
 
 	phydev = mdiobus_get_phy(bp->mii_bus, bp->phy_addr);
+	phydev_ref = !!phydev;
 	if (!phydev &&
 	    sprom->boardflags_lo & (B44_BOARDFLAG_ROBO | B44_BOARDFLAG_ADM)) {
 		dev_info(sdev->dev,
@@ -2281,6 +2283,8 @@ static int b44_register_phy_one(struct b44 *bp)
 		err = phy_connect_direct(bp->dev, phydev, &b44_adjust_link,
 					 PHY_INTERFACE_MODE_MII);
 	if (err) {
+		if (phydev_ref)
+			phy_device_put(phydev);
 		dev_err(sdev->dev, "could not attach PHY at %i\n",
 			bp->phy_addr);
 		goto err_out_mdiobus_unregister;
@@ -2297,6 +2301,8 @@ static int b44_register_phy_one(struct b44 *bp)
 	bp->old_link = 0;
 
 	phy_attached_info(phydev);
+	if (phydev_ref)
+		phy_device_put(phydev);
 
 	return 0;
 
diff --git a/drivers/net/ethernet/broadcom/bgmac-bcma.c b/drivers/net/ethernet/broadcom/bgmac-bcma.c
index 36f9bad28e6a..9d562952c377 100644
--- a/drivers/net/ethernet/broadcom/bgmac-bcma.c
+++ b/drivers/net/ethernet/broadcom/bgmac-bcma.c
@@ -209,6 +209,7 @@ static int bgmac_probe(struct bcma_device *core)
 		if (ci->id == BCMA_CHIP_ID_BCM53573 && phydev &&
 		    (phydev->drv->phy_id & phydev->drv->phy_id_mask) == PHY_ID_BCM54210E)
 			phydev->dev_flags |= PHY_BRCM_EN_MASTER_MODE;
+		phy_device_put(phydev);
 	}
 
 	if (core->bus->hosttype == BCMA_HOSTTYPE_PCI) {
diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
index a4e0d5a68268..c8cbdcfb223b 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
@@ -305,6 +305,7 @@ int bcmgenet_mii_probe(struct net_device *dev)
 	struct device_node *dn = kdev->of_node;
 	phy_interface_t phy_iface = priv->phy_interface;
 	struct phy_device *phydev;
+	bool put_phydev = false;
 	u32 phy_flags = PHY_BRCM_AUTO_PWRDWN_ENABLE |
 			PHY_BRCM_DIS_TXCRXC_NOENRGY |
 			PHY_BRCM_IDDQ_SUSPEND;
@@ -373,6 +374,7 @@ int bcmgenet_mii_probe(struct net_device *dev)
 				pr_err("Unable to find PHY\n");
 				return -ENODEV;
 			}
+			put_phydev = true;
 		} else {
 			phydev = dev->phydev;
 		}
@@ -380,6 +382,8 @@ int bcmgenet_mii_probe(struct net_device *dev)
 
 		ret = phy_connect_direct(dev, phydev, bcmgenet_mii_setup,
 					 phy_iface);
+		if (put_phydev)
+			phy_device_put(phydev);
 		if (ret) {
 			pr_err("could not attach to PHY\n");
 			return -ENODEV;
diff --git a/drivers/net/ethernet/broadcom/sb1250-mac.c b/drivers/net/ethernet/broadcom/sb1250-mac.c
index c839dd9804d3..a46e2d0f2480 100644
--- a/drivers/net/ethernet/broadcom/sb1250-mac.c
+++ b/drivers/net/ethernet/broadcom/sb1250-mac.c
@@ -2324,16 +2324,18 @@ static int sbmac_open(struct net_device *dev)
 static int sbmac_mii_probe(struct net_device *dev)
 {
 	struct sbmac_softc *sc = netdev_priv(dev);
+	struct phy_device *found;
 	struct phy_device *phy_dev;
 
-	phy_dev = phy_find_first(sc->mii_bus);
-	if (!phy_dev) {
+	found = phy_find_first(sc->mii_bus);
+	if (!found) {
 		printk(KERN_ERR "%s: no PHY found\n", dev->name);
 		return -ENXIO;
 	}
 
-	phy_dev = phy_connect(dev, dev_name(&phy_dev->mdio.dev),
+	phy_dev = phy_connect(dev, dev_name(&found->mdio.dev),
 			      &sbmac_mii_poll, PHY_INTERFACE_MODE_GMII);
+	phy_device_put(found);
 	if (IS_ERR(phy_dev)) {
 		printk(KERN_ERR "%s: could not attach to PHY\n", dev->name);
 		return PTR_ERR(phy_dev);
diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 73a4b569b03e..d55b979e01fe 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -1415,7 +1415,7 @@ static void tg3_mdio_config_5785(struct tg3 *tp)
 	u32 val;
 	struct phy_device *phydev;
 
-	phydev = mdiobus_get_phy(tp->mdio_bus, tp->phy_addr);
+	phydev = tp->phydev;
 	switch (phydev->drv->phy_id & phydev->drv->phy_id_mask) {
 	case PHY_ID_BCM50610:
 	case PHY_ID_BCM50610M:
@@ -1566,6 +1566,7 @@ static int tg3_mdio_init(struct tg3 *tp)
 
 	if (!phydev || !phydev->drv) {
 		dev_warn(&tp->pdev->dev, "No PHY devices\n");
+		phy_device_put(phydev);
 		mdiobus_unregister(tp->mdio_bus);
 		mdiobus_free(tp->mdio_bus);
 		return -ENODEV;
@@ -1593,6 +1594,7 @@ static int tg3_mdio_init(struct tg3 *tp)
 		tp->phy_flags |= TG3_PHYFLG_IS_FET;
 		break;
 	}
+	tp->phydev = phydev;
 
 	tg3_flag_set(tp, MDIOBUS_INITED);
 
@@ -1606,6 +1608,8 @@ static void tg3_mdio_fini(struct tg3 *tp)
 {
 	if (tg3_flag(tp, MDIOBUS_INITED)) {
 		tg3_flag_clear(tp, MDIOBUS_INITED);
+		phy_device_put(tp->phydev);
+		tp->phydev = NULL;
 		mdiobus_unregister(tp->mdio_bus);
 		mdiobus_free(tp->mdio_bus);
 	}
@@ -1966,7 +1970,7 @@ static void tg3_setup_flow_control(struct tg3 *tp, u32 lcladv, u32 rmtadv)
 	u32 old_tx_mode = tp->tx_mode;
 
 	if (tg3_flag(tp, USE_PHYLIB))
-		autoneg = mdiobus_get_phy(tp->mdio_bus, tp->phy_addr)->autoneg;
+		autoneg = tp->phydev->autoneg;
 	else
 		autoneg = tp->link_config.autoneg;
 
@@ -2002,7 +2006,7 @@ static void tg3_adjust_link(struct net_device *dev)
 	u8 oldflowctrl, linkmesg = 0;
 	u32 mac_mode, lcl_adv, rmt_adv;
 	struct tg3 *tp = netdev_priv(dev);
-	struct phy_device *phydev = mdiobus_get_phy(tp->mdio_bus, tp->phy_addr);
+	struct phy_device *phydev = tp->phydev;
 
 	spin_lock_bh(&tp->lock);
 
@@ -2091,7 +2095,7 @@ static int tg3_phy_init(struct tg3 *tp)
 	/* Bring the PHY back to a known state. */
 	tg3_bmcr_reset(tp);
 
-	phydev = mdiobus_get_phy(tp->mdio_bus, tp->phy_addr);
+	phydev = tp->phydev;
 
 	/* Attach the MAC to the PHY. */
 	phydev = phy_connect(tp->dev, phydev_name(phydev),
@@ -2116,7 +2120,7 @@ static int tg3_phy_init(struct tg3 *tp)
 		phy_support_asym_pause(phydev);
 		break;
 	default:
-		phy_disconnect(mdiobus_get_phy(tp->mdio_bus, tp->phy_addr));
+		phy_disconnect(tp->phydev);
 		return -EINVAL;
 	}
 
@@ -2134,7 +2138,7 @@ static void tg3_phy_start(struct tg3 *tp)
 	if (!(tp->phy_flags & TG3_PHYFLG_IS_CONNECTED))
 		return;
 
-	phydev = mdiobus_get_phy(tp->mdio_bus, tp->phy_addr);
+	phydev = tp->phydev;
 
 	if (tp->phy_flags & TG3_PHYFLG_IS_LOW_POWER) {
 		tp->phy_flags &= ~TG3_PHYFLG_IS_LOW_POWER;
@@ -2155,13 +2159,13 @@ static void tg3_phy_stop(struct tg3 *tp)
 	if (!(tp->phy_flags & TG3_PHYFLG_IS_CONNECTED))
 		return;
 
-	phy_stop(mdiobus_get_phy(tp->mdio_bus, tp->phy_addr));
+	phy_stop(tp->phydev);
 }
 
 static void tg3_phy_fini(struct tg3 *tp)
 {
 	if (tp->phy_flags & TG3_PHYFLG_IS_CONNECTED) {
-		phy_disconnect(mdiobus_get_phy(tp->mdio_bus, tp->phy_addr));
+		phy_disconnect(tp->phydev);
 		tp->phy_flags &= ~TG3_PHYFLG_IS_CONNECTED;
 	}
 }
@@ -4047,7 +4051,7 @@ static void tg3_power_down_prepare(struct tg3 *tp)
 			struct phy_device *phydev;
 			u32 phyid;
 
-			phydev = mdiobus_get_phy(tp->mdio_bus, tp->phy_addr);
+			phydev = tp->phydev;
 
 			tp->phy_flags |= TG3_PHYFLG_IS_LOW_POWER;
 
@@ -12257,7 +12261,7 @@ static int tg3_get_link_ksettings(struct net_device *dev,
 		struct phy_device *phydev;
 		if (!(tp->phy_flags & TG3_PHYFLG_IS_CONNECTED))
 			return -EAGAIN;
-		phydev = mdiobus_get_phy(tp->mdio_bus, tp->phy_addr);
+		phydev = tp->phydev;
 		phy_ethtool_ksettings_get(phydev, cmd);
 
 		return 0;
@@ -12333,7 +12337,7 @@ static int tg3_set_link_ksettings(struct net_device *dev,
 		struct phy_device *phydev;
 		if (!(tp->phy_flags & TG3_PHYFLG_IS_CONNECTED))
 			return -EAGAIN;
-		phydev = mdiobus_get_phy(tp->mdio_bus, tp->phy_addr);
+		phydev = tp->phydev;
 		return phy_ethtool_ksettings_set(phydev, cmd);
 	}
 
@@ -12490,7 +12494,7 @@ static int tg3_nway_reset(struct net_device *dev)
 	if (tg3_flag(tp, USE_PHYLIB)) {
 		if (!(tp->phy_flags & TG3_PHYFLG_IS_CONNECTED))
 			return -EAGAIN;
-		r = phy_start_aneg(mdiobus_get_phy(tp->mdio_bus, tp->phy_addr));
+		r = phy_start_aneg(tp->phydev);
 	} else {
 		u32 bmcr;
 
@@ -12623,7 +12627,7 @@ static int tg3_set_pauseparam(struct net_device *dev, struct ethtool_pauseparam
 	if (tg3_flag(tp, USE_PHYLIB)) {
 		struct phy_device *phydev;
 
-		phydev = mdiobus_get_phy(tp->mdio_bus, tp->phy_addr);
+		phydev = tp->phydev;
 
 		if (!phy_validate_pause(phydev, epause))
 			return -EINVAL;
@@ -14064,7 +14068,7 @@ static int tg3_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 		struct phy_device *phydev;
 		if (!(tp->phy_flags & TG3_PHYFLG_IS_CONNECTED))
 			return -EAGAIN;
-		phydev = mdiobus_get_phy(tp->mdio_bus, tp->phy_addr);
+		phydev = tp->phydev;
 		return phy_mii_ioctl(phydev, ifr, cmd);
 	}
 
diff --git a/drivers/net/ethernet/broadcom/tg3.h b/drivers/net/ethernet/broadcom/tg3.h
index a9e7f88fa26d..b7cf1f0513cb 100644
--- a/drivers/net/ethernet/broadcom/tg3.h
+++ b/drivers/net/ethernet/broadcom/tg3.h
@@ -3273,6 +3273,7 @@ struct tg3 {
 	int				pcie_readrq;
 
 	struct mii_bus			*mdio_bus;
+	struct phy_device		*phydev;
 	int				old_link;
 
 	u8				phy_addr;
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index d394f1f43b68..d2c835ad9e00 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -998,6 +998,7 @@ static int macb_phylink_connect(struct macb *bp)
 
 		/* attach the mac to the phy */
 		ret = phylink_connect_phy(bp->phylink, phydev);
+		phy_device_put(phydev);
 	}
 
 	if (ret) {
diff --git a/drivers/net/ethernet/engleder/tsnep_main.c b/drivers/net/ethernet/engleder/tsnep_main.c
index 5db04e209dc6..dfae85dd7968 100644
--- a/drivers/net/ethernet/engleder/tsnep_main.c
+++ b/drivers/net/ethernet/engleder/tsnep_main.c
@@ -2668,6 +2668,8 @@ static int tsnep_probe(struct platform_device *pdev)
 	tsnep_ptp_cleanup(adapter);
 ptp_init_failed:
 phy_init_failed:
+	phy_device_put(adapter->phydev);
+	adapter->phydev = NULL;
 	if (adapter->mdiobus)
 		mdiobus_unregister(adapter->mdiobus);
 mdio_init_failed:
@@ -2686,6 +2688,8 @@ static void tsnep_remove(struct platform_device *pdev)
 
 	tsnep_ptp_cleanup(adapter);
 
+	phy_device_put(adapter->phydev);
+	adapter->phydev = NULL;
 	if (adapter->mdiobus)
 		mdiobus_unregister(adapter->mdiobus);
 
diff --git a/drivers/net/ethernet/ethoc.c b/drivers/net/ethernet/ethoc.c
index 0c418557264c..021c1719131c 100644
--- a/drivers/net/ethernet/ethoc.c
+++ b/drivers/net/ethernet/ethoc.c
@@ -715,10 +715,13 @@ static int ethoc_mdio_probe(struct net_device *dev)
 
 	err = phy_connect_direct(dev, phy, ethoc_mdio_poll,
 				 PHY_INTERFACE_MODE_GMII);
-	if (err)
+	if (err) {
+		phy_device_put(phy);
 		return dev_err_probe(&dev->dev, err, "could not attach to PHY\n");
+	}
 
 	phy_set_max_speed(phy, SPEED_100);
+	phy_device_put(phy);
 
 	return 0;
 }
@@ -782,6 +785,8 @@ static int ethoc_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 	struct ethoc *priv = netdev_priv(dev);
 	struct mii_ioctl_data *mdio = if_mii(ifr);
 	struct phy_device *phy = NULL;
+	bool put_phy = false;
+	int ret;
 
 	if (!netif_running(dev))
 		return -EINVAL;
@@ -793,11 +798,16 @@ static int ethoc_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 		phy = mdiobus_get_phy(priv->mdio, mdio->phy_id);
 		if (!phy)
 			return -ENODEV;
+		put_phy = true;
 	} else {
 		phy = dev->phydev;
 	}
 
-	return phy_mii_ioctl(phy, ifr, cmd);
+	ret = phy_mii_ioctl(phy, ifr, cmd);
+	if (put_phy)
+		phy_device_put(phy);
+
+	return ret;
 }
 
 static void ethoc_do_set_mac_address(struct net_device *dev)
diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index 6d2fe5c2f390..69228f09796f 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -1500,6 +1500,7 @@ static int ftgmac100_mii_probe(struct net_device *netdev)
 	struct platform_device *pdev = to_platform_device(priv->dev);
 	struct device_node *np = pdev->dev.of_node;
 	struct phy_device *phydev;
+	struct phy_device *found;
 	phy_interface_t phy_intf;
 	int err;
 
@@ -1533,14 +1534,15 @@ static int ftgmac100_mii_probe(struct net_device *netdev)
 			    phy_modes(phy_intf));
 	}
 
-	phydev = phy_find_first(priv->mii_bus);
-	if (!phydev) {
+	found = phy_find_first(priv->mii_bus);
+	if (!found) {
 		netdev_info(netdev, "%s: no PHY found\n", netdev->name);
 		return -ENODEV;
 	}
 
-	phydev = phy_connect(netdev, phydev_name(phydev),
+	phydev = phy_connect(netdev, phydev_name(found),
 			     &ftgmac100_adjust_link, phy_intf);
+	phy_device_put(found);
 
 	if (IS_ERR(phydev)) {
 		netdev_err(netdev, "%s: Could not attach to PHY\n", netdev->name);
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index ced4dbf8cd90..71d42e061789 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -2982,6 +2982,7 @@ static int fec_enet_mii_probe(struct net_device *ndev)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
 	struct phy_device *phy_dev;
+	bool phydev_ref = false;
 	int ret;
 
 	if (fep->phy_node) {
@@ -2995,8 +2996,13 @@ static int fec_enet_mii_probe(struct net_device *ndev)
 	} else {
 		/* check for attached phy */
 		phy_dev = phy_find_first(fep->mii_bus);
-		if (fep->dev_id && phy_dev)
-			phy_dev = phy_find_next(fep->mii_bus, phy_dev);
+		if (fep->dev_id && phy_dev) {
+			struct phy_device *first = phy_dev;
+
+			phy_dev = phy_find_next(fep->mii_bus, first);
+			phy_device_put(first);
+		}
+		phydev_ref = !!phy_dev;
 
 		if (!phy_dev) {
 			netdev_info(ndev, "no PHY, assuming direct connection to switch\n");
@@ -3012,6 +3018,8 @@ static int fec_enet_mii_probe(struct net_device *ndev)
 		if (ret) {
 			if (phy_is_pseudo_fixed_link(phy_dev))
 				fixed_phy_unregister(phy_dev);
+			if (phydev_ref)
+				phy_device_put(phy_dev);
 			netdev_err(ndev, "could not attach to PHY\n");
 			return ret;
 		}
@@ -3035,6 +3043,8 @@ static int fec_enet_mii_probe(struct net_device *ndev)
 	fep->full_duplex = 0;
 
 	phy_attached_info(phy_dev);
+	if (phydev_ref)
+		phy_device_put(phy_dev);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c
index b6f0a2780ea8..bf5cf9a6c927 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c
@@ -263,6 +263,11 @@ static int hbg_fixed_phy_init(struct hbg_priv *priv)
 	return hbg_phy_connect(priv);
 }
 
+static void hbg_phy_put(void *data)
+{
+	phy_device_put(data);
+}
+
 int hbg_mdio_init(struct hbg_priv *priv)
 {
 	struct device *dev = &priv->pdev->dev;
@@ -297,6 +302,9 @@ int hbg_mdio_init(struct hbg_priv *priv)
 	if (!phydev)
 		return dev_err_probe(dev, -ENODEV,
 				     "failed to get phy device\n");
+	ret = devm_add_action_or_reset(dev, hbg_phy_put, phydev);
+	if (ret)
+		return ret;
 
 	mac->phydev = phydev;
 	hbg_mdio_init_hw(priv);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index a08d8a35aef9..25926bb77c5b 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -9731,8 +9731,11 @@ static int hclge_init_ae_dev(struct hnae3_ae_dev *ae_dev)
 err_ptp_uninit:
 	hclge_ptp_uninit(hdev);
 err_mdiobus_unreg:
-	if (hdev->hw.mac.phydev)
+	if (hdev->hw.mac.phydev) {
+		phy_device_put(hdev->hw.mac.phydev);
+		hdev->hw.mac.phydev = NULL;
 		mdiobus_unregister(hdev->hw.mac.mdio_bus);
+	}
 err_msi_irq_uninit:
 	hclge_misc_irq_uninit(hdev);
 err_msi_uninit:
@@ -10131,8 +10134,11 @@ static void hclge_uninit_ae_dev(struct hnae3_ae_dev *ae_dev)
 	hclge_uninit_mac_table(hdev);
 	hclge_del_all_fd_entries(hdev);
 
-	if (mac->phydev)
+	if (mac->phydev) {
+		phy_device_put(mac->phydev);
+		mac->phydev = NULL;
 		mdiobus_unregister(mac->mdio_bus);
+	}
 
 	/* Disable MISC vector(vector0) */
 	hclge_enable_vector(&hdev->misc_vector, false);
diff --git a/drivers/net/ethernet/lantiq_etop.c b/drivers/net/ethernet/lantiq_etop.c
index 83ce3bfefa5c..0ace9a7f52ac 100644
--- a/drivers/net/ethernet/lantiq_etop.c
+++ b/drivers/net/ethernet/lantiq_etop.c
@@ -358,16 +358,18 @@ ltq_etop_mdio_probe(struct net_device *dev)
 {
 	struct ltq_etop_priv *priv = netdev_priv(dev);
 	struct phy_device *phydev;
+	struct phy_device *found;
 
-	phydev = phy_find_first(priv->mii_bus);
+	found = phy_find_first(priv->mii_bus);
 
-	if (!phydev) {
+	if (!found) {
 		netdev_err(dev, "no PHY found\n");
 		return -ENODEV;
 	}
 
-	phydev = phy_connect(dev, phydev_name(phydev),
+	phydev = phy_connect(dev, phydev_name(found),
 			     &ltq_etop_mdio_link, priv->pldata->mii_mode);
+	phy_device_put(found);
 
 	if (IS_ERR(phydev)) {
 		netdev_err(dev, "Could not attach to PHY\n");
diff --git a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
index d1f8a72cae53..7c61b5a2e35e 100644
--- a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
+++ b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
@@ -478,6 +478,7 @@ static int mlxbf_gige_probe(struct platform_device *pdev)
 				 mlxbf_gige_link_cfgs[priv->hw_version].adjust_link,
 				 mlxbf_gige_link_cfgs[priv->hw_version].phy_mode);
 	if (err) {
+		phy_device_put(phydev);
 		dev_err(&pdev->dev, "Could not attach to PHY: %pe\n", ERR_PTR(err));
 		goto out;
 	}
@@ -486,6 +487,7 @@ static int mlxbf_gige_probe(struct platform_device *pdev)
 
 	/* Display information about attached PHY device */
 	phy_attached_info(phydev);
+	phy_device_put(phydev);
 
 	err = register_netdev(netdev);
 	if (err) {
diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index 24ae56a3c9ed..133422f96cd5 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -3245,6 +3245,7 @@ static int lan743x_phylink_connect(struct lan743x_adapter *adapter)
 		if (phydev) {
 			/* attach the mac to the phy */
 			ret = phylink_connect_phy(adapter->phylink, phydev);
+			phy_device_put(phydev);
 		} else if (((adapter->csr.id_rev & ID_REV_ID_MASK_) ==
 			      ID_REV_ID_LAN7431_) || adapter->is_pci11x1x) {
 			struct phylink_link_state state;
diff --git a/drivers/net/ethernet/nxp/lpc_eth.c b/drivers/net/ethernet/nxp/lpc_eth.c
index 8b9a3e3bba30..281a2c15669a 100644
--- a/drivers/net/ethernet/nxp/lpc_eth.c
+++ b/drivers/net/ethernet/nxp/lpc_eth.c
@@ -752,6 +752,7 @@ static int lpc_mii_probe(struct net_device *ndev)
 {
 	struct netdata_local *pldat = netdev_priv(ndev);
 	struct phy_device *phydev;
+	struct phy_device *found;
 
 	/* Attach to the PHY */
 	if (lpc_phy_interface_mode(&pldat->pdev->dev) == PHY_INTERFACE_MODE_MII)
@@ -760,17 +761,18 @@ static int lpc_mii_probe(struct net_device *ndev)
 		netdev_info(ndev, "using RMII interface\n");
 
 	if (pldat->phy_node)
-		phydev =  of_phy_find_device(pldat->phy_node);
+		found = of_phy_find_device(pldat->phy_node);
 	else
-		phydev = phy_find_first(pldat->mii_bus);
-	if (!phydev) {
+		found = phy_find_first(pldat->mii_bus);
+	if (!found) {
 		netdev_err(ndev, "no PHY found\n");
 		return -ENODEV;
 	}
 
-	phydev = phy_connect(ndev, phydev_name(phydev),
+	phydev = phy_connect(ndev, phydev_name(found),
 			     &lpc_handle_link_change,
 			     lpc_phy_interface_mode(&pldat->pdev->dev));
+	phy_device_put(found);
 	if (IS_ERR(phydev)) {
 		netdev_err(ndev, "Could not attach to PHY\n");
 		return PTR_ERR(phydev);
diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index 417c15d1ff42..9dd6c91f7a70 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -605,11 +605,14 @@ static int oa_tc6_phy_init(struct oa_tc6 *tc6)
 				 &oa_tc6_handle_link_change,
 				 PHY_INTERFACE_MODE_INTERNAL);
 	if (ret) {
+		phy_device_put(tc6->phydev);
+		tc6->phydev = NULL;
 		netdev_err(tc6->netdev, "Can't attach PHY to %s\n",
 			   tc6->mdiobus->id);
 		oa_tc6_mdiobus_unregister(tc6);
 		return ret;
 	}
+	phy_device_put(tc6->phydev);
 
 	phy_attached_info(tc6->netdev->phydev);
 
diff --git a/drivers/net/ethernet/qualcomm/emac/emac-phy.c b/drivers/net/ethernet/qualcomm/emac/emac-phy.c
index 5c94af7bb6b6..43e968d1b430 100644
--- a/drivers/net/ethernet/qualcomm/emac/emac-phy.c
+++ b/drivers/net/ethernet/qualcomm/emac/emac-phy.c
@@ -125,13 +125,6 @@ int emac_phy_config(struct platform_device *pdev, struct emac_adapter *adpt)
 		else
 			adpt->phydev = mdiobus_get_phy(mii_bus, phy_addr);
 
-		/* of_phy_find_device() claims a reference to the phydev,
-		 * so we do that here manually as well. When the driver
-		 * later unloads, it can unilaterally drop the reference
-		 * without worrying about ACPI vs DT.
-		 */
-		if (adpt->phydev)
-			get_device(&adpt->phydev->mdio.dev);
 	} else {
 		struct device_node *phy_np;
 
diff --git a/drivers/net/ethernet/rdc/r6040.c b/drivers/net/ethernet/rdc/r6040.c
index f4d434c379e7..e80aa4cd43a6 100644
--- a/drivers/net/ethernet/rdc/r6040.c
+++ b/drivers/net/ethernet/rdc/r6040.c
@@ -998,16 +998,18 @@ static void r6040_adjust_link(struct net_device *dev)
 static int r6040_mii_probe(struct net_device *dev)
 {
 	struct r6040_private *lp = netdev_priv(dev);
-	struct phy_device *phydev = NULL;
+	struct phy_device *phydev;
+	struct phy_device *found;
 
-	phydev = phy_find_first(lp->mii_bus);
-	if (!phydev) {
+	found = phy_find_first(lp->mii_bus);
+	if (!found) {
 		dev_err(&lp->pdev->dev, "no PHY found\n");
 		return -ENODEV;
 	}
 
-	phydev = phy_connect(dev, phydev_name(phydev), &r6040_adjust_link,
+	phydev = phy_connect(dev, phydev_name(found), &r6040_adjust_link,
 			     PHY_INTERFACE_MODE_MII);
+	phy_device_put(found);
 
 	if (IS_ERR(phydev)) {
 		dev_err(&lp->pdev->dev, "could not attach to PHY\n");
diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index ec4fc21fa21f..bbab465bf90d 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -5423,6 +5423,11 @@ static int r8169_mdio_write_reg_c45(struct mii_bus *mii_bus, int addr,
 	return 0;
 }
 
+static void r8169_phy_put(void *data)
+{
+	phy_device_put(data);
+}
+
 static int r8169_mdio_register(struct rtl8169_private *tp)
 {
 	struct pci_dev *pdev = tp->pci_dev;
@@ -5463,9 +5468,15 @@ static int r8169_mdio_register(struct rtl8169_private *tp)
 		return ret;
 
 	tp->phydev = mdiobus_get_phy(new_bus, 0);
-	if (!tp->phydev) {
+	if (!tp->phydev)
 		return -ENODEV;
-	} else if (!tp->phydev->drv) {
+
+	ret = devm_add_action_or_reset(&pdev->dev, r8169_phy_put,
+				       tp->phydev);
+	if (ret)
+		return ret;
+
+	if (!tp->phydev->drv) {
 		/* Most chip versions fail with the genphy driver.
 		 * Therefore ensure that the dedicated PHY driver is loaded.
 		 */
diff --git a/drivers/net/ethernet/samsung/sxgbe/sxgbe_mdio.c b/drivers/net/ethernet/samsung/sxgbe/sxgbe_mdio.c
index 0227223c06fa..6598978d8a92 100644
--- a/drivers/net/ethernet/samsung/sxgbe/sxgbe_mdio.c
+++ b/drivers/net/ethernet/samsung/sxgbe/sxgbe_mdio.c
@@ -273,6 +273,7 @@ int sxgbe_mdio_register(struct net_device *ndev)
 				    phydev_name(phy), act ? " active" : "");
 			phy_found = true;
 		}
+		phy_device_put(phy);
 	}
 
 	if (!phy_found) {
diff --git a/drivers/net/ethernet/smsc/smsc911x.c b/drivers/net/ethernet/smsc/smsc911x.c
index 3ebd0664c697..5429c78b64e5 100644
--- a/drivers/net/ethernet/smsc/smsc911x.c
+++ b/drivers/net/ethernet/smsc/smsc911x.c
@@ -1032,6 +1032,7 @@ static int smsc911x_mii_probe(struct net_device *dev)
 				 pdata->config.phy_interface);
 
 	if (ret) {
+		phy_device_put(phydev);
 		netdev_err(dev, "Could not attach to PHY\n");
 		return ret;
 	}
@@ -1042,6 +1043,7 @@ static int smsc911x_mii_probe(struct net_device *dev)
 
 	/* mask with MAC supported features */
 	phy_support_asym_pause(phydev);
+	phy_device_put(phydev);
 
 	pdata->last_duplex = -1;
 	pdata->last_carrier = -1;
@@ -1107,8 +1109,10 @@ static int smsc911x_mii_init(struct platform_device *pdev,
 	}
 
 	phydev = phy_find_first(pdata->mii_bus);
-	if (phydev)
+	if (phydev) {
 		phydev->mac_managed_pm = true;
+		phy_device_put(phydev);
+	}
 
 	return 0;
 
diff --git a/drivers/net/ethernet/smsc/smsc9420.c b/drivers/net/ethernet/smsc/smsc9420.c
index 0c97211b6254..19a6727676d4 100644
--- a/drivers/net/ethernet/smsc/smsc9420.c
+++ b/drivers/net/ethernet/smsc/smsc9420.c
@@ -1102,19 +1102,21 @@ static void smsc9420_phy_adjust_link(struct net_device *dev)
 static int smsc9420_mii_probe(struct net_device *dev)
 {
 	struct smsc9420_pdata *pd = netdev_priv(dev);
-	struct phy_device *phydev = NULL;
+	struct phy_device *phydev;
+	struct phy_device *found;
 
 	BUG_ON(dev->phydev);
 
 	/* Device only supports internal PHY at address 1 */
-	phydev = mdiobus_get_phy(pd->mii_bus, 1);
-	if (!phydev) {
+	found = mdiobus_get_phy(pd->mii_bus, 1);
+	if (!found) {
 		netdev_err(dev, "no PHY found at address 1\n");
 		return -ENODEV;
 	}
 
-	phydev = phy_connect(dev, phydev_name(phydev),
+	phydev = phy_connect(dev, phydev_name(found),
 			     smsc9420_phy_adjust_link, PHY_INTERFACE_MODE_MII);
+	phy_device_put(found);
 
 	if (IS_ERR(phydev)) {
 		netdev_err(dev, "Could not attach to PHY\n");
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 79b71466d5b0..dd74e2e2d0ac 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1347,6 +1347,7 @@ static int stmmac_init_phy(struct net_device *dev)
 		phydev->dev_flags |= dev_flags;
 
 		ret = phylink_connect_phy(priv->phylink, phydev);
+		phy_device_put(phydev);
 	} else {
 		fwnode_handle_put(phy_fwnode);
 		ret = phylink_fwnode_phy_connect(priv->phylink, fwnode, dev_flags);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index afe98ff5bdcb..ce7e52c638b4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -681,6 +681,7 @@ int stmmac_mdio_register(struct net_device *ndev)
 
 	phydev = phy_find_first(new_bus);
 	if (!phydev || phydev->mdio.addr > max_addr) {
+		phy_device_put(phydev);
 		dev_warn(dev, "No PHY found\n");
 		err = -ENODEV;
 		goto no_phy_found;
@@ -703,6 +704,7 @@ int stmmac_mdio_register(struct net_device *ndev)
 		priv->plat->phy_addr = phydev->mdio.addr;
 
 	phy_attached_info(phydev);
+	phy_device_put(phydev);
 
 bus_register_done:
 	priv->mii = new_bus;
diff --git a/drivers/net/ethernet/tehuti/tn40_phy.c b/drivers/net/ethernet/tehuti/tn40_phy.c
index 39eef7ca7958..694967f7ccca 100644
--- a/drivers/net/ethernet/tehuti/tn40_phy.c
+++ b/drivers/net/ethernet/tehuti/tn40_phy.c
@@ -62,8 +62,10 @@ int tn40_phy_register(struct tn40_priv *priv)
 
 	phylink = phylink_create(config, NULL, PHY_INTERFACE_MODE_XAUI,
 				 &tn40_mac_ops);
-	if (IS_ERR(phylink))
+	if (IS_ERR(phylink)) {
+		phy_device_put(phydev);
 		return PTR_ERR(phylink);
+	}
 
 	priv->phydev = phydev;
 	priv->phylink = phylink;
@@ -73,4 +75,5 @@ int tn40_phy_register(struct tn40_priv *priv)
 void tn40_phy_unregister(struct tn40_priv *priv)
 {
 	phylink_destroy(priv->phylink);
+	phy_device_put(priv->phydev);
 }
diff --git a/drivers/net/ethernet/ti/davinci_emac.c b/drivers/net/ethernet/ti/davinci_emac.c
index 3802122d0f1b..dee71d2858ec 100644
--- a/drivers/net/ethernet/ti/davinci_emac.c
+++ b/drivers/net/ethernet/ti/davinci_emac.c
@@ -1401,7 +1401,9 @@ static int emac_devioctl(struct net_device *ndev, struct ifreq *ifrq, int cmd)
  */
 static int emac_dev_open(struct net_device *ndev)
 {
+	char phy_id_buf[MII_BUS_ID_SIZE + 3];
 	struct device *emac_dev = &ndev->dev;
+	const char *phy_id;
 	struct resource *res;
 	int q, m, ret;
 	int res_num = 0, irq_num = 0;
@@ -1409,6 +1411,8 @@ static int emac_dev_open(struct net_device *ndev)
 	struct emac_priv *priv = netdev_priv(ndev);
 	struct phy_device *phydev = NULL;
 
+	phy_id = priv->phy_id;
+
 	ret = pm_runtime_resume_and_get(&priv->pdev->dev);
 	if (ret < 0) {
 		dev_err(&priv->pdev->dev, "%s: failed to get_sync(%d)\n",
@@ -1493,7 +1497,7 @@ static int emac_dev_open(struct net_device *ndev)
 	}
 
 	/* if no phy-handle and no fixed link, use the first phy on the bus */
-	if (!phydev && !priv->phy_id) {
+	if (!phydev && !phy_id) {
 		struct device_node *np;
 
 		np = of_find_compatible_node(NULL, NULL, "ti,davinci_mdio");
@@ -1503,21 +1507,25 @@ static int emac_dev_open(struct net_device *ndev)
 			if (bus) {
 				struct phy_device *phy = phy_find_first(bus);
 
-				if (phy)
-					priv->phy_id = phydev_name(phy);
+				if (phy) {
+					strscpy(phy_id_buf, phydev_name(phy),
+						sizeof(phy_id_buf));
+					phy_id = phy_id_buf;
+					phy_device_put(phy);
+				}
 				put_device(&bus->dev); /* of_mdio_find_bus */
 			}
 			of_node_put(np); /* of_find_compatible_node */
 		}
 	}
 
-	if (!phydev && priv->phy_id && *priv->phy_id) {
-		phydev = phy_connect(ndev, priv->phy_id,
+	if (!phydev && phy_id && *phy_id) {
+		phydev = phy_connect(ndev, phy_id,
 				     &emac_adjust_link,
 				     PHY_INTERFACE_MODE_MII);
 		if (IS_ERR(phydev)) {
 			dev_err(emac_dev, "could not connect to phy %s\n",
-				priv->phy_id);
+				phy_id);
 			ret = PTR_ERR(phydev);
 			goto err;
 		}
diff --git a/drivers/net/ethernet/toshiba/tc35815.c b/drivers/net/ethernet/toshiba/tc35815.c
index 6e3758dfbdbd..89a8e53f0342 100644
--- a/drivers/net/ethernet/toshiba/tc35815.c
+++ b/drivers/net/ethernet/toshiba/tc35815.c
@@ -609,17 +609,19 @@ static int tc_mii_probe(struct net_device *dev)
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(mask) = { 0, };
 	struct tc35815_local *lp = netdev_priv(dev);
 	struct phy_device *phydev;
+	struct phy_device *found;
 
-	phydev = phy_find_first(lp->mii_bus);
-	if (!phydev) {
+	found = phy_find_first(lp->mii_bus);
+	if (!found) {
 		printk(KERN_ERR "%s: no PHY found\n", dev->name);
 		return -ENODEV;
 	}
 
 	/* attach the mac to the phy */
-	phydev = phy_connect(dev, phydev_name(phydev),
+	phydev = phy_connect(dev, phydev_name(found),
 			     &tc_handle_link_change,
 			     lp->chiptype == TC35815_TX4939 ? PHY_INTERFACE_MODE_RMII : PHY_INTERFACE_MODE_MII);
+	phy_device_put(found);
 	if (IS_ERR(phydev)) {
 		printk(KERN_ERR "%s: Could not attach to PHY\n", dev->name);
 		return PTR_ERR(phydev);
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c
index c63bb6e6f405..a201569e6b72 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c
@@ -156,6 +156,11 @@ static int ngbe_phylink_init(struct wx *wx)
 	return 0;
 }
 
+static void ngbe_phy_put(void *data)
+{
+	phy_device_put(data);
+}
+
 int ngbe_mdio_init(struct wx *wx)
 {
 	struct pci_dev *pdev = wx->pdev;
@@ -186,6 +191,9 @@ int ngbe_mdio_init(struct wx *wx)
 	wx->phydev = phy_find_first(mii_bus);
 	if (!wx->phydev)
 		return -ENODEV;
+	ret = devm_add_action_or_reset(&pdev->dev, ngbe_phy_put, wx->phydev);
+	if (ret)
+		return ret;
 
 	phy_attached_info(wx->phydev);
 
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
index dc9f24314658..466218fd831c 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
@@ -521,6 +521,11 @@ static int txgbe_sfp_register(struct txgbe *txgbe)
 	return 0;
 }
 
+static void txgbe_phy_put(void *data)
+{
+	phy_device_put(data);
+}
+
 static int txgbe_ext_phy_init(struct txgbe *txgbe)
 {
 	struct phy_device *phydev;
@@ -555,6 +560,9 @@ static int txgbe_ext_phy_init(struct txgbe *txgbe)
 		wx_err(wx, "no PHY found\n");
 		return -ENODEV;
 	}
+	ret = devm_add_action_or_reset(&pdev->dev, txgbe_phy_put, phydev);
+	if (ret)
+		return ret;
 
 	phy_attached_info(phydev);
 
diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 00d0e4159e9b..8c6d0e6ab472 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -18,6 +18,7 @@
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/phy.h>
+#include <linux/rcupdate.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/string.h>
@@ -27,34 +28,47 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/mdio.h>
 
-static struct mdio_device *mdiobus_find_device(struct mii_bus *bus, int addr)
-{
-	bool addr_valid = addr >= 0 && addr < ARRAY_SIZE(bus->mdio_map);
-
-	if (WARN_ONCE(!addr_valid, "addr %d out of range\n", addr))
-		return NULL;
-
-	return bus->mdio_map[addr];
-}
-
+/**
+ * mdiobus_get_phy - get a PHY from an MDIO bus by address
+ * @bus: MDIO bus containing the PHY
+ * @addr: PHY address on the bus
+ *
+ * Return: A referenced PHY device, or %NULL when the address is invalid or
+ * does not contain a registered PHY. The caller must call phy_device_put().
+ */
 struct phy_device *mdiobus_get_phy(struct mii_bus *bus, int addr)
 {
 	struct mdio_device *mdiodev;
+	struct phy_device *phydev = NULL;
+	bool addr_valid = addr >= 0 && addr < ARRAY_SIZE(bus->mdio_map);
 
-	mdiodev = mdiobus_find_device(bus, addr);
-	if (!mdiodev)
+	if (WARN_ONCE(!addr_valid, "addr %d out of range\n", addr))
 		return NULL;
 
-	if (!(mdiodev->flags & MDIO_DEVICE_FLAG_PHY))
-		return NULL;
+	rcu_read_lock();
+	mdiodev = rcu_dereference(bus->mdio_map[addr]);
+	if (mdiodev && mdiodev->flags & MDIO_DEVICE_FLAG_PHY) {
+		get_device(&mdiodev->dev);
+		phydev = container_of(mdiodev, struct phy_device, mdio);
+	}
+	rcu_read_unlock();
 
-	return container_of(mdiodev, struct phy_device, mdio);
+	return phydev;
 }
 EXPORT_SYMBOL(mdiobus_get_phy);
 
 bool mdiobus_is_registered_device(struct mii_bus *bus, int addr)
 {
-	return mdiobus_find_device(bus, addr) != NULL;
+	bool addr_valid = addr >= 0 && addr < ARRAY_SIZE(bus->mdio_map);
+	bool registered;
+
+	if (WARN_ONCE(!addr_valid, "addr %d out of range\n", addr))
+		return false;
+
+	registered = rcu_access_pointer(bus->mdio_map[addr]) ||
+		     (READ_ONCE(bus->mdio_map_pending) & BIT(addr));
+
+	return registered;
 }
 EXPORT_SYMBOL(mdiobus_is_registered_device);
 
diff --git a/drivers/net/phy/mdio_bus_provider.c b/drivers/net/phy/mdio_bus_provider.c
index ce3a607a40cb..6ff647b28e8f 100644
--- a/drivers/net/phy/mdio_bus_provider.c
+++ b/drivers/net/phy/mdio_bus_provider.c
@@ -330,6 +330,8 @@ struct mii_bus *mdiobus_alloc_size(size_t size)
 		return NULL;
 
 	bus->state = MDIOBUS_ALLOCATED;
+	mutex_init(&bus->mdio_map_lock);
+	init_waitqueue_head(&bus->mdio_map_wait);
 	if (size)
 		bus->priv = (void *)bus + aligned_size;
 
@@ -355,10 +357,9 @@ static int of_mdiobus_find_phy(struct device *dev, struct mdio_device *mdiodev,
 			       struct device_node *np)
 {
 	struct device_node *child;
+	int addr, ret;
 
 	for_each_available_child_of_node(np, child) {
-		int addr;
-
 		if (of_node_name_eq(child, "ethernet-phy-package")) {
 			/* Validate PHY package reg presence */
 			if (!of_property_present(child, "reg")) {
@@ -366,12 +367,13 @@ static int of_mdiobus_find_phy(struct device *dev, struct mdio_device *mdiodev,
 				return -EINVAL;
 			}
 
-			if (!of_mdiobus_find_phy(dev, mdiodev, child)) {
+			ret = of_mdiobus_find_phy(dev, mdiodev, child);
+			if (!ret || ret == -EBUSY) {
 				/* The refcount for the PHY package will be
 				 * incremented later when PHY join the Package.
 				 */
 				of_node_put(child);
-				return 0;
+				return ret;
 			}
 
 			continue;
@@ -382,6 +384,11 @@ static int of_mdiobus_find_phy(struct device *dev, struct mdio_device *mdiodev,
 			continue;
 
 		if (addr == mdiodev->addr) {
+			if (of_node_test_and_set_flag(child, OF_POPULATED)) {
+				of_node_put(child);
+				return -EBUSY;
+			}
+
 			device_set_node(dev, of_fwnode_handle(child));
 			/* The refcount on "child" is passed to the mdio
 			 * device. Do _not_ use of_node_put(child) here.
@@ -393,22 +400,26 @@ static int of_mdiobus_find_phy(struct device *dev, struct mdio_device *mdiodev,
 	return -ENODEV;
 }
 
-static void of_mdiobus_link_mdiodev(struct mii_bus *bus,
-				    struct mdio_device *mdiodev)
+static int of_mdiobus_link_mdiodev(struct mii_bus *bus,
+				   struct mdio_device *mdiodev)
 {
 	struct device *dev = &mdiodev->dev;
 
 	if (dev->of_node || !bus->dev.of_node)
-		return;
+		return 0;
 
-	of_mdiobus_find_phy(dev, mdiodev, bus->dev.of_node);
+	return of_mdiobus_find_phy(dev, mdiodev, bus->dev.of_node);
 }
 #endif
 
-static struct phy_device *mdiobus_scan(struct mii_bus *bus, int addr, bool c45)
+static struct phy_device *__mdiobus_scan(struct mii_bus *bus, int addr,
+					 bool c45)
 {
 	struct phy_device *phydev = ERR_PTR(-ENODEV);
 	struct fwnode_handle *fwnode;
+#if IS_ENABLED(CONFIG_OF_MDIO)
+	bool of_node_populated = false;
+#endif
 	char node_name[16];
 	int err;
 
@@ -420,7 +431,12 @@ static struct phy_device *mdiobus_scan(struct mii_bus *bus, int addr, bool c45)
 	/* For DT, see if the auto-probed phy has a corresponding child
 	 * in the bus node, and set the of_node pointer in this case.
 	 */
-	of_mdiobus_link_mdiodev(bus, &phydev->mdio);
+	err = of_mdiobus_link_mdiodev(bus, &phydev->mdio);
+	if (err == -EBUSY) {
+		phy_device_free(phydev);
+		return ERR_PTR(-ENODEV);
+	}
+	of_node_populated = !!phydev->mdio.dev.of_node;
 #endif
 
 	/* Search for a swnode for the phy in the swnode hierarchy of the bus.
@@ -437,6 +453,11 @@ static struct phy_device *mdiobus_scan(struct mii_bus *bus, int addr, bool c45)
 
 	err = phy_device_register(phydev);
 	if (err) {
+#if IS_ENABLED(CONFIG_OF_MDIO)
+		if (of_node_populated)
+			of_node_clear_flag(phydev->mdio.dev.of_node,
+					   OF_POPULATED);
+#endif
 		phy_device_free(phydev);
 		return ERR_PTR(-ENODEV);
 	}
@@ -458,7 +479,17 @@ static struct phy_device *mdiobus_scan(struct mii_bus *bus, int addr, bool c45)
  */
 struct phy_device *mdiobus_scan_c22(struct mii_bus *bus, int addr)
 {
-	return mdiobus_scan(bus, addr, false);
+	struct phy_device *phydev;
+	int err;
+
+	err = mdiobus_device_change_begin(bus, false);
+	if (err)
+		return ERR_PTR(err);
+
+	phydev = __mdiobus_scan(bus, addr, false);
+	mdiobus_device_change_end(bus, false);
+
+	return phydev;
 }
 EXPORT_SYMBOL(mdiobus_scan_c22);
 
@@ -476,7 +507,7 @@ EXPORT_SYMBOL(mdiobus_scan_c22);
  */
 static struct phy_device *mdiobus_scan_c45(struct mii_bus *bus, int addr)
 {
-	return mdiobus_scan(bus, addr, true);
+	return __mdiobus_scan(bus, addr, true);
 }
 
 static int mdiobus_scan_bus_c22(struct mii_bus *bus)
@@ -487,7 +518,7 @@ static int mdiobus_scan_bus_c22(struct mii_bus *bus)
 		if ((bus->phy_mask & BIT(i)) == 0) {
 			struct phy_device *phydev;
 
-			phydev = mdiobus_scan_c22(bus, i);
+			phydev = __mdiobus_scan(bus, i, false);
 			if (IS_ERR(phydev) && (PTR_ERR(phydev) != -ENODEV))
 				return PTR_ERR(phydev);
 		}
@@ -504,7 +535,7 @@ static int mdiobus_scan_bus_c45(struct mii_bus *bus)
 			struct phy_device *phydev;
 
 			/* Don't scan C45 if we already have a C22 device */
-			if (bus->mdio_map[i])
+			if (mdiobus_is_registered_device(bus, i))
 				continue;
 
 			phydev = mdiobus_scan_c45(bus, i);
@@ -529,13 +560,50 @@ static bool mdiobus_prevent_c45_scan(struct mii_bus *bus)
 	mdiobus_for_each_phy(bus, phydev) {
 		u32 oui = phydev->phy_id >> 10;
 
-		if (oui == MICREL_OUI)
+		if (oui == MICREL_OUI) {
+			phy_device_put(phydev);
 			return true;
+		}
 	}
 
 	return false;
 }
 
+static void mdiobus_stop_device_changes(struct mii_bus *bus)
+{
+	mutex_lock(&bus->mdio_map_lock);
+	bus->state = MDIOBUS_UNREGISTERING;
+	wake_up_all(&bus->mdio_map_wait);
+	mutex_unlock(&bus->mdio_map_lock);
+
+	wait_event(bus->mdio_map_wait, !READ_ONCE(bus->mdio_map_ops));
+}
+
+static void mdiobus_remove_devices(struct mii_bus *bus)
+{
+	struct mdio_device *mdiodev;
+	int i;
+
+	for (i = 0; i < PHY_MAX_ADDR; i++) {
+		mutex_lock(&bus->mdio_map_lock);
+		mdiodev = rcu_dereference_protected(bus->mdio_map[i],
+						    lockdep_is_held(&bus->mdio_map_lock));
+		if (mdiodev)
+			mdio_device_get(mdiodev);
+		mutex_unlock(&bus->mdio_map_lock);
+		if (!mdiodev)
+			continue;
+
+		if (!mdiodev->device_remove(mdiodev, false))
+			mdiodev->device_free(mdiodev);
+		mdio_device_put(mdiodev);
+	}
+
+	mutex_lock(&bus->mdio_map_lock);
+	bus->state = MDIOBUS_UNREGISTERED;
+	mutex_unlock(&bus->mdio_map_lock);
+}
+
 /**
  * __mdiobus_register - bring up all the PHYs on a given bus and attach them to bus
  * @bus: target mii_bus
@@ -552,10 +620,9 @@ static bool mdiobus_prevent_c45_scan(struct mii_bus *bus)
  */
 int __mdiobus_register(struct mii_bus *bus, struct module *owner)
 {
-	struct mdio_device *mdiodev;
 	struct gpio_desc *gpiod;
 	bool prevent_c45_scan;
-	int i, err;
+	int err;
 
 	if (!bus || !bus->name)
 		return -EINVAL;
@@ -596,7 +663,9 @@ int __mdiobus_register(struct mii_bus *bus, struct module *owner)
 	 *
 	 * State will be updated later in this function in case of success
 	 */
+	mutex_lock(&bus->mdio_map_lock);
 	bus->state = MDIOBUS_UNREGISTERED;
+	mutex_unlock(&bus->mdio_map_lock);
 
 	err = device_register(&bus->dev);
 	if (err) {
@@ -613,8 +682,7 @@ int __mdiobus_register(struct mii_bus *bus, struct module *owner)
 		err = dev_err_probe(&bus->dev, PTR_ERR(gpiod),
 				    "mii_bus %s couldn't get reset GPIO\n",
 				    bus->id);
-		device_del(&bus->dev);
-		return err;
+		goto error_reset_gpiod;
 	} else	if (gpiod) {
 		bus->reset_gpiod = gpiod;
 		fsleep(bus->reset_delay_us);
@@ -629,6 +697,10 @@ int __mdiobus_register(struct mii_bus *bus, struct module *owner)
 			goto error_reset_gpiod;
 	}
 
+	mutex_lock(&bus->mdio_map_lock);
+	bus->state = MDIOBUS_REGISTERING;
+	mutex_unlock(&bus->mdio_map_lock);
+
 	if (bus->read) {
 		err = mdiobus_scan_bus_c22(bus);
 		if (err)
@@ -643,20 +715,17 @@ int __mdiobus_register(struct mii_bus *bus, struct module *owner)
 			goto error;
 	}
 
+	mutex_lock(&bus->mdio_map_lock);
 	bus->state = MDIOBUS_REGISTERED;
+	mutex_unlock(&bus->mdio_map_lock);
 	dev_dbg(&bus->dev, "probed\n");
 	return 0;
 
 error:
-	for (i = 0; i < PHY_MAX_ADDR; i++) {
-		mdiodev = bus->mdio_map[i];
-		if (!mdiodev)
-			continue;
-
-		mdiodev->device_remove(mdiodev);
-		mdiodev->device_free(mdiodev);
-	}
 error_reset_gpiod:
+	mdiobus_stop_device_changes(bus);
+	mdiobus_remove_devices(bus);
+
 	/* Put PHYs in RESET to save power */
 	if (bus->reset_gpiod)
 		gpiod_set_value_cansleep(bus->reset_gpiod, 1);
@@ -668,21 +737,11 @@ EXPORT_SYMBOL(__mdiobus_register);
 
 void mdiobus_unregister(struct mii_bus *bus)
 {
-	struct mdio_device *mdiodev;
-	int i;
-
 	if (WARN_ON_ONCE(bus->state != MDIOBUS_REGISTERED))
 		return;
-	bus->state = MDIOBUS_UNREGISTERED;
 
-	for (i = 0; i < PHY_MAX_ADDR; i++) {
-		mdiodev = bus->mdio_map[i];
-		if (!mdiodev)
-			continue;
-
-		mdiodev->device_remove(mdiodev);
-		mdiodev->device_free(mdiodev);
-	}
+	mdiobus_stop_device_changes(bus);
+	mdiobus_remove_devices(bus);
 
 	/* Put PHYs in RESET to save power */
 	if (bus->reset_gpiod)
@@ -702,8 +761,11 @@ EXPORT_SYMBOL(mdiobus_unregister);
  */
 void mdiobus_free(struct mii_bus *bus)
 {
+	mutex_lock(&bus->mdio_map_lock);
+
 	/* For compatibility with error handling in drivers. */
 	if (bus->state == MDIOBUS_ALLOCATED) {
+		mutex_unlock(&bus->mdio_map_lock);
 		kfree(bus);
 		return;
 	}
@@ -711,6 +773,7 @@ void mdiobus_free(struct mii_bus *bus)
 	WARN(bus->state != MDIOBUS_UNREGISTERED,
 	     "%s: not in UNREGISTERED state\n", bus->id);
 	bus->state = MDIOBUS_RELEASED;
+	mutex_unlock(&bus->mdio_map_lock);
 
 	put_device(&bus->dev);
 }
diff --git a/drivers/net/phy/mdio_device.c b/drivers/net/phy/mdio_device.c
index 06151f207134..8166e779f177 100644
--- a/drivers/net/phy/mdio_device.c
+++ b/drivers/net/phy/mdio_device.c
@@ -15,8 +15,11 @@
 #include <linux/mdio.h>
 #include <linux/mii.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/phy.h>
+#include <linux/rcupdate.h>
 #include <linux/reset.h>
+#include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/unistd.h>
@@ -33,12 +36,16 @@
 static int mdio_device_register_reset(struct mdio_device *mdiodev)
 {
 	struct reset_control *reset;
+	int err;
 
 	/* Deassert the optional reset signal */
 	mdiodev->reset_gpio = gpiod_get_optional(&mdiodev->dev,
 						 "reset", GPIOD_OUT_LOW);
-	if (IS_ERR(mdiodev->reset_gpio))
-		return PTR_ERR(mdiodev->reset_gpio);
+	if (IS_ERR(mdiodev->reset_gpio)) {
+		err = PTR_ERR(mdiodev->reset_gpio);
+		mdiodev->reset_gpio = NULL;
+		return err;
+	}
 
 	if (mdiodev->reset_gpio)
 		gpiod_set_consumer_name(mdiodev->reset_gpio, "PHY reset");
@@ -116,6 +123,8 @@ static void mdio_device_release(struct device *dev)
 	kfree(to_mdio_device(dev));
 }
 
+static int __mdio_device_remove(struct mdio_device *mdiodev, bool dynamic);
+
 struct mdio_device *mdio_device_create(struct mii_bus *bus, int addr)
 {
 	struct mdio_device *mdiodev;
@@ -129,7 +138,7 @@ struct mdio_device *mdio_device_create(struct mii_bus *bus, int addr)
 	mdiodev->dev.parent = &bus->dev;
 	mdiodev->dev.bus = &mdio_bus_type;
 	mdiodev->device_free = mdio_device_free;
-	mdiodev->device_remove = mdio_device_remove;
+	mdiodev->device_remove = __mdio_device_remove;
 	mdiodev->bus = bus;
 	mdiodev->addr = addr;
 	mdiodev->reset_state = -1;
@@ -159,19 +168,27 @@ int mdio_device_register(struct mdio_device *mdiodev)
 		return err;
 
 	err = device_add(&mdiodev->dev);
-	if (err) {
+	if (err)
 		pr_err("MDIO %d failed to add\n", mdiodev->addr);
-		goto out;
-	}
-
-	return 0;
 
- out:
-	mdiobus_unregister_device(mdiodev);
-	return err;
+	return mdiobus_registration_done(mdiodev, err);
 }
 EXPORT_SYMBOL(mdio_device_register);
 
+static int __mdio_device_remove(struct mdio_device *mdiodev, bool dynamic)
+{
+	int err;
+
+	err = mdiobus_begin_remove(mdiodev, dynamic);
+	if (err)
+		return err;
+
+	device_del(&mdiodev->dev);
+	mdiobus_finish_remove(mdiodev, dynamic);
+
+	return 0;
+}
+
 /**
  * mdio_device_remove - Remove a previously registered mdio device from the
  *			MDIO bus
@@ -183,42 +200,215 @@ EXPORT_SYMBOL(mdio_device_register);
  */
 void mdio_device_remove(struct mdio_device *mdiodev)
 {
-	device_del(&mdiodev->dev);
-	mdiobus_unregister_device(mdiodev);
+	__mdio_device_remove(mdiodev, false);
 }
 EXPORT_SYMBOL(mdio_device_remove);
 
 int mdiobus_register_device(struct mdio_device *mdiodev)
 {
+	struct mii_bus *bus = mdiodev->bus;
 	int err;
 
-	if (mdiodev->bus->mdio_map[mdiodev->addr])
-		return -EBUSY;
+	mutex_lock(&bus->mdio_map_lock);
+	if (bus->state != MDIOBUS_REGISTERING &&
+	    bus->state != MDIOBUS_REGISTERED) {
+		err = -ENODEV;
+		goto out_unlock;
+	}
+	if (bus->mdio_map_removing) {
+		err = -EBUSY;
+		goto out_unlock;
+	}
+
+	if (rcu_access_pointer(bus->mdio_map[mdiodev->addr]) ||
+	    bus->mdio_map_pending & BIT(mdiodev->addr)) {
+		err = -EBUSY;
+		goto out_unlock;
+	}
+
+	bus->mdio_map_pending |= BIT(mdiodev->addr);
+	bus->mdio_map_pending_owner[mdiodev->addr] = current;
+	bus->mdio_map_ops++;
+	mutex_unlock(&bus->mdio_map_lock);
 
 	if (mdiodev->flags & MDIO_DEVICE_FLAG_PHY) {
 		err = mdio_device_register_reset(mdiodev);
-		if (err)
+		if (err) {
+			mdiobus_registration_done(mdiodev, err);
 			return err;
+		}
 
 		/* Assert the reset signal */
 		mdio_device_reset(mdiodev, 1);
 	}
 
-	mdiodev->bus->mdio_map[mdiodev->addr] = mdiodev;
-
 	return 0;
+
+out_unlock:
+	mutex_unlock(&bus->mdio_map_lock);
+	return err;
 }
 
-int mdiobus_unregister_device(struct mdio_device *mdiodev)
+/**
+ * mdiobus_device_change_begin - start changing devices on a registered bus
+ * @bus: MDIO bus that will be scanned or changed
+ * @removing: whether to start an exclusive removal transaction
+ *
+ * Return: zero on success or a negative error code when the bus is unavailable
+ */
+int mdiobus_device_change_begin(struct mii_bus *bus, bool removing)
 {
-	if (mdiodev->bus->mdio_map[mdiodev->addr] != mdiodev)
-		return -EINVAL;
+	int err = 0;
 
-	mdio_device_unregister_reset(mdiodev);
+	mutex_lock(&bus->mdio_map_lock);
+	if (bus->state != MDIOBUS_REGISTERED) {
+		err = -ENODEV;
+	} else if (bus->mdio_map_removing ||
+		   (removing && bus->mdio_map_ops)) {
+		err = -EBUSY;
+	} else {
+		bus->mdio_map_ops++;
+		if (removing)
+			bus->mdio_map_removing = true;
+	}
+	mutex_unlock(&bus->mdio_map_lock);
 
-	mdiodev->bus->mdio_map[mdiodev->addr] = NULL;
+	return err;
+}
+EXPORT_SYMBOL_GPL(mdiobus_device_change_begin);
 
-	return 0;
+static void mdiobus_operation_done_locked(struct mii_bus *bus)
+{
+	lockdep_assert_held(&bus->mdio_map_lock);
+
+	if (WARN_ON_ONCE(!bus->mdio_map_ops))
+		return;
+	bus->mdio_map_ops--;
+	if (!bus->mdio_map_ops)
+		wake_up_all(&bus->mdio_map_wait);
+}
+
+/**
+ * mdiobus_device_change_end - finish changing devices on an MDIO bus
+ * @bus: MDIO bus previously passed to mdiobus_device_change_begin()
+ * @removing: value passed to mdiobus_device_change_begin()
+ */
+void mdiobus_device_change_end(struct mii_bus *bus, bool removing)
+{
+	mutex_lock(&bus->mdio_map_lock);
+	if (removing) {
+		WARN_ON_ONCE(!bus->mdio_map_removing);
+		bus->mdio_map_removing = false;
+	}
+	mdiobus_operation_done_locked(bus);
+	mutex_unlock(&bus->mdio_map_lock);
+}
+EXPORT_SYMBOL_GPL(mdiobus_device_change_end);
+
+static void mdiobus_operation_done(struct mii_bus *bus)
+{
+	mutex_lock(&bus->mdio_map_lock);
+	mdiobus_operation_done_locked(bus);
+	mutex_unlock(&bus->mdio_map_lock);
+}
+
+static void mdiobus_unpublish_device(struct mdio_device *mdiodev)
+{
+	struct mii_bus *bus = mdiodev->bus;
+
+	lockdep_assert_held(&bus->mdio_map_lock);
+
+	if (rcu_access_pointer(bus->mdio_map[mdiodev->addr]) == mdiodev)
+		rcu_assign_pointer(bus->mdio_map[mdiodev->addr], NULL);
+	if (mdiodev->dev.of_node)
+		of_node_clear_flag(mdiodev->dev.of_node, OF_POPULATED);
+}
+
+int mdiobus_registration_done(struct mdio_device *mdiodev, int err)
+{
+	struct mii_bus *bus = mdiodev->bus;
+
+	mutex_lock(&bus->mdio_map_lock);
+	if (WARN_ON_ONCE(!(bus->mdio_map_pending & BIT(mdiodev->addr))))
+		goto out_unlock;
+
+	if (err) {
+		mdiobus_unpublish_device(mdiodev);
+	} else {
+		WARN_ON_ONCE(rcu_access_pointer(bus->mdio_map[mdiodev->addr]));
+		/* Teardown waits for this operation before consuming the map. */
+		rcu_assign_pointer(bus->mdio_map[mdiodev->addr], mdiodev);
+	}
+
+	bus->mdio_map_pending &= ~BIT(mdiodev->addr);
+	bus->mdio_map_pending_owner[mdiodev->addr] = NULL;
+	wake_up_all(&bus->mdio_map_wait);
+
+out_unlock:
+	mutex_unlock(&bus->mdio_map_lock);
+	if (err) {
+		if (mdiodev->flags & MDIO_DEVICE_FLAG_PHY) {
+			mdio_device_reset(mdiodev, 1);
+			mdio_device_unregister_reset(mdiodev);
+		}
+	}
+	mdiobus_operation_done(bus);
+
+	return err;
+}
+
+int mdiobus_begin_remove(struct mdio_device *mdiodev, bool dynamic)
+{
+	struct mii_bus *bus = mdiodev->bus;
+	struct phy_device *phydev;
+	int err = 0;
+
+	mutex_lock(&bus->mdio_map_lock);
+	if (dynamic && bus->state != MDIOBUS_REGISTERED) {
+		err = -ENODEV;
+		goto out_unlock;
+	}
+	if (bus->mdio_map_pending & BIT(mdiodev->addr)) {
+		err = -EBUSY;
+		goto out_unlock;
+	}
+
+	if (rcu_access_pointer(bus->mdio_map[mdiodev->addr]) != mdiodev) {
+		err = -ENODEV;
+		goto out_unlock;
+	}
+
+	if (dynamic && mdiodev->flags & MDIO_DEVICE_FLAG_PHY) {
+		phydev = to_phy_device(&mdiodev->dev);
+		if (phydev->attached) {
+			err = -EBUSY;
+			goto out_unlock;
+		}
+	}
+
+	mdiobus_unpublish_device(mdiodev);
+
+out_unlock:
+	mutex_unlock(&bus->mdio_map_lock);
+	return err;
+}
+
+void mdiobus_finish_remove(struct mdio_device *mdiodev, bool dynamic)
+{
+	struct fwnode_handle *fwnode;
+
+	/* Let map readers acquire their device reference before it is dropped. */
+	synchronize_rcu();
+
+	if (mdiodev->flags & MDIO_DEVICE_FLAG_PHY)
+		mdio_device_unregister_reset(mdiodev);
+
+	/* Do not keep an overlay node alive with the removed device. */
+	if (dynamic) {
+		fwnode = dev_fwnode(&mdiodev->dev);
+		device_set_node(&mdiodev->dev, NULL);
+		fwnode_handle_put(fwnode);
+	}
 }
 
 /**
diff --git a/drivers/net/phy/mscc/mscc_ptp.c b/drivers/net/phy/mscc/mscc_ptp.c
index 4865eac74b0e..7ca9d14dc02c 100644
--- a/drivers/net/phy/mscc/mscc_ptp.c
+++ b/drivers/net/phy/mscc/mscc_ptp.c
@@ -1274,43 +1274,27 @@ static const struct ptp_clock_info vsc85xx_clk_caps = {
 	.do_aux_work	= &vsc85xx_do_aux_work,
 };
 
-static struct vsc8531_private *vsc8584_base_priv(struct phy_device *phydev)
-{
-	struct vsc8531_private *vsc8531 = phydev->priv;
-
-	if (vsc8531->ts_base_addr != phydev->mdio.addr) {
-		struct mdio_device *dev;
-
-		dev = phydev->mdio.bus->mdio_map[vsc8531->ts_base_addr];
-		phydev = container_of(dev, struct phy_device, mdio);
-
-		return phydev->priv;
-	}
-
-	return vsc8531;
-}
-
-static bool vsc8584_is_1588_input_clk_configured(struct phy_device *phydev)
-{
-	struct vsc8531_private *vsc8531 = vsc8584_base_priv(phydev);
-
-	return vsc8531->input_clk_init;
-}
-
-static void vsc8584_set_input_clk_configured(struct phy_device *phydev)
-{
-	struct vsc8531_private *vsc8531 = vsc8584_base_priv(phydev);
-
-	vsc8531->input_clk_init = true;
-}
-
 static int __vsc8584_init_ptp(struct phy_device *phydev)
 {
 	static const u32 ltc_seq_e[] = { 0, 400000, 0, 0, 0 };
 	static const u8  ltc_seq_a[] = { 8, 6, 5, 4, 2 };
+	struct vsc8531_private *base_vsc8531 = phydev->priv;
+	struct phy_device *base_phydev = NULL;
 	u32 val;
 
-	if (!vsc8584_is_1588_input_clk_configured(phydev)) {
+	if (base_vsc8531->ts_base_addr != phydev->mdio.addr) {
+		base_phydev = mdiobus_get_phy(phydev->mdio.bus,
+					      base_vsc8531->ts_base_addr);
+		if (!base_phydev)
+			return -ENODEV;
+		if (!base_phydev->priv) {
+			phy_device_put(base_phydev);
+			return -ENODEV;
+		}
+		base_vsc8531 = base_phydev->priv;
+	}
+
+	if (!base_vsc8531->input_clk_init) {
 		phy_lock_mdio_bus(phydev);
 
 		/* 1588_DIFF_INPUT_CLK configuration: Use an external clock for
@@ -1325,8 +1309,10 @@ static int __vsc8584_init_ptp(struct phy_device *phydev)
 
 		phy_unlock_mdio_bus(phydev);
 
-		vsc8584_set_input_clk_configured(phydev);
+		base_vsc8531->input_clk_init = true;
 	}
+	if (base_phydev)
+		phy_device_put(base_phydev);
 
 	/* Disable predictor before configuring the 1588 block */
 	val = vsc85xx_ts_read_csr(phydev, PROCESSOR,
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 34d00f1ee483..e767aa174f2e 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -35,6 +35,7 @@
 #include <linux/property.h>
 #include <linux/ptp_clock_kernel.h>
 #include <linux/rtnetlink.h>
+#include <linux/sched.h>
 #include <linux/sfp.h>
 #include <linux/skbuff.h>
 #include <linux/slab.h>
@@ -209,10 +210,21 @@ static void __init features_init(void)
 
 void phy_device_free(struct phy_device *phydev)
 {
-	put_device(&phydev->mdio.dev);
+	phy_device_put(phydev);
 }
 EXPORT_SYMBOL(phy_device_free);
 
+/**
+ * phy_device_put - drop a reference to a PHY device
+ * @phydev: PHY device, or %NULL
+ */
+void phy_device_put(struct phy_device *phydev)
+{
+	if (phydev)
+		put_device(&phydev->mdio.dev);
+}
+EXPORT_SYMBOL(phy_device_put);
+
 static void phy_mdio_device_free(struct mdio_device *mdiodev)
 {
 	struct phy_device *phydev;
@@ -227,12 +239,14 @@ static void phy_device_release(struct device *dev)
 	kfree(to_phy_device(dev));
 }
 
-static void phy_mdio_device_remove(struct mdio_device *mdiodev)
+static int __phy_device_remove(struct phy_device *phydev, bool dynamic);
+
+static int phy_mdio_device_remove(struct mdio_device *mdiodev, bool dynamic)
 {
 	struct phy_device *phydev;
 
 	phydev = container_of(mdiodev, struct phy_device, mdio);
-	phy_device_remove(phydev);
+	return __phy_device_remove(phydev, dynamic);
 }
 
 static struct phy_driver genphy_driver;
@@ -1121,25 +1135,40 @@ int phy_device_register(struct phy_device *phydev)
 	err = phy_scan_fixups(phydev);
 	if (err) {
 		phydev_err(phydev, "failed to initialize\n");
-		goto out;
+		return mdiobus_registration_done(&phydev->mdio, err);
 	}
 
 	err = device_add(&phydev->mdio.dev);
-	if (err) {
+	if (err)
 		phydev_err(phydev, "failed to add\n");
-		goto out;
-	}
 
-	return 0;
+	return mdiobus_registration_done(&phydev->mdio, err);
+}
+EXPORT_SYMBOL(phy_device_register);
+
+static int __phy_device_remove(struct phy_device *phydev, bool dynamic)
+{
+	int err;
+
+	err = mdiobus_begin_remove(&phydev->mdio, dynamic);
+	if (dynamic && err == -EBUSY)
+		dev_warn(&phydev->mdio.dev,
+			 "cannot remove a PHY while it is attached or being registered\n");
+	if (err)
+		return err;
+
+	unregister_mii_timestamper(phydev->mii_ts);
+	pse_control_put(phydev->psec);
+
+	device_del(&phydev->mdio.dev);
 
- out:
 	/* Assert the reset signal */
 	phy_device_reset(phydev, 1);
 
-	mdiobus_unregister_device(&phydev->mdio);
-	return err;
+	mdiobus_finish_remove(&phydev->mdio, dynamic);
+
+	return 0;
 }
-EXPORT_SYMBOL(phy_device_register);
 
 /**
  * phy_device_remove - Remove a previously registered phy device from the MDIO bus
@@ -1151,15 +1180,7 @@ EXPORT_SYMBOL(phy_device_register);
  */
 void phy_device_remove(struct phy_device *phydev)
 {
-	unregister_mii_timestamper(phydev->mii_ts);
-	pse_control_put(phydev->psec);
-
-	device_del(&phydev->mdio.dev);
-
-	/* Assert the reset signal */
-	phy_device_reset(phydev, 1);
-
-	mdiobus_unregister_device(&phydev->mdio);
+	__phy_device_remove(phydev, false);
 }
 EXPORT_SYMBOL(phy_device_remove);
 
@@ -1182,7 +1203,8 @@ EXPORT_SYMBOL(phy_get_c45_ids);
  * @bus: the target MII bus
  * @pos: cursor
  *
- * Return: next phy_device on the bus, or NULL
+ * Return: next referenced phy_device on the bus, or %NULL. The caller must
+ * call phy_device_put() on the returned PHY.
  */
 struct phy_device *phy_find_next(struct mii_bus *bus, struct phy_device *pos)
 {
@@ -1734,6 +1756,53 @@ static bool phy_drv_supports_irq(const struct phy_driver *phydrv)
 	return phydrv->config_intr && phydrv->handle_interrupt;
 }
 
+static int phy_claim(struct phy_device *phydev)
+{
+	struct mdio_device *mdiodev = &phydev->mdio;
+	struct mii_bus *bus = mdiodev->bus;
+	unsigned int addr = mdiodev->addr;
+	int err = 0;
+
+retry:
+	mutex_lock(&bus->mdio_map_lock);
+	if (bus->state != MDIOBUS_REGISTERING &&
+	    bus->state != MDIOBUS_REGISTERED) {
+		err = -ENODEV;
+	} else if (bus->mdio_map_removing) {
+		err = -ENODEV;
+	} else if (bus->mdio_map_pending & BIT(addr)) {
+		if (bus->mdio_map_pending_owner[addr] == current) {
+			err = -EPROBE_DEFER;
+		} else {
+			mutex_unlock(&bus->mdio_map_lock);
+			wait_event(bus->mdio_map_wait,
+				   !(READ_ONCE(bus->mdio_map_pending) & BIT(addr)) ||
+				   READ_ONCE(bus->state) == MDIOBUS_UNREGISTERING ||
+				   READ_ONCE(bus->state) == MDIOBUS_UNREGISTERED ||
+				   READ_ONCE(bus->state) == MDIOBUS_RELEASED);
+			goto retry;
+		}
+	} else if (rcu_access_pointer(bus->mdio_map[addr]) != mdiodev) {
+		err = -ENODEV;
+	} else if (phydev->attached) {
+		err = -EBUSY;
+	} else {
+		phydev->attached = true;
+	}
+	mutex_unlock(&bus->mdio_map_lock);
+
+	return err;
+}
+
+static void phy_release(struct phy_device *phydev)
+{
+	struct mii_bus *bus = phydev->mdio.bus;
+
+	mutex_lock(&bus->mdio_map_lock);
+	phydev->attached = false;
+	mutex_unlock(&bus->mdio_map_lock);
+}
+
 /**
  * phy_attach_direct - attach a network device to a given PHY device pointer
  * @dev: network device to attach
@@ -1755,6 +1824,7 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 	struct module *bus_owner = phydev->mdio.bus->owner;
 	struct device *d = &phydev->mdio.dev;
 	struct module *ndev_owner = NULL;
+	bool claimed = false;
 	int err;
 
 	/* For Ethernet device drivers that register their own MDIO bus, we
@@ -1770,6 +1840,13 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 	}
 
 	get_device(d);
+	err = phy_claim(phydev);
+	if (err == -EBUSY)
+		phydev_err(phydev, "PHY already attached\n");
+	if (!err)
+		claimed = true;
+	if (err)
+		goto error_put_device;
 
 	/* Assume that if there is no driver, that it doesn't
 	 * exist, and we should use the genphy driver.
@@ -1798,12 +1875,6 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 			goto error_module_put;
 	}
 
-	if (phydev->attached_dev) {
-		dev_err(&dev->dev, "PHY already attached\n");
-		err = -EBUSY;
-		goto error;
-	}
-
 	phydev->phy_link_change = phy_link_change;
 	if (dev) {
 		phydev->attached_dev = dev;
@@ -1899,6 +1970,8 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 	phydev->is_genphy_driven = 0;
 	d->driver = NULL;
 error_put_device:
+	if (claimed)
+		phy_release(phydev);
 	put_device(d);
 	if (ndev_owner != bus_owner)
 		module_put(bus_owner);
@@ -1974,6 +2047,7 @@ void phy_detach(struct phy_device *phydev)
 
 	/* The PHY and its parent bus may be released by put_device() below. */
 	bus_owner = phydev->mdio.bus->owner;
+	phy_release(phydev);
 
 	put_device(&phydev->mdio.dev);
 	if (dev)
diff --git a/drivers/net/phy/phylib-internal.h b/drivers/net/phy/phylib-internal.h
index 664ed7faa518..7e9161fcdd90 100644
--- a/drivers/net/phy/phylib-internal.h
+++ b/drivers/net/phy/phylib-internal.h
@@ -25,7 +25,9 @@ int phy_speed_down_core(struct phy_device *phydev);
 void phy_check_downshift(struct phy_device *phydev);
 
 int mdiobus_register_device(struct mdio_device *mdiodev);
-int mdiobus_unregister_device(struct mdio_device *mdiodev);
+int mdiobus_registration_done(struct mdio_device *mdiodev, int err);
+int mdiobus_begin_remove(struct mdio_device *mdiodev, bool dynamic);
+void mdiobus_finish_remove(struct mdio_device *mdiodev, bool dynamic);
 
 int genphy_c45_read_eee_adv(struct phy_device *phydev, unsigned long *adv);
 
diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_devices.c
index 293ef80c4e30..21249777062e 100644
--- a/drivers/net/usb/asix_devices.c
+++ b/drivers/net/usb/asix_devices.c
@@ -696,6 +696,10 @@ static int ax88772_init_mdio(struct usbnet *dev)
 
 static void ax88772_mdio_unregister(struct asix_common_private *priv)
 {
+	phy_device_put(priv->phydev_int);
+	priv->phydev_int = NULL;
+	phy_device_put(priv->phydev);
+	priv->phydev = NULL;
 	mdiobus_unregister(priv->mdio);
 	mdiobus_free(priv->mdio);
 }
diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index cb782d81d84f..69fb2ec9252f 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2683,6 +2683,7 @@ static struct phy_device *lan78xx_get_phy(struct lan78xx_net *dev)
 
 	default:
 		netdev_err(dev->net, "Unknown CHIP ID: 0x%08x\n", dev->chipid);
+		phy_device_put(phydev);
 		return ERR_PTR(-ENODEV);
 	}
 }
@@ -2869,8 +2870,10 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)
 		return PTR_ERR(phydev);
 
 	ret = lan78xx_phylink_setup(dev);
-	if (ret < 0)
+	if (ret < 0) {
+		phy_device_put(phydev);
 		return ret;
+	}
 
 	ret = lan78xx_mac_prepare_for_phy(dev);
 	if (ret < 0)
@@ -2909,10 +2912,12 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)
 	ret = lan78xx_configure_leds_from_dt(dev, phydev);
 	if (ret < 0)
 		goto phylink_uninit;
+	phy_device_put(phydev);
 
 	return 0;
 
 phylink_uninit:
+	phy_device_put(phydev);
 	lan78xx_phy_uninit(dev);
 
 	return ret;
diff --git a/drivers/net/usb/smsc95xx.c b/drivers/net/usb/smsc95xx.c
index 42e4048b574b..a41f0dd7676a 100644
--- a/drivers/net/usb/smsc95xx.c
+++ b/drivers/net/usb/smsc95xx.c
@@ -1289,12 +1289,14 @@ static int smsc95xx_bind(struct usbnet *dev, struct usb_interface *intf)
 		netdev_err(dev->net, "can't attach PHY to %s\n", pdata->mdiobus->id);
 		goto unregister_mdio;
 	}
+	phy_device_put(pdata->phydev);
 
 	phy_attached_info(dev->net->phydev);
 
 	return 0;
 
 unregister_mdio:
+	phy_device_put(pdata->phydev);
 	mdiobus_unregister(pdata->mdiobus);
 
 free_mdio:
diff --git a/drivers/power/reset/linkstation-poweroff.c b/drivers/power/reset/linkstation-poweroff.c
index e56d75bfcc43..bb93dd14f450 100644
--- a/drivers/power/reset/linkstation-poweroff.c
+++ b/drivers/power/reset/linkstation-poweroff.c
@@ -192,6 +192,7 @@ static void __exit linkstation_poweroff_exit(void)
 {
 	pm_power_off = NULL;
 	unregister_reboot_notifier(&linkstation_reboot_nb);
+	phy_device_put(phydev);
 }
 
 module_init(linkstation_poweroff_init);
diff --git a/include/linux/mdio.h b/include/linux/mdio.h
index a7d9e3ae362a..7ce784af0c66 100644
--- a/include/linux/mdio.h
+++ b/include/linux/mdio.h
@@ -31,7 +31,7 @@ struct mdio_device {
 
 	int (*bus_match)(struct device *dev, const struct device_driver *drv);
 	void (*device_free)(struct mdio_device *mdiodev);
-	void (*device_remove)(struct mdio_device *mdiodev);
+	int (*device_remove)(struct mdio_device *mdiodev, bool dynamic);
 
 	/* Bus address of the MDIO device (0-31) */
 	int addr;
@@ -694,6 +694,8 @@ static inline int mdiodev_c45_write(struct mdio_device *mdiodev, u32 devad,
 
 bool mdiobus_is_registered_device(struct mii_bus *bus, int addr);
 struct phy_device *mdiobus_get_phy(struct mii_bus *bus, int addr);
+int mdiobus_device_change_begin(struct mii_bus *bus, bool removing);
+void mdiobus_device_change_end(struct mii_bus *bus, bool removing);
 
 /**
  * mdio_module_driver() - Helper macro for registering mdio drivers
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 5f8d65868e0f..6a64314dd67a 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -22,6 +22,7 @@
 #include <linux/mii_timestamper.h>
 #include <linux/module.h>
 #include <linux/timer.h>
+#include <linux/wait.h>
 #include <linux/workqueue.h>
 #include <linux/device-id/mdio.h>
 #include <linux/u64_stats_sync.h>
@@ -331,6 +332,7 @@ struct phy_port;
 struct sfp_bus;
 struct sfp_upstream_ops;
 struct sk_buff;
+struct task_struct;
 
 /**
  * struct mdio_bus_stats - Statistics counters for MDIO busses
@@ -391,7 +393,9 @@ struct mii_bus {
 	/** @state: State of bus structure */
 	enum {
 		MDIOBUS_ALLOCATED = 1,
+		MDIOBUS_REGISTERING,
 		MDIOBUS_REGISTERED,
+		MDIOBUS_UNREGISTERING,
 		MDIOBUS_UNREGISTERED,
 		MDIOBUS_RELEASED,
 	} state;
@@ -400,7 +404,19 @@ struct mii_bus {
 	struct device dev;
 
 	/** @mdio_map: list of all MDIO devices on bus */
-	struct mdio_device *mdio_map[PHY_MAX_ADDR];
+	struct mdio_device __rcu *mdio_map[PHY_MAX_ADDR];
+	/** @mdio_map_pending: addresses with registration in progress */
+	u32 mdio_map_pending;
+	/** @mdio_map_pending_owner: task registering each pending address */
+	struct task_struct *mdio_map_pending_owner[PHY_MAX_ADDR];
+	/** @mdio_map_lock: protects the MDIO device map and bus state */
+	struct mutex mdio_map_lock;
+	/** @mdio_map_wait: wait for active map operations during teardown */
+	wait_queue_head_t mdio_map_wait;
+	/** @mdio_map_ops: active registrations, scans and firmware changes */
+	unsigned int mdio_map_ops;
+	/** @mdio_map_removing: firmware removal blocking map changes and attachment */
+	bool mdio_map_removing;
 
 	/** @phy_mask: PHY addresses to be ignored when probing */
 	u32 phy_mask;
@@ -652,6 +668,8 @@ struct phy_oatc14_sqi_capability {
  * @n_ports: Number of ports currently attached to the PHY
  * @max_n_ports: Max number of ports this PHY can expose
  * @lock:  Mutex for serialization access to PHY
+ * @attached: Whether a network device or standalone user attached the PHY;
+ *	protected by the MDIO bus map lock
  * @state_queue: Work queue for state machine
  * @link_down_events: Number of times link was lost
  * @shared: Pointer to private data shared by phys in one package
@@ -781,6 +799,7 @@ struct phy_device {
 	struct delayed_work state_queue;
 
 	struct mutex lock;
+	bool attached;
 
 	/* This may be modified under the rtnl lock */
 	bool sfp_bus_attached;
@@ -2159,6 +2178,7 @@ struct fwnode_handle *fwnode_get_phy_node(const struct fwnode_handle *fwnode);
 struct phy_device *get_phy_device(struct mii_bus *bus, int addr, bool is_c45);
 int phy_device_register(struct phy_device *phy);
 void phy_device_free(struct phy_device *phydev);
+void phy_device_put(struct phy_device *phydev);
 void phy_device_remove(struct phy_device *phydev);
 int phy_get_c45_ids(struct phy_device *phydev);
 int phy_init_hw(struct phy_device *phydev);
@@ -2198,9 +2218,19 @@ static inline struct phy_device *phy_find_first(struct mii_bus *bus)
 	return phy_find_next(bus, NULL);
 }
 
+static inline struct phy_device *
+phy_find_next_and_put(struct mii_bus *bus, struct phy_device *phydev)
+{
+	struct phy_device *next = phy_find_next(bus, phydev);
+
+	phy_device_put(phydev);
+
+	return next;
+}
+
 #define mdiobus_for_each_phy(_bus, _phydev)		\
 	for (_phydev = phy_find_first(_bus); _phydev;	\
-	     _phydev = phy_find_next(_bus, _phydev))
+	     _phydev = phy_find_next_and_put(_bus, _phydev))
 
 #if IS_ENABLED(CONFIG_PHYLIB)
 int phy_start_cable_test(struct phy_device *phydev,
diff --git a/net/dsa/user.c b/net/dsa/user.c
index 03c7af6abe18..1ad5e5a398f5 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -2640,16 +2640,20 @@ static int dsa_user_phy_connect(struct net_device *user_dev, int addr,
 {
 	struct dsa_port *dp = dsa_user_to_port(user_dev);
 	struct dsa_switch *ds = dp->ds;
+	struct phy_device *phydev;
+	int ret;
 
-	user_dev->phydev = mdiobus_get_phy(ds->user_mii_bus, addr);
-	if (!user_dev->phydev) {
+	phydev = mdiobus_get_phy(ds->user_mii_bus, addr);
+	if (!phydev) {
 		netdev_err(user_dev, "no phy at %d\n", addr);
 		return -ENODEV;
 	}
 
-	user_dev->phydev->dev_flags |= flags;
+	phydev->dev_flags |= flags;
+	ret = phylink_connect_phy(dp->pl, phydev);
+	phy_device_put(phydev);
 
-	return phylink_connect_phy(dp->pl, user_dev->phydev);
+	return ret;
 }
 
 static int dsa_user_phy_setup(struct net_device *user_dev)

-- 
2.53.0

