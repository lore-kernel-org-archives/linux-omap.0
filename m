Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9630C38DD3
	for <linux-omap@vger.kernel.org>; Thu,  5 Feb 2026 02:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770259642; cv=none; b=Qu+41gLgeC9XNAhQ8xkzKTrxYz4+EFWqfNFHQOHFEic6PWG2IYncFvQCz2ED+Vrw6OR3GqzT5FKEzFPsAwvUYhIMrQtxkyJqVM0ejDKGAGw2XdrBQQ5UDAPzeO6+c0Vk431zdgVKlvIltdav26a6UDP7LPOq+mnbT8mLiLTTq7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770259642; c=relaxed/simple;
	bh=8Gg0Td2TnZxUw2O77jFwN1ILQNYnFw/fjFCDTq59L7s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IBA3c8U4Ot/wXEx0+PUGwwH2iuyTi4JVw/HXKgg3xB/NR5W2XZSlU9usFSsiQ8RWpB0eegmftwnBlGa8pYrA4MP70kolg2bavuDepc1zLdSmed1T2gTCcYBBpgtkkvOn54SgHlHq5eJ3G8lHjzSJDhwLRgQgO2NRXel2MqC+FNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VCz8lea8; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCz8lea8"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8947404b367so5682676d6.3
        for <linux-omap@vger.kernel.org>; Wed, 04 Feb 2026 18:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770259641; x=1770864441; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nY8yM9Zc7+K73Kkfh7FYItubbQedLPsN6KpC2egtpVw=;
        b=VCz8lea8AO24AxguUZNZbQHcKsENy+UuqehHjyHuDnOmJGfUMnTBbtrE+3A2FN2Mcs
         /5yvx/4iXb4ir00o/Hj0jbCkVq8kK6sGBuo/MV0QujfbUxUJQgcSgcnwtef2uGS/ExU1
         Vo/Eter55UIofqEEJhSghxHifpr88MsDdZ6y6elB67y8khqmVCXnhEsX4ZX/AKXf4tHK
         L5ukdPJDL9BnviNJTiDhORFPL+cRlE0Xq/vqfNc0MFgM0DvsuFiDr3S7lHUUUEnOdEJQ
         srpxmg2Vo0hAkmHwvgwLTvgvdHp7QyMSAGs1AGh+Hm7J2N9YUVJt3Gy7ewnf9fNcskA0
         sJnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770259641; x=1770864441;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nY8yM9Zc7+K73Kkfh7FYItubbQedLPsN6KpC2egtpVw=;
        b=wgyylpD1ZX8r1y/DCeomawBr/YKjeGzrNvEXhPHbtaDDJn65JUGnej5KKUR+pknsir
         CdEQ3VahRFcj5ZaLB2nyvFFNp1ckpirm4N8s02I0kUoyiAveuzavOsE3UxqIAmqWWM6/
         PZJbQb8vbAORExICF0Cyty8JqdrVZDsSif0pLXgkIwfg4DfUdEAI/+BUeAtF9DLtzHuJ
         2O4VJJhV9CteRJW5ZPLLbYq43368zVz9meh+nyaxvFKTB27+KQtb2PE8lOuQ1xmo10nY
         H8CmfznZYlojJa5WBePjDLbPD6+OU4f/DWHaaFvmIoFECvQ/Bnv5vfxtVrRG+N6ch1aM
         nE0g==
X-Forwarded-Encrypted: i=1; AJvYcCUwWEJrg8ovXHuYXlrJ3yfY7tiNmz/JDdxJLf+LZ3zBoZccgkgeZIkQl4Wdz2MHqs55tpEi9VwrgtCP@vger.kernel.org
X-Gm-Message-State: AOJu0YzITfCcxz6EhqKNVhF6+PjA8uV8Asyxisstki+emZiKvpBTQYIs
	5vkvIchTWznDrgBvUMJaQaqQWg/8Vbhph6ajbN+1agGoIQXDTQQ8gbP4
X-Gm-Gg: AZuq6aI5KRoBh2FH/CoJvUCTgTkPVBDdYLezjU46EODp3V2dkBPLUJcxBlOfBEV8f+z
	G537bKEEkHliEflMoMRIKnq5H0D989TJZgrDniRJfAygcnv38MbctbBIAnGXcDuo91TNTnKuVFn
	z6DKhaktFJiFTQ1gs3meU45pVbovrZZfkTwWKwH/QDFkjVjJdIODn5Q+DI7u5qT8DculFznhzDZ
	4tuvD1fl/BkOej+tg9BzrBPCdKc6k6f0wut6x1HJXYX/gd1cGSTuRWamMAR9my3bHkd+QOz8kur
	/TDD9yosqgVZPD/wP5rAVhVnPLylvwSi7CxIGObJUfvhgKiluISQ0fCl6nSCkyB6xhQkw6Z9Xke
	i8Xm/oAw6ZzB7Cswqxv7kzwR9du8oD/hlbqD00kAsw//jG8J1Tz4fuG/Qcm/eSagG4KxNTNLY1z
	4nOGO98320Satkm1X5s6y6RJQPUtEzkBo=
X-Received: by 2002:ad4:5ce2:0:b0:88f:ccba:8f20 with SMTP id 6a1803df08f44-895221ad111mr65849446d6.48.1770259641266;
        Wed, 04 Feb 2026 18:47:21 -0800 (PST)
Received: from localhost.localdomain ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ca2fd2b5e3sm308193085a.25.2026.02.04.18.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 18:47:20 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
Subject: [PATCH net 0/2] net: cpsw_new: Fix multiple issues in the
 cpsw_probe() error path
Date: Thu, 05 Feb 2026 10:47:01 +0800
Message-Id: <20260205-cpsw-error-path-v1-0-6e58bae6b299@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKUEhGkC/x2MMQqAMAwAvyKZDdSCCn5FHGoTNUstqahQ+neLy
 8ENdxkSq3CCqcmgfEuSM1Tp2gb84cLOKFQdrLGDqUAf04OseipGdx1I1K9+tDSQc1CrqLzJ+x9
 nCHzBUsoHZMvzs2YAAAA=
X-Change-ID: 20260202-cpsw-error-path-dd5bc72d6daa
To: netdev@vger.kernel.org
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Roger Quadros <rogerq@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Daniel Zahka <daniel.zahka@gmail.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
 Nicolas Dichtel <nicolas.dichtel@6wind.com>, 
 Murali Karicheri <m-karicheri2@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Grygorii Strashko <grygorii.strashko@ti.com>, linux-omap@vger.kernel.org, 
 stable@vger.kernel.org, Kevin Hao <haokexin@gmail.com>
X-Mailer: b4 0.14.2

These two patches address duplicate or unnecessary netdev unregistration
in the cpsw_probe() error handling path.

---
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: Roger Quadros <rogerq@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>
Cc: Daniel Zahka <daniel.zahka@gmail.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: Murali Karicheri <m-karicheri2@ti.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: linux-omap@vger.kernel.org
Cc: stable@vger.kernel.org

---
Kevin Hao (2):
      net: cpsw_new: Fix unnecessary netdev unregistration in cpsw_probe() error path
      net: cpsw_new: Fix potential unregister of netdev that has not been registered yet

 drivers/net/ethernet/ti/cpsw_new.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)
---
base-commit: 0f8a890c4524d6e4013ff225e70de2aed7e6d726
change-id: 20260202-cpsw-error-path-dd5bc72d6daa

Best regards,
-- 
Kevin Hao <haokexin@gmail.com>

