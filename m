Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793203593;
	b=qzFosh32agV5QrxJ1ROD0L/OOakMnWB9h/2/ArbGsL394/F2EHa/IlgRVujSlD18nlLq
	 SeEQ+H64ZvT2vKt8e/btmSahHEIGVUmVVxRAH0pyMVGfiWRWM/LyTFMB0J7/HawQeX2sl
	 b51F8N8Vkcib363/l501AWadhAEUbg8jj+xdHWnED993fozHwqMzNcP9Dy4Z9aLGu4p7y
	 MbzmkNfpbPM8YRNf2CzAtMz0l0rr5hSx49L7cAe4wnR6Hd+AcInoFoXiXZkR0YSGKoYn9
	 4aF2wdg62k8he6juP1/njNkWp1jddBxkxjA7LygZd3Q3eLxWiUa8Yj5hQzG5G9JhvPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793203593;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=7ZA+lAyHuDEsFhqEslFfArNJzGGWxbNE92ukEzZuxNI=;
	b=VJODojWDfhfsFBAm64NFosR4ARyMZyOS+FqAuW/Ihr66+6iubNyIE8KzaXI69a9puBrF
	 NRpsIbpE3B2iEXHJg4cd8SqwtJhTKgP+6kSMM6ZCrK3L49aF6nn12brBZnPYyjlVQsK7i
	 iBqhuJr1krt5kLE6sAbOhigqvh/fn5UWd8IIgpoTwgFMu8G0lP9MZ3m2DMiIIpBYUqXut
	 hs+cQQL1vIx1jp1hDHnkquL0DfrK5sIFu63KstnICyBqREdqeK4zeiO/wyfCeP3DnVxS2
	 tEVgHFLlAveIacmkA5pPQ7PEHPo0X+CnZ5tZmYZE1+PjrgdXMGKTUC3GYWRhyH2WJkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=cxt3iCfe;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE6660A2634
	for <linux-omap@vger.kernel.org>; Wed, 28 Oct 2026 16:06:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DE6660A2634
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=cxt3iCfe
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a2000d5fb1so8494785e9.1
        for <linux-omap@vger.kernel.org>; Wed, 28 Oct 2026 09:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793203592; x=1793808392; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7ZA+lAyHuDEsFhqEslFfArNJzGGWxbNE92ukEzZuxNI=;
        b=cxt3iCfeaXPmT0e03ZR6Gpu7Ti+yT+t39ypsg0oOnFF8HvvWrgTuKHbstmvDceG62G
         nxHNMwbr3vbApZ7ymqgN5mrcvKhVB0N0JB67VgY4T3ULqOZZi8W6gjnHK4baZX+OaLsK
         8VGtlexj07cz9Xk0JXKAHsoSFVtezCnqKi28n6QWh+MxLX6zSPeUVDEuMSGdZetZ7kjM
         iN4/MF0rCH8YJknGwMGmkpj8cTedHwTAkdky+8DAjwMTqGZfEp6TDzUMdLHYzYfYWTbW
         etjTUe4OyAyZ+b4Q4muqSikggEymJ1Tlj8tZocnMtIvwCpVBx5fSU+R9jMscUpyoJT3U
         Zhow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793203592; x=1793808392;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7ZA+lAyHuDEsFhqEslFfArNJzGGWxbNE92ukEzZuxNI=;
        b=kCRRob1wY0lVBqCGLB6FU5524ugdDO5YhZwqdATYztAm4CAO/p+u6j1VWM6lF6y/8j
         By9xk1NqKcO5S9sLppTMfdOQSPyoy9nU9he11DaFyajpGSt7+vcmnG6hoJ3xRqJYV1IH
         FIUlhYpvEQb6yUAYMhztcPrWEA3AHHmQuend5OKgUVUieTfemsmrrQEz4905nzcmoM1+
         Rv37dBWOi28+WH9xBgeMctw2cwnTC146t6PvkGsVoVP6GNEjw2odYNHFeFi081lCsJVP
         7ztX8oToUsltPjP87dgUXUbBFZVsCLyZVAkSA5iII27rjl07Fw+x7suBZrcybjCLFnNA
         +0Zg==
X-Gm-Message-State: AFq9FYLYhxQ6eiiyYyVz/jebm1fEk2p87Cnvq0gR/qKZEUpgYZ1inWnO
	sr/CO1GwdkLc5NbQaFPjKgijl+rdYy1FcycU0XtKrXo1m+6yvWwPU+MbM+2y2j0hr+g=
