Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1B73ABD91
	for <linux-omap@vger.kernel.org>; Fri,  7 Aug 2026 03:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786074896; cv=none; b=LS6blfdToOro1G8Ygu5zEQXci/PG2JIlynr8QVQ2pUEn9F/k8RZAq/+w15U1oE42lvjpjX+t9GK4xNvBWGlNPUuyWJOSO5kBjCshU1FlAMInbCt/s203xwUd190IszfDuaK2Q9Ftlede0ZLaGVUINRJjPWmePEZNe3JAg4rXftY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786074896; c=relaxed/simple;
	bh=YMYpQ6XFhM2cLP/3ZcZBUZKBv+hhpqEzcr8uR8DX0hI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S4Xi5kmgUKm/Yne8Frgnw39VZOpruGmFD9Iltds8Sn7HAS4hvsd5qDW8p8ZMbY/l1bAY4lLkoZrctovd7McN8j6AUvsfB9VMpH+4pA2BW2VhFiSdeye3DdjWJCyz/uMtIIbXYt3hScZZ5Hs6s4uHqPaj2trBgXyif3qtloG7iwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JClCp8dA; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JClCp8dA"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6ae4aff94c2so1797721eaf.3
        for <linux-omap@vger.kernel.org>; Thu, 06 Aug 2026 20:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786074890; x=1786679690; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mzaXaAGZuzZqDVtohWJRcwtoKOyfow4JWerY6rOg8/Q=;
        b=JClCp8dA3GMoLxfqXEgDTxOOLEB1fcGC5VsYOlbSSgq0pCT+E5nntU10yP94PddfOK
         gix8KsX77L+mIWvnt6LroW5W1hrI56HDEg7zxjnkOir+rnsd6MXoihdAR5h6MMVYQEG6
         Gvjmok9j8k2hgd/j0ENfs3XaNuc3Uhn604rlPsfls+AQaRPkdAJwPEuSpYQ6Od1HJ7ff
         dXVCgYw9wXs4BMhUKaVaHvJIMK2nKgl9puZvxPbyI1ZTmpmdtoOJPA+RNjTxfviYPsh5
         yEzPcyIJIhPNwel1xeeNjKCwO4a0oZor7C5B57WorawPibAS4UBoA4rHGxCTqluMCXZZ
         FlVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786074890; x=1786679690;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mzaXaAGZuzZqDVtohWJRcwtoKOyfow4JWerY6rOg8/Q=;
        b=eIixVk1zPZ6xI/7rS/Wg/qqhjdVtwCK0avvmgmxrFARfqekAbfXt96vdysPYSZtB9o
         5WVdlw8LW4m+qKMBdSTNgUmz99PV6ELKEH9PZSX1ZFxfWtgKND2j/QokSbzRdR7GqHj/
         xXqTcKEu4yJpmAdZWYkW+us3ziYMbmic9n/YppEDA2JTRJONmWEc1jfoAqP5++bGtyjo
         O8Ynl3SE7kuINlJv3h5dmczbm96lSBp+KwaocXKr6/e5EXEbInnmWKZx3Q5fNYQPo2vr
         cKkmBJy8FacHmgSlXguQiSrPw6eUW10GclfbxGFzyewUvKfTB3F4jBUkx5YPpMLyEHKM
         lv2w==
X-Forwarded-Encrypted: i=1; AHgh+RraCxnjBViObJMUYSjuRqIKF/lf8mGUcv5xBdotwkFieEI8AMHQVKgIfHSCg/qP0ed5hOBILuuiuA3G@vger.kernel.org
X-Gm-Message-State: AOJu0YzyG6PWJaeyPb9uy39DV3HUk5OmygWNZrlxR1I2TFG64ApJdCPR
	5yR2m0G01h8DtqGMwHhBAHK5oQS0E9joK8BskNmaTIAOUeMjoyYWIQPi
