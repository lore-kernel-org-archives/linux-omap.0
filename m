Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793649219;
	b=mXt06rwYB7pVgaM81KBDKmqZnZmF9GgXeaUBzAId1qTwC1/pLp9e0/HnvGrhEk4yPRYU
	 9mq41zVMKCvPTwobzW+puZvbLFyT4/QQEkINkdv6Idbtfqd4HhveuzJP0w9AKi5xLiz6r
	 x6C7XpZ3RdhKj/1opMex2gDrXk+mJnKt0QCDgVtuiGr3DNXr8wGeGmODfGxLw8o8D6I96
	 uxKFb9D64osPRExGIq4fCzehgAZsNFE0N5+p8AqA96/Q7nKD8MgxuJ9hQwhxccyRsMVA+
	 1J/srsgWOAPLFAUHgZUz8obzQFw7rfum6wd85p09iYnkwgvHllDlnvoB8uP78BRJNGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793649219;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=majDZyUsfWyRx1U53vBoYbbsfxp7bUhn4KTUkz67Qug=;
	b=oNhP7meP3GSUbjryY4/pcaTF3xqJMonL3u+lxJcKx4ph8bKwnOzF13fOLrJ6nQ498Srj
	 NKIwLsqg1zUDFS6cwfbeyMF2Wp3oC6LFwQT5dSGP0uHgjradwzyoR188yIRsr0YFl6LLz
	 vYZuwLQdyNdO7sbXY8d8PTW4+CsUgcbrtLJ8aI975u3z3PZ0Qd1xHYPjxs1fD/Z+cnRWd
	 E+DojchqVfxqJc+bRe2E9hS9PF+r98OwoCclLUbLn27GQFHFQGeU6kGibdO7EvF4ori8X
	 PvwVTOWQQCyV0ard1gU90dDc1ybGwSCaoLb4xoPFVx1WU1PKRn9YixLCyuGHm0879RQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ihhePW6n;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4062C606EEAC
	for <linux-omap@vger.kernel.org>; Mon,  2 Nov 2026 19:53:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4062C606EEAC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ihhePW6n
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a35db1f202so36340835e9.3
        for <linux-omap@vger.kernel.org>; Mon, 02 Nov 2026 11:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793649218; x=1794254018; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=majDZyUsfWyRx1U53vBoYbbsfxp7bUhn4KTUkz67Qug=;
        b=ihhePW6nG5aQKA6k0s6mG8ZXxjGO7JitLw3yRxzPxncDkZfGWQNI6++JrLCSd48y0U
         0M1QprzxL6xmcd8TADdM9AFoTElRw7DqZYAbfii1uG1c995ilrV6LPWOZTpBA3RTvfIR
         wlsH/fpoq7FkEO812jxLGv6TPyvzbsQwosGjHaHSCQaPdPImC7kKNbG7uurXZC92FciV
         /n0mkpaDJ+pe1Z1ysqwpgXHrd1E/cmEeHxoxKVWy3oqk0p5mIWOlxhh4PbgoDvbEF5mz
         bmxdZPndCtpm8K5Oh3lAjQ5LE1E+LM/F24EHRYFMrcE8v2s+olmr2914wxAYtd4ME6Xq
         59pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793649218; x=1794254018;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=majDZyUsfWyRx1U53vBoYbbsfxp7bUhn4KTUkz67Qug=;
        b=gE8qOjm6AsPKUtVOY+fYObcyxX7phiCUJJAYdjXXFuxk+CACJwbBnVfOT55Z+9FrKh
         XgP3zvZCHwFxF6cUAbfAob0WpMVwLKubalazZbJ22d3HjBholByf1ZQQM6Y1SgpKZryx
         rkbBt7gpFIqLAdGlgKN8yznUU/w286lPug3uu0Gxj6p4roNxxZisfm/5Wb3OD1XOJ1Q2
         rSK31GVg8Hhh5bk5w78UtqOX4Kt3t/BgRh/7eBNt+jL9hQng+A7HjULhBWOmjtn4rErc
         9nWwmvEm/1QaNM/kpvlAW6Joicq+jZU/WY65cofQwB3opOobB4n2GqrwVV8Zwurh/UVf
         bHGQ==