X-Gm-Gg: AYBFou0MTX+WEztJP5gPtkIXyNljYb9ePGHRB2lDmP4GkZvMv6RYxVBmtCJn6P9D5wV
	d7ZlZ2k2bXaz3wiFDOurHe8tDUVs7uZFotyOonDCzxjxU7aF52MAJdiy+0Xs0WxsWvJuS/NP5bv
	KDMN8IFGZpr3C72xR5urxu9hoiho5PEQ6bxKKeGiCLYCHml8H2uvqLPaSSA8srSMFxwjn4u8BiF
	txbqqlo9AByJ1qXwr22v0yXYx77F6LvGtj4HiSVHxSg6LLTYQLW3+PQIzKI2k+cz1F0vphjOS6W
	nHzPJhl4p0935tBA1aKPUIIzDIIsnE6fxKKzPm/i4hbpLy1qTE9/V69c79VRSwUpp1QYxi9WO45
	SvGc+WxSUQqmHOv0ttSgIBFKEBOI9uMYC9W71gwtWch+it4bxr4ap1WqAb/63hJRM6oV/9pRvI0
	LYquIMLWYAL1o2mSnRwDuBFdtNIrfj/6JDkh7MLmcDgHOeWsjq8F57dmNL6Qsh2cN9oQdzPItgi
	zw/J7q71jpV7poDM8qzq2Xt0ZvxclsIqozXcGB46OUCMaS5h/K93RS0FpP2aihePfl/AJJRiRdt
	L7C+l0j2FtVf24+3RgN6mWhS6/KhzIzE6EFplwn6QGK399JuynoTf0G/QqGasP2KKyHvW6YlkgL
	l99qherKlxut/pOsd4zTgb6JcQw==
X-Received: by 2002:a05:600c:3556:b0:4a2:1cc:6551 with SMTP id 5b1f17b1804b1-4a9678c3cadmr65712265e9.35.1793203591617;
        Wed, 28 Oct 2026 09:06:31 -0700 (PDT)
Received: from z13-ek5.local ([151.40.161.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa81a896ecsm1625875e9.9.2026.10.28.09.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:06:31 -0700 (PDT)
From: Ettore Chimenti <ettore.chimenti@linaro.org>
Date: Wed, 28 Oct 2026 17:06:08 +0100
Subject: [PATCH v2 7/9] ARM: dts: omap: dm816x: Remove hwmod code for USB
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
Message-Id: <20261028-patch-ektor5-dm8168-dts-v2-7-4544429251e2@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793203582; l=2202;
 i=ettore.chimenti@linaro.org; s=20261014; h=from:subject:message-id;
 bh=Ny6o+8O75PYtwR2Tbz8N21c8sCnj9yIYkNJzjWqiRRs=;
 b=e2Cm89NUh+NWLAqlSGnjPS9Qu2O++UotrEcH7tte7NtpZVzxvOd9M+H4nKGn+8JXxX8PSH1PL
 NQS5foBIQrUBlTbY4ZPammQ7bf2KFpxUI4ifneZh92O8oRNb5O/qxZD
X-Developer-Key: i=ettore.chimenti@linaro.org; a=ed25519;
 pk=wCaUblFVaqhuBTQt/hAtysafsAaEsqj/yOD9SPlz6NM=

From: Andrew Goodbody <andrew.goodbody@linaro.org>

Remove the hwmod property from the USB controller node and the matching
code from the hwmod data file as this is now deprecated.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
Signed-off-by: Ettore Chimenti <ettore.chimenti@linaro.org>
---
 arch/arm/boot/dts/ti/omap/dm816x.dtsi      |  1 -
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c | 21 ---------------------
 2 files changed, 22 deletions(-)

diff --git a/arch/arm/boot/dts/ti/omap/dm816x.dtsi b/arch/arm/boot/dts/ti/omap/dm816x.dtsi
index b839ee29e9eb..55f4b91fa1fc 100644
--- a/arch/arm/boot/dts/ti/omap/dm816x.dtsi
+++ b/arch/arm/boot/dts/ti/omap/dm816x.dtsi
@@ -576,7 +576,6 @@ uart3: serial@48024000 {
 		/* NOTE: USB needs a transceiver driver for phys to work */
 		usb: target-module@47400000 {
 			compatible = "ti,sysc-omap4", "ti,sysc";
-			ti,hwmods = "usb_otg_hs";
 			reg = <0x47400000 0x4>,
 			      <0x47400010 0x4>;
 			reg-names = "rev", "sysc";
diff --git a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
index 9b5c728fb7da..b9735b507d6b 100644
--- a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
@@ -646,26 +646,6 @@ static struct omap_hwmod_ocp_if dm814x_default_l3_slow__usbss = {
 	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod dm816x_usbss_hwmod = {
-	.name		= "usb_otg_hs",
-	.clkdm_name	= "default_l3_slow_clkdm",
-	.main_clk	= "sysclk6_ck",
-	.prcm		= {
-		.omap4 = {
-			.clkctrl_offs = DM81XX_CM_DEFAULT_USB_CLKCTRL,
-			.modulemode = MODULEMODE_SWCTRL,
-		},
-	},
-	.class		= &dm81xx_usbotg_class,
-};
-
-static struct omap_hwmod_ocp_if dm816x_default_l3_slow__usbss = {
-	.master		= &dm81xx_default_l3_slow_hwmod,
-	.slave		= &dm816x_usbss_hwmod,
-	.clk		= "sysclk6_ck",
-	.user		= OCP_USER_MPU,
-};
-
 static struct omap_hwmod_class_sysconfig dm816x_timer_sysc = {
 	.rev_offs	= 0x0000,
 	.sysc_offs	= 0x0010,
@@ -1250,7 +1230,6 @@ static struct omap_hwmod_ocp_if *dm816x_hwmod_ocp_ifs[] __initdata = {
 	&dm816x_l4_hs__emac1,
 	&dm81xx_l4_hs__sata,
 	&dm81xx_alwon_l3_slow__gpmc,
-	&dm816x_default_l3_slow__usbss,
 	NULL,
 };
 

-- 
2.56.0

