Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F9E4052D8
	for <linux-omap@vger.kernel.org>; Thu, 15 Oct 2026 16:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792083303; cv=none; b=Q3lRiuyv8j7krxODFgG2YzU7JcaLH1bzoJkCTNCPA+K5reyGAyNrzS8xKVhR7d+I4Qf0CDgez3sESy65RViz4okB0QAeaH4aZWOX9WX7gaGbIyUKWqs+hMta4FQYtVfAfDumVCOXPG3FT6Ozt/32DH9px+fJbV2zA0cxx+uDAfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792083303; c=relaxed/simple;
	bh=33w0zdjcE6uxwqU7ll8OOTlJSYoyfRiEeotGi/VFEE8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sjXFdYJO5AnV0fG15xdYuXPqjFnProCAACDAmG9Q+kZNxnRm77uWZxq3eBxIzV8pKXP5WBHOZ6iHG/CFVJSZ6rKi7HEF6PFq97jrMe6E8SvT6m6zKw2RTd/VUo0KaDErbBcGooQ8D+2VCzeKd019GD8cLShLRHE5R6mmd+kPQoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eZlhHBxV; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eZlhHBxV"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48df8fe8513so644234f8f.0
        for <linux-omap@vger.kernel.org>; Thu, 15 Oct 2026 09:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792083284; x=1792688084; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9A4R0ld4xtPUzYOLQ26dMhhwMrPELtsTfbERqTYNE9Y=;
        b=eZlhHBxVOtFw4GowvBv9ja0joMXzFSEXtRo85a0t0z2iHtgwdp8lqaHyh7kaOL+LJr
         PHwgUyUa3vMvr+wsSLcPFzizvHkADBWto97BYtnt4T3HND3O6Z4czD1Asp27KEp1ww5d
         7rzd68vNhRjKwMnC6CaMNfMhgaODdVVdvQ2Er7Jxtb8rTepdQ0ovLzSB2NAidi8Ov+nz
         5QX8KYp+XHUjE5hn151mbsYHf9EpezkumGqze1554et4HJoIgSQxMrozRRfluv74hQ82
         5TieRpBaRmzYUZbLyyRNYocPwk4DmwmHkx5YT8dn5evd4fES1v9NocrL+2ZmQwXmYHqu
         vR5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792083284; x=1792688084;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9A4R0ld4xtPUzYOLQ26dMhhwMrPELtsTfbERqTYNE9Y=;
        b=lfmoMdasHerZglv2g9Lnb9dlNAyv/KMCdRx+6zP3WtbTejgR/2V+ictR6Jpq100e1Z
         qDofyFidRmhx5GVJScZKaLKtyRrK9DVsioxteQ64+xiuYXRPjJiOXIKTA4GIguMxg6gL
         m+BPQaeMGXVD8EoaciXrnOLFlKZ0TQSyOHCVxL/fHVYrRwmWh8gj8vRVSeVeHDJGmNDz
         3vFw8VVxc3YV6Dr8lxkRMTD615tZMflVivjppbhKMtiPFd01Uw8+c9kMmrEKnnckvofT
         NvPvJfiAsVCGnoPIWckS3KfLFQiHhAjo4dCtmCQW3l5lf1MuGbrFmUrRF1cLA+gTD3yT
         AFBg==
X-Gm-Message-State: AFq9FYI69oplLuVJZs83QAi2ZovQNczQ5m+j6c18Iz6E+k/QCM0Y/9hI
	p855B+es3w4peAwqn7ma+JADkdWNrY7fTlLRjxZL+VS2El214xXpOoXHsFfT+o85QL8=
X-Gm-Gg: AYBFou1TtPfJPdEJyFbQ2tQgIbwOCECcN4DslW4/1dD1hWvtPR+WAn7vgqYvtfmBZCY
	Y8s0xd699zMy1otvucZNzn6bLMU9QJKFz3YYgnj2BOPUkaqgw38Uow7KVjfNgBN0LSP2yfR4eMj
	ntcvZUPizzxDf4qLbsPYKiTvCa5jV/FiqyjmpijJVA5tWsGOAsgS7Xtu9EAHt0p7GQE4NWUKvkQ
	Q45iZffNsfNf4a/W/vVMVboQTZtYs0SggujFJjpYeteWhtvxn3dG8Dr92bXuENkvOj34Qp2BOSC
	nuqAe9N75In9o8HCAsQhdDcO9GGSmG7+uOZsc/k2K4R/5FHuO75M4SjzE1aN30IroD4VGaJPujl
	LoaHYK9gODgBqmLR4ytJoNzh5P5KOv1DZ3TuZp9xNB0A/q0NKuAorIswmAKwE/hehrKQCY4YjNA
	CdyNjwo7xqdNTET7q2Qz/3n/jA/aYWs4VPBI3ekKeqQUuC7G525JapPy/nvNIXVolFgS6jUHYLj
	7PISjuzWnz1uxMPNce7lxelsxVygPtlT3Ww7ZiqEmSgmDXnii89Mu3CRrtZYaDIigWFIg==
