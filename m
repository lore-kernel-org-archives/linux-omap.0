Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26EA39EF1C
	for <linux-omap@vger.kernel.org>; Fri,  7 Aug 2026 03:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786074890; cv=none; b=P6BwyKaHuzjhEqvqqRXvW5Y6wtEtX/21jLaTUQBMB7s2B2YnC7/aycl2l2cQEHpAURewE8LD9yMFya+lgst1iqKO5s7aHtcjPxzitLHkfbwPpXecr85ew0KDaJPUsysLAitwi7sQwkuVFyajROqCRyoNnfDePE1e7QX6N1aBuC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786074890; c=relaxed/simple;
	bh=PTx1xmaBWvPevkP6ZbmwzZ7YY+06PmbkiJMfuow2Mow=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Li6R+Je4q7fgu6z9Z6vyLRgjahRcrEUK0UWwvkwydxa3Vi5Pq5A3SW4c9/fA2V0OH1qCd5Zj0qyWXwow5942DU1txMG1Wgo5fqJITMT5TvmMbE4TDqHGz5kckZCtSee4QAeFEkmRa+3FGlEdJ6UVeIS4jsIyIixKSqh4CBSS9JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lxs3lwMX; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lxs3lwMX"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-448cf99c133so1786084fac.1
        for <linux-omap@vger.kernel.org>; Thu, 06 Aug 2026 20:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786074885; x=1786679685; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=387qnwbkMAAVcWYZO25x2XelYHqPuaJgYNRgF/uAO2o=;
        b=Lxs3lwMXw2rSykmSvFCeMxtFLAgRWTuyorrT/njVaSBDN3G78bS/msNbhr16C8LWlp
         wexI0H+T+6LKslK4Lv6VDj5roOOB+wMgsVqeMj5kkJp3cVYuyUkygVEn4igTIsckZtNe
         RpjWr1AktZ29R6kZ8oL1CnTy+infJOfKaiidxGsTZ3G+UZm1he038+95RGYtClHXhgnh
         IJ6HcQ7i9LmFPKjfecK3i6g5l2qqa3NcsTQTTBNMjNonkhV7JVY8WEii+BjzROehNt3L
         I//bACXeik0z0Ukd0/H/OkmFdarom6dhGZhwAQGGOXUAvKI07fUx5iL8LHc7+rwc4GK/
         iZDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786074885; x=1786679685;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=387qnwbkMAAVcWYZO25x2XelYHqPuaJgYNRgF/uAO2o=;
        b=DNDyPffopgXh/xv8J5fxhjfdAtMBA6/m1bOjOBFpN134Oy9T76knD537boY2xwoKQ3
         3gersoN+pzBq509g6KNajg9JoftvVYxcqPsWzbZJ8sKdmAHGo7i/AmPaXCMemwuah3WZ
         rtBbfs7otrDF/S20Z3VYun6tT2aSWwUInkVBxPiVwI2PyNrIBOVHb9vQTohpQVvhvMCT
         qd87tf5wRYrnvmgr90061pRgoWqPkJuFNaglG3UObVh0lSqeg9Mf54ITIF82Mpv3Zpvb
         xJ/BunvOXic72alu0btv60GINb5JNEv5hTwMJBnqJCgxXADz56xvQkn+PPZPCrJF3VwU
         nl6w==
X-Forwarded-Encrypted: i=1; AHgh+RooNZ+evmvxaevKoK4QtcurANyp6StFME/nyuK2P/LYU5BZiM4aMvpDULan8pxHeU7DbXCaFVyy2AMS@vger.kernel.org
X-Gm-Message-State: AOJu0YyTnUQMLZsdvVkotLba/yTDYw/UeSJjUZIEG0Qo6g643qQO3DUB
	a0eyFmbL8gW8lDmaVh8avbJtSFI73Eb/QYHlIZ5XpNbs/HV9L8PfDR17
X-Gm-Gg: AR+sD11sBOh4aQJjfk5pb8FWI+dUfF/HvqTj7LUzMy1BT7eQrzQ80TZ1wJabMPHaULb
	D6dbItdwqB4Hfw88XA0r7joTGdRIJ0S2ZOSXhd5L4hfa4Rex/DkQcvqwzy90RQxGMRj9s0tlq38
	scrYz0dx6X/O4G6mrSniOJy9+74waGxYBrDBrw5C9YNJNhFESoXHesRyNd8saxRrr5ldvfzhmGd
	oGvupv34aByqZYPhC6kgXsABlbE2b+/ky3Gs1wJSKbQcixVQReSkcPhFDePiyz0HG+KnuC3bPHM
	R9LeGlhQe++t8eVGxIcW9vTPVyBdZ0Mi8Jw4tz7Ih40NT+jB933rLL4kNBhulmLfd5iLyh+FH5B
	By6wQpvOMKC8URpBnQot0i16B53g/nj/l1XKW6DNFV1bvVITOF7ty231/EheffnrIzjOMChxzUO
	O/wu2jBD0bs0nPD74833sVJMElQwj73lf7C7AiGJJ7UoJITyItrPAd9JUKaSVa9zS6T4r2uEE4S
	OidF0pFDYHk5x3wkkCdVutzjh9SCHBTh7iJYgkD2zbVPF6SkCyKL5iUMwI1BST7NtMyozXmGQ8R
	RKaYCWVE2Jegh7bV8jd7aQv/IrDoIbztqcmnmY5ZfDdCrfDb8IJB0A79wuXTVIU7EM1k70gM9wt
	4mnYJmb2lSupa3uicuRt7gMd+HQU=
