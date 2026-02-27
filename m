Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877EB3783C7
	for <linux-omap@vger.kernel.org>; Fri, 27 Feb 2026 20:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772225541; cv=none; b=GCS7rWAFSUmHpifHVN72BKyp/Ui7XEipF4q4ctNJUvroOZ09sFVwz/C6+ZqAY0iei2ZaN3rDnWJYBvBwxE0v6tXXzLwSW5aAoDllzjLuJSdwnIspraBCa8LZjLf2DenqS2B7vjlhaYnV+EAMl/3bLt/netK27fmSAh5yfxdpExs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772225541; c=relaxed/simple;
	bh=GqjKoTi3sqjM4DFWEK5EeqFz+57uitIUOBAcAYymFh0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=IUP03PwdipEaOc9IBe0wWmwQ5rJBgPnsImaIrYuFTFKDRFSUjQ1u1cOmmTCFwvu0L9fAIxZUNsKHMURQlyWDKatoHoBicf9rM+FZ1j0LSmTH8jgdm1TjQoVeEHeSeaWhWTyphMX7Ih+MrdqFk0Sl1PANpHmMtpXOv6wU96REZdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nA+jGx3/; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nA+jGx3/"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48379a42f76so18920185e9.0
        for <linux-omap@vger.kernel.org>; Fri, 27 Feb 2026 12:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772225538; x=1772830338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=91AmFn1bnJ1j3RF9zOPMDgsmX8OjH1RBUGMrbZi7xFY=;
        b=nA+jGx3/AUZeX+U3ufEQ2egXe+Tjp3CNeTB0mQ4UWRIc/6XJMLoYe5mYgusZXNEMYl
         YYWaFOpeBGh42lG1g/UjoTpQ6gpIZIE6TrNaHvS0wh7me7zv9LbH834QvcU8IWM+wC5+
         U/yxWN5LgL9InzldZpK10azlZgVi86YQDE5sAuH3Xz8rLkoGOkTmsVYywlAORSsIGVYW
         D4vRkEj5s2hqHptXdhgCtQlpKvCtYJrFfb35ZAgsuv6CFnYoZ7PE5zKqmlrZ2UlvYJWV
         c5E8GmKMqV6aXfolXl0arVsfPyxdQnTOK7BkvYAPdj/x2YbgVYE0r+CSJLkS+GDZzLPZ
         yv4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772225538; x=1772830338;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=91AmFn1bnJ1j3RF9zOPMDgsmX8OjH1RBUGMrbZi7xFY=;
        b=nVKZ4ByMMlWgPWB41Nx++hhGvlm3fpeoLi0ZXO1TZWAtpDW4EYpxmE52KA5pdKVj4O
         THI8DDm7CDPFC9xGzFdCWmoUD/qBFhV2hj5jEzveWU2IGQ7+EIn3Dev2JvxnnsWTje8v
         GvUrqaTJVN4n9aLzmzH0/eBle4HMkN5szEjhP1ftteFn/jPdeVx7+LSWjaWQlaQykRSw
         kVWmEvOA9Mr4zqZLCU9wcZLhl0XB8zzOqM24blaHEl39i2h3G8ef45gbmU+73oFWXOnl
         fdMpPk0NXXMyfqmVvCHsNzkOS3Fu9s1YIPllb39dLPKlo74izv4CygS1RknQAnALeroM
         6dDg==
X-Gm-Message-State: AOJu0Yw4uLW9zM9uhJCLa1aZZ8Jr8jbEx8BSzrSFzHpfln8qoa1pkMWv
	ThvGI9L/vQqYeBM6Konlf4twB7jg2+io1SZmWcrYUO7unE33sGbqMqeq
X-Gm-Gg: ATEYQzwdZNJpkAYJchjxYH+2f3OXBZnXerSuGiC9unhECGVtwiJSbJMKRocnDaXzpih
	LQth9yUw9UP4Imv2K19RzsJlKgwx97+UuRZKfs13lunEwGrf1FxUV6Y18maPDwvY2CkBT/OCpgv
	XZ7+u1bqOkhDgxz2GWjsxp3rveTSPS9v2ozudDqVqo5tgjMaDgoxqGI6H0RkZQ9iXHByTG2FVBa
	7g+QR2yKTK0GXZW/eVAzzrGqFrQzIw08KaDqjwF+01wY5qatkUvvhLu0aaAzPok4ZDGRzu6PE3+
	wsjvZDhEVY0n09dXLAxXJ1ymgeECcX4ZJZEhFn+4WwgHqBPa+y8s30h3xUv3OaUxL18EuczOmJw
	yZGwq1/K/N/lxcLartL/YkpF6p+kMeP4a3XotptH+EZzbN1D3BDYuoMdd5f+qDX2Bm8i62s4ag7
	6kKma8P8mn9b1LFKGrux4N3fCDgVP989TK24h9EqsFMedR8eStU2yY4dVekxOxEptNv8TJJhisg
	SVVyPPSKfLuu6KkG9l4o4BTYozBvTlO5DAPTZDG7RcjTju+j/pD6gnc9XHbbpEYiw==