X-Gm-Gg: AR+sD12WgngfeRQXIUngK8DR96CWoEV7ZV5fmRFv0flaK1W/iYbKJQw9sb31ThBKwIU
	1a6c1IWsYEu2rbmFxdg2due4Xx7o585S9UD4hghX2J99Ghu1rvpjhxsYFGmep0g6KjWnoYlBXpp
	wB+kqlVEVSWmYoCJB72K2Q3Rf/YGmIusl7WDuFDU7fA6dDXXluI8KmtgwN87kVxHLyEQCKap+yI
	SfEz1dACozOduqQkfr7kPyD6aCizhXbPOCTcLRoJbCIsdNIFCKu8wtDwHY2SKjz0ySCFeS34l5l
	I7U4vym+Q1HDf+E6LkmsjWoPbOA+FNvP7gzuvhDmtB+PvV/5PjAj2krgLvpWObu72oN32qcSpZv
	PYnvutXKUFlZslfUg5JQOc7Y4eA9uVABdQt9S2cYo342ueUQ00Ju4ACF0W2bJjT0e5IppDePsl2
	c+Og4idsnl12NecShj7Tzu3yzpKUE85m0/ZuDeJDfNGkwGPKP2nSONk764VXuATn/m/ibi4ZqCi
	/B2r3Xs/u+CSmGSE3ivUn4vZNLByktseiqv0ctB32g3QufLPhcz8vE7B54kCcLzfLN2mY1u1CRg
	7SuHU+pNIELTZYcUm69wASX+CyBNyvB3KLgidUZVX07lexhCDhUJ04jX03qli32i2GPfyCZXwqi
	ZH1TRF/nM2kexeUdr
X-Received: by 2002:a05:6820:81e:b0:6ae:871c:e3f2 with SMTP id 006d021491bc7-6ae970269a4mr9643139eaf.29.1786074889885;
        Thu, 06 Aug 2026 20:54:49 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b02bbc41bbsm1329339eaf.3.2026.08.06.20.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 20:54:49 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 06 Aug 2026 21:54:23 -0600
Subject: [PATCH net-next v4 4/4] net: mdio: support dynamic OF device
 changes
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-submit-mdio-of-dynamic-v2-v4-4-4beb0c50d5ba@gmail.com>
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

MDIO buses enumerate firmware children only when the bus is registered.
A later DT overlay or status transition is ignored, unlike I2C and SPI.

Add an OF reconfiguration notifier. On addition, create fixed-address
PHYs and generic MDIO devices, scan free addresses for legacy PHY nodes
without reg, and recurse into Ethernet PHY packages. Track populated
nodes so static enumeration, address scanning and notifier-driven
enumeration cannot create duplicates. Walk every package child and report
the first population error without undoing devices which may already have
acquired consumers. Only scan nodes which omit reg; reject malformed fixed
addresses instead of treating them as legacy addressless PHYs.

Serialize static and notifier-driven population while allowing a PHY
probe to enable another node on the same bus. Check the node's current
state after taking that lock so an older notification cannot override a
newer status change.

On removal, refuse to unregister attached or in-flight PHYs and find the
object by its OF node. This also covers PHYs found by address scanning.
Treat all PHYs in a package as one removal scope, so removing one member
cannot invalidate state used by an attached peer. Preflight overlay
removal while it can still be refused; normal changeset errors are
propagated so the caller can restore the previous state. Ignore unrelated
nodes and MDIO buses which have already disappeared when the global
overlay preflight walks a changeset.

Keep overlay preflight outside the global MDIO reconfiguration lock. The
OF core invokes PRE_REMOVE while holding its own mutex, and an MDIO device
probe running under the reconfiguration lock may apply an OF changeset.
Use a per-bus removal transaction to block new registration and attachment
while checking the map. Starting that exclusive transaction fails when
another map operation is active, so refuse the overlay removal rather than
waiting under the OF mutex; the caller can retry after that operation
finishes.

Hold a core MDIO change transaction across discovery and registration so
bus teardown cannot race the MDIO reads used to identify a PHY. Compile
the notifier only with CONFIG_OF_DYNAMIC and the overlay preflight only
with CONFIG_OF_OVERLAY.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v3 -> v4:
  - use the RCU-safe map access introduced by patch 3 while checking a
    removal scope

Changes v2 -> v3:
  - do not block overlays containing unrelated non-MDIO nodes
  - do not block overlays whose MDIO bus is no longer present
  - use READ_ONCE() and WRITE_ONCE() for recursive lock-owner accesses
  - use the common checked MDIO device-removal callback
  - avoid an OF/MDIO lock inversion during overlay preflight
  - refuse overlay removal while another MDIO map change is active
  - propagate removal-transaction conflicts from the OF notifier
  - do not scan nodes with a malformed reg property
  - treat a populated node associated with another MDIO bus as busy

