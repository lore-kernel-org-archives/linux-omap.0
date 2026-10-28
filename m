Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.128
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793202852;
	b=o79cawELgQVRa5Dmrcj77KWctQi+M0HdccgnCmTuaEWSrwG7M0p0KOGKut4vR5bAnAyl
	 x7HYDp7+gwL5rhBk6Rw7IJW9Xe45xh7X36L9C71vJ+1NVB/yYGx6zKgf0XkW139ij1GLf
	 3FAS6teLEJS8ye2pxii+Sq/3ia0k5DAqzzaza0xlFVvDWANYxTrFC/gtlyj1d8Dry7lr1
	 8O8dg3mP96B2LAXVhKDu3sf49AontrD08FICKhI/LSlY382SPM6C9BMyemgSgFGfLL6RE
	 myNYFYOk7c1PTjIxKBEXwPVvRvkiL9+6XB303odPKhy67vD/MIEFmxzaHSiLHu6yQRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793202852;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=s1UyKyctrlPlJ2gbkchgyeCfLNA2hMysZa7PZpT0zm8=;
	b=nqzQMlT5fGsOn0aGaQWQLOBC3AVHxNt0THAnAtfKSfNYQuIm/Nc/A46wHk5gfPfaquv1
	 5yJjfgnU0aytJUzsRrFD7bImz+Dmw64d3ZgvxKmGaCYH9F7f8TowI4QkRkj9nJxNs9/tp
	 a/EHyO8Mh7aqCYW5tXdtM/twDlFl+1rurP/FdvMWpxq/ELtUmEMADW2ef60prNyxSWpY+
	 azJV5nze5IDMPH6SkDY7NVfj0u7sOhLiN28gpC7cyzeYSiRhwFZAgWccYed5pD+9TiQw0
	 yFjDedxxqLMOFuB86URXwtL+Log9zLfSSJbJ3uQKgson7Ovj87evzgRlsxuHYlMq4AQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=vm8wI5Lb;
	arc=none smtp.remote-ip=74.125.225.128
Received: from mail-wm2-f0.google.com (mail-wm2-f0.google.com [74.125.225.128])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0596606A31C
	for <linux-omap@vger.kernel.org>; Wed, 28 Oct 2026 15:54:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0596606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=vm8wI5Lb
Received: by mail-wm2-f0.google.com with SMTP id 5b1f17b1804b1-4a2d6cf8c98so3089525e9.1
        for <linux-omap@vger.kernel.org>; Wed, 28 Oct 2026 08:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793202850; x=1793807650; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=s1UyKyctrlPlJ2gbkchgyeCfLNA2hMysZa7PZpT0zm8=;
        b=vm8wI5LbRDQYrEmYEj78r7uuoHOAYlXHXa5xzTBZ3im9tToxrObib1JOjJQ67HJOBQ
         dYCw7aEZKFALq9GOSMCLov+cRCkIM4LE1g+koO2QqnwLp49ZCXvCowHJgw6oeXExJQ2/
         4d8iGz6ojhtHwR6Qm3a7LuLYnZwVef2ntvN922WIqIs1D6Ld00WjQHsjabL603/TQ2Zh
         +Mi2P8ssc2EsPNDtCtCNnisgmdPIEtcwKx6Y+j6MEe4dP6yQbDXQFksFSFt246HLj4/E
         5+SVmLUj6XbMsS1z9mYpDNZDW+PN+4yWdFIYBdL4q9BYOZdCQu/e4zoIqFhBn7JIYLzK
         pecw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793202850; x=1793807650;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=s1UyKyctrlPlJ2gbkchgyeCfLNA2hMysZa7PZpT0zm8=;
        b=YBYtTh77ydhjdDSlJK1oPmO0umUqj+G4atPkaxbmzMSWG0JMYrZpEnk6A7OQiDjaCn
         opA2R5/ANIK+24hzZKtroNyRRcLhZJ77vBoxeqMi4qxL1U2lW3VMaMJ8/rpCY6wVuP3+
         dGM1NVoT9VcGHesRTwR9a3UZWAJ9ZBHWTuHrbfxeX/YiZrvfMoXYKqj3ZL2CpY7o2g8p
         6KPnsoCHsHstOE73aW+t/6e0TKGwzVCUaChO60RbS5NApLikKpnR16k6/p8e2Xx7ZBic
         kmcvsFO+03n7477Q6pb7kx4BJPiAhnUB+Vx8q1HVLWQIc5JR5WB9Xoo66IvbayoDcTYb
         vAxQ==
X-Gm-Message-State: AFq9FYJ5idUYhZKxGGi6sAx62xw34f6l2D3V/OBJJLsCSD1RuSnL4xbp
	qcbi9C2eEVvarlvorNkSC8rN9rkP82suvgAbx5iKFO5CfoC7Ml5QB0GRTnBiS5gIr5c=
