Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793649221;
	b=xoj5zVCoWqGN3yGYHISmcA3M4st/IiPfz6ScQyRLKFcSfV/0DlhxGkEA/ittFlwv95tQ
	 2MO2PTGxjbv6vVRDa6gFHyYx0baVoBk7gW2E8ahaJYxF8SuyuSkjQcpF0szbTKj3nOgnZ
	 sJuiX9Rer4slxcOEe7bscXqjVQMb++a/BalPtIZiWE9viKLrj7zpMQvfOUb8ZqBWkG50+
	 b/MCS3NJ+D3YrXUVyCESAfe6NoQPBZ+xp/BB29iL5C5DrJqWc6KKgzaPv/CTxL46KmhGd
	 p1Yulg9OwnRvPG5cbFlGq3Mfvqlh/QVjZW7+34rOIvjJXJlpf5rrcwVl9bxXeboLLRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793649221;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=6xc/z4mGViwNXCDInd4Dq6eMgtyQh/VWtUKTEtky+Fs=;
	b=wLPOK6CkW+9JF9SQTLGqiHN9u2YrGia1qkbIcKdT0dF2MOZkKlkxrr9px0r5lI4CgV1N
	 XcUP/LRDPwHuwN+pyerATSIGJabsQXDJz1LtNLSJ8okXVTjTwAX8B2iA5oK7SKke+J+C5
	 BGAKfgCfkdy37pdKcCtOoCTqIXH+spDw1foZk8QhE33lmKuVuakwJd2tFcP4VevcYQlf8
	 yTq5f0njJHgsn+Dyby+tdg5eUgWCdUbZ/xHVNL/t7LF66QlkXwF6NQmxOkI0D/TDEyssP
	 RN/47sWSj/02yRQrcC9NbAkBpNUfO04CnkMZa9P4tw1PMgVWcG8gHz7WF13lxhHtuCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=CZG30O0e;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C7D606EEBB
	for <linux-omap@vger.kernel.org>; Mon,  2 Nov 2026 19:53:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65C7D606EEBB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=CZG30O0e
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48df4f540ebso1561811f8f.3
        for <linux-omap@vger.kernel.org>; Mon, 02 Nov 2026 11:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793649219; x=1794254019; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6xc/z4mGViwNXCDInd4Dq6eMgtyQh/VWtUKTEtky+Fs=;
        b=CZG30O0eHcF47HD6dmaY2YcHN9EgyPb001GjtcfZ205JKhcdOmziqN4UL9ap9Xl4xO
         +gCMpO8Sp+aQAWjErgpSQvMRoDOmekLjOrqzm4Zras78P9UttQCpq+fZiNt9qQg9hNDs
         kcvhcsXlVp6bBlaO3RHZOnBBzT2MuJ5wxHSIzrTLHQ+lkMfqTjQKitU2j1xjNmNTwo9O
         C4EEhMEqBMaCZrbC403Gh8m82711y0quJpU9u5dJ34zFsyQIsUD78FMH88SCIPGgo99R
         ilTtyLjE4GFbNtLcgwO4vuJZHUkl+7oZkCiEuTRt/tgZkugTfXOpwIifo6fESTaiKL8U
         ye7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793649219; x=1794254019;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6xc/z4mGViwNXCDInd4Dq6eMgtyQh/VWtUKTEtky+Fs=;
        b=YBuaWhK22NKZ2q8PXdO0Pzlnn6i/+txtwpBGxiZ16jidFi7sqJZzbNnMpMAj2xNyFn
         c9QCeQGwV6Opntu+3Z+HeNycFTflXqVa6GTpRNaUJLCyR67TWc4Y5FZMw6CDzYefLovH
         ncbEVMxiaLxNt69r3CEM5J/wSfM5zl5ADtB1wPZWps2qLbSXq3za6U+fTPOAq91NSRhB
         uRm/LfDIuAypvdIfA0oPTijeSltCIBsu2dVbJwGQvtCBAwG3cO4K32hn2aVLYDDH79rO
         7D/TsQyceMl203oKs5qH0ipxeBecauGWsz7DpJfBEX4NOnC7nlzJqodI6APJoOK+sJKy
         0UGQ==
X-Gm-Message-State: APuU4Z//cWV6zkycbJPGFH9gIiylPfdlPsJEdDrwb1WBFh3+83HPpGgu
	4x6rAVlI6aDLF0WzyvaCFRJiLaLKyruRKYyQSZSnoAIv05W5xAzWGtqBjWNAikYuFg8=
X-Gm-Gg: AYBFou0MbVGEnuQFut6A669YC5+3BuOyMGM1DbOBvoameO25C+DMZceQQbx3x3ygCKL
	l0HsfSOBPRCxcjivXCNlc79cmDJKCOvUc7pv2wvmldCRZTZEkPHGY5RMM97rFya+3hio9v7LzY4
	4kQLBQoh/Gc5MpSdL7IJqsztb5hO+yOS2hAo6WwI6wrDcvysVllVFHfLjUpi5SmYTyoercOOjUF
	lSOYf18A9ugcIeFUZ4oQfutsv/48+2Td80YKbDXwNR+Sgc3v93S16COKHs1C9fKWtEV+QBN5eBi
	ZQS7hqGnNN0muEYZUoK/IlzfztSjpfoOa4Kinn9E6n3Ix9I22i+14QbLE+Io2KUcqG5z8e4z9OI
	lJGsmbIUTdiJaGkHCh8H8w9td7mwTqEa2pVnWGnWAftz3u49r/5M85o1BKbL1k6WOvzkFWYKdii
	FLsQ7ylYl82fSgK3Q6QfKIrF6ShdcV/oByWog18HbD/U1ZE2M/OWEiSpQ6NhFxJQ7Adp559V9XA
	hgP2O/iDwwMKnjaD7hkxmGewdcSPeT7JUfy1bbEIgZdNrhewwmZv5Ny9WyKEDKCx0s1G2qBzQCF
	2KqWum9Ax9mdBIjugxpUvzEYgkEQzJ5n00CtSZcjFXmq/YsIw8IZtGTIwQjGAmRd2knm0w6C9Lo
	KJCa05aze5UzkPkHhOP5DlpvdL/Q=
X-Received: by 2002:a05:6000:260d:b0:487:1256:ab80 with SMTP id ffacd0b85a97d-48e6e521406mr25540676f8f.57.1793649218827;
        Mon, 02 Nov 2026 11:53:38 -0800 (PST)
Received: from z13-ek5.local ([151.40.161.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71a4d3cesm24039784f8f.7.2026.11.02.11.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:53:38 -0800 (PST)
From: Ettore Chimenti <ettore.chimenti@linaro.org>
Date: Mon, 02 Nov 2026 20:52:54 +0100
Subject: [PATCH v3 8/9] ARM: dts: omap: dm8168-evm: Correct SD card pinmux
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
Message-Id: <20261102-patch-ektor5-dm8168-dts-v3-8-9bd6d1d128f2@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793649208; l=2155;
 i=ettore.chimenti@linaro.org; s=20261014; h=from:subject:message-id;
 bh=83Hmt2YYwsYCIfUczSaxPVDOXa1KO6SZNJLSBdpkV5o=;
 b=TLBdM1+sU+wTuaQpo94tDJqhnYNjg8MUQxSIk4PZnYVzOAOkVVw7lGekklx4Cq3Ehj9UD9D0n
 dl2n0uUP2tLBPCNhdpI91bIrVmPTfvcydc/9Amkd5hC+OuD442bSYeU
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
Reviewed-by: Andreas Kemnade <andreas@kemnade.info>
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

