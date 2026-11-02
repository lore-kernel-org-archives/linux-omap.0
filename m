Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793649221;
	b=um0qop4R3BTD/pnPh5HMtoNY97JXFhFx6bf2nYENeUptdHGXfn4dvpTdX+cwe5WZ8W+f
	 B7rDqkcECLt/vf0I/PvUeOz3QZODLNODSAEOXMDHa62aBFc5CP+dHFPux62kEStwjvFN6
	 sPdvWUozd+/nh1xTj7NTCMZ0xzXxN4WSJw9+IF5QJWeBeLCMj+mtXC2jvljj+FR2dIjLW
	 19B6CxlI6UR2CQc/8pYtlKhwnxxTdmxAtksyc7TFIBAzTMD66gu2cigCi1RJESAAMdP8k
	 Y+n/bSg4EWvzqmVF40XQTTy17r0l2QzZKzeh0Amdj9ciXgpKdMPK0FSdyTsVXOQLOQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793649221;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=0fpz/uw2nhdb0euDYGKBTP+bqdC3yE0PUdZgdE1EJC8=;
	b=fdPINH6jnGQY3uQ/sWYYyXN3nDWNRjztUqJaWyExTMCX6zQnb6khxn1Nc+aFfJeX3O8K
	 p0TjZZc9CmjWZOA9Gwd81XKomjo4HLgb5DnrtoMiMpKs/Wj0KNmBvdjAHAZ2A1RiEMV8n
	 mdNh5fPWPkkb86sITT/U9fQXZcbJfijpH47OFnzsm/B+sip3C/Pg52hO78MtRXNk5GUzO
	 gU7c+Ew1oUHyxJC79c/Oj79Mws/ByseYMp8dOQs+jTN+dCy08WMxw1+oxDU/TkYfve13R
	 ZIlXVaZJ0V6iz0v/UQvmM3yOP7SffGSOpvk7x942Z7xCZxyrwI3aUbe46uoXgYhkpBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=rVr9EIXe;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828766082BD4
	for <linux-omap@vger.kernel.org>; Mon,  2 Nov 2026 19:53:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 828766082BD4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=rVr9EIXe
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a5087a5348so27697535e9.0
        for <linux-omap@vger.kernel.org>; Mon, 02 Nov 2026 11:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793649220; x=1794254020; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0fpz/uw2nhdb0euDYGKBTP+bqdC3yE0PUdZgdE1EJC8=;
        b=rVr9EIXegK7MvTJ3LW+g+Z/AsJ6mM66GF3AgBUJtVngRLoA4OihLKNRtkB22JnZKFS
         rEz3HZK8Li+Xp1xKgmH2ZjHAwbSaHjqwV/acRWJqunhpadxp7NcRJpOBnxQaGF58WHlt
         RSdU+VGM4JoNgxBbvF59mh4pOQpfPtawON/q6pOPl+HSMHbLXvhReMdB83Yb1LoQzUe7
         3aCWyW7H4e6EroWAJNW/g6SU20rBQM4OkpLkzj6TiEHZTROw1qq/lVznf1fUHj+p77WB
         7onJOlO4ktfhXTOgXVSTPKcJanpE2EmAk7gQZDpY7nImvJJlKotzrYjb0c55/N8EiuGQ
         0FTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793649220; x=1794254020;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0fpz/uw2nhdb0euDYGKBTP+bqdC3yE0PUdZgdE1EJC8=;
        b=Hif1jmMYB0XV2285gjVKH3wT+AuZXb82GFPEuoywT4zhZ6yNupMtA2KLl8NJs19bfx
         gQEvOGxPso6wk/c4/6WpdD56r+isnawQ2/nr+r+ob9BYtE3+i8rrr84OMzFGsrPjjDmg
         Ke75deK92idHnm/vQ9kLf8mN3I9at+xbQmNCF5tZZgFRgcUFmUt6lcjXfqCXBf0KOfBL
         /MvijJdEabBYF92b2OAtpPT7qfMgf+h7piW7CxWwlUyO9nADm7U5o+C9AEAP/w3qzwu6
         7UtutxktuPS/zGHgnclc2GsGN9ZEzoTwUDWXpsYZfqDnGDTHRf/6EnLujLLPPyMph2cC
         T8JQ==
X-Gm-Message-State: AFq9FYJPM2zJTIsfVm550khtk/ph2n0jNsYdYgA5ct1mmPMsCvBeB7qy
	bAEbOtHQQdBBIAdDbYtWYc80mHvdWoGsaRs37OhqLC3Ru45OhJa2x0cuHOeyRuFBn1E=
