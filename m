Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793203594;
	b=G9/3B2OlKTfo6aM6MB1pDloUb8HLZnDOBdg6NTqcje5i9baS/IlnvmP50fV6KC5mOKXu
	 2K9dtApr6SAt+O2QjPighUFwogyOcGkWbgRY42De6kQViPbYX/WFwJZrVDg2FpGwSmlzl
	 y/JiZv8eqrW9z/L7+zkUofGSZg0Nnl7fOlH3c6j60kbLO2qH7nuvNUhnT1j8fvk5rDBQA
	 ujwL9Dos8LutoJqYKwPBvJKFiKFnPAaIFN0vaWb+LPV1r8uOvaOkV0LxN1YI9eoz5JzZf
	 EvHZm5rpuVF7XItfNmaXDXjj4YhizwXvDa5Eu1ti5gYpnM8V2I3PdIu1D45Z/MFqvCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793203594;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=K5cbxD/lRSp2Q3hLi6PLLzoHUCTKepxDQp4Kq4HqxLM=;
	b=gReiZiMypp/tJAoZea5Y1A/mZAb4U11M8pwH9zW0FMrskxGIqgFrc3oj9glctq800PwV
	 +90oYl0ILiQaMQG5THdcbW9QQw5Az/hXDhLxlvGHF0GnaILUoxOxDNdEaZUhbJhtqVXbG
	 5CJ6bu20jET8D5INLegY0hoOIPSbq7R9V9a2ZNgsXe1U2zbgcV9KWCaesMMI35JZGXG60
	 Ly8L0sY7wInOvi5GQDDrhfk0DWu49Y53ouCM+Fa15jJRIPlqsE5BcvfYrtIDG6DO4KBWj
	 RXSVj+ijzWl1yB1fOetodswiYmIm2km1Akx3VTnLPBxm/T3Ct8udLcuzOSBitPRKfyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=mPH3qpCb;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CAD606B26B
	for <linux-omap@vger.kernel.org>; Wed, 28 Oct 2026 16:06:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44CAD606B26B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=mPH3qpCb
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a1fbd52ab6so9389155e9.0
        for <linux-omap@vger.kernel.org>; Wed, 28 Oct 2026 09:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793203593; x=1793808393; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K5cbxD/lRSp2Q3hLi6PLLzoHUCTKepxDQp4Kq4HqxLM=;
        b=mPH3qpCbAKLiev8/hNU719zKhQN6qRmCwgloVp7ypKQZpC9Uk61P8Yj7ABA16hvoM0
         +86OxbofRb70B4z3af2vh/6kS4boXPnK7Kr89xBvlCdoqdhMkfgWk1yAjghm1hu4q6C+
         Cqwmk6aI6MN2x4uCioaMdg0xvqiG+9IUdy7JUA5mub6nVtisQhw7+4pXhqWLkcExZxnQ
         rT0/j5XQ/jd9qw9/cnEW/pB5cJhyiPF6bDCExaREU0X9TRMvOk1a+QVOnAO0CGLGJ9tc
         aa2I5lc1eDV8ES3nhSOvoHuiZ3adPz9KxarEvKxpzICn871XshDaJ9331nE3NhtQoDpg
         Kmrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793203593; x=1793808393;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K5cbxD/lRSp2Q3hLi6PLLzoHUCTKepxDQp4Kq4HqxLM=;
        b=gllNrQtxc13mruDm5n56R391h3NVLPqmtZ31xnQXh3PPrRZTMn/QV6uGQk5y1p3pPu
         i2ZysFrZYl6qedVsELlsUpzMjFpU8tZlgJoY6BI1hOi9IcYRxv6qtQJ//kGXL1KKzl2o
         kfcbKtHk3lvu12YKbkTMxDCyWcKARgyXy63HkVSzbkpAU3urcxHWukve+V4jZqh96iuS
         AhseAwz+YVMmGV49499HAGwWaCDLV05LyIn4JjuhAcHYSRDrCpmwQFsD2qqfv0M6iOxV
         8Y0QErL7sjz0w+6qmp07MpoAV65ySTVC9gUD1Wl2mjrXTlma11BAIJRT1Jm6m1Yo5tW5
         e0Mg==
X-Gm-Message-State: AFq9FYJYYuXoJoXSDSKBA/12UTa8GMLSfsHW83NuaipKZ0IOyYE1Sb50
	vDZcWGbdOiveL4ZvVnBrd/rbwGcymXkiGhA7XwIv6VK4283IJNJNcBlV+ajMcuSPfPA=
X-Gm-Gg: AYBFou2+Gsjkvz3Xz5zMFSAplYR6JczHC1pnq5bI7B1vipgOLyAhJ/vF+xFht3j77+L
	LelEpHk+pl2bx2zXmCKyYIMuoNooaJTcRWxesqm9OQC2H0TWvak38HCG4xcL0VY1ic+gBtmCxBF
	5+LnFBQwd6oS356Yr1LyuEDtIIKMkHAGo/qVZGnU35atHWZUZutPY32flPJnw+kmzecfzwzyaUu
	sXRvFc2qGqrrlYdNqru9fmhS23i8CHhbR3+T9c7VbUCUmglb6fOFt2HdM6cvOrfEaL18is5q3yU
	Jq6F2hGt8XbUM1NRPByFiqyJyL9mrDSy2OlKT6BmPHpifPCyFMgdN1KWoieOpXSVmb4hSbKwHde
	nmwx9H9Ttx0CYLvB5StyuJjDMYa+7wfus9Zb4aX3NFoyj2/fth0K9Op08y2je6VShbUndXXYz4j
	TYvVoZwMWbwAotkTgVV/lUJ4rqK2bqneoHLXcHoNPrRV6/NA0ikegtn8v05QDXjQ6djY8vYYJAv
	qgihD5A1lzIRTqc1ekDHpakdIFYlKqcndSsNJCwgBl1cUrF+D29536tMDNk0cpJXZIYi9GdNF9U
	IbcRuS+7rOn+IcC+8r4jF3rpEBxXDa4y6UEBnUmO1gXR1f6tZJ3sEDDj0HmVqXypFPYxt6B0TSk
	lLcVuirkzA4VKbmf9ia/FXsZTg7FZZa38PmnMndp5x2wKnto=