X-Received: by 2002:a05:6000:4553:b0:488:6bcb:ec92 with SMTP id ffacd0b85a97d-48dbaadcfd8mr27221647f8f.17.1792083283972;
        Thu, 15 Oct 2026 09:54:43 -0700 (PDT)
Received: from z13-ek5.local ([151.41.28.233])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0aaa5dbsm20775664f8f.12.2026.10.15.09.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 09:54:43 -0700 (PDT)
From: Ettore Chimenti <ettore.chimenti@linaro.org>
Subject: [PATCH 0/4] clk: ti: fapll/dm816x: clock tree and calculation
 fixes
Date: Thu, 15 Oct 2026 18:54:29 +0200
Message-Id: <20261015-patch-ektor5-dm8168-clk-v1-0-8b99c5cd5541@linaro.org>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXM3QpAQBCG4VvRHJvaEZJbkQPWYPy3u6Tk3i0On
 /q+9wLLRthCHlxg+BAr6+JBYQC6r5aOURpviFSUkqIYt8rpHnl0q0mwmTNKM9TTiBz/A0pqBf6
 9GW7l/MpF+dvu9cDavTm47wcLSrPcewAAAA==
X-Change-ID: 20261014-patch-ektor5-dm8168-clk-e426101415b0
To: Tero Kristo <kristo@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
 Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Tony Lindgren <tony@atomide.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Rouven Czerwinski <rouven.czerwinski@linaro.org>
Cc: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ettore Chimenti <ettore.chimenti@linaro.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792083282; l=1668;
 i=ettore.chimenti@linaro.org; s=20261014; h=from:subject:message-id;
 bh=33w0zdjcE6uxwqU7ll8OOTlJSYoyfRiEeotGi/VFEE8=;
 b=bZPgsiJnDeGOKFJE78I2bUEqqyxEubxzl/T0MZ6XjjKEJTiC1lK7Vrq88pRK36Y7k1LfrsZ5D
 YZPBhsudElNDZlUVtAOrdi74WMMJewl0pvoCOVCtc0jU7oGv6zfB+2B
X-Developer-Key: i=ettore.chimenti@linaro.org; a=ed25519;
 pk=wCaUblFVaqhuBTQt/hAtysafsAaEsqj/yOD9SPlz6NM=

During TI DM8168-EVM board testing we found that the clock hierarcy and
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
- Fix clock tree hierarchy by not using ti_dt_clk_name helper(), that
  causes the first PLL as the parent of all clocks in DM816x.
- Add sys_ck alias required for DM816x clock lookup, fixing a boot
  error.
- Correct rate calculation logic in fapll driver.
- Add error logging for clocks failing registration to ease debugging.

Fixing clock tree hierarcy is critical as it fixes DM8168-EVM boot
failure in 7.3-rc7. These fixes are affecting DM816x SoCs only.

Signed-off-by: Ettore Chimenti <ettore.chimenti@linaro.org>
---
Andrew Goodbody (1):
      clk: ti: fapll: Fix clock speed calculation

Ettore Chimenti (1):
      clk-816x: add sys_ck clock as sys_clkin_ck alias

Rouven Czerwinski (2):
      clk: ti: fapll: remove ti_dt_clk_name helper
      clk: ti: fapll: print clock name that fails to register

 drivers/clk/ti/clk-816x.c |  1 +
 drivers/clk/ti/fapll.c    | 16 ++++++----------
 2 files changed, 7 insertions(+), 10 deletions(-)
---
base-commit: 0fcb05b72344f40806cbe810de8872f1698bf053
change-id: 20261014-patch-ektor5-dm8168-clk-e426101415b0

Best regards,
--  
Ettore Chimenti <ettore.chimenti@linaro.org>

