Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793787464;
	b=yx5fJI6ikuRvJnNMQbitYIPdrx07og3+f1LaZ6gTvfLmmxmOQc4MwUKz/Mm1WTJebqIY
	 8d9bTmE9y0JBIpgKeS5+jMj9eY73ck4bcgtcAAWQd5IpLqodVURewS2tIoUS3lmss/24M
	 DFbyPqLIbZLWn9cx3ZtyKEB3PYAXky1drIGEZSZlaN1NjLpCvcxG8AP6T2Ql/+pFUTeLX
	 pMqVRHcJxtcezSVjVLQYEN5vaaxRcfe52QWr6+AgWK7uVwsNuGKDVmoZrWUH7Qntj3kwm
	 OqYS0evc+nKiTmwpYt46S7iXBmu8bXFRnWU/v7ZIfjZSpX/LlALKLP4uYaYSUzLF5mQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793787464;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=U9UqJ5usnXoaVC8QtHP+44Z4GZ6155Rmc3hUzLC5hxE=;
	b=Qn8yADE5OYkeYIzgJfTu6aHaTDzUSoBVD3VKpKjt8fTVJC9amzNuhP+DrbCQ1zlghnJa
	 45jtryiut0GiD95lZ2QJG/1ngPeyXFWCwFjMyfKzMpjCEWFeLLU62h0dHa2t51r7qPuch
	 yqkrSJjZ/8a6zmJhi4c6v7bYQlt9V0oViaYoXoP6W+fksemiBqKezBePV7UeV8Wai19uE
	 JKiw10cIY4yhSiqEeEeWprsx5fvfAw5O/B70NkKfxg7qj10DH0uYHCkMT1J0zgta87znX
	 9WBPpzD3OgxFJ4TNyROtLTmk1CrjJaA4lEaSqBMvBJ8JDv1SOVMINo2MzCFRC220sJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amarulasolutions.com;
	spf=pass smtp.mailfrom=amarulasolutions.com;
	dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=jOgHbxoj;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC22B606A31B
	for <linux-omap@vger.kernel.org>; Wed,  4 Nov 2026 10:17:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC22B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=jOgHbxoj
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso4444415e9.3
        for <linux-omap@vger.kernel.org>; Wed, 04 Nov 2026 02:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1793787462; x=1794392262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=U9UqJ5usnXoaVC8QtHP+44Z4GZ6155Rmc3hUzLC5hxE=;
        b=jOgHbxoj2iLWtbcGzwRxSE0ua0Kttx7nbiqAklxyKq9eijtUnRF7k+BwiNn3oEfVLz
         bVuDl8AJURHh7GhBaaCcfSNGtmGpngeZMcLzOd9mXmyACHDxXdY6uuZUDguikbQ4AgdM
         0wsmCxf/PppzCG581cuYvVYtvHSt8MGuAls8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793787462; x=1794392262;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U9UqJ5usnXoaVC8QtHP+44Z4GZ6155Rmc3hUzLC5hxE=;
        b=HsnHPAijTo30e8b8+QT40t9ZsUhdNaWjbtVeWhtiLulRfTirrdJEYsRpFfYh+eYOoX
         3c3Gdm0XDlO+jKIwES2ljn8bCkVrALucyDkT+Va+OqabZnt7mTbu83lUST9SqS06+A0n
         cFRbu21Jxv0dkRW3ovsUFT3o5JNAbHpxqFirq0AxTRL8aVKgAwjvoADWkGTe819GHvtC
         +i3CrDgk9vQUL4OTwfZfIziISktnB7gf1tj5UM2BZ40DZp4BhgMWh5zdoSiGT1qLmC79
         wbu8KGPE9wX+hDG3TxNtOgYh2Yse4dIEyVWdjAahwcvdrQ1FgheoLsjfg1mQHU/QTBdU
         RZUw==
X-Forwarded-Encrypted: i=1; AKwUvBxs/WnLrgy8U9dxBFap/i9PRHWFfI27UukwyoSRyboF2jvurT5jK8kGO1Q1f774sQ/1Z9BnSyuz77+x@vger.kernel.org
X-Gm-Message-State: APuU4Z/58oIYueA6aAnFNBWfxFfsPERhtZA9p7S8hBquu1hbv5kAXbZY
	E+LL4NHZQBy3LTDRt+fH1zV0fwunGhpptaDh9c2wSpmVsQCBobup8Re35E4VZZL/DJ8=