X-Gm-Gg: AYBFou1HX30BiHh7EF7JG5yN1u/K/DtxeRdgKYVacU/5Nu6LmXC+mIDD1hx29AjT7k1
	Wh7DifLmv4rNRYHmoAzcLGOGvXVf5yYy2ePHSMeVGufEWEiLXqCCVFlGGjPLkwa6GaHvflJkC+i
	zwUrDzQxaBkcg9tclTH+WrK+CHxRQ55Rqmiri9G6g6QibAUtu7MqlzT3Ax2FQodI8p9ATn7hNEV
	/6NRRbkGhRHjdjRAEu49pxt1TQRvR3NwvA3L0kHcRGEVus7NphOVptt2f3h9aRMC+D8RlbXM/DW
	ZGnVuiv/XtPsgSU7rVVei0QCWX31rwzJLYN42G4Bfk8mCq9g0SlHpM4TfbFZjVYmq1SHHIJkFt+
	8RpHbuk6HZge+8u1RBLvho6NBWfwxFhsSx2kqaWpdYdS0TGxpzxZSu6rAnwF75QGxSFt/Y3WhFJ
	2m5SoU28MFPPWEXNC7rNP8hr1IC8iz9IhcCkTzEtZGBreNhyIWbFndAa4ZU6E7T4sa6tf3SFAY4
	i7FFBGfisdW78Xb2YV6g4jVbQCfGc68gjJZkbs5fJvHC+j0qFVZINT4h0iDzzyWrDvKquywIFiG
	mnr6gFzU2H4djFo/T9RETZP6WuPr+vUJTF3wasFg+mcC1aGpgzhS53EfMxPUR+Zf4/7Nzlx97ck
	7PYDKJa5VcLaYP0bQH7iRwfu85A==
X-Received: by 2002:a05:600c:810c:b0:4a2:150f:1613 with SMTP id 5b1f17b1804b1-4a9660b4fcbmr57282255e9.7.1793202850166;
        Wed, 28 Oct 2026 08:54:10 -0700 (PDT)
Received: from z13-ek5.local ([151.40.161.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa7f3229dbsm1468515e9.1.2026.10.28.08.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 08:54:09 -0700 (PDT)
From: Ettore Chimenti <ettore.chimenti@linaro.org>
Subject: [PATCH v2 0/4] clk: ti: fapll/dm816x: clock tree and calculation
 fixes
Date: Wed, 28 Oct 2026 16:53:48 +0100
Message-Id: <20261028-patch-ektor5-dm8168-clk-v2-0-dc6bf0fabae4@linaro.org>
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNQQ6CMBBFr0Jm7ZgOoQRceQ/DAsoII0hJi0RDu
 LsF4tLlS95/fwHPTtjDJVrA8Sxe7BAgPkVg2nJoGKUODLGKU1KU4FhOpkXuJus01s+M0gxN3yE
 nh0C6UhDWo+O7vPfyrTjYv6oHm2nLbUYrPkQ++/VMm/d70X9fZkKFWZXnRpta64SuvQyls2frG
 ijWdf0Ckyt7RtEAAAA=
X-Change-ID: 20261014-patch-ektor5-dm8168-clk-e426101415b0
To: Tero Kristo <kristo@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
 Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Tony Lindgren <tony@atomide.com>, 
 Michael Turquette <mturquette@linaro.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Rouven Czerwinski <rouven.czerwinski@linaro.org>
Cc: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ettore Chimenti <ettore.chimenti@linaro.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793202849; l=1986;
 i=ettore.chimenti@linaro.org; s=20261014; h=from:subject:message-id;
 bh=yKm8jdJ4eG09cLn4qLiQzmeN4+VpA6d2SRVgK0o0Pa8=;
 b=Dl1ClXIoZyogzSsxG3KH455rWygbMMmT04YoMPUCSMBnFY1rfcDnqhFcu7LmfqiKcD9HlwqU1
 pNy/qQ0jp/HCOZXLspdK9GcqGaVHcZEzUBrIP70TxYkZE2qGxsqUua7
X-Developer-Key: i=ettore.chimenti@linaro.org; a=ed25519;
 pk=wCaUblFVaqhuBTQt/hAtysafsAaEsqj/yOD9SPlz6NM=

During TI DM8168-EVM board testing we found that the clock hierarchy and
clock calculation was broken already on 6.12:

    main_pll_clk1       <--- main PLL should be parent of other PLLs.
       sysclk1_ck                   
       main_pll_clk7            
		...
       main_pll_clk6            
		...
       main_pll_clk5            
		...
       main_pll_clk4            
		...

This series brings fixes and additions for TI DM816x / FAPLL clock tree
and frequency calculation.

Summary:
- Fix clock tree hierarchy by not using ti_dt_clk_name() helper, that
  causes the first PLL as the parent of all clocks in DM816x.
- Correct rate calculation logic in fapll driver (1/2^24, was 1/10^7).
- Add sys_ck alias required for DM816x clock lookup, fixing a boot
  error.
- Add error logging for clocks failing registration to ease debugging.

Fixing clock tree hierarchy is critical as it fixes DM8168-EVM boot
failure in 7.3-rc7. These fixes are affecting DM816x SoCs only.

Signed-off-by: Ettore Chimenti <ettore.chimenti@linaro.org>
---
Changes in v2:
- Fixed off-by-one error in clock calculation (Sashiko).
- Fixed clock calculation also in the set rate path.
- Added Fixes tag to clock calculation fix patch.
- Link to v1: https://patch.msgid.link/20261015-patch-ektor5-dm8168-clk-v1-0-8b99c5cd5541@linaro.org

---
Andrew Goodbody (1):
      clk: ti: fapll: Fix clock speed calculation

Ettore Chimenti (1):
      clk-816x: add sys_ck clock as sys_clkin_ck alias

Rouven Czerwinski (2):
      clk: ti: fapll: remove ti_dt_clk_name helper
      clk: ti: fapll: print clock name that fails to register

 drivers/clk/ti/clk-816x.c |  1 +
 drivers/clk/ti/fapll.c    | 22 +++++++++-------------
 2 files changed, 10 insertions(+), 13 deletions(-)
---
base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e
change-id: 20261014-patch-ektor5-dm8168-clk-e426101415b0

Best regards,
--  
Ettore Chimenti <ettore.chimenti@linaro.org>

