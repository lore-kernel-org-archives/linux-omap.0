Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793649212;
	b=SSCqGuNOAFgPie/0v6omSeEERLCKGUV5dcGrrcsGV8Z4Rq/90IVyKWf9inlC2s28KII1
	 fXQjus3FlxHqcwsPC/upxKjBQZyEIzI9OMnFKcniLyjJ0zzGZENLPTgaU4Cypqax46Dpb
	 TwHJZB9X/uiCtbBoIAcBVIxJUS6s8gLK6/eucg3cBvUWg5QRXoJGeHIR1XE+iaUj0VS3I
	 eWMF6/uU1bQ/+bcGVqSEbI3t/sPxJtNbvcaSHycpTbIX36uz9Sj3iQt9o7Ys1vEPLlnRr
	 hV+AUaEVM/PegPwrLBftl0c3ovtTk+IxFoCisg4Hp1W+0I/E0BfLywy5UhkygMYCqeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793649212;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=7d0shAOVJ1K7372dJ2kGybXJI56xuJHqHu/gSqF4j54=;
	b=bKVh0iauqNzc8rnZt3/u5cwNIONY8OXKZ/R8+wt2aRUsdVBnSjSquT1/ozlYsP6TYJvR
	 4zVUkP/5kXsAj7JpuJigh0IyzaWqlvHmTdrPtRDqs73hUGZhZo2RGXO1HX+l9b+7K7JL4
	 k1jJKHQ9LC7goRT1ayzfSBbLKm3rbnzy5YKZF0Eelxg4hHy7LinJ2BwFsEd30JO202/lx
	 WYqKZhoBDNoGRTH4SLnY0v2xWbRfLgw7Q/i2ycwb9YeJXhb521zx6iYOixcqzigeTUfbe
	 WiawtSwfzLjA09FHppqaK/CdfmeerQ51xnBfUqMpJfY5M0uuTjGys4PnXA+QfbpNihw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=tm6dYXLV;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7258606A32C
	for <linux-omap@vger.kernel.org>; Mon,  2 Nov 2026 19:53:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7258606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=tm6dYXLV
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a20a37703bso27057045e9.1
        for <linux-omap@vger.kernel.org>; Mon, 02 Nov 2026 11:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793649210; x=1794254010; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7d0shAOVJ1K7372dJ2kGybXJI56xuJHqHu/gSqF4j54=;
        b=tm6dYXLVklLHH8myqEweMrC1yiCYroQQ5l03wfAaG02x7dzD+jtd/XZapAvC2BFtJ8
         oQKoFx3G19wa62a2RwsVi5jsWyr2Jax+qIMfK6L+04bPtIu0oKzFgd9KMOwp8ZRo3FE8
         i+Zul6/QX0RHTvIICVFfbfR/HfGUCOtvdob7QRvRHgeCpQIJRvAx5gUM575WHu0WnrGk
         3OoYDXH2pt1Nt8E7Cvw6kfiV/WJ2QYrVMzXg51b/M9F7HpYu1Hoi3mKwC80R/YJdsWaj
         wqaE8oznYOjf/ZdPiSdYcuuY7y2cRq/i6ZVG06to2hDjrENA3bGCDmWIv80/nLEZqlI8
         3jEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793649210; x=1794254010;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7d0shAOVJ1K7372dJ2kGybXJI56xuJHqHu/gSqF4j54=;
        b=AxHHdcmZdBbh1ve4XpJolzyvi2Fk6P+5K4rv6u3HPRmwVLJvtKJC/t8FhBKA5qDRXP
         1k2msxWGS6V4I/NkiTBDz/eePHH6ERALPznaWcDQjnAEysdK9AKgpRehL0uCo/SXVdF5
         jRGQ1AhZCX0OA4pzH0v6bohMtJJrj3TC13aZNYzJdl5Ae8dTJwMIIkqcna/gkDcEn+x1
         U8kKX20uFHSO0hFT5Sr28B7b6q3ChKzTuymiqjeqfdUfSrTrirQWdmE6efR3X8dTQ/n7
         XmO8P+sdGy5X6y2htfXnGRkP3V49yN9Df3qO0MSLmEsa5WwVcgDPokTh3LWKsQniExsQ
         HB+A==