Changes v1 -> v2:
  - split from the ACx00 series
  - move the PHY declaration to function scope for netdev style
---
 drivers/net/mdio/of_mdio.c | 454 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 445 insertions(+), 9 deletions(-)

diff --git a/drivers/net/mdio/of_mdio.c b/drivers/net/mdio/of_mdio.c
index 051e449bbe7c..7bd994cab5a0 100644
--- a/drivers/net/mdio/of_mdio.c
+++ b/drivers/net/mdio/of_mdio.c
@@ -13,6 +13,7 @@
 #include <linux/fwnode_mdio.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/netdevice.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
@@ -20,6 +21,8 @@
 #include <linux/of_net.h>
 #include <linux/phy.h>
 #include <linux/phy_fixed.h>
+#include <linux/sched.h>
+#include <linux/string.h>
 
 #define DEFAULT_GPIO_RESET_DELAY	10	/* in microseconds */
 
@@ -27,6 +30,52 @@ MODULE_AUTHOR("Grant Likely <grant.likely@secretlab.ca>");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("OpenFirmware MDIO bus (Ethernet PHY) accessors");
 
+#if IS_ENABLED(CONFIG_OF_DYNAMIC)
+/*
+ * OF changes can nest when probing one MDIO device enables another node on
+ * the same bus. Serialize independent changes while allowing that nesting.
+ */
+static DEFINE_MUTEX(of_mdio_reconfig_mutex);
+static struct task_struct *of_mdio_reconfig_owner;
+static unsigned int of_mdio_reconfig_depth;
+
+static void of_mdio_reconfig_lock(void)
+{
+	if (!mutex_trylock(&of_mdio_reconfig_mutex)) {
+		if (READ_ONCE(of_mdio_reconfig_owner) == current) {
+			of_mdio_reconfig_depth++;
+			return;
+		}
+		mutex_lock(&of_mdio_reconfig_mutex);
+	}
+
+	WARN_ON_ONCE(READ_ONCE(of_mdio_reconfig_owner));
+	WARN_ON_ONCE(of_mdio_reconfig_depth);
+	WRITE_ONCE(of_mdio_reconfig_owner, current);
+	of_mdio_reconfig_depth = 1;
+}
+
+static void of_mdio_reconfig_unlock(void)
+{
+	WARN_ON_ONCE(READ_ONCE(of_mdio_reconfig_owner) != current);
+	WARN_ON_ONCE(!of_mdio_reconfig_depth);
+
+	if (--of_mdio_reconfig_depth)
+		return;
+
+	WRITE_ONCE(of_mdio_reconfig_owner, NULL);
+	mutex_unlock(&of_mdio_reconfig_mutex);
+}
+#else
+static inline void of_mdio_reconfig_lock(void)
+{
+}
+
+static inline void of_mdio_reconfig_unlock(void)
+{
+}
+#endif
+
 /* Extract the clause 22 phy ID from the compatible string of the form
  * ethernet-phy-idAAAA.BBBB */
 static int of_get_phy_id(struct device_node *device, u32 *phy_id)
