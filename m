Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794605476;
	b=FVDtOy3TWxKh8eMd+YIzw09d+coYiR01WZMY/50l1QzLQ9FWxLskXzppTL1sZMT7I7X8
	 Ffvjx4+3gLEEPw9GAGR4IxCbKFkAoKpHTMi4nEmlqhyd0W0J/HpvA3Dfo8B6FJApFV8EP
	 JeukigFnW1PAJM+dqwvsqF/5IH2J0aqh6cLLq5rcqUYbG4QwirVLQBDnOgVFqkaxGiY3a
	 LHw/u33JRf5B3uvrQhUAtbonMUCy62T4Gk68XuuNEMrPY30S6WEkk8clQrVfkbM+U0YQ3
	 scFfnfBino3EksHODi29cw4y6nZsFv2HpcYwnCRYlwZtkcjNGKyRSZmeRqV11dBMMnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794605476;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=jcVvNA1LksN88nh/Er3FQFE79HxWvLX+M8oefDd7Y4U=;
	b=EFH0vEnEzNgT69G5Fs9krjIieTGaOo/egnHQ5gkwLG88j4D0EmUFD5buis7uVWEgVMBG
	 +l3PZFIGcUvM4SVEVmHIb8sAgZ+bLHZn6AEzm1xKkwyGl4f5HI6k1LcWGCTrKCYzDkTkS
	 tEEQljjpZyf87bGt2BcK3qnVvy72PqSssyuCnEugrHS8umWQkV0pII67OiA2677Krge30
	 9XwBi2HD8v76JATrkYm3bo76jLZQ6tnE+F0QZZCdx5GijoiOWcEUcAevxmTBsn/OaLLHm
	 Gza8ariSOD5akQG940kjlnUJD1JE7GDUPco3PfALB5CcdcNrj/3nAjvf0cA3RTDV8vA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b="CPx8/6vJ";
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95038606A337
	for <linux-omap@vger.kernel.org>; Fri, 13 Nov 2026 21:31:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95038606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=CPx8/6vJ
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-490c3ae81d3so691365f8f.2
        for <linux-omap@vger.kernel.org>; Fri, 13 Nov 2026 13:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794605474; x=1795210274; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jcVvNA1LksN88nh/Er3FQFE79HxWvLX+M8oefDd7Y4U=;
        b=CPx8/6vJoAXqRB91bmXoRqhowyKjq3PrBoeeN/TxCMY3qZ9y9aacgjWaDu0oMC7Ich
         2kxH7niecbiyXurohkjI/BbKtNPrFzaVMd/PAVnrWnA7ePIbBgdLYTs2ZnZUXbFq+Zrg
         iqbnv8AXHw6A9BqU2/zamEsv6ziBnMyEqteOAOqQfg0/GGpUZDr9V1sNyY4CYJmFQxN/
         jnkzsWKhObxXithy5hrnWemgUpVHIGVB3VvX6jqyTE5NB9VbiTocf6IqDmTxIKcD65V3
         Zx8kFrIYofgxIsNCgxkqpACznD75hXnS9rqgjZ7GqUTaN0OVgCc/CgPPJ3naH1jxwdgY
         Rfzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794605474; x=1795210274;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jcVvNA1LksN88nh/Er3FQFE79HxWvLX+M8oefDd7Y4U=;
        b=1ceMdUI+Rk2E+4MPq7/54tkbUWYxkh9tfyGSe0jHdEvfrvu9/PTxMIQ+c49FkKGARC
         yOP3XhXUYU0r1xa/t5JyoxdNuzcWjksm6K4sH8li4Tp8gX/fHf2gsAixiHjD0jFwoFBl
         0YBpBTwoRH985UwyGL3EYbLxc/siZ2pAQzmF0csnwgtOYeahmS3uxGb0HWkqP/rLXJdj
         9mlQyqQwoGht8hFuc0yYD9g+LEBp1WTilhXA62iV2bgGSwHO4xECF5nQZtU7vrVqvV39
         XUe1hv8nj+JxLpsHNEtUXinC3V+j3CFZy55PnG6r2u3flz47ow0lrWbYUMS7fmhpXdvQ
         Zq7A==
X-Gm-Message-State: APuU4Z82FWJF2iqbGkWyRktp5shuNqQnGATp/pZIbiaVe1t6OUsNFPeq
	UkGC5Ut5pgvfp3GGFQioWg2KksHYR+AlYra/9QaNbNAfhAIub7FIQFjQANZRfc8UFwk=
