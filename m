Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC6337CD3E
	for <linux-omap@vger.kernel.org>; Wed,  3 Jun 2026 14:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780495680; cv=none; b=Dc+1yh9AVXFj7RqNm3a3U3QJ6QLHhJGMZNAQrrcBnTYVQxwdbxtTpAJNUzQbrt+A5aVMXOsx4qSHz9p8SNeS16uYRzd2zQfHN6U2Q+e/JqCwUoRdc78FTwsi1CQcl8Ce8biRWiMkGu3hO9ny10ldIk7gwbbF7FAd/b1xCqyO718=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780495680; c=relaxed/simple;
	bh=XGKzH9s+2q27a9w2p/I1TF7QHbREPEMPONGhf5bDR30=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=oMI+vRhOYrquxcEwvAQvGHPeKwNpiuM9v9jo34K3IMoI4y0sH8umguldIFJEV5AsjIb7wXX5ohxhsLzx8er7cfEcVnLuKvBh9UhFJf0xGhxLGdKBp0U5hZNBRyXarcWSEaGU9ye2zoZgzyvS2EDO730FPjEbyxcoonBl5hawhow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bOQPueHa; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOQPueHa"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-6603d8697d2so6269998d50.0
        for <linux-omap@vger.kernel.org>; Wed, 03 Jun 2026 07:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780495678; x=1781100478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=0zxTk+9izXoTQNzySWiMV38Wz1CdNNANMN1wpKE+69g=;
        b=bOQPueHagCodEiXtX/jnqQ1Q2rrPGs/B7KT+8kMTXtXgHKvinSV+b5P9QSBZ/e4nWh
         bm5h+VEzJRMTvv6KXZp2hPSQ7wDT92PtK9+gPWm8qfZE5rb+bg6yk60YL6wueCKsRnsy
         DLeLC26lW6N0dpYi/UtKJVtpr6jgFwzBa8g1SaMb259MOkymSAuuzlIpEFvWO/Ylsosk
         aY7Q4sSq4GOCrph4t3ElHaUVs9B1+iN4Go5LmbG893qUXOtgZSyT5Hqmhk40mxDPB2Pu
         5uSpQ5tZcNtKrW8Pl78UlkLcoWQHK5Rdt2m/25RE76wujwOlh8VEWtM0vSFj8zzS9dC+
         cMqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780495678; x=1781100478;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0zxTk+9izXoTQNzySWiMV38Wz1CdNNANMN1wpKE+69g=;
        b=ipiRi2xXRCWsakpQd9Gkie/4fjvJUe/oEkztlpdqUqPkm4oARvKi4WSxF5dmFUhNLy
         AIXlgzR7KoW1C9Q0u1zcTr5uIJkYyI4O5Atven0dxkWrEJiAGVf/PTIjyfxEZzWIzsO4
         VwzMzD2SdJm+hXhWfbwMmPzUBj0Hkpt6AEFRuZfjvqW95og7nJpmVOJksNOSKIsSo14h
         OIpBus0UF52prgK1OjuEOfQjK8x3SkC6vgDT6S8j4aRCH1KBlgVjIF/bmoloC7Lrg0ag
         iKo5YpHrNw6hk8w41F48X761CUmutCxgLiwvqhXeKryNYp39pSdecyFnGvb5GBz6ybRw
         KD5g==
X-Forwarded-Encrypted: i=1; AFNElJ/fqsmtewBmOtGtqpRHZ2XRc3ky+1Edif18yHPYwnOz9G2dAwkawVrTDyEi2+KGjplWTJgSOyoFgD5F@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/Sv9+XH8pDUA+eV06v9I5ePPj9AyPbrLObYhEwbTaluDhwA0+
	EWEtrUC0Ug053G/a1f54cdTsTQOGscNmN5XfgAII4q/AcoUunJ+S10Tg
X-Gm-Gg: Acq92OGQl2DEBb8MqDVcQ93DJMMcmpSjzSjbmaUqyyA+oM13xikzZRjuSsH/weensmc
	oswQlcS6V1VgFHb+a8EoJJH/yeC98581JcMokz/OHxGER+ZejzoFofl+Q7r1/IsxFAmGrb+p1Ip
	Y6L+pK+sP5/bxhxDzBcowK7cmEG3Imsb9ulcUWgOTJjGjU2U5FYt/nXDuAhIJauOVXoyrSLRCeL
	UZgrIeulkDHgDkJQXlLbTTvjyNR2CXGVIKJ89gBIhAovBU0S3ky8d2LQ+OAMIjhm2eAk0fXOsl5
	SgNqnuDunOerb5tfVaCAUXZwoCg2piBuc7jK0xCD8C2QHV4lA4dDcoBoFCTB8rN2dO6rb6Q6Iem
	kDJ0eOxWkbqk3/5/hjpsR79/4AMrKY0jj9Z+Psdmh7fFYudSElx1Gn+5DqjkfUGp8y8Y+b768Mi
	2vY8aa+tlbqdbce/X5BYtZOio=
X-Received: by 2002:a05:690e:4812:b0:650:3952:3d3d with SMTP id 956f58d0204a3-660dbfd0026mr1783021d50.44.1780495677652;
        Wed, 03 Jun 2026 07:07:57 -0700 (PDT)
Received: from lgs.. ([118.193.39.24])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-660d647d3aesm1885466d50.18.2026.06.03.07.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 07:07:57 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kevin Hao <haokexin@gmail.com>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	linux-omap@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: cpsw_new: unregister devlink on port registration failure
Date: Wed,  3 Jun 2026 22:07:42 +0800
Message-ID: <20260603140742.1398659-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cpsw_probe() registers devlink before registering the CPSW ports.

If cpsw_register_ports() fails, the error path only unregisters the
notifiers and then releases the lower level resources. It does not undo
the successful cpsw_register_devlink() call, leaving the devlink instance
and its parameters registered after probe has failed.

Add a devlink cleanup label for the path where devlink registration has
already succeeded, and use it when port registration fails.

Fixes: ed3525eda4c4 ("net: ethernet: ti: introduce cpsw switchdev based driver part 1 - dual-emac")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/net/ethernet/ti/cpsw_new.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/cpsw_new.c b/drivers/net/ethernet/ti/cpsw_new.c
index 7f42f58a4b03..95b3b58db6e0 100644
--- a/drivers/net/ethernet/ti/cpsw_new.c
+++ b/drivers/net/ethernet/ti/cpsw_new.c
@@ -2050,7 +2050,7 @@ static int cpsw_probe(struct platform_device *pdev)
 
 	ret = cpsw_register_ports(cpsw);
 	if (ret)
-		goto clean_unregister_notifiers;
+		goto clean_unregister_devlink;
 
 	dev_notice(dev, "initialized (regs %pa, pool size %d) hw_ver:%08X %d.%d (%d)\n",
 		   &ss_res->start, descs_pool_size,
@@ -2062,6 +2062,8 @@ static int cpsw_probe(struct platform_device *pdev)
 
 	return 0;
 
+clean_unregister_devlink:
+	cpsw_unregister_devlink(cpsw);
 clean_unregister_notifiers:
 	cpsw_unregister_notifiers(cpsw);
 clean_cpts:
-- 
2.43.0

