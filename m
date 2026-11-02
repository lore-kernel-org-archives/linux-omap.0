Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793649217;
	b=K3pPX0Bu6tfNw3VTxV1zFxba9ujy7fLfE3qMYMsaJp3AUPuNXdXoJ3qDvHxmb355k8Xo
	 sPtVZVFmY4/k84voLGiJ2uTplcypqh2Jf+gmv764lfUREaOcur8aPySaEFW80SETOgV1T
	 f7EkXBDcInsBr1yhN0B61QHEkgMsx0xHwBYZVq3+Z+L3DxpuKHyLODmjx2zOQMp4zj3VL
	 mphkR9IA4YxZjQk6InOnN1luqQxCJcLnFmOrobzCv3ZJMvb/AKz7Ti4gaO1oX3muNtGnu
	 nHf59AamaIiPjXbGY6rhyDaszsBmSPFbk9sMW5HXefsfZDKKWMWmELlBI6vgbdQQT7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793649217;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=xImj77wxU1JiPHrCn+RpkXX1bCUiT+eJFmt0+GqsKlk=;
	b=DnYOXcAjeJPrcw814NNTwvLs78ZnDhxIT6+eztIprJULdrPaGQigKS84OloeV0iaUOc7
	 4Re6eFbqswb0iUG+pZVK7T1KH3AijzHz5h0TJl5uZyBw8igJDeskTua51mPkAzjpamkd2
	 5LoF1dWOXVvlhKHN8tco2sJpXh/1M5CG4GpLXmT0fE36K/M1WYe1VslMC+hQiX0jJsQmQ
	 3cXxgLgUxscGMOQ85/xc/JhqQrwhanQ+H1Evk54pGEwtrE9U5npTxVTUja+71RVJ7ul9p
	 1uAsK3TifDHnLjFOXFNrL843LEMAduExYFK6dmI0ub+NaZMcBPcZ5Ue/KSlT06+rjtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=wr0ze8ZS;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410BA606EE8E
	for <linux-omap@vger.kernel.org>; Mon,  2 Nov 2026 19:53:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 410BA606EE8E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=wr0ze8ZS
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a59100fa83so30740645e9.0
        for <linux-omap@vger.kernel.org>; Mon, 02 Nov 2026 11:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793649216; x=1794254016; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xImj77wxU1JiPHrCn+RpkXX1bCUiT+eJFmt0+GqsKlk=;
        b=wr0ze8ZSw+SH4GDQWPNXanLZXkEVtyzUNtWcuEqD8bYpY12rL9ZY5uuFcMkEUTpI74
         WYivSYlbwK5MRgpoylmFHd+y3FJyeAUqoqKqpZgtTyiYaAbTvrV9vF+HALxpMorTpF+2
         PwEaniNrv1K6NhtElM/05sy4sXLZB0nR1nQ36RGpD1hww+VGIlgAxQSTlv1GPgY53F0Y
         7cRo2jc5SG1Aj/9v4LyY9F7qwcei6Tm1CiEmkMcsZWAVuSmEGwvTjmgDt17mc9T3BYYo
         dKjDdz+z3q37d0LNbGGIV4luI4c0cpdBmnHc7HzmWCSCh1BQt59W6Xbj6G70VUVATBPA
         0RqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793649216; x=1794254016;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xImj77wxU1JiPHrCn+RpkXX1bCUiT+eJFmt0+GqsKlk=;
        b=dFkRK4SRpMOw3ifsRwgVr7JDHsWUW2B2g1LlmOZatm1pkpVO0pxLXID5m0wXnHMqas
         +3bk8+vwutIdHCLaGnAk+gZvv/ZgI3A73ThIW5LFylwtSkD6LZcB7BJakdlLOYohC9Vh
         sZekogyohxwoHcOyGPiFpLi1rQbxtCWOWPK16Kg9nXJ5RFqJ6oDJEALRJ4UynvDQe7Vw
         8tZEe5583p+Hb1yBIH/tYwYPrcQ+BYrPjkVbUlcTj94b8PZ+4TgBVN0UTJEVJl/ndLPC
         88f3VlfQRN9RbII5S+IPpoglGmNbq20+/dUgV4/M8EWYY6/zSOVXIjh9ELcOyGM2TUGv
         FOPA==
X-Gm-Message-State: AFq9FYJXKMIoTShOELixjU8UTgN7uFmsSaQ5sPkD8aS15jmUn6l2Aydk
	R848RvrVpOS+zVh1p8h+1jS0ia4ZBiPrv9SPXr10l2alPDb6fYbYZyJNwtpseea03z4=
