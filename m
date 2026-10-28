Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793203587;
	b=PKJkFnymT0DwF4n5n67CxN6ibGG/5F5lTs3hlpokJuDpHVIo36cv23D0uvbVnv4aQO9x
	 OB8J+9ECuIpII5c+D3gV3aWYzeDeQTAOm+9L7vf+4icl7AGt9rB5mpIXPVjuZWMOlbzQk
	 QWaYnGjWsIuacXB/aHzb2rKI1FD4Qg61ORWaFtNqF8HrsWJ1Y5v0AhGWc/jUW3nxuRaIO
	 TePdIyxEPA3Ww1cZmeTt+oRq7fgAEvDs1X0kIiWZEzrAwAQ2f7bl9NLtSKlrkg+5PqI7K
	 TMPoeFMZ/Xt7dtAco8IPbr9/ATpbe77CBo+CVkKkm5zaRC64AausgCUzcyyUI/SfUIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793203587;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=3uI0MFbTtASjLF9hlBwhObgSemLAwBt6XCum0+3gyyM=;
	b=gLXXRlcd2a/u7OP0RutsHsbRcz9ZMUI+3zWvkNnQ5xOaLuORRhhAd1+jRWUB/wgXC/r7
	 wlCqJQyYSPSMHzc4RkrYW2w+aS+FQycYxoOcD6GEApvhJ/CqNrgsyX8R0y0oQfoOVI1V6
	 mUVCVBhvWZpKnOYpp457RgqvUjVydIfYNxiATR+WC3FcIjuorrmqls7RmcTAhzgGJddCb
	 /d1eflpMrS7dQ8TjFJfUHVLmmGRImgVSRvtz8Dv56hFr1OCjh9K3697BngqYhzdvmil75
	 kZIAVRbk4caC5q+uDDDwDeSOYhUQOxg9xdVb9VUCBzxxNuqOgnjQJMLwPWOYUjQdwjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=tPvehUgC;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF862606AA79
	for <linux-omap@vger.kernel.org>; Wed, 28 Oct 2026 16:06:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF862606AA79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=tPvehUgC
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a5177d78c7so11187285e9.2
        for <linux-omap@vger.kernel.org>; Wed, 28 Oct 2026 09:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793203585; x=1793808385; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3uI0MFbTtASjLF9hlBwhObgSemLAwBt6XCum0+3gyyM=;
        b=tPvehUgC8iL6Bd9LkWwcRwzfEX8rc7sVMVUk8QFwp2gY4FNrJnoTueh2ceLQfpRH7y
         QoUfBWJh871NMwSy00RcdWY1Wa6P+dB/72P2hXY6bhPXbXBJgWe70vFfiIb0SgH2m2IB
         2kngo1rYQ4ULc+GmwhydYxO77x1Pq8xjCiAgPoxrWymWA7rfPziMYJ1BgRT9kk9a2f1D
         8W8+lRl9KTe2jUZGNUHH/CJ0j4cGSXChMxdiauei/crTabpSqOonVcuPrEFfoLBT5t5y
         WCTSZoGW1LPYezj22PqsptV4ADYnKDu9lMg097wYNBYxCx6qYdhFoyOa+HqLvEl+6/41
         lvcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793203585; x=1793808385;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3uI0MFbTtASjLF9hlBwhObgSemLAwBt6XCum0+3gyyM=;
        b=rn8BVrPHci8EJ4qLlZX9vyg9EU7CnHP6dKiG5IjMIQ7z/bIlt/B4GFtHhtll80acEw
         5vHvE4bu4m8IIUZg0wfSySmVxYkN8wsCVWoYKB8jixx78GZ0yWzt6KTrMF5oXLsMLk8m
         04SlwfQI7QpmBo8MyMzFVSRxOpWdy/Z7JLZr2WmZ+EiUFNdg/2RLsts0mBshuEoNyBWs
         yeODQFnvymaHg+VFffXTav/2v1vIgppKQYCkirlu2RfCKw6V9EFOtZbK5R4vYXjHAoX4
         UQ8dt7GmjYfPcOp8bUVxKdJMa6PJhSDXwgleNtCAIqanwaWwfcHc2S1SVl1im6HdAub0
         p9Aw==
X-Gm-Message-State: AFq9FYI8MeDxvpdJmTLPbaO37SdWREYXXDuITWwMsfet4p5IrsYvzcCp
	XIRero+D0Wd25HufZ/hj8sqmiWEWhCep+5FZI5Y0jk4Q4VfEbGqVCDXY6jnmtNqtMs8=
