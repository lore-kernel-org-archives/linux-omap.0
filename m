Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793649214;
	b=v5WAP7EGg80Mrf2C6EznZViSsBf4NsXSJ0tACpRjZO/dYmb+wUtvkauZXVoClbKwHJjO
	 UK+5lHkQl5P5tJLW1LLTL7HcCFbkzdptQ2Y5f0JdDrtPsjCccTTU0xH9wuU9ENmme47V8
	 IM6QQtjHgDJ7nvCr+15MFPUeOmwrslWVMWBS/wMhUIa03KlWeSi6xsB0VJwe2859/uGKP
	 gV7PVaMbwc45uUq/egaPocLzPZQmPnTQ2PNVbA4qUahjkIaflic3pBjvSs0D0oqFrOcug
	 DMQbS4h5pd4xn7sr+jnuOtBGMF92EqszJlSIbbmSt7cB20IzMOoKDbHDIhx1nse1PgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793649214;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=y5G5Oi9tmTaDaaDivZDz2djuyaQ/VmV0KNWnT/BwMm0=;
	b=Q3cw0YZRqNr4qn41IN8EYxO4+jZZjd0IH+oS+tgQFgV+STr9SvdZu9P4J+p7P0i9feLY
	 kaxT2z2NCti3Fw2I3+PT3Drlfsb9uf63wkNfVs98Up8A07Co/KC79vaSNdELI3lO042eu
	 U5Qu/c2r9qNpdN+s8rOp8BPpDc6HBFzBPlioeC7By1mD1H+L268sNsA5M6c+XZPMSJsNv
	 GgbAS0UrgOQ6OCJjaxrV5IXTpkhUTqPZOKpaIpK3Cd7twy3/HdUi2oqx9Tz2GE00TTzMZ
	 /QKBQf//DSmkaO77NL34yTHeybzaiY1h7bDDTgXjzMK5M8Um6yNEXxAphQHVLjaOFuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b="TjzApD/u";
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B73606D822
	for <linux-omap@vger.kernel.org>; Mon,  2 Nov 2026 19:53:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63B73606D822
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=TjzApD/u
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48af4d4e61fso2093434f8f.2
        for <linux-omap@vger.kernel.org>; Mon, 02 Nov 2026 11:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793649213; x=1794254013; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y5G5Oi9tmTaDaaDivZDz2djuyaQ/VmV0KNWnT/BwMm0=;
        b=TjzApD/uGH3hLZ884dtVle7ojDH/UHexKG7gL2q0/x0OSigv9NZuk/xIQWnVXqUiML
         OxyK9LHFrK1kZUHBEyMZGb5I8kCabObeWH0EG2mJctbmhJOgOndJDEWr51hppTHsAsU5
         bOMxwqXhiyjqSGMRKFaSDWN9HCoA7VFQqDdbJ0CAwlulm1YuWBGGhGK0kZlhm1SUKRzp
         boeatkcvd3qpZ0dkrLBxcy2Wgeti5JmX3TT2lq6n/nc3E4ILdu0yBgRKkRV6VSF6h7mr
         QTqMxAyMoS3akennWqbvfcqLYS2yKrS/zQvXFfIJPbrrWLQLCvYadq4DG5e9mscvpiVa
         XF7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793649213; x=1794254013;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y5G5Oi9tmTaDaaDivZDz2djuyaQ/VmV0KNWnT/BwMm0=;
        b=iN+2jKGCOg0tQpifenkH+YuWU03SZ9HKxej1rdcKrm0qto4Heq6L2OmwFyPVV06npO
         QUj6n1ymWRKnHqrKp/HLiSQ9m4B6BFGTMoFZe1Lmag7FKKDuQ7A5D5rrU83zzOM5OlxX
         lWDEBKNxRp2xHoNGNRynPMGN8dATwNWBWNq2m7XpHTdaZDxxzcXn0ZboGuy09W/VKhgq
         9Zsz8SAr993abQmX8LKRoGub6+beCQZanmHJUXOfeSGHwHt/00qmgJOhn5s0V03CdR4w
         bPL0qUWhWxfTqUHw6xu5+vYv/0O6r6bZ+2DL4Zd7VqDztvEpAi3ObIfjC7uBB0GoP82k
         i6Tw==
X-Gm-Message-State: APuU4Z87qGnG1aSGeh7TUKqRodsElCFS25iaz2ZR4sGIbuEFzwR7ST6U
	eIyjvH3tH+9/24IaZbql/xGZw0CCUsUSpFjJXid62f7lFEdEAkmaP1Fx4X8Pcbzdjyk=