X-Received: by 2002:a05:600c:34cf:b0:4a2:397:73fd with SMTP id 5b1f17b1804b1-4a9667755f3mr61530825e9.12.1793203592754;
        Wed, 28 Oct 2026 09:06:32 -0700 (PDT)
Received: from z13-ek5.local ([151.40.161.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa81a896ecsm1625875e9.9.2026.10.28.09.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:06:32 -0700 (PDT)
From: Ettore Chimenti <ettore.chimenti@linaro.org>
Date: Wed, 28 Oct 2026 17:06:09 +0100
Subject: [PATCH v2 8/9] ARM: dts: omap: dm8168-evm: Correct SD card pinmux
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
Message-Id: <20261028-patch-ektor5-dm8168-dts-v2-8-4544429251e2@linaro.org>
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
 Ettore Chimenti <ettore.chimenti@linaro.org>, 
 Christopher Obbard <chris.obbard@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793203582; l=2102;
 i=ettore.chimenti@linaro.org; s=20261014; h=from:subject:message-id;
 bh=eWhzeB8jAMTZPI1KrE3IIq1D7Ssewn5fvDeiaH0we+4=;
 b=CUTdkEkF+dq1LidthdxZMOHWhYkh3VNaqmkMHQcbzmIMwWqhtlFSpowlgfjJ9B+E6nNFDhmgJ
 4l964OezPWqCU8RpaNDL7ofSCLEmk1/wscSP2drx4dcm0qqWHWQZ+ME
X-Developer-Key: i=ettore.chimenti@linaro.org; a=ed25519;
 pk=wCaUblFVaqhuBTQt/hAtysafsAaEsqj/yOD9SPlz6NM=

From: Andrew Goodbody <andrew.goodbody@linaro.org>

The SD card lines use external pullups and so the internal pullups need
to be disabled so that they do not cause contention on the lines.
This bug was revealed by correcting the effective bit mask of
the pinctrl device. Use the correct macro for DM8168.

Also fix typo in comment SD_DAT2->SD_DAT3.

Fixes: 86800ffe84055 ("ARM: dts: omap: dm816x: Correct pinctrl register")
Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
Reviewed-by: Christopher Obbard <christopher.obbard@linaro.org>
Tested-by: Christopher Obbard <christopher.obbard@linaro.org>
[ettore.chimenti@linaro.org: squashed after fixing DM816x macros ]
Signed-off-by: Ettore Chimenti <ettore.chimenti@linaro.org>
---
 arch/arm/boot/dts/ti/omap/dm8168-evm.dts | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/ti/omap/dm8168-evm.dts b/arch/arm/boot/dts/ti/omap/dm8168-evm.dts
index 81450e15b889..a6d42766a496 100644
--- a/arch/arm/boot/dts/ti/omap/dm8168-evm.dts
+++ b/arch/arm/boot/dts/ti/omap/dm8168-evm.dts
@@ -45,13 +45,13 @@ DM816X_IOPAD(0x0aac, MUX_MODE0)			/* SPI_D1 */
 
 	mmc_pins: mmc-pins {
 		pinctrl-single,pins = <
-			DM816X_IOPAD(0x0a70, MUX_MODE0)			/* SD_POW */
-			DM816X_IOPAD(0x0a74, MUX_MODE0)			/* SD_CLK */
-			DM816X_IOPAD(0x0a78, MUX_MODE0)			/* SD_CMD */
-			DM816X_IOPAD(0x0a7C, MUX_MODE0)			/* SD_DAT0 */
-			DM816X_IOPAD(0x0a80, MUX_MODE0)			/* SD_DAT1 */
-			DM816X_IOPAD(0x0a84, MUX_MODE0)			/* SD_DAT2 */
-			DM816X_IOPAD(0x0a88, MUX_MODE0)			/* SD_DAT2 */
+			DM816X_IOPAD(0x0a70, PULL_DIS | MUX_MODE0)	/* SD_POW */
+			DM816X_IOPAD(0x0a74, PULL_DIS | MUX_MODE0)	/* SD_CLK */
+			DM816X_IOPAD(0x0a78, PULL_DIS | MUX_MODE0)	/* SD_CMD */
+			DM816X_IOPAD(0x0a7C, PULL_DIS | MUX_MODE0)	/* SD_DAT0 */
+			DM816X_IOPAD(0x0a80, PULL_DIS | MUX_MODE0)	/* SD_DAT1 */
+			DM816X_IOPAD(0x0a84, PULL_DIS | MUX_MODE0)	/* SD_DAT2 */
+			DM816X_IOPAD(0x0a88, PULL_DIS | MUX_MODE0)	/* SD_DAT3 */
 			DM816X_IOPAD(0x0a8c, MUX_MODE2)			/* GP1[7] */
 			DM816X_IOPAD(0x0a90, MUX_MODE2)			/* GP1[8] */
 		>;

-- 
2.56.0