@@ -80,10 +129,20 @@ static int of_mdiobus_register_device(struct mii_bus *mdio,
 static int of_mdiobus_register_child(struct mii_bus *mdio,
 				     struct device_node *child, u32 addr)
 {
+	int rc;
+
+	if (of_node_test_and_set_flag(child, OF_POPULATED))
+		return 0;
+
 	if (of_mdiobus_child_is_phy(child))
-		return of_mdiobus_register_phy(mdio, child, addr);
+		rc = of_mdiobus_register_phy(mdio, child, addr);
+	else
+		rc = of_mdiobus_register_device(mdio, child, addr);
+
+	if (rc)
+		of_node_clear_flag(child, OF_POPULATED);
 
-	return of_mdiobus_register_device(mdio, child, addr);
+	return rc;
 }
 
 /* The following is a list of PHY compatible strings which appear in
@@ -255,13 +314,21 @@ int __of_mdiobus_register(struct mii_bus *mdio, struct device_node *np,
 	if (rc)
 		return rc;
 
+	of_mdio_reconfig_lock();
+	rc = mdiobus_device_change_begin(mdio, false);
+	if (rc) {
+		of_mdio_reconfig_unlock();
+		mdiobus_unregister(mdio);
+		return rc;
+	}
+
 	/* Loop over the child nodes and register a phy_device for each phy */
 	rc = __of_mdiobus_parse_phys(mdio, np, &scanphys);
 	if (rc)
-		goto unregister;
+		goto out_change;
 
 	if (!scanphys)
-		return 0;
+		goto out_change;
 
 	/* auto scan for PHYs with empty reg property */
 	for_each_available_child_of_node(np, child) {
@@ -272,19 +339,388 @@ int __of_mdiobus_register(struct mii_bus *mdio, struct device_node *np,
 
 		rc = of_mdiobus_scan_phy(mdio, child);
 		if (rc && rc != -ENODEV)
-			goto put_unregister;
+			goto put_child;
+		rc = 0;
 	}
 
-	return 0;
+out_change:
+	mdiobus_device_change_end(mdio, false);
+	of_mdio_reconfig_unlock();
+	if (!rc)
+		return 0;
 
-put_unregister:
-	of_node_put(child);
-unregister:
 	mdiobus_unregister(mdio);
 	return rc;
+
+put_child:
+	of_node_put(child);
+	goto out_change;
 }
 EXPORT_SYMBOL(__of_mdiobus_register);
 
+#if IS_ENABLED(CONFIG_OF_DYNAMIC)
+static bool of_mdiobus_node_is_available(struct device_node *node)
+{
+	return !of_node_check_flag(node, OF_DETACHED) &&
+	       of_device_is_available(node);
+}
+
+static int of_mdiobus_add_node(struct mii_bus *mdio,
+			       struct device_node *node)
+{
+	struct device_node *child;
+	int addr, rc, ret = 0;
+
+	if (!of_mdiobus_node_is_available(node))
+		return 0;
+
+	if (of_node_name_eq(node, "ethernet-phy-package")) {
+		if (!of_property_present(node, "reg"))
+			return 0;
+
+		for_each_available_child_of_node(node, child) {
+			rc = of_mdiobus_add_node(mdio, child);
+			if (rc && rc != -ENODEV && !ret)
+				ret = rc;
+		}
+
+		return ret;
+	}
+
+	addr = of_mdio_parse_addr(&mdio->dev, node);
+	if (addr < 0) {
+		if (of_property_present(node, "reg"))
+			return addr;
+
+		rc = of_mdiobus_scan_phy(mdio, node);
+	} else {
+		rc = of_mdiobus_register_child(mdio, node, addr);
+	}
+
+	if (rc == -ENODEV && addr >= 0)
+		dev_err(&mdio->dev,
+			"MDIO device at address %d is missing.\n", addr);
+
+	return rc;
+}
+
+static bool of_mdiobus_node_is_busy(struct mii_bus *mdio,
+				    struct device_node *node)
+{
+	struct mdio_device *mdiodev;
+	struct phy_device *phydev;
+	bool busy = false;
+
+	if (of_node_name_eq(node, "ethernet-phy-package")) {
+		for_each_child_of_node_scoped(node, child) {
+			if (of_mdiobus_node_is_busy(mdio, child))
+				return true;
+		}
+
+		return false;
+	}
+
+	if (!of_node_check_flag(node, OF_POPULATED))
+		return false;
+
+	mdiodev = of_mdio_find_device(node);
+	if (!mdiodev)
+		return true;
+	if (mdiodev->bus != mdio) {
+		put_device(&mdiodev->dev);
+		return true;
+	}
+
+	mutex_lock(&mdio->mdio_map_lock);
+	busy = rcu_access_pointer(mdio->mdio_map[mdiodev->addr]) != mdiodev ||
+	       (mdio->mdio_map_pending & BIT(mdiodev->addr));
+	if (mdiodev->flags & MDIO_DEVICE_FLAG_PHY) {
+		phydev = to_phy_device(&mdiodev->dev);
+		if (phydev->attached) {
+			busy = true;
+			dev_warn(&mdiodev->dev,
+				 "cannot remove an attached PHY; remove its consumer first\n");
+		}
+	}
+	mutex_unlock(&mdio->mdio_map_lock);
+	put_device(&mdiodev->dev);
+
+	return busy;
+}
+
+static struct device_node *
+of_mdiobus_get_removal_scope(struct device_node *node)
+{
+	struct device_node *parent;
+
+	if (of_node_name_eq(node, "ethernet-phy-package"))
+		return of_node_get(node);
+
+	parent = of_get_parent(node);
+	if (of_node_name_eq(parent, "ethernet-phy-package"))
+		return parent;
+
+	of_node_put(parent);
+	return of_node_get(node);
+}
+
+static int of_mdiobus_remove_node(struct mii_bus *mdio,
+				  struct device_node *node)
+{
+	struct mdio_device *mdiodev;
+	struct device_node *child;
+	int ret;
+
+	if (of_node_name_eq(node, "ethernet-phy-package")) {
+		for_each_child_of_node(node, child) {
+			ret = of_mdiobus_remove_node(mdio, child);
+			if (ret) {
+				of_node_put(child);
+				return ret;
+			}
+		}
+		return 0;
+	}
+
+	if (!of_node_check_flag(node, OF_POPULATED))
+		return 0;
+
+	/* The OF node lookup also covers PHYs found by address scanning. */
+	mdiodev = of_mdio_find_device(node);
+	if (!mdiodev)
+		return -EBUSY;
+	if (mdiodev->bus != mdio) {
+		put_device(&mdiodev->dev);
+		return -ENODEV;
+	}
+
+	ret = mdiodev->device_remove(mdiodev, true);
+	if (!ret)
+		mdiodev->device_free(mdiodev);
+	put_device(&mdiodev->dev);
+
+	return ret == -ENODEV ? 0 : ret;
+}
+
+static struct mii_bus *of_mdiobus_find_parent(struct device_node *node)
+{
+	struct device_node *parent, *bus_node;
+	struct mii_bus *mdio;
+
+	parent = of_get_parent(node);
+	if (!parent)
+		return NULL;
+
+	if (of_node_name_eq(parent, "ethernet-phy-package")) {
+		if (!of_device_is_available(parent) ||
+		    !of_property_present(parent, "reg")) {
+			of_node_put(parent);
+			return NULL;
+		}
+
+		bus_node = of_get_parent(parent);
+		of_node_put(parent);
+	} else {
+		bus_node = parent;
+	}
+
+	mdio = of_mdio_find_bus(bus_node);
+	of_node_put(bus_node);
+
+	return mdio;
+}
+
+#if IS_ENABLED(CONFIG_OF_OVERLAY)
+/* Overlay entry notifier errors cannot stop removal after the tree changed. */
+static bool of_mdiobus_live_node_is_busy(struct device_node *node)
+{
+	struct device_node *scope;
+	struct mii_bus *mdio;
+	bool busy;
+
+	scope = of_mdiobus_get_removal_scope(node);
+	mdio = of_mdiobus_find_parent(scope);
+	/* Non-MDIO nodes and buses already removed cannot block an overlay. */
+	if (!mdio) {
+		busy = false;
+		goto out_put_scope;
+	}
+
+	busy = true;
+	if (!mdiobus_device_change_begin(mdio, true)) {
+		busy = of_mdiobus_node_is_busy(mdio, scope);
+		mdiobus_device_change_end(mdio, true);
+	}
+	put_device(&mdio->dev);
+
+out_put_scope:
+	of_node_put(scope);
+	return busy;
+}
+
+static struct device_node *
+of_mdiobus_overlay_target_child(struct device_node *target,
+				struct device_node *overlay_child)
+{
+	const char *name = kbasename(overlay_child->full_name);
+	struct device_node *child;
+
+	for_each_child_of_node(target, child) {
+		if (!of_node_cmp(kbasename(child->full_name), name))
+			return child;
+	}
+
+	return NULL;
+}
+
+static bool of_mdiobus_overlay_node_is_busy(struct device_node *overlay,
+					    struct device_node *target,
+					    bool added)
+{
+	struct device_node *overlay_child, *target_child;
+	bool busy, child_added;
+
+	if ((added || of_property_present(overlay, "status")) &&
+	    of_mdiobus_live_node_is_busy(target))
+		return true;
+
+	for_each_child_of_node(overlay, overlay_child) {
+		target_child = of_mdiobus_overlay_target_child(target,
+							       overlay_child);
+		if (!target_child)
+			continue;
+
+		child_added = of_node_check_flag(target_child, OF_OVERLAY);
+		busy = of_mdiobus_overlay_node_is_busy(overlay_child,
+						       target_child, child_added);
+		of_node_put(target_child);
+		if (busy) {
+			of_node_put(overlay_child);
+			return true;
+		}
+	}
+
+	return false;
+}
+
+static int of_mdiobus_overlay_notify(struct notifier_block *nb,
+				     unsigned long action, void *arg)
+{
+	struct of_overlay_notify_data *nd = arg;
+	bool busy;
+
+	if (action != OF_OVERLAY_PRE_REMOVE)
+		return NOTIFY_OK;
+
+	busy = of_mdiobus_overlay_node_is_busy(nd->overlay, nd->target,
+					       false);
+
+	return busy ? notifier_from_errno(-EBUSY) : NOTIFY_OK;
+}
+
+static struct notifier_block of_mdio_overlay_notifier = {
+	.notifier_call = of_mdiobus_overlay_notify,
+};
+#endif
+
+static int of_mdiobus_notify(struct notifier_block *nb, unsigned long action,
+			     void *arg)
+{
+	struct of_reconfig_data *rd = arg;
+	struct device_node *scope;
+	struct mii_bus *mdio;
+	enum of_reconfig_change change;
+	bool removing;
+	int rc, ret = NOTIFY_OK;
+
+	of_mdio_reconfig_lock();
+	change = of_reconfig_get_state_change(action, rd);
+	switch (change) {
+	case OF_RECONFIG_CHANGE_ADD:
+		/* A newer change may have made this notification stale. */
+		if (!of_mdiobus_node_is_available(rd->dn))
+			goto out_unlock;
+		removing = false;
+		break;
+	case OF_RECONFIG_CHANGE_REMOVE:
+		/* A newer change may have made this notification stale. */
+		if (of_mdiobus_node_is_available(rd->dn))
+			goto out_unlock;
+		removing = true;
+		break;
+	default:
+		goto out_unlock;
+	}
+
+	mdio = of_mdiobus_find_parent(rd->dn);
+	if (!mdio)
+		goto out_unlock;
+
+	rc = mdiobus_device_change_begin(mdio, removing);
+	if (rc) {
+		if (!removing)
+			ret = notifier_from_errno(-EPROBE_DEFER);
+		else if (rc != -ENODEV)
+			ret = notifier_from_errno(rc);
+		goto out_put_mdio;
+	}
+
+	if (!removing) {
+		rc = of_mdiobus_add_node(mdio, rd->dn);
+	} else {
+		/* The node may already be detached from its parent hierarchy. */
+		scope = of_mdiobus_get_removal_scope(rd->dn);
+		if (of_mdiobus_node_is_busy(mdio, scope))
+			rc = -EBUSY;
+		else
+			rc = of_mdiobus_remove_node(mdio, rd->dn);
+		of_node_put(scope);
+	}
+
+	mdiobus_device_change_end(mdio, removing);
+	if (rc && (removing || rc != -ENODEV))
+		ret = notifier_from_errno(rc);
+
+out_put_mdio:
+	put_device(&mdio->dev);
+out_unlock:
+	of_mdio_reconfig_unlock();
+
+	return ret;
+}
+
+static struct notifier_block of_mdio_notifier = {
+	.notifier_call = of_mdiobus_notify,
+};
+
+static int __init of_mdio_init(void)
+{
+	int ret;
+
+	ret = of_reconfig_notifier_register(&of_mdio_notifier);
+	if (ret)
+		return ret;
+
+#if IS_ENABLED(CONFIG_OF_OVERLAY)
+	ret = of_overlay_notifier_register(&of_mdio_overlay_notifier);
+	if (ret)
+		of_reconfig_notifier_unregister(&of_mdio_notifier);
+#endif
+
+	return ret;
+}
+module_init(of_mdio_init);
+
+static void __exit of_mdio_exit(void)
+{
+#if IS_ENABLED(CONFIG_OF_OVERLAY)
+	of_overlay_notifier_unregister(&of_mdio_overlay_notifier);
+#endif
+	of_reconfig_notifier_unregister(&of_mdio_notifier);
+}
+module_exit(of_mdio_exit);
+#endif /* CONFIG_OF_DYNAMIC */
+
 /**
  * of_mdio_find_device - Given a device tree node, find the mdio_device
  * @np: pointer to the mdio_device's device tree node

-- 
2.53.0