X-Gm-Gg: AYBFou1QTdpNo7Qme/mi1OVO25NPTBDTSefaDPtVIfge8rKG5J96QaJBfoOFZ9yGK8o
	/c5SL/ipBoSGtofrjW0++w2ZjD5UsCfelOD+YjvrICqtQJiQWlBY5qE2Ol3OKVfd2B2XnrwsIJJ
	riguwkD4Hj1LNmP7eOm5HNO8v96nSN/lsdmli3delOhA6gDQrWfC3r3rQGZQf+b8gWdKj61rFVM
	Ol64ibDFJnHPtGnJkbdwae/Ju65CA/OzjUc5B3TG/bFcRkKPtbxeoKAYcuSh+F0E5uCTh7Y4mAH
	ynlmJenW9HOS3SzX2JEVwS3Ved3fOCrz0H/Ix+VOqQrNbUckraseiQgWCdZS3Y8spEJ1nUVkUCO
	2ZtvBeuXgzJkNbqG0AxUCvaqR5QUhUnE2ig3gqfiJ71jpEx91cQzfNL7xj4zo35jdinIvFZHVg9
	2Reonfkgm4ubanX4XksDllJ2vH4J3Zk3mBXnYHWmO/iYUiosDNk7XXaPoKXU7NFjC9jwjcs/F0R
	H1UDXA9aTDUtThGvyyIPytgBvckBHaNMCZwhP946WtP4/EwHYF25oS5LjdVMEI7iCw05WdR+kWK
	HHnawfr2KWK05p2LumsVK4MxFYy4SM9aKSdVdfuRu5JazHodVBhvwLGiCMhWXcHv+lcKkad5tDa
	aDYGFPSkVAPzrNsd2cYa5Oz5BbMBqrYCDwHAg+vMP4w3LPhtulS5n
X-Received: by 2002:a05:600c:34d6:b0:4a2:1364:252a with SMTP id 5b1f17b1804b1-4ac150b2192mr366110145e9.3.1793787462248;
        Wed, 04 Nov 2026 02:17:42 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.amarulasolutions.com ([217.201.213.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48feeb51a9csm3035105f8f.59.2026.11.04.02.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 02:17:41 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: michael@amarulasolutions.com,
	linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Brian Masney <bmasney+clk@redhat.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Tero Kristo <kristo@kernel.org>,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-omap@vger.kernel.org
Subject: [PATCH v4 0/3] clk: ti: dpll: switch spread spectrum to the generic framework
Date: Wed,  4 Nov 2026 11:16:54 +0100
Message-ID: <20261104101732.4043372-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The am33xx/am43xx DPLL spread spectrum clocking (SSC) is configured
through vendor specific DT properties. Since 7.3 the clock framework
provides a generic API and the assigned-clock-sscs DT property for it,
so the series moves the TI DPLL to the generic configuration and
deprecates the vendor specific properties.

The last patch applies the configuration right away, as the clock
core skips set_rate() when the requested rate is already the current
one, e.g. when the bootloader has set it up.

Tested on a BeagleBone Black with equivalent parameters, set through
the deprecated properties, assigned-clock-sscs or both. The dpll_disp_ck
SSC registers are programmed with the same values as before the series.

Changes in v4:
- Add Reviewed-by tag of Krzysztof Kozlowski
- Keep the reverse Christmas tree order for the variables list
- Check the range of the deprecated ti,ssc-deltam property
- Drop the checks already done by the clock framework
- Split the already applied check into the disabled and enabled cases
- Keep the reverse Christmas tree order for the variables list

Changes in v3:
- Deprecate the properties instead of dropping them
- Keep parsing the deprecated vendor specific properties
- Skip reprogramming only if the configuration is already applied
  to the hardware

Changes in v2:
- Check the DPLL lock state instead of its parent, as the reference
  and bypass clocks can be the same clock

Dario Binacchi (3):
  dt-bindings: clock: ti: dpll: deprecate the ti,ssc-* properties
  clk: ti: dpll: use the generic spread spectrum configuration
  clk: ti: dpll: apply the spread spectrum configuration right away

 .../devicetree/bindings/clock/ti/dpll.txt     |  9 +-
 drivers/clk/ti/clock.h                        |  2 +
 drivers/clk/ti/dpll.c                         | 21 +++-
 drivers/clk/ti/dpll3xxx.c                     | 96 +++++++++++++++++--
 include/linux/clk/ti.h                        |  9 +-
 5 files changed, 112 insertions(+), 25 deletions(-)

---
base-commit: 05441d697f7f9a927264f4058cbbc6a03dfcac9d
branch: am33xx-assigned-clock-sscs

-- 
2.43.0