X-Received: by 2002:a05:600c:3b18:b0:459:db7b:988e with SMTP id 5b1f17b1804b1-483c9bc1f39mr72749215e9.13.1772225537679;
        Fri, 27 Feb 2026 12:52:17 -0800 (PST)
Received: from ?IPV6:2003:ea:8f14:5500:d4cd:9f12:bbf5:9c93? (p200300ea8f145500d4cd9f12bbf59c93.dip0.t-ipconnect.de. [2003:ea:8f14:5500:d4cd:9f12:bbf5:9c93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483c3b7713csm114349145e9.11.2026.02.27.12.52.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 12:52:17 -0800 (PST)
Message-ID: <cc8e83aa-48c3-4497-b6ad-760a7f9e25dc@gmail.com>
Date: Fri, 27 Feb 2026 21:52:16 +0100
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] net: ti: davinci_emac: stop using bus type
 mdio_bus_type
To: Siddharth Vadapalli <s-vadapalli@ti.com>,
 Roger Quadros <rogerq@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>
Cc: linux-omap@vger.kernel.org,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This driver is the only user of mdio_bus_type outside phylib.
Using mdio_bus_type isn't strictly needed here, so use an alternative
approach. This will allow to make mdio_bus_type private to phylib
in a follow-up series.

Compile-tested only.

Note: Devices supported by this driver are OF-only, therefore the string
      comparison in match_first_device() isn't needed any longer.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/ti/davinci_emac.c | 39 ++++++++++----------------
 1 file changed, 15 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/ti/davinci_emac.c b/drivers/net/ethernet/ti/davinci_emac.c
index 22d14fa5fe3..052ecd83f80 100644
--- a/drivers/net/ethernet/ti/davinci_emac.c
+++ b/drivers/net/ethernet/ti/davinci_emac.c
@@ -1389,15 +1389,6 @@ static int emac_devioctl(struct net_device *ndev, struct ifreq *ifrq, int cmd)
 		return -EOPNOTSUPP;
 }
 
-static int match_first_device(struct device *dev, const void *data)
-{
-	if (dev->parent && dev->parent->of_node)
-		return of_device_is_compatible(dev->parent->of_node,
-					       "ti,davinci_mdio");
-
-	return !strncmp(dev_name(dev), "davinci_mdio", 12);
-}
-
 /**
  * emac_dev_open - EMAC device open
  * @ndev: The DaVinci EMAC network adapter
@@ -1417,7 +1408,6 @@ static int emac_dev_open(struct net_device *ndev)
 	int i = 0;
 	struct emac_priv *priv = netdev_priv(ndev);
 	struct phy_device *phydev = NULL;
-	struct device *phy = NULL;
 
 	ret = pm_runtime_resume_and_get(&priv->pdev->dev);
 	if (ret < 0) {
@@ -1502,20 +1492,22 @@ static int emac_dev_open(struct net_device *ndev)
 		}
 	}
 
-	/* use the first phy on the bus if pdata did not give us a phy id */
+	/* if no phy-handle and no fixed link, use the first phy on the bus */
 	if (!phydev && !priv->phy_id) {
-		/* NOTE: we can't use bus_find_device_by_name() here because
-		 * the device name is not guaranteed to be 'davinci_mdio'. On
-		 * some systems it can be 'davinci_mdio.0' so we need to use
-		 * strncmp() against the first part of the string to correctly
-		 * match it.
-		 */
-		phy = bus_find_device(&mdio_bus_type, NULL, NULL,
-				      match_first_device);
-		if (phy) {
-			priv->phy_id = dev_name(phy);
-			if (!priv->phy_id || !*priv->phy_id)
-				put_device(phy);
+		struct device_node *np;
+
+		np = of_find_compatible_node(NULL, NULL, "ti,davinci_mdio");
+		if (np) {
+			struct mii_bus *bus = of_mdio_find_bus(np);
+
+			if (bus) {
+				struct phy_device *phy = phy_find_first(bus);
+
+				if (phy)
+					priv->phy_id = phydev_name(phy);
+				put_device(&bus->dev); /* of_mdio_find_bus */
+			}
+			of_node_put(np); /* of_find_compatible_node */
 		}
 	}
 
@@ -1523,7 +1515,6 @@ static int emac_dev_open(struct net_device *ndev)
 		phydev = phy_connect(ndev, priv->phy_id,
 				     &emac_adjust_link,
 				     PHY_INTERFACE_MODE_MII);
-		put_device(phy);	/* reference taken by bus_find_device */
 		if (IS_ERR(phydev)) {
 			dev_err(emac_dev, "could not connect to phy %s\n",
 				priv->phy_id);
-- 
2.53.0