X-Received: by 2002:a05:6820:c91:b0:6aa:e482:3ee3 with SMTP id 006d021491bc7-6b016c9eed1mr4663164eaf.8.1786074885511;
        Thu, 06 Aug 2026 20:54:45 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b02bbc41bbsm1329339eaf.3.2026.08.06.20.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 20:54:45 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 06 Aug 2026 21:54:21 -0600
Subject: [PATCH net-next v4 2/4] net: mdio: factor out OF child
 registration helpers
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-submit-mdio-of-dynamic-v2-v4-2-4beb0c50d5ba@gmail.com>
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

Live OF reconfiguration needs to create the same PHY and generic MDIO
devices as initial bus population, including legacy PHY nodes that need
address scanning.

Factor fixed-address child registration and PHY address scanning into
helpers. The old scan loop also visited every free address for a child
without a reg property even when the child was not a PHY. Reject that case
before scanning while preserving enumeration of valid PHY and generic MDIO
children.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

---
Changes v1 -> v2:
  - split from the ACx00 series without code changes
---
 drivers/net/mdio/of_mdio.c | 66 ++++++++++++++++++++++++++++------------------
 1 file changed, 40 insertions(+), 26 deletions(-)

diff --git a/drivers/net/mdio/of_mdio.c b/drivers/net/mdio/of_mdio.c
index b8d298c04d3f..051e449bbe7c 100644
--- a/drivers/net/mdio/of_mdio.c
+++ b/drivers/net/mdio/of_mdio.c
@@ -77,6 +77,15 @@ static int of_mdiobus_register_device(struct mii_bus *mdio,
 	return 0;
 }
 
+static int of_mdiobus_register_child(struct mii_bus *mdio,
+				     struct device_node *child, u32 addr)
+{
+	if (of_mdiobus_child_is_phy(child))
+		return of_mdiobus_register_phy(mdio, child, addr);
+
+	return of_mdiobus_register_device(mdio, child, addr);
+}
+
 /* The following is a list of PHY compatible strings which appear in
  * some DTBs. The compatible string is never matched against a PHY
  * driver, so is pointless. We only expect devices which are not PHYs
@@ -136,6 +145,32 @@ bool of_mdiobus_child_is_phy(struct device_node *child)
 }
 EXPORT_SYMBOL(of_mdiobus_child_is_phy);
 
+static int of_mdiobus_scan_phy(struct mii_bus *mdio,
+			       struct device_node *child)
+{
+	int addr, rc;
+
+	if (!of_mdiobus_child_is_phy(child))
+		return -ENODEV;
+
+	for (addr = 0; addr < PHY_MAX_ADDR; addr++) {
+		if (mdiobus_is_registered_device(mdio, addr))
+			continue;
+
+		dev_info(&mdio->dev, "scan phy %pOFn at address %i\n",
+			 child, addr);
+
+		/* -ENODEV means that scanning should continue. */
+		rc = of_mdiobus_register_child(mdio, child, addr);
+		if (!rc)
+			return 0;
+		if (rc != -ENODEV)
+			return rc;
+	}
+
+	return -ENODEV;
+}
+
 static int __of_mdiobus_parse_phys(struct mii_bus *mdio, struct device_node *np,
 				   bool *scanphys)
 {
@@ -164,10 +199,7 @@ static int __of_mdiobus_parse_phys(struct mii_bus *mdio, struct device_node *np,
 			continue;
 		}
 
-		if (of_mdiobus_child_is_phy(child))
-			rc = of_mdiobus_register_phy(mdio, child, addr);
-		else
-			rc = of_mdiobus_register_device(mdio, child, addr);
+		rc = of_mdiobus_register_child(mdio, child, addr);
 
 		if (rc == -ENODEV)
 			dev_err(&mdio->dev,
@@ -197,7 +229,7 @@ int __of_mdiobus_register(struct mii_bus *mdio, struct device_node *np,
 {
 	struct device_node *child;
 	bool scanphys = false;
-	int addr, rc;
+	int rc;
 
 	if (!np)
 		return __mdiobus_register(mdio, owner);
@@ -238,27 +270,9 @@ int __of_mdiobus_register(struct mii_bus *mdio, struct device_node *np,
 		    of_node_name_eq(child, "ethernet-phy-package"))
 			continue;
 
-		for (addr = 0; addr < PHY_MAX_ADDR; addr++) {
-			/* skip already registered PHYs */
-			if (mdiobus_is_registered_device(mdio, addr))
-				continue;
-
-			/* be noisy to encourage people to set reg property */
-			dev_info(&mdio->dev, "scan phy %pOFn at address %i\n",
-				 child, addr);
-
-			if (of_mdiobus_child_is_phy(child)) {
-				/* -ENODEV is the return code that PHYLIB has
-				 * standardized on to indicate that bus
-				 * scanning should continue.
-				 */
-				rc = of_mdiobus_register_phy(mdio, child, addr);
-				if (!rc)
-					break;
-				if (rc != -ENODEV)
-					goto put_unregister;
-			}
-		}
+		rc = of_mdiobus_scan_phy(mdio, child);
+		if (rc && rc != -ENODEV)
+			goto put_unregister;
 	}
 
 	return 0;

-- 
2.53.0