X-Gm-Gg: AYBFou1vtt5ggbef3LXBcUazuVuJ+FgdXCbicXNRefu38hJqeANS3o+Q6pOQTyjS6TM
	m6R67aTxJpPsf4VfHWjWeM9uN5iQp5WgMYVlNMBQP+N6lnIclZirrzdWLiMnamvU2OhREPcsxhC
	x8w6yCjdUtUn4CCBbuKtmet/87MWUIC4K/uf2jZRxfwCbYj+z3lXtgBlKe9UIzKQAggioNbLmqk
	GtWDUY7FaBVjAL+yaFUAdsQCYUtgRMG/FJoNJ1OtKn6iTDxefx9JwYbQvMSguWq4pdgUzxsYF0c
	XD6tuEId2U2WcSfsL0qIIn3/wUP04mTa12HCHpeNe8sWTSKA+UWOznjbvcNU3Kzf2k0y90ZWE3k
	mfgOekK6h3UlPepSMHLAyIm7kZqGE4sPdLFo7JjRnyjcp4bP0ESVm63gLTTyE7Chn+EIFHZ/loJ
	Ucmdcb8T4XfHuyzeqG/PLKRbM4emB1Z6GZD2Y3UeqISxhluRiyNQhEOB4VBXWMpazwZHRB8m8ah
	xXm8/1rhlF4X1ZNU0+h2LnROFgaLYGRrnmyoVWVTLpyXkp5pUPW3dP7cBzOR+Mb8Hbe7HBDAtOn
	TRMZSlHEwfNGbgjf/IHHQKbpu1bGbLs+wLpHgp2+vW52m2BdVuRCf12kpPWZGw665WT/OcNhTjv
	nv02P02SigK/wsEoLTZCxJbWpZz/Hj6y/jFzmjUS9SK2d69tc
X-Received: by 2002:a05:600c:4e42:b0:4a0:27eb:49b with SMTP id 5b1f17b1804b1-4a9678c276dmr60643465e9.30.1793203585194;
        Wed, 28 Oct 2026 09:06:25 -0700 (PDT)
Received: from z13-ek5.local ([151.40.161.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa81a896ecsm1625875e9.9.2026.10.28.09.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:06:24 -0700 (PDT)
From: Ettore Chimenti <ettore.chimenti@linaro.org>
Date: Wed, 28 Oct 2026 17:06:02 +0100
Subject: [PATCH v2 1/9] ARM: dts: omap: dm816x: Add specific pinctrl config
 defines
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
Message-Id: <20261028-patch-ektor5-dm8168-dts-v2-1-4544429251e2@linaro.org>
References: <20261028-patch-ektor5-dm8168-dts-v2-0-4544429251e2@linaro.org>
In-Reply-To: <20261028-patch-ektor5-dm8168-dts-v2-0-4544429251e2@linaro.org>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Christopher Obbard <chris.obbard@oss.qualcomm.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Paul Walmsley <paul@pwsan.com>, Russell King <linux@armlinux.org.uk>, 
 Rouven Czerwinski <rouven.czerwinski@linaro.org>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Ettore Chimenti <ettore.chimenti@linaro.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793203582; l=1034;
 i=ettore.chimenti@linaro.org; s=20261014; h=from:subject:message-id;
 bh=hmVSe81lrJ4EvLkYlczyhL6zv7IwzxLZV9wv/8nR9Ag=;
 b=LTKHuS4ke5N8E/7u8UBcMaws7grXO2Ccr8ynEVKSNxQOMV5oIM2lSk9PHFNQu6TahHNKaLFkw
 0Gq9UnU3vJnA2IHmEV5Itg5FF1w42ztMv/0Oa5jHnoCCzbkIUYNsqWA
X-Developer-Key: i=ettore.chimenti@linaro.org; a=ed25519;
 pk=wCaUblFVaqhuBTQt/hAtysafsAaEsqj/yOD9SPlz6NM=

Add pinctrl config defines for TI DM816x SoC pinctrl configuration.
Using same definition as OMAP2/3 except pullup/down enable macros, which
are inverted for this SoC.

Signed-off-by: Ettore Chimenti <ettore.chimenti@linaro.org>
---
 arch/arm/boot/dts/ti/omap/dm816x-pinctrl.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/ti/omap/dm816x-pinctrl.h b/arch/arm/boot/dts/ti/omap/dm816x-pinctrl.h
new file mode 100644
index 000000000000..b93f971cbe95
--- /dev/null
+++ b/arch/arm/boot/dts/ti/omap/dm816x-pinctrl.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * This header provides constants specific to DM816X pinctrl defines.
+ */
+
+#ifndef _PINCTRL_DM816X_H
+#define _PINCTRL_DM816X_H
+
+#include <dt-bindings/pinctrl/omap.h>
+
+#undef PULL_UP
+#undef PULL_ENA
+
+/* DM816x mux bit defines */
+#define PULL_ENA		(0 << 3)
+#define PULL_DIS		(1 << 3)
+#define PULL_DN			(0 << 4)
+#define PULL_UP			(1 << 4)
+
+#endif

-- 
2.56.0

