Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44453126D4
	for <linux-omap@vger.kernel.org>; Fri,  6 Feb 2026 21:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770414810; cv=none; b=kuRKZU/Hxfcfrp3ZwJZ0aRRmt1CFvNUxVIY1FdzKaAjYcO8S3hUVCBTQ4tbT7BkdTr+ZfgjUo5ksGyR3X4nocrXQsA5+q/KhnBbDlMYxp2OZ5//lIAI9Zahb0Cbxv90GIrBwKKb5qZrx4HcjtvTuzYlSYQ0RP3yGALITQ2QXw/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770414810; c=relaxed/simple;
	bh=N+K+u5vfKMyiGUx+T0sMrtyHfAeD78DEAek8Bx0L4zA=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=k/jBAxgKVhp+bKRFWZpgblCTfuVm6hEDlSylTWXWk14OPyBrxYA0zW64qAWZ79SgMGf/XToWjMeEsiucGf4US6Lkr2PLThcVK5+DBHFqQFF/GMjn7bNwt0W8Sz6WrR7LE6YYyWDx0Wb+6NFdkRvxQKi9jHe1TgYMTylUNWLFYm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HDoe48c/; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDoe48c/"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4806bf39419so22243925e9.1
        for <linux-omap@vger.kernel.org>; Fri, 06 Feb 2026 13:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770414809; x=1771019609; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zAl16RgQK7YFCIKgzNT/s5NyKcYOEtIJSgcBAHgZb7s=;
        b=HDoe48c/Sh/GixgFeEhGiXRICOx/j7IdK1TgdROkAVUiFzmZiKwPaOGucohEEZSIW9
         +QZBPkrNJ6HB1228kCdkxQ3NR2y4hFNoYRRcRkkoNU8PWuv8mfkaWJ0WFQTLJ1WTdy9I
         C3qKVUohU/mSRW/i5vrd8wfyNvkd9sWupz5yI28YlMlUgTPbInWJJD3b+M4l/HBCn7DA
         aP/+TnW/RKOaUZH8BI4XJ1S2MMKpqoz1R4vd/CaNN2MwOswMbsB4tkj8BbwMFnFHzuWV
         XPwW/eW19gbwFjY8ZxZ+JQm6WLtsKAq8WgfIW8Gvq9x9DvN8jV6cChFOs8FBjywdwOwe
         6m2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770414809; x=1771019609;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zAl16RgQK7YFCIKgzNT/s5NyKcYOEtIJSgcBAHgZb7s=;
        b=jbRuJqxnFTuyf/ujgr9CqPFk66qp2xAVHVy6vjUv9uoIPzPnga13KJTuhvrU9cvI3H
         amdfQXh/rgj4q8O78o4C2qWOgqRBV7PK0gBj3Vn6dCEfPkFiiygfWSYgmasxmJCdrcqv
         6yZWyHRRu/VjsETPYNwEgbWnxuWc/kVDveHlGBYfS1t2ZxQsxwODOwe5I7ZXSR9zTk1J
         rxOkXYmwZcY+Qy/HZLk0AFLvd81rANfTU6XkiFHF79QIUevoBNKSiUm73esmtB3hJKHi
         9x0W9gwzyMUiVwuzrAl2V6H5kbKkXBewz0hp6o/GTkoTWEC6+yal/2uzi9n365XMOZy3
         nK4g==
X-Forwarded-Encrypted: i=1; AJvYcCV5eVybQnxQyv7Wh8tMcyphi/S9jLS6LWfHhFKPqJM4jUs+WI33/AVAYQfH1XTAMMtNa0j9QecV0Zwy@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9XA6aKq1S6XCJczEU5rrHbJ4PegKAGo2lJAKlCZYfSCUNczWU
	2csDcL7Z/CCbXgzkl9Z5/+h/H4ZYBBF6ED4RoK9aaFn5ItkuqU+yiU59
X-Gm-Gg: AZuq6aJpVWigtoHGG2v4V4daBfuJKPt4sv+BtblGbfwDPZZXDFLrd6C8GW7885bYBB8
	BHt76iCv9QQqHgZLHPU/++uGFK8iDaIhYM37bEonYrsNXlMBo+YU1ncCgKCtRfQyrvOickO29s4
	PnrPNl87MvpySUohSaYBiz1+Brd687W87tzGzQHUK0Ejcu7zafpkzKTo8ESUchGDPQNvWN9Wsp0
	lrt9uegTC3vLGf0poKQnV27kwiHvrAUuSuS1+peVb8PFGszJJEq530lV6TUYzUf3qzGN0ii6lEF
	INOxanF/zUR12fdNUz1+wm32FamXh7a56Vze7mXjojWXQwFRJMm0cfusmMvLC4uYio0jxblXgJc
	nec0tsHoTyfD9KOU1tK7ugjx/q8/Z1L/7mXd34Gj/VcatMi/Kpzu/GdeJnWnQsvA+eEKWItRc2b
	tazkKkkHGtT4NklKjLOG9hK/t5mgO+kxDtVpIt3mqw+gmdvi/+1E0M0s8DyBZiggR5L4fgfvmlb
	94B0wiGK2tw7Ez1F6XP2CRv73NqYwijC2TagBtSjeqx6L/8ylhOKw==
X-Received: by 2002:a5d:5f55:0:b0:435:8dd5:ad4f with SMTP id ffacd0b85a97d-436209964d4mr12103443f8f.9.1770414808890;
        Fri, 06 Feb 2026 13:53:28 -0800 (PST)