X-Gm-Message-State: AFq9FYKAwvFXOOG0PYkUqWRwdGN2OvQjhZmvxtirlBkM7V6fqSFJ1ipL
	v5HBPgaREDynR5HbIq1R5zC7HNavPWu7VY+JV47bSjGYZ2KpOauH3LO2Uh5bd4cy9Bs=
X-Gm-Gg: AYBFou1yTML5kgUSVdHvRMhKNSYecLQzvU9VHe/kU8er3AuhSoIIzaCFdVpH42XYwKf
	649PqcOcVFDqkiIhhmAC8cR+5LCO3Kay1hHv8tcx71AQiFyS2sU4Gxa+iVHujzxn6LHtC12QBdz
	JIpA+IYDtZUtOkhwRWsB8gLuOwgKHBdW2FB0vkLP2GtjTiOZ9XiXSXprivkuWeNLAHKsS1TtmAV
	R49GP5iNC/IBTMKbHme6spSZaBU5ShiS5rRyx/mfdRP/pRwo2SeEKi5iJomjmNGgAko7MexH6YG
	PoyHLpc1JJJFXV3jqa7EUfwTtKKdtvkTiNCF0LCqj9w+r14ueGGYpyhOGO7eaG5e05pkatXg32y
	FGzfoKyzEGrDuz/cdFyCDOmRegTEqH1lAQA5K+/sZe8/e5rsuGNF6LZbVVgPxxWeXZ5Cs4ijCKG
	vY7U5M1GqUROBFWcH0koF8TqVJmhSNsaWtZoBFl3yEnLybOhxrkq1nc0V1dZEBCHdDPR9HM2R40
	oRhUQKX75Zvk0TP1W+5yupFbsRuzci1F/WAyoHjmlB+by72t54yjXV0aFlec7rCqYhVWiLOnk1n
	Opc9IQv2sCdoOZWCNQ/u7PI2fpbdwtO+FG9BfoKlqkhgX2dWX/+O73zWhavu+YWZ+Y1HvnpNbDv
	eglCiLZPgmtBvF/fAP6MZy3JuRg==
X-Received: by 2002:a05:600c:1f94:b0:4a8:f2ad:a9e5 with SMTP id 5b1f17b1804b1-4ac1548f591mr254361025e9.3.1793649210359;
        Mon, 02 Nov 2026 11:53:30 -0800 (PST)
Received: from z13-ek5.local ([151.40.161.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71a4d3cesm24039784f8f.7.2026.11.02.11.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:53:30 -0800 (PST)
From: Ettore Chimenti <ettore.chimenti@linaro.org>
Date: Mon, 02 Nov 2026 20:52:47 +0100
Subject: [PATCH v3 1/9] ARM: dts: omap: dm816x: Add specific pinctrl config
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
Message-Id: <20261102-patch-ektor5-dm8168-dts-v3-1-9bd6d1d128f2@linaro.org>
References: <20261102-patch-ektor5-dm8168-dts-v3-0-9bd6d1d128f2@linaro.org>
In-Reply-To: <20261102-patch-ektor5-dm8168-dts-v3-0-9bd6d1d128f2@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793649208; l=1087;
 i=ettore.chimenti@linaro.org; s=20261014; h=from:subject:message-id;
 bh=pNEg8PM8cIp8ox2y+p3fYgoghPcp69Vhurs3Xww0fMA=;
 b=7FEE9qKpkZS4TmJ0ng4j0OyfENMQ/VSbQvaLIHzr2DP8dPlCjEE33M8B+fZIJoj3KWBfvUBSq
 4UVr7SVq73QC7TRJsvkn9TnNlTt03EMZoDO3ZrKgov02XeVPMcF8afM
X-Developer-Key: i=ettore.chimenti@linaro.org; a=ed25519;
 pk=wCaUblFVaqhuBTQt/hAtysafsAaEsqj/yOD9SPlz6NM=

Add pinctrl config defines for TI DM816x SoC pinctrl configuration.
Using same definition as OMAP2/3 except pullup/down enable macros, which
are inverted for this SoC.

Reviewed-by: Andreas Kemnade <andreas@kemnade.info>
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

