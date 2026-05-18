Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617C934F27F
	for <linux-omap@vger.kernel.org>; Mon, 18 May 2026 04:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779077781; cv=none; b=Ysz60YUpCnZT/RJ+XtUUBveyNGKimUdg6tC53Pwks2eE/xsR+wtK0+ojOEDjyfVRzXmGYy+RQMGqC7UNGJuVoJ/cIoUz/ylYehTXLwNHXfmoeZ2eYmv62lF6yhkbv40cuB8VtWGW9jZ1adc8RV+4qGGaGRpYFZFqXlKxwihaFoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779077781; c=relaxed/simple;
	bh=NNLw2mHv8LfbmL7f5JQUYeGZzG4YcR6rxxNzYnnt9ZY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tutyGK4b/vC1HnOGFXNVX1rB4qx2YwKM/7B+TbpvWrbM32rfcwyCYrtIrkV2HBtmHFv6Ay2UGGjrKDVxIq3RvC1cY/T1Y+ch0PPGYkXnvJ68G3vAD8zQiZdE8hluYfrmhKzxPxau2MUV0JgM4IqumsiZraQKMrVN5jGVqI5HYmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TPBe+RT/; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPBe+RT/"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b9ec9443c2so14244045ad.1
        for <linux-omap@vger.kernel.org>; Sun, 17 May 2026 21:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779077778; x=1779682578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7aye6WWOgBR4D7HR027ausHE7pM+mcEdLaJ+4UgKytw=;
        b=TPBe+RT/8EcbG5LJhP0AJwnVkMCxoOCnDtzoywzm3fjo5kGz71bZnVJuTClfhed56j
         +7ZEQZK50/Et3dfatRzw1lh4PqTMahy8FLRZKnirl4YSXf2LWKVzjahdA6J8WkXsyPtI
         EtUmvZWTJnkOL8U9MozIOnn1ZNjlzGcyOxuGLsb+AqlWmsaa30n+QdIV2h/K7aJXhgDO
         8E4av1+6ArJTW+qeJ9VWdTJN1KXSgyxnUqlYHGSlEvUX82e0dvCl6B0yAGs5q9jmJssd
         aKIZcj2P2H/Fk7MB/1JOUsqXsVzuDVCqLlAdayzRbkBjzUBX0pLHk1Mm9sxU6KOUmGO1
         SWtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779077778; x=1779682578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7aye6WWOgBR4D7HR027ausHE7pM+mcEdLaJ+4UgKytw=;
        b=dORZuCSDhnsl+TZ4XjXcy2on1YCQEhdnhuuH2+IODhjP08ccBtdFj6DFuKCRXxxqOo
         zDFUdNPKAleOKC0lSoTQUPmvnwTWzuDb7D0yDDPcodfv3sRr17DNSokxuuFzk8w2s8mP
         oQwD+a5RS+xfgfbK0yKmZGePZ7RGY+QxAhijTvfAI4TKwALqDk3aPhfNH5Ts9zGHWHjA
         KSRF8NlWKks4avrzR+u9PJyMyCmOZ1MW4SGJeQYt1oZ6R8kggT11RO/gpl1qCyWkEHJT
         /4VYThHGh/aD0a0bV2mm3JfjKj7bBDKFi9jjri4cNJ65wwdvmlBO8KNDm8K/E6Tgptt/
         tLXQ==
X-Gm-Message-State: AOJu0YytlhRWJ2Prsie81Oq09p6HOp/ceu2Nb6Igslb4ZXQT8JY2ryIp
	ZQDtFbZS6n4Z06QUQG98YD5+wu9sJ3hBXLCF40h7Z12N6UZMvBqlS/Uqkx/Hag==
X-Gm-Gg: Acq92OGMFrGefeY86vewk54VAFLPgMRaQ5/IWs6gbgDV2bzl9cspLr2C8ln2VofC4gO
	rVx8tsyuls3LNAlrNjKD4WhTbvDrDL3N/9LI5/3hVLNRjrLvAIwmUYPz1o/EAINTV1n9UU4gz5J
	yFum7qfEWd78pY5RNCgZcgBBs+cTHkjB/jYnyBlY1Zmmm7TyyyheUcuxqoKH17mx9QnxaU5wys8
	esSpKzgR2MRPGPgXpCtY/acp9VBYb98kuAmvbIJd4yc5Go/l8rZIVWddmNemxct8OagKuMwsub4
	I4NU6fm75Q/jdSGiln9GBANuKfYOYNPV6wjTK6JevgMlL7uVD3CmcTTSD9mYPjOoicZGVna+uDz
	jS9rjAz1U/0DiTXJKIqLS/gIxTmXZ9uacxBh0dVjpKCbsXYqozwigbwsq4mnyCY5wfeXWVMuutd
	qfeljnoDtJQQZVuCIdyFd/1diHpaC/bRD4eF7qJLJz5l7rC6zriFGZva6lQySuGTfoT12jTjHxW
	KEcbgCr5P6uRQyiLA9cnwoQsCSWPEVBK/IG5of3EVE/2g==
X-Received: by 2002:a17:903:1b45:b0:2b2:9a70:3f0a with SMTP id d9443c01a7336-2bd7e7f4367mr111456415ad.4.1779077778413;
        Sun, 17 May 2026 21:16:18 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5fc60sm136973385ad.9.2026.05.17.21.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 21:16:16 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-omap@vger.kernel.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Lee Jones <lee@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] mfd: twl6030-irq: Use of_device_get_match_data()
Date: Sun, 17 May 2026 21:15:58 -0700
Message-ID: <20260518041558.765958-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use of_device_get_match_data() to fetch the IRQ mapping table directly instead of open-coding an of_match_device() lookup.

This also lets the driver drop the of_device.h include.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/mfd/twl6030-irq.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/twl6030-irq.c b/drivers/mfd/twl6030-irq.c
index 0ca00f618d4d..8831c81a1f90 100644
--- a/drivers/mfd/twl6030-irq.c
+++ b/drivers/mfd/twl6030-irq.c
@@ -27,7 +27,6 @@
 #include <linux/suspend.h>
 #include <linux/of.h>
 #include <linux/irqdomain.h>
-#include <linux/of_device.h>
 
 #include "twl-core.h"
 
@@ -293,10 +292,10 @@ int twl6030_init_irq(struct device *dev, int irq_num)
 	int			nr_irqs;
 	int			status;
 	u8			mask[3];
-	const struct of_device_id *of_id;
+	const int *irq_mapping_tbl;
 
-	of_id = of_match_device(twl6030_of_match, dev);
-	if (!of_id || !of_id->data) {
+	irq_mapping_tbl = of_device_get_match_data(dev);
+	if (!irq_mapping_tbl) {
 		dev_err(dev, "Unknown TWL device model\n");
 		return -EINVAL;
 	}
@@ -334,7 +333,7 @@ int twl6030_init_irq(struct device *dev, int irq_num)
 
 	twl6030_irq->pm_nb.notifier_call = twl6030_irq_pm_notifier;
 	atomic_set(&twl6030_irq->wakeirqs, 0);
-	twl6030_irq->irq_mapping_tbl = of_id->data;
+	twl6030_irq->irq_mapping_tbl = irq_mapping_tbl;
 
 	twl6030_irq->irq_domain = irq_domain_create_linear(dev_fwnode(dev), nr_irqs,
 							   &twl6030_irq_domain_ops, twl6030_irq);
@@ -378,4 +377,3 @@ void twl6030_exit_irq(void)
 		 */
 	}
 }
-
-- 
2.54.0

