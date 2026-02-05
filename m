Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C1170818
	for <linux-omap@vger.kernel.org>; Thu,  5 Feb 2026 02:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770259655; cv=none; b=jMZrAkts44O1dyiU/RYnYTmFkMcJyqXhUIB1fEIvXcD5n51ehWQUJgfgLQ+zFEQQhudflVR1cOmig+2wGKxEwvGaKPhBs7N6I8TNGTVMn1wV2HrRsffXRzjUME7X/A5oVSrGapN/kyO3RiDQzNQB/pOdHIJEEQoSqzhxBebw+m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770259655; c=relaxed/simple;
	bh=LM4w3ayI+D3t0rJOATqyc1N6jV2xUEBJsXzJpchcBWw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U5vM4VGyaLHjw3hbeCtAaLwsJYCF1verovB2vOEbdzzVz8myUBanhnHFNdlM/gilMJJlb5HURQuPVH/yp9T+hFJI2+SY+0m6uuS1/E/eqafMicysmwO9g6fDTvOjqpg+Ne586KUPAY/Syhnh6m/gQp9pQqraVvuEgheR6q+hSOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hKsBstF/; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKsBstF/"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8946a794e4fso5412766d6.2
        for <linux-omap@vger.kernel.org>; Wed, 04 Feb 2026 18:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770259654; x=1770864454; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jkp+zpklLnwgbsWysYnnsbXefJfZs3Z+JpdRtUJO3sk=;
        b=hKsBstF/L8BXDDz7BXf5XGoxAdWlfYDHFefekPj+avmMF9Qt/rTjbw1fU4jDXNESrm
         4H3YsMVQBLrlDiwORpkyGyL4s8lsr6ff6Su0330f4RXpjtsDzlqHf+PhB8Npc8+Ui+zd
         2N9wbWwuLZb9hdeq79uIpbCmvLJiPo6SJfKNlfyZ+1bUPTBo34D2Igjc7IU9McUSHSH9
         PJ2iopPgaEhRazL7ieS4Ia8KZ905NPZrLuSpUBzDag1VSQ9jstl3bN3EGbNTH9B8MLmL
         CD1HOa/yzvxBUQqZHlH4k9x0vx/6arIPTWNkGtmnqKw878Wc9pee46cT3EI3c5d4759w
         XiDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770259654; x=1770864454;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Jkp+zpklLnwgbsWysYnnsbXefJfZs3Z+JpdRtUJO3sk=;
        b=ivDC8i3EWYeFFbChs6pu8QkEaOHVP1I1+aHyD6gyJgZUADku7nVzUiBtR3wKpZ/eCI
         SDiLB7OCv6V4Cw6m7f3Eq8AulvoVJft9Y6kq8M6bSVzWP7vt+sspivyETRo7btf1V8Hz
         KrlRmIvbyb10z4qavP5jAjH+HNshDJaDAsHcqflZBB0BthXXtjV4lsdrZXeiGjXnHmtM
         +THtfTvIe9XMIrTnkuoFiUX7eX5yo/xOPImjt3k8m7KBIkwrD5u4V2cQ41pJ+PQcvyTw
         ho2g3wMajGIQuw2SKmmJ55hj6KYg36Ef2uoVDew6cKrWnXAN2bwb4QN+mIKbhDKyDft4
         pmQA==
X-Forwarded-Encrypted: i=1; AJvYcCU14LV7YFSdjC5cWj593HPG5mmXilaPMDGVY7y+FIG8fV4GtbY2SmVPEuo2E99Aed9Wjab9nPLvAWwq@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh2EACmROKvNtXYOWe0J3xB0xyXCQBDFSGgmVbWr5j4EaqcsrZ
	YjiLgm0GU4FUWpf5C7nefxJtqT7VgNXfnVCMyM/Z7GPwnvy7KWFNx0PY
X-Gm-Gg: AZuq6aLzey8MMnvi/aeJZu5X7WhZ9CZMzbPJS/ukFQ1QCS5mDKL14gMI6VEVMqzotao
	6M8eSgXg/jXcmzq6Mam7xMoe3wz0hzwNCT/YhzsDbVovkbT5aO83Xa34H/XyRKT3lSPZz9T9ZKa
	okrxMzxR63anZZAvfpng8RVWjVKfHMQOLGsr80ULtj434UzbdoBDvDbxh+2p4tciPeQqsbNwi8g
	tjzjfYSoyMg8jrq1D0Fq8WqAT0gGesj33t9MbFytTpAtB4G+kgu2jv5Xxqhrvm1VUpVm7w28v1c
	H+ud5OuExmdkTddkNAjZbun5Wo6G5ck1i9/urNhO6H9BKnHx+LYfC6ypKQdRcPyhsBk+QvnTJ/r
	jNoGPaCeBX/UOhOywFVwYNsTcHbERj0491uiFev5pzfr7rOaK8vvivs07OlmTVQmK9UEfHcELLX
	yTMjinLi0a3KiewGnNKkZl
X-Received: by 2002:ad4:596f:0:b0:894:70f6:1694 with SMTP id 6a1803df08f44-895220fe1d7mr68191666d6.11.1770259654001;
        Wed, 04 Feb 2026 18:47:34 -0800 (PST)
Received: from localhost.localdomain ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ca2fd2b5e3sm308193085a.25.2026.02.04.18.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 18:47:33 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
Date: Thu, 05 Feb 2026 10:47:03 +0800
Subject: [PATCH net 2/2] net: cpsw_new: Fix potential unregister of netdev
 that has not been registered yet
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-cpsw-error-path-v1-2-6e58bae6b299@gmail.com>
References: <20260205-cpsw-error-path-v1-0-6e58bae6b299@gmail.com>
In-Reply-To: <20260205-cpsw-error-path-v1-0-6e58bae6b299@gmail.com>
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

If an error occurs during register_netdev() for the first MAC in
cpsw_register_ports(), even though cpsw->slaves[0].ndev is set to NULL,
cpsw->slaves[1].ndev would remain unchanged. This could later cause
cpsw_unregister_ports() to attempt unregistering the second MAC.
To address this, add a check for ndev->reg_state before calling
unregister_netdev(). With this change, setting cpsw->slaves[i].ndev
to NULL becomes unnecessary and can be removed accordingly.

Fixes: ed3525eda4c4 ("net: ethernet: ti: introduce cpsw switchdev based driver part 1 - dual-emac")
Signed-off-by: Kevin Hao <haokexin@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/net/ethernet/ti/cpsw_new.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw_new.c b/drivers/net/ethernet/ti/cpsw_new.c
index b9fc31eb06134dae33427eaba06341c39eb4b41c..7f42f58a4b031fab4c93680c153383e8eeb8f7f8 100644
--- a/drivers/net/ethernet/ti/cpsw_new.c
+++ b/drivers/net/ethernet/ti/cpsw_new.c
@@ -1472,7 +1472,7 @@ static void cpsw_unregister_ports(struct cpsw_common *cpsw)
 
 	for (i = 0; i < cpsw->data.slaves; i++) {
 		ndev = cpsw->slaves[i].ndev;
-		if (!ndev)
+		if (!ndev || ndev->reg_state != NETREG_REGISTERED)
 			continue;
 
 		priv = netdev_priv(ndev);
@@ -1494,7 +1494,6 @@ static int cpsw_register_ports(struct cpsw_common *cpsw)
 		if (ret) {
 			dev_err(cpsw->dev,
 				"cpsw: err registering net device%d\n", i);
-			cpsw->slaves[i].ndev = NULL;
 			break;
 		}
 	}

-- 
2.52.0