X-Gm-Message-State: AFq9FYLi7FJXcLmv00s9kuDGjrAfYaWowmDGd9GaQ4mm86sKIo8hw4On
	hGdDx/R+Xn0n4uPwDtZwEBqppFeBFg1vwjtqi8/uD7ZiH+q8Ea5gSQDrTCMab1tr8Wo=
X-Gm-Gg: AYBFou2IngBM1nl2D2yac2gRP2w2usLwrFWexdDk9I/RaMhntT9p0P1MC8Uaq3h2IPp
	33xoyblAjrEJkdtuPxiVTa2gijx6LVD4BbgVLE0jHCrlPaF5srcOsNOHo2qT3bIwuQV7RyoJqph
	W2IkUM7WeC+6xBkSzB7OzUnFhpmuH3zCZdd3tf0HfaWNbSXSgU6QXqJVklqhJZoS1nKvvfjD8hK
	fokhR7QJif2g3nO6jJnrlN1SK/2Sig8qJp5p+NQjFDeVS7FdChRZGLU2phbagCY2iQMFXsS0wWA
	njWBV7/26Ph8NAQlHXv4V7+qidda3PQRBSx/5GRG7Wvbd/scOhYtR4ZWI1C8JGSk4IjrLw6iKHA
	sJLNSASS2Ti6ZR+J3hUm+lXE+P7kpsl9ximw83ALpFoHTak3XMElBnchQPGvAmswnaasbyLSPGp
	laF/x9J3zU+HyJl5XAOvBK2iFx8X2Q/2ZAHyT5drep0ABjZt//AQ0wuJhg+4KilJemyXzz6W+xK
	YO1JNpAAGqo8Dd3lCseuuZL1sot0LeMAC+i87umEl9Z3P/8ys0FaUqsTyeK+DCAA344uRDofcq8
	XMhQ86uyHydY9tHCmysxzVuai++JLkNNWQzy8SKAhl66S2YQ5dYguPnGq5UCk1QvZWEWBuYE/Aj
	8G/QOHMgVaD9BZ3GUbisXz1yKokA=
X-Received: by 2002:a05:600c:e41a:b0:4b2:406b:f3bd with SMTP id 5b1f17b1804b1-4b2406bf3d2mr33884285e9.23.1793649217703;
        Mon, 02 Nov 2026 11:53:37 -0800 (PST)
Received: from z13-ek5.local ([151.40.161.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71a4d3cesm24039784f8f.7.2026.11.02.11.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:53:37 -0800 (PST)
From: Ettore Chimenti <ettore.chimenti@linaro.org>
Date: Mon, 02 Nov 2026 20:52:53 +0100
Subject: [PATCH v3 7/9] ARM: OMAP2+: ti816x: Remove hwmod code for USB
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
Message-Id: <20261102-patch-ektor5-dm8168-dts-v3-7-9bd6d1d128f2@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793649208; l=1624;
 i=ettore.chimenti@linaro.org; s=20261014; h=from:subject:message-id;
 bh=k71BaTXmePgSJ8uhTSNGLd6YddqmO25ujKt3OAYRrbI=;
 b=P8AE5PbmCCLuy/Ppxw3PTz0WUPfmfz1xHkFqfzmjk7Pc+my/DThex7cRdc8Cv30Fio8oEhxUz
 1kdtOJibLGlA1JLTSPIVWpwfXfCOB886FOvJubPpva5dvZEc7OZGYtR
X-Developer-Key: i=ettore.chimenti@linaro.org; a=ed25519;
 pk=wCaUblFVaqhuBTQt/hAtysafsAaEsqj/yOD9SPlz6NM=

From: Andrew Goodbody <andrew.goodbody@linaro.org>

Remove the TI Sitara DM816x deprecated hwmod code from the hwmod data
file in favour of the ti-sysc implementation. Tested on DM8168-EVM.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
Signed-off-by: Ettore Chimenti <ettore.chimenti@linaro.org>
---
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
index bdd04fed8034..8ca492ada179 100644
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
@@ -1225,7 +1205,6 @@ static struct omap_hwmod_ocp_if *dm816x_hwmod_ocp_ifs[] __initdata = {
 	&dm816x_l4_hs__emac1,
 	&dm81xx_l4_hs__sata,
 	&dm81xx_alwon_l3_slow__gpmc,
-	&dm816x_default_l3_slow__usbss,
 	NULL,
 };
 

-- 
2.56.0