X-Gm-Gg: AYBFou0xl229pgHYJBCmWVOipdhZFFP4OfFzbDMxgokkZYjB7pU9rGmk6OivDHD+DZl
	HR0hv9DyEVm0XJOmy3oaUIRjj/6RV3FgTC+pkQYfAHVM8O/Nx0KKdqljNFiE3A0m7egjY3HEC64
	R1KTpiUQ8BsjEpy3J3HLcAsCjcdxO7D78dpPzDwAHMww8VE0/aDftJXzER15EUipOGvPY7vVNfS
	gqYF9U0agScfymqeNEFVz5vccmbnpXNv+pI/vNgMZ77nCmzgJI9AboT9x7vJrpYENBzSeMbE05k
	Mo1WS9a+6xVwZKUtdejkbXXNJ1WKgRVM22HvrL0Cevnbis0Ewwq18dy6vbS8Tv8mXSMfkAqOuiy
	CjT1rnF1QaQM8slBc4AZqv/key6W4vFSma411b6iqLwbDHNso5Oa3oG2VBuGpnttWtqiqn3VvkH
	kEJnyk88CLvs4qI2J7QiTshKofFO/+GPqdZ7/0ArNe4tnwZBBwtJXSd0m37ys4aNtsCb8m1IStG
	IpxKxeXv4Ya8eB5UHPPzQTn3CzBeUeXL67TVSuJ753B4dUcmfRyHR2tS0MwZ71S3R+Se3wngvBL
	0sfYbDguYcYOEMxSg6YIpbG1Zgn99nJxOpcbu8d/P/Dw5IDf53ok+9c+tiUVtGfa//J37Tenm6k
	FWPjpF0Eoz0b12P6nrOWfd5M2SQ==
X-Received: by 2002:a05:600c:19c8:b0:4a3:59c9:a743 with SMTP id 5b1f17b1804b1-4ac1913ef8fmr260265065e9.27.1793649219912;
        Mon, 02 Nov 2026 11:53:39 -0800 (PST)
Received: from z13-ek5.local ([151.40.161.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71a4d3cesm24039784f8f.7.2026.11.02.11.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:53:39 -0800 (PST)
From: Ettore Chimenti <ettore.chimenti@linaro.org>
Date: Mon, 02 Nov 2026 20:52:55 +0100
Subject: [PATCH v3 9/9] ARM: dts: omap: dm8168-evm: enable MUSB multipoint
 support
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
Message-Id: <20261102-patch-ektor5-dm8168-dts-v3-9-9bd6d1d128f2@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793649208; l=1481;
 i=ettore.chimenti@linaro.org; s=20261014; h=from:subject:message-id;
 bh=GPDgtWDoINKJrraqXEHk7avh0mT0fUwCN99SIrQYwCE=;
 b=rdyCT6dPdNGjEGb0mGj7AcMz0ZkRYEhJcmpAPs44qs2/zbWAbI3Wlil1MRcniIsO6bUaDt8X4
 vYzMD3bLdtQBzai49938vlHle0a73q/YWslU6vw3k9vpk6Jx12fmEy9
X-Developer-Key: i=ettore.chimenti@linaro.org; a=ed25519;
 pk=wCaUblFVaqhuBTQt/hAtysafsAaEsqj/yOD9SPlz6NM=

From: Christopher Obbard <christopher.obbard@linaro.org>

The DM8168 USB controllers are used in host mode and must advertise
multipoint support to the MUSB core. Without this the kernel disables
external hub support and warns:

    musb-hdrc: kernel must disable external hubs, please fix the
	configuration

On the affected board this also prevents devices from enumerating
reliably, with descriptor reads failing with -EPROTO:

    usb 1-1: device descriptor read/all, error -71

Set mentor,multipoint to the default value of 1 for both MUSB instances.
With this enabled, USB devices enumerate successfully on the host ports.

Signed-off-by: Christopher Obbard <christopher.obbard@linaro.org>
Reviewed-by: Andreas Kemnade <andreas@kemnade.info>
Signed-off-by: Ettore Chimenti <ettore.chimenti@linaro.org>
---
 arch/arm/boot/dts/ti/omap/dm8168-evm.dts | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/boot/dts/ti/omap/dm8168-evm.dts b/arch/arm/boot/dts/ti/omap/dm8168-evm.dts
index a6d42766a496..4b4e4d850231 100644
--- a/arch/arm/boot/dts/ti/omap/dm8168-evm.dts
+++ b/arch/arm/boot/dts/ti/omap/dm8168-evm.dts
@@ -198,17 +198,14 @@ &mmc1 {
 	wp-gpios = <&gpio2 8 GPIO_ACTIVE_HIGH>;
 };
 
-/* At least dm8168-evm rev c won't support multipoint, later may */
 &usb0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&usb0_pins>;
-	mentor,multipoint = <0>;
 };
 
 &usb1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&usb1_pins>;
-	mentor,multipoint = <0>;
 };
 
 &sata {

-- 
2.56.0