Received: from ?IPV6:2003:ea:8f15:8200:e142:60ff:2daa:1023? (p200300ea8f158200e14260ff2daa1023.dip0.t-ipconnect.de. [2003:ea:8f15:8200:e142:60ff:2daa:1023])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43629664632sm8463498f8f.0.2026.02.06.13.53.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Feb 2026 13:53:28 -0800 (PST)
Message-ID: <5bc19909-0fc7-485c-a573-4819eeea5b5d@gmail.com>
Date: Fri, 6 Feb 2026 22:53:26 +0100
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Walleij <linus.walleij@linaro.org>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Simon Horman <horms@kernel.org>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Roger Quadros <rogerq@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 linux-omap@vger.kernel.org
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] net: ethernet: ti: davinci_emac: remove member
 phy_id from struct emac_platform_data
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

b4aed01de486 ("ARM: davinci: Delete DM646x board files") removed the
last user of member phy_id. So let's remove phy_id.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/ti/davinci_emac.c | 24 ++++++++++--------------
 include/linux/davinci_emac.h           |  9 ---------
 2 files changed, 10 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/ti/davinci_emac.c b/drivers/net/ethernet/ti/davinci_emac.c
index ed8116fb05e..df51441a2b8 100644
--- a/drivers/net/ethernet/ti/davinci_emac.c
+++ b/drivers/net/ethernet/ti/davinci_emac.c
@@ -329,7 +329,6 @@ struct emac_priv {
 	u32 mac_hash2;
 	u32 multicast_hash_cnt[EMAC_NUM_MULTICAST_BITS];
 	u32 rx_addr_type;
-	const char *phy_id;
 	struct device_node *phy_node;
 	spinlock_t lock;
 	/*platform specific members*/
@@ -1418,6 +1417,7 @@ static int emac_dev_open(struct net_device *ndev)
 	struct emac_priv *priv = netdev_priv(ndev);
 	struct phy_device *phydev = NULL;
 	struct device *phy = NULL;
+	const char *phy_id = NULL;
 
 	ret = pm_runtime_resume_and_get(&priv->pdev->dev);
 	if (ret < 0) {
@@ -1502,8 +1502,8 @@ static int emac_dev_open(struct net_device *ndev)
 		}
 	}
 
-	/* use the first phy on the bus if pdata did not give us a phy id */
-	if (!phydev && !priv->phy_id) {
+	/* use the first phy on the bus */
+	if (!phydev) {
 		/* NOTE: we can't use bus_find_device_by_name() here because
 		 * the device name is not guaranteed to be 'davinci_mdio'. On
 		 * some systems it can be 'davinci_mdio.0' so we need to use
@@ -1513,20 +1513,19 @@ static int emac_dev_open(struct net_device *ndev)
 		phy = bus_find_device(&mdio_bus_type, NULL, NULL,
 				      match_first_device);
 		if (phy) {
-			priv->phy_id = dev_name(phy);
-			if (!priv->phy_id || !*priv->phy_id)
+			phy_id = dev_name(phy);
+			if (!phy_id || !*phy_id)
 				put_device(phy);
 		}
 	}
 
-	if (!phydev && priv->phy_id && *priv->phy_id) {
-		phydev = phy_connect(ndev, priv->phy_id,
-				     &emac_adjust_link,
+	if (!phydev && phy_id && *phy_id) {
+		phydev = phy_connect(ndev, phy_id, &emac_adjust_link,
 				     PHY_INTERFACE_MODE_MII);
 		put_device(phy);	/* reference taken by bus_find_device */
 		if (IS_ERR(phydev)) {
 			dev_err(emac_dev, "could not connect to phy %s\n",
-				priv->phy_id);
+				phy_id);
 			ret = PTR_ERR(phydev);
 			goto err;
 		}
@@ -1761,10 +1760,8 @@ davinci_emac_of_get_pdata(struct platform_device *pdev, struct emac_priv *priv)
 	pdata->no_bd_ram = of_property_read_bool(np, "ti,davinci-no-bd-ram");
 
 	priv->phy_node = of_parse_phandle(np, "phy-handle", 0);
-	if (!priv->phy_node) {
-		if (!of_phy_is_fixed_link(np))
-			pdata->phy_id = NULL;
-		else if (of_phy_register_fixed_link(np) >= 0)
+	if (!priv->phy_node && of_phy_is_fixed_link(np)) {
+		if (!of_phy_register_fixed_link(np))
 			priv->phy_node = of_node_get(np);
 	}
 
@@ -1846,7 +1843,6 @@ static int davinci_emac_probe(struct platform_device *pdev)
 
 	/* MAC addr and PHY mask , RMII enable info from platform_data */
 	memcpy(priv->mac_addr, pdata->mac_addr, ETH_ALEN);
-	priv->phy_id = pdata->phy_id;
 	priv->rmii_en = pdata->rmii_en;
 	priv->version = pdata->version;
 	priv->int_enable = pdata->interrupt_enable;
diff --git a/include/linux/davinci_emac.h b/include/linux/davinci_emac.h
index 28e6cf1356d..c1482557d3e 100644
--- a/include/linux/davinci_emac.h
+++ b/include/linux/davinci_emac.h
@@ -25,15 +25,6 @@ struct emac_platform_data {
 	u32 ctrl_ram_offset;
 	u32 hw_ram_addr;
 	u32 ctrl_ram_size;
-
-	/*
-	 * phy_id can be one of the following:
-	 *   - NULL		: use the first phy on the bus,
-	 *   - ""		: force to 100/full, no mdio control
-	 *   - "<bus>:<addr>"	: use the specified bus and phy
-	 */
-	const char *phy_id;
-
 	u8 rmii_en;
 	u8 version;
 	bool no_bd_ram;
-- 
2.53.0

