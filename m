Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11BE3DA7F2
	for <linux-omap@vger.kernel.org>; Fri, 26 Jun 2026 09:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782466904; cv=none; b=U7Un/AKFU8ogZxdAsPOLhZu/zY92GIWJJLqZF6VNmbwGZ5hgv9QmgNm+h9zA+80fpRk7RkXch7grgfuaE+sjyfK0qvE4Djn26e7hkv4cfFngQ/1I5MInUl6ujPj4yqHXmWGL8S8E0L2PNJa+Ge+CyV6nANfZLulfYWZRqMoqX+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782466904; c=relaxed/simple;
	bh=MfAhvEObsV+KWrsGCI3P9Sm+CI6pojZgxHIyPBbaVtY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tLRcWKCdEu4KiHzy+C669KnqWh5wvJ5aVh3mhlfYeGTUHSvpbBaRa1Bt7R8KQYXrDv4/a2CY4n6yhBfmuNI8owCQqSm+ceT0XnYwBHXlABNwVM/U407Dq1I25DamJTm8ogneAcq2cd/O1re1MMyDOkJJ4BQzWTHRfdTpwCi/hvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FePgrkES; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FePgrkES"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-37e0d09be07so535658a91.3
        for <linux-omap@vger.kernel.org>; Fri, 26 Jun 2026 02:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782466902; x=1783071702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7J5GI2pmCkcVilqZesKiSKQTUF3Kx6m9amj3OnCb7ho=;
        b=FePgrkESIGxeer7BHTiyP2TAgfINLAmkUQERMgw/JKd2LX614imH4Ghx8gRrjaE6fA
         2SL3G8m9j2PJOon+W4Z9O9NrDf1oHhWHn16lWs6S7subGUtX3+xR3O3Tjd8d3JXkVkC7
         EWZxJ+hHjfWyOnckINiF73QwCrFzsXaSY0H9mfr4L0DilRr07yPH7XpgKjXosE2lRpsg
         7x3sLv61lo2N0SF5hh0RUKlAgvu7FuSgzajhqGSW5rUBScOylNQorkK2ajAmOf/uIlJH
         oPPnK2Nwq5gSNqCxrF97qkimI0/HgaoeyH7u+Una15GUg7u3PR8fqvIVarMPDrBADAqv
         xetg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782466902; x=1783071702;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7J5GI2pmCkcVilqZesKiSKQTUF3Kx6m9amj3OnCb7ho=;
        b=kBA8Ujo9km4uylTtxqvR8ZathIK3cNH1yJFIjudiRsurS/mWBSjuzveo9o7MTTn+VF
         TQl63u6rP8hTqcZcrPeFClPAZyN/tNuHf0EOtmm7ItqVIPYLDG67/bDXkEktleOpu6Vk
         7eOa+hGql1fjSt9KSEO33f1kcmdOLy9aBnwMazWTZgsJS3mVx56sO1HO/jtvH0se+UFl
         wdh00qgI1rVpBypHfxbf5/CHNBLUQFybWoTS1HWHUS+czALq1ZprFIuxiSC8gaMFARzp
         /K/he0e9dYZVliFH5rgMhJYVTrz+2rcOT92FGrT6DGkJHdyKsBkoIkXMhaeU7pKJA/Z8
         8zFQ==
X-Gm-Message-State: AOJu0YwRq/SYQtQBueiTWMPp8a+kCRfhxbt3l8Ox1LwvQTwNgSNZp3Oy
	UBXesqcvKoBsVZUyZcdQuU6fgU6V83t4oUgPF1/vdlJ9z6gdM+Rsf/o=
X-Gm-Gg: AfdE7cn5lH5qzGpiduQgWISaQGrEtKHdrULwLaMSPFa8OkqpPdt5CMmYI+a5mlQddOc
	iwli2d7EfktKHdOfhi2VUc3RVEavcox5SzfoF94oY5fqRIQ5r1I2Co6Gpkcfgl+3C53ZGobJrkJ
	MEUT58MdHYDGbg7mzMr3JJOfVwwsH+GmryWVoQTNIdWw3Jz4cmRsDVm4aM25sWayMIIbgasyOXJ
	YWGQ1AwPaGbMH8nYlVIWgNoKUPEYcYB9h4bdI4o8iFfz/7QIha4t2u8m258o5koYsbwV+tWxZpC
	n294CCrvDkqUk5w245O0RUEOAAUJ0WxoifCznzIre/qngtVWvE6YdJvW6jVJOJtZMrvVuRMLUbN
	VLskvfBzwW4bUKrOVadod9y01tAoYwcxmT0/uHTnJsEFGlc8qI4uRE4f2DBmbTLuBuko96c0n3P
	PSyAsmCo1JfcBFUN6KLL+ACcnBABWCs/OoxK1yTlJg3MG1VVgPTN9K+6QRwr7lEOjSC+9ExPvM3
	LSb/bMNZjGe2unwxLfvhkSpHB5ts0b5NSoSv9LXNyOHM7E3UQ==
X-Received: by 2002:a17:90b:384e:b0:36e:2106:ded8 with SMTP id 98e67ed59e1d1-37dfa28bb98mr6256890a91.25.1782466902167;
        Fri, 26 Jun 2026 02:41:42 -0700 (PDT)
Received: from localhost.localdomain ([14.5.152.27])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37e12daa2fesm456408a91.2.2026.06.26.02.41.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 26 Jun 2026 02:41:40 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Tero Kristo <kristo@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: linux-omap@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] clk: ti: adpll: unregister OF clock provider on remove
Date: Fri, 26 Jun 2026 18:41:26 +0900
Message-ID: <20260626094134.71961-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ti_adpll_probe() registers the driver's onecell clock provider with
of_clk_add_provider().  The remove path only frees the clock resources,
leaving the provider registered after the backing data has been torn
down.

Unregister the OF clock provider before freeing the ADPLL resources so
the provider no longer points at released driver data after device
removal.

Fixes: 21330497f303 ("clk: ti: Add support for dm814x ADPLL")
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/clk/ti/adpll.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/ti/adpll.c b/drivers/clk/ti/adpll.c
index e305fcb..0c22e33 100644
--- a/drivers/clk/ti/adpll.c
+++ b/drivers/clk/ti/adpll.c
@@ -925,6 +925,7 @@ static void ti_adpll_remove(struct platform_device *pdev)
 {
 	struct ti_adpll_data *d = dev_get_drvdata(&pdev->dev);
 
+	of_clk_del_provider(d->np);
 	ti_adpll_free_resources(d);
 }
 
-- 
2.53.0