X-Gm-Gg: AYBFou2qPhJ5CwsdPkeNNGhBFtE3mAewCVCWcBrbxzKW17ydxlftwgHuocK1j2BEY3H
	TSI02f1hWFAiPiOBplyd05amTYX4xMQjMABejnS71+38LCxeIEteLrDs0XiTi9eDRYb7H3rfsnF
	DIVgvAgmizwUqrgpuXFElHl+c+c+XgGs+RHRadtpseiactUyfVAPHZpZvxP7vXllZKdNUivGGH2
	lU74YM1T5mWY9bwoAwoefDoj01qVnNxtytGFCoiKw/Ar3jqJKiH84ELFlX2Gs9e4ZUMnv+VzOdQ
	ihDYkgFRcO51nhmaAgBjnqQ8O6Ge5Fzjek9X68miW6Sp46l0Xp7mf6FayxBYpBEI6MQ7l1370Mt
	OvB8mUa2qX5DOULh16VhAQkBULddSG7S1tMQPZ2IjxHN6S1M3a4p0Oj3jfl58CJzkVZoIguKBlc
	lNJHD/Fwm2kRo9s7WQQ5GY+6qVATx+ItbyZyNrsdIMeSI9DBTTfH++Ei4+Iszpb/d40eMUDcbMj
	9RGV6oSNZJu5NGAKAOZLGzkCTEmVsTVTrwZfErk+yZnKFtw0emOT6+gSI23H5w5CHv6KZ+mz7cr
	E73UmixVcu4rWB4rSSH+fD/HWEBnYAXjJoVDO+8ifmSBkF5eDGxrqa6WxTXQUiQxpEea+9nlh1F
	odsOWVLN8tbcEFmnkW3Y5NRm6Ig==
X-Received: by 2002:a05:6000:4013:b0:48e:6264:c388 with SMTP id ffacd0b85a97d-48e6e2ff911mr23181536f8f.23.1793649212689;
        Mon, 02 Nov 2026 11:53:32 -0800 (PST)
Received: from z13-ek5.local ([151.40.161.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71a4d3cesm24039784f8f.7.2026.11.02.11.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:53:32 -0800 (PST)
From: Ettore Chimenti <ettore.chimenti@linaro.org>
Date: Mon, 02 Nov 2026 20:52:49 +0100
Subject: [PATCH v3 3/9] ARM: dts: omap: dm816x: Fix pinctrl range
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
Message-Id: <20261102-patch-ektor5-dm8168-dts-v3-3-9bd6d1d128f2@linaro.org>
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
 Ettore Chimenti <ettore.chimenti@linaro.org>, 
 Christopher Obbard <chris.obbard@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793649208; l=1269;
 i=ettore.chimenti@linaro.org; s=20261014; h=from:subject:message-id;
 bh=P0EUDiEV5xVvoAc15r04teIU1ur9dww1Y4noU9iuuEY=;
 b=hWsGqtoEWoqx9qzruR2/klCLZ1d2o0pZzDW9WAI4o5XM6uZIewzua0xt5k33Uxf/kYfLHjJI4
 6ez87CXChQXDvHN4LYW/ZD4wk7GvPZYihUn2fr+m9G2qHv0+6+iOc83
X-Developer-Key: i=ettore.chimenti@linaro.org; a=ed25519;
 pk=wCaUblFVaqhuBTQt/hAtysafsAaEsqj/yOD9SPlz6NM=

From: Andrew Goodbody <andrew.goodbody@linaro.org>

The range of addresses accessed for the pinctrl module needs to be
extended to take account of the fixing of the size of the pinctrl
register to be 32 bits instead of 16 bits. So in order to allow the
final pin control register the address range must end on a 32 bit
boundary, not a 16 bit one.

Fixes: 86800ffe84055 ("ARM: dts: omap: dm816x: Correct pinctrl register")
Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
Reviewed-by: Christopher Obbard <christopher.obbard@linaro.org>
Tested-by: Christopher Obbard <christopher.obbard@linaro.org>
Reviewed-by: Andreas Kemnade <andreas@kemnade.info>
Signed-off-by: Ettore Chimenti <ettore.chimenti@linaro.org>
---
 arch/arm/boot/dts/ti/omap/dm816x.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ti/omap/dm816x.dtsi b/arch/arm/boot/dts/ti/omap/dm816x.dtsi
index 261ebca8863d..fc124f9ecfa1 100644
--- a/arch/arm/boot/dts/ti/omap/dm816x.dtsi
+++ b/arch/arm/boot/dts/ti/omap/dm816x.dtsi
@@ -90,7 +90,7 @@ scrm: scrm@48140000 {
 
 			dm816x_pinmux: pinmux@800 {
 				compatible = "pinctrl-single";
-				reg = <0x800 0x50a>;
+				reg = <0x800 0x50c>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 				#pinctrl-cells = <1>;

-- 
2.56.0

