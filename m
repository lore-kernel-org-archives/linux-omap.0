Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E043B9DAE
	for <linux-omap@vger.kernel.org>; Thu,  4 Jun 2026 04:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780548069; cv=none; b=AlPw+hRZxO7BA7NZzyOvm4iEaXHlPM4koGqnjPqKK6PJWgDDuSEsOuEuYEEYHKYY1bS19SCH7TsKhTwFXB4hTRtQJAdP/iqGNDj6Y6JAHGZTNMNzw/gxkJHtj6Hb8Qx9EOmbDfE98LaT3PXVECHr/g3GimTrGASGhQR1e2CCoK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780548069; c=relaxed/simple;
	bh=0eh0KIQbs1qSSAuQkd0I9L7iFhTklV6ijuBWROey6iE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r3AOhFYxUQLGhXigq3ONATOJd9DhyTOM9Kh0Z8UNccRX19z5eeV+TIBFrswrLYjVvJjR1NCW7MiDw2fSin1o5czP5VQNojweqD4O/MUPccWz4uM58fZQFeoXPYprHFm/p7UDBOOZIjug2K3KD5e13IeyPfSbGtzlM1BV/HtgoYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WKkcjl4r; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKkcjl4r"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2c132ac5ec2so2965245ad.1
        for <linux-omap@vger.kernel.org>; Wed, 03 Jun 2026 21:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780548067; x=1781152867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yYdWhysklbTaMq+vmdQBdY8EoKqbkXlWNN3QS92WACE=;
        b=WKkcjl4rEo0R/2bVQHQhF+2KrgYUhQxFwDO0nrd5ggTAnbkaYiuhg7oB92ZKBNjevj
         vfTvgz93bYw0az1N5L1zaR7GkwpSpwBuSS+bkxy+DAowNYnMOXUds9oqW2xS71jtcbJ6
         L+fTYm+SX4fvoqp6wZNgpOQVt598M0AcP6CiOyfPEXOZLzqk6o0oa8R/q1YVo3A1XMUB
         k37fufOQ1OnVAG/sDyyQUS/T8GBJ1AWHu9N4jJGpqWv3AwFTKsZ405s9Ig8LejyR9E/O
         gLrYHXf1qhr2fySrEF2lUZEYGh3UKYDv6cHKE3RxQkEm3n3KJOX/kGUmVuBLiUgswkCZ
         yh3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780548067; x=1781152867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yYdWhysklbTaMq+vmdQBdY8EoKqbkXlWNN3QS92WACE=;
        b=XfqvjkZveWVX4i7dXhfASat0m4MYHK1Z90hkrcam9UmSDdi4GYHAibCIpRmYFOFX4p
         hnW2gkyFOTmzP81Fp36cgLcrOYGtSwt3UhpgHjprv7OQK41O8eXt+zD0/HU5rCNvVTMG
         qPQW0GjnJmxGPzQZALWp53jOrs8mVPguTJvKAKylKMe5p/ko3y1WVK9x44eTOGnn2h6t
         zpvEyRwZkMmmNLhZ3HOqHGStVKGT8JwkWx0tjAxYHLjMBClRh3rNrlD+kByA4zG3CcZW
         zA/6frstMhlzf2E+08JaszKb6YrTOddIwZadQmITz30GL76zDl88kilPcSC2vuqrYgt2
         YAbg==
X-Forwarded-Encrypted: i=1; AFNElJ9rwWDMQRCVY5bp1iekBYBoltgLP9Wx9vo4g3EOBv3tdKXbegT3KaNrSAUIQKzTg2Wd9UedvvlOvRA0@vger.kernel.org
X-Gm-Message-State: AOJu0YzK17R9tKve5PIESKnwn0Rl2L9+gUYySOp8ExF+KJy8c3Y1/eo0
	5cdgc8vfyJFmsLGEsU6eyQ7uoILQq17c0J/T+5zMDfUUy4GyzoKz9WV8
X-Gm-Gg: Acq92OGMCTqI5ywBqNAlFhBd+gOUrfEPJ/XI78VRX60gJiVgK7pAgVzDeckcwkN9bLe
	TsQLUZVQnDJZNdIT2aJ6V8GVZcmuhseQhBPxna3NduyT+qCbWTGXlHinTRjV9H8w4kE5Q2ZVlBU
	j6GnuKxorPNYQdZTZWY2m0QkKTyQKF2vKbOLnAU2S9OGdDRMcOyxhm1TCkMHOqdsHDvJvJBUyhQ
	DsIfazhDl9mSrdCfnNHNkHeETv8dCL88YwSelm7WNG6U9Zei3hpc+RLteRG9MUi/fWR4aVqEOAC
	0yXABZIfe5Thd3sNOZiTxqtfH73QZlIXCNe/6XSXVAXwBJESiSlwSZrNsZO4aSJ/sv++dRijZ5Q
	c38w6U0rdFdR6UoPoPZgMABZ5b/XLt5KgKYc437B/gHuog+Z4l7IFvhwkZUCMT6IrQWJROUQAj9
	NEraWiHlwiZThJwpHz
X-Received: by 2002:a17:902:d2c2:b0:2bf:21e6:baee with SMTP id d9443c01a7336-2c1641be20dmr70162455ad.28.1780548067020;
        Wed, 03 Jun 2026 21:41:07 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e096sm42344025ad.44.2026.06.03.21.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 21:41:06 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Kevin Hao <haokexin@gmail.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	linux-omap@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Subject: [PATCH net-next v2] net: cpsw_new: unregister devlink on port registration failure
Date: Thu,  4 Jun 2026 12:31:15 +0800
Message-ID: <20260604043115.1409134-1-lgs201920130244@gmail.com>
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

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v2:
  - Updated the subject for net-next.
  - Dropped the Fixes tag.

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

