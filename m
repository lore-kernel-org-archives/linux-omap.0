Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794268101;
	b=t+UYoPdHxyaebipnRBKQg0U9aPngfZs7jj+zjD/RiCEUizxbd+sAf9H9672ZdBxX0WWP
	 z28XCTspUjSHP2IfCnzBQqkxa/bHhvdKIvD5HdGmH6YO/PVilxdjWWGliiYAwDavK6XyZ
	 GNJYAEwzng7vPqGv8h8JQflVHN/ywTIxMgBKt1hdMxIq6Mk4HD5nx8t1AWcVN7vsxlYe3
	 Jnd6flrDExojnstbdF/58B2K3AQaijfgPcv0xCXLnXhj6WfVyq7SXwG8rmhfly+/9NjrT
	 x+wKghxe+WjyszuummTs/lrVIxoakhlr6K0EWOxG3bMi5HZMDlgk/ozdn9vhurGL84w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794268101;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=0kg/HesuQx+H+4XlkLsyd8/tGdp9/7GasWyI0Chc0Bc=;
	b=miRSRkAY6OdEcDU0FM1mzUxXkCu0KKOQweuW8jh8gTr0EC5s82ILmJOvbUrKp6jdnnrf
	 4p5c5Kl5X/Q3l8Gz3Yzv6kj8UvL0cKRUeB6W4OrsLJbVH8adIobNGzCwJt8kvmB2B8edi
	 +di/Iyfz4r//dWnyP2ZnnhLd7yBpVVKRRJOE2ABbXS6XrbHbFzJw2OrTUiZX0ENpiPU3V
	 jESLwIQeupMGYb3E9PFVAOq3yoAdWEXvZavWmV7np0yM28+GY93D2DqtlkbvSyh24+lyO
	 BCnda8v2ry0JMF2hPvewuBo/5CYVy4x3QXwR7e3r8ME/2yzhzWsfcdiw5kTHlkwkzag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=CSHDzbIh;
	arc=none smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF66606A31C
	for <linux-omap@vger.kernel.org>; Mon,  9 Nov 2026 23:48:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1AF66606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=CSHDzbIh
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8b5e5e64494so725106b3a.1
        for <linux-omap@vger.kernel.org>; Mon, 09 Nov 2026 15:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1794268099; x=1794872899; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0kg/HesuQx+H+4XlkLsyd8/tGdp9/7GasWyI0Chc0Bc=;
        b=CSHDzbIhXxfGeqjdbH86qI7hJislmKI/V2LCUpEpyRpUZoBvES5AW/84/K2TT0s/BH
         hpnKKJrjkZxNSJONJ7wulfrFj3piNXUsLE0EMq72hvAX0pk1+NvI9y/qKy7pJjfq3/6U
         ZFs3DqUh62TldCLE7C1jvXuXUwqQ/SR/MicEOaagE8VRnxdzzGTkK8F/GnSycryt8OMY
         q1KTA2BFZ7pLwUWy5by1JBFe2xkvDUreki5UWswHxQufHPyAvEuzyJyKxQns02p52PCb
         59F8rrKQaGe7WOuk9ujru4n8Y2WkDq+he4MRXE6qWcbdlP9lEyqRZpdhSEjkYbs4AZEj
         mM8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794268099; x=1794872899;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0kg/HesuQx+H+4XlkLsyd8/tGdp9/7GasWyI0Chc0Bc=;
        b=jAe/xbfStqIXHqavt+hTa2VmFywbt4jiBOD6NJgUEiDeccAne5tQLMRpHdDf3gJakM
         SMNyrBtqHn2MtbN6jkYSGfGmZv+i6RFc/x9NkkQm4BNa5gfxWYmkgeVQDVqe9RHslXMg
         y4gUg2A/dqwcJiDQ6jy7Ne47pQjQeZkUuxA9rlL7oUz1Ot/PzDtRFSOMxSTbLmZQzcE/
         0BluQ8piyWxKYFL2yZfqh80wt2y32MH/7TvjY6kB76MlgN/Z5qOI2445Csv5+08+nZoS
         Dl8Apb2yNur2n8jIV+iURkTUHpWhuudBdh869c5ZzLtzMOOoIEn17IPJVx1f/bY0a9GA
         MTzw==