X-Gm-Gg: AYBFou38Lr6roiePfLnfgG23ubCtfr9e/grlVyI54xiMRKQ+GHg7lKbEX2fchInCTuv
	otuxyPAHUODF5Mkjm+nVZ7oRvMYPv4aMtx/vAlhuu9vWDTFDyXjH/LjjQcKp6Cu0hMgw5BH523N
	Iyze61BfAOeeaMfGjMPv33mOdnrxUbdczaQmc/OhWM5uONE08nt1w5LRZV2vHUk9MoSiMrKCf9a
	j/QWE9CpoBoLc8KuNjZ//u7/OaBCHrJ7ESgPMDZwO7jTrYFrxGQKEVUDAPDLy/gOJS9r3WK90gg
	tocPyGW6byKdwUw9dMvLfjVqb7VGBDnsDlBtT55f1EhFjGNWIM6nN2K18d17OLgsvHDmUSH0R4n
	VpKKllb9U7IXzu7ZFTqxs0L7zyHlbDxs7/L0Kxl62viNnHFOvcBPVJZD6JugZgnHbN8HmOIztWh
	5d3Y/VcUQpwKCr6dm5qDvdggNmD3Qwf+GF4uYu+NvPX4O9sIFdwnv1vTedFvaZj4HxiptCGwV2n
	CVFz6yKq1cQ98ym+DBOWEgJjWzpGYJTn4U+NvUyLz36kIg8ZMVcspkK6NDc13iLxMwiaHbcriZk
	qqap1y5+E9DH7YeunPQ/TqtQpRE1AZGcCP0aU1k9EcO4XwXbSJE5MNgmWf9IQX64Rrxz+mvHH57
	KdVbnJqn0p83gW1uRoTVBF75ZlbyGJeJ85WY2rTRVzXUCncg=
X-Received: by 2002:a05:6000:25e4:b0:488:823d:5086 with SMTP id ffacd0b85a97d-49c6b788c35mr8390429f8f.0.1794605473829;
        Fri, 13 Nov 2026 13:31:13 -0800 (PST)
Received: from z13-ek5.local ([151.40.161.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c609c8a77sm7447727f8f.49.2026.11.13.13.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 13:31:13 -0800 (PST)
From: Ettore Chimenti <ettore.chimenti@linaro.org>
Subject: [PATCH v3 0/4] clk: ti: fapll/dm816x: clock tree and calculation
 fixes
Date: Fri, 13 Nov 2026 22:30:46 +0100
Message-Id: <20261113-patch-ektor5-dm8168-clk-v3-0-a42cd1edc5f3@linaro.org>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNQQ6CMBQFr0K69pu2UlJceQ/joi0fqCCQFomGc
 HdbiIkuWL5k3sxMPDqLnpyTmTicrLd9F8bpkBBTq65CsEXYhFOeMcpSGNRoasBm7J2A4iFZJsG
 0DWC6AUxoSsJ7cFja12q+3rbtn/qOZoy6SNTWB8l7TU8sct+K2K1MDChInedGmEKIlF1a2ynXH
 3tXkZiZ+I+Iy30RD6LCZLqkpdIK0z/Rsiwfr7YkUxoBAAA=
X-Change-ID: 20261014-patch-ektor5-dm8168-clk-e426101415b0
To: Tero Kristo <kristo@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
 Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Tony Lindgren <tony@atomide.com>, 
 Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Rouven Czerwinski <rouven.czerwinski@linaro.org>
Cc: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Ettore Chimenti <ettore.chimenti@linaro.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794605472; l=2296;
 i=ettore.chimenti@linaro.org; s=20261014; h=from:subject:message-id;
 bh=eEMKCkSJZRXgEvsvPPTkLeYwfdGBsD85wJfM19/qpMw=;
 b=nYfXjSOrK0IvytX8ZmDY54G1+AthZRvB7qQoAfcIeKA6shrkMCKVrsoLXk6sJvHuDsGSbWnuA
 SrgM+duc8H+BWEYcmNr5U5KDYo7RPbkYIZhaSvQ7Anm/5NtMzNB03ka
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
Changes in v3:
- Picked up Brian's review suggestions to extend commit message.
- Added constant macros in speed calculations, removing "magic numbers".
- Link to v2: https://patch.msgid.link/20261028-patch-ektor5-dm8168-clk-v2-0-dc6bf0fabae4@linaro.org

Changes in v2:
- Fixed off-by-one error in clock calculation (Sashiko).
- Fixed clock calculation also in the set rate path.
- Added Fixes tag to clock calculation fix patch.
- Link to v1: https://patch.msgid.link/20261015-patch-ektor5-dm8168-clk-v1-0-8b99c5cd5541@linaro.org

---
Andrew Goodbody (1):
      clk: ti: fapll: Fix clock speed calculation

Ettore Chimenti (1):
      ARM: OMAP2+: ti81xx: use non-scalable voltage domains

Rouven Czerwinski (2):
      clk: ti: fapll: remove ti_dt_clk_name helper
      clk: ti: fapll: print clock name that fails to register

 arch/arm/mach-omap2/voltagedomains3xxx_data.c |  2 +-
 drivers/clk/ti/fapll.c                        | 26 +++++++++++++-------------
 2 files changed, 14 insertions(+), 14 deletions(-)
---
base-commit: 2800868f63227c8237d70c41e70d441c919620d6
change-id: 20261014-patch-ektor5-dm8168-clk-e426101415b0

Best regards,
--  
Ettore Chimenti <ettore.chimenti@linaro.org>