X-Gm-Gg: AYBFou1BOlnCVyb5PT7YMa59NOXpv3UHnbi8BTgCRHaPAmGSdwVfCtmfboDO14/Gr3f
	RdgB5lIjPtQdsTmIGsdvy2qg4UTSd7cTqvfu+HLcKRYtfCbxHc8tNN21GYdX15W45JkmnUdashD
	OsXcn2AMsXH/j/XHDMu4bL1sgJMH1dg8bgOLJn9nMCFak7Gd1qgfMLZwfJwOWbfVgKMooQr58v9
	S6z3nqvY9b6BxI+WEQNHi67P3oH7ga7AO1CCLlM+RPN+occfOMv+I3ZdIdc9rcEjhuA0/5SbwRv
	SHnYz6WIG433+Az17Knp/Z6Mg9noFjlWlorUWWISKNl6/z8ZROgqCZV6AYSd1D6BrIWssqJ9DtQ
	jRIPBBwIKquoIo2aTcuMlmSJ4gfR+wI6scfmn54tIQt7RHw+Vy4DDEnJOXYLrCWIc+v19gQTW4p
	MtPRgxgMvITWSawUcxSihyEDldwaDOjuI9YHpAVw7XMmdL8DAQqWUMvBT3rsNsl93ZGk2+9pDXs
	TQgD7uQNdEi1tLKWeugOkfGtwPeiFV2RTKT9T8+SheSyBmbs42J63PgR8gfmsx4rWF/eEkzZxtf
	G7r/6xCpdt3Hg/551Mx+3oMcGqIgRH7DROHqEJ5RywjdtwlnP4bRmdvH9yGO3LraJRUaPZj06No
	EV2CCjdwSgv3AKapQtkg9lbtVvXk=
X-Received: by 2002:a05:600c:6989:b0:4a7:6425:c274 with SMTP id 5b1f17b1804b1-4ac150b38d0mr253158745e9.2.1793649215549;
        Mon, 02 Nov 2026 11:53:35 -0800 (PST)
Received: from z13-ek5.local ([151.40.161.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71a4d3cesm24039784f8f.7.2026.11.02.11.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:53:35 -0800 (PST)
From: Ettore Chimenti <ettore.chimenti@linaro.org>
Date: Mon, 02 Nov 2026 20:52:51 +0100
Subject: [PATCH v3 5/9] ARM: OMAP2+: ti816x: Remove mmc1 hwmod
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
Message-Id: <20261102-patch-ektor5-dm8168-dts-v3-5-9bd6d1d128f2@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793649208; l=1739;
 i=ettore.chimenti@linaro.org; s=20261014; h=from:subject:message-id;
 bh=G9T2NjG2BfNSixK5sZS2CvW8OhbMENFuouCNl2SV0jo=;
 b=ZZLDjvHR6I7hIyGPauR2LYro//dURZ3tYARcVpY+gDOy8N4xYf/mLi6AHVlxgrzjl5I3lL6xr
 RBe+pYKXStnD6Fv6kqtmFRpBrzXmGw/RgUYx9gVc6FQ7jEsPfEUs7ud
X-Developer-Key: i=ettore.chimenti@linaro.org; a=ed25519;
 pk=wCaUblFVaqhuBTQt/hAtysafsAaEsqj/yOD9SPlz6NM=

Removing TI Sitara DM816x deprecated hwmod for mmc1 in favour of
ti-sysc implementation. Tested on DM8168-EVM.

Tested-by: Andrew Goodbody <andrew.goodbody@linaro.org>
Signed-off-by: Ettore Chimenti <ettore.chimenti@linaro.org>
---
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
index 9b5c728fb7da..bdd04fed8034 100644
--- a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
@@ -989,30 +989,6 @@ static struct omap_hwmod_ocp_if dm814x_alwon_l3_med__mmc3 = {
 	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod dm816x_mmc1_hwmod = {
-	.name		= "mmc1",
-	.clkdm_name	= "alwon_l3s_clkdm",
-	.opt_clks	= dm81xx_mmc_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(dm81xx_mmc_opt_clks),
-	.main_clk	= "sysclk10_ck",
-	.prcm		= {
-		.omap4 = {
-			.clkctrl_offs = DM816X_CM_ALWON_SDIO_CLKCTRL,
-			.modulemode = MODULEMODE_SWCTRL,
-		},
-	},
-	.dev_attr	= &mmc_dev_attr,
-	.class		= &dm81xx_mmc_class,
-};
-
-static struct omap_hwmod_ocp_if dm816x_l4_ls__mmc1 = {
-	.master		= &dm81xx_l4_ls_hwmod,
-	.slave		= &dm816x_mmc1_hwmod,
-	.clk		= "sysclk6_ck",
-	.user		= OCP_USER_MPU,
-	.flags		= OMAP_FIREWALL_L4
-};
-
 static struct omap_hwmod_class_sysconfig dm816x_mcspi_sysc = {
 	.rev_offs	= 0x0,
 	.sysc_offs	= 0x110,
@@ -1236,7 +1212,6 @@ static struct omap_hwmod_ocp_if *dm816x_hwmod_ocp_ifs[] __initdata = {
 	&dm81xx_l4_ls__gpio2,
 	&dm81xx_l4_ls__elm,
 	&ti81xx_l4_ls__rtc,
-	&dm816x_l4_ls__mmc1,
 	&dm816x_l4_ls__timer3,
 	&dm816x_l4_ls__timer4,
 	&dm816x_l4_ls__timer5,

-- 
2.56.0