X-Gm-Message-State: APuU4Z8mjaBUvEPecDvlX09FHEYAmp9SIKOBA4J4k2snLQmhpAggDOlR
	3OfYgGjCFvcLHhEwFv5nxx7Vhqhn5odD/VGR55vlTD9Crrmf6pmO7GVBgcQ/zqlTnaU=
X-Gm-Gg: AYBFou3aewV4R7qeyKDHTfppxIB9c/6yRxe9MuxZKxsyQeXBhraluoz2R9k/MP3iGs5
	Guc+pD8UDAhCDdx0B9mLtsft5lCq6R/dxczLqSvzcaE+AQ7JwjlpTB/dL5NrAlgeooPYhFLIwM2
	ek9BwASEg7oUWKdHgKWnZQge9TwVbMvzdVWRPLc5r8yNQH685Z1Jsi7otGOEWWYBBlnFr4KnlFH
	aZ3St0R69TwozW0GeYLwrYEalLkpHk74nJr9Ufb6h6tNlKTCyJ6QtKWbS1ju+lnmDi2nEK6/M3X
	neUTEekJGmx1Yv2ZjpDnkbfu7v9yey6+i9Isl/4SxA9HivRfcr7qnqHTFUOoYOf0FgD28fM4v/M
	9nWzwe6cyXBkOeoDevU/V99RqrIzDH1srCNAchbGvnKamYdoPdF5HSnjUEmlS+rHUm0LLKMAfla
	chpLHnIa5ZKoWXuIJ3lZF3sYbdu0hJt1RbIdPtLvSNlSGx7g8AG/yyd7DkJyx8z1xXwP/I/afGk
	roVlBqLbc5NG9MGmuiPCpQaEKZfMCLkWCjY2AccfQuhuHMhf4UzlG6MK6/F7+zKFH36eV9FWekE
	LquayHR4BuifHqY0WMEw6yKiT4QSpkcTSWlP06oyTvBb0w==
X-Received: by 2002:a05:6a20:8f29:b0:3e2:afda:c37d with SMTP id adf61e73a8af0-3f18f98b947mr664988637.60.1794268099444;
        Mon, 09 Nov 2026 15:48:19 -0800 (PST)
Received: from localhost ([97.126.173.69])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-cdd8d695905sm200663a12.11.2026.11.09.15.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 15:48:18 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Roger Quadros <rogerq@kernel.org>, 
 Tony Lindgren <tony@atomide.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Robert Nelson <robertcnelson@gmail.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jason Kridner <jkridner@beagleboard.org>, 
 Deepak Khatri <lorforlinux@beagleboard.org>, 
 Ayush Singh <ayush@beagleboard.org>
In-Reply-To: <20260901-v7-3-rc1-beaglebone-black-revd-v1-0-f521950b777a@gmail.com>
References: <20260901-v7-3-rc1-beaglebone-black-revd-v1-0-f521950b777a@gmail.com>
Subject: Re: [PATCH 0/3] Add support for BeagleBone Black RevD
Message-Id: <179426809791.2265990.16577191585004964317.b4-ty@b4>
Date: Mon, 09 Nov 2026 15:48:17 -0800
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
X-Mailer: b4 0.16.0


On Tue, 01 Sep 2026 16:42:20 -0500, Robert Nelson wrote:
> The BeagleBoard.org BeagleBone Black RevD and Industrial (00D0/EID0) are
> redesigns of the BeagleBone Black Rev C3. They feature an IT66122 HDMI
> PHY to replace the EOL NXP TDA19988.

Applied, thanks!

[1/3] dt-bindings: omap: Add BeagleBone Black RevD
      commit: 4020138a2339cbb0cb6fbfc6ab08fe693ac5231b
[2/3] arm: dts: omap: Add support for BeagleBone Black RevD
      commit: badbca2876de684230329b49c30c7087cc88c10f
[3/3] arm: dts: ti: Enable overlays for BeagleBone Black RevD
      commit: e0685c2acb7fb85586490791b3e28497884fdb7f

Best regards,
-- 
Kevin Hilman (TI) <khilman@baylibre.com>

