Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E8F3BB9E0
	for <linux-omap@vger.kernel.org>; Fri, 16 Oct 2026 14:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792161689; cv=none; b=XaoEUBQvb2opvoasl76XHZGBBDLZDxCnyEHjIZjcKLOeeLeNL432+mo8NIUDT8tHF0KxdsppcndePR1otGIId9xC0GXq0B//zO70JRFlgHW2nWgzhU3qPyyLQjYbChtZ/uNchF/wPvtWgGpS9Q1e9N7e0jY84x0Vuazf15ZfyYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792161689; c=relaxed/simple;
	bh=nesVO5b+FMOoHD3j2mKVeLRcR1Mo8Kg9GRD2c+fFh+M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PuRshKBedMGaU07aeF8DWk9swi1m6Ry6W23oGZMJp1legnG5QJ5GzG6wtzHfmwJKjFO3CX6LuJeXLiBbAnD8O0qQu/+Q8VPjVt9Z4fPYRS2YN9lKL5aO2/xLlKkqBz56/cf5CC8y3GZvo5R4gjQ/tVkBJTN2mbhHQ4jb/XJKVpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F5kGl67a; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F5kGl67a"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48afcd7ba9bso3711896f8f.3
        for <linux-omap@vger.kernel.org>; Fri, 16 Oct 2026 07:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792161686; x=1792766486; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9nKpbbRcagz/95Xy3I3HJP6MXZuF969V/i+8+al+dGw=;
        b=F5kGl67aJmD7/MqgHhft717hHD37i86ozhU0uhpHHy59Np+sp7Ll2jsO/09OZnRg2p
         qn3u8fH51Kd8kz1XPEfsVvWaYPaoD2RMrMrdlR45HDvlp0eylnzzQmVQW/E+be8zqtzB
         b/M6f4jWrOSS1RCfjbQqbdHC8XMEy1nXDkR27BlvdcDg4YgiwODQGOmG6OLVE+9U6cV7
         TtNB601/CWbBbFq5ul/SaMDCNQ0Hy6z6q5K9jEX05TQZLk1xP22Jcmnz8mQWykyusROE
         bcsIfnyCyb45q/ZJKekQXZrGZMdtkB/XdzKrpwmxDmQXQE1GK9HS/Uud9yB7DI+sBT2q
         KoQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792161686; x=1792766486;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9nKpbbRcagz/95Xy3I3HJP6MXZuF969V/i+8+al+dGw=;
        b=c/8iqLk6d1U1Qtz3J9tZs3nfSjK7iQWpy9pzEgtRP11xdp6lvKNlsmen8+edSonHQ7
         SCDWBZntkjUjVaPapZzY+dotqbXmTcMsDI4GWwKftg0QIZ4CQxLLuVBU8FvJSHEUVGkB
         LB6NmM1+2lcPb+JZostH5pf/6etps5iDf5EgeLaGj41phCBxclG5ugzxS8XnUNL3q7lY
         uPMCo6MrcizPAcP8O2BBCxmc4ZyQXLDKOK+jsIcqrd0ApDptGUyrQR/VZSteoGOsDKfZ
         1avbY6MBenjgDBjFeEt7Kqj5MSAPzWIay1cdfVCrHlNljkPZtasgS/MGSqqPDn24npad
         tzlw==
X-Gm-Message-State: AFq9FYL39uHOQHFCvyxYZjbJ8f5vs6+Mo9ZiR11RYyAP8E4YEjo+UQrT
	xjiO6ccfu13N6V1KbEVJIk87TGgV3oCXLipK+j3dE3e8ugc9qGOJbOj+iXmgzTokVRg=
X-Gm-Gg: AYBFou1TuxLDVdJYI44szHXLuz53M5ldR9YGi8NTt6IaUF3+RinOp9NX4837fyOpnaA
	0GZBTYu9bURD6vgHYR/wZ7MQ9powBT3UUeMTd5K2LPWsibORuh7duKwdBprLKVNKLmtiraiuqjr
	x1E7Ogrr+/6XphmLK9pE4mbuD08aeC5HMLEVTsezrcmbwwwkx9HYpCQqYqvxyhjPMVEr5fpyvQc
	dQXoMGfX4ZMEh+yLhRkpYXk24RXgkD0z+zHsryT+uAiB6tj/ctNrhZQEtYvWHj5tLKNhalrJnM4
	Mq0bHcyHBN/64cktFjbTCPtlvOaUhYLqrt03nDTV/HM1/zZ7qH0z6gIavA1F8qgfom+T82micB8
	wPmH9c+O7h+EOw216O1ChucvYGnnDEiNss+QaKmUVRwiSG6SEi8RxVByVDJSPoOUG1mO9xvwSbl
	DGru+vTOZLFCB0A0A+xuFlce+O98rzJjcxys9pgEP56QZsJ5H5chyVzWndTw8FWnYaR3T/ziAWW
	6M6+A/1OMIx3TQERlOq0SNelQwNEoOkCdLAM+wni6IskcvYdx/RLfSjwIaut0Yg6d/LlKiHq/2A
	Aw39
X-Received: by 2002:a05:6000:4310:b0:48d:ef7a:e59f with SMTP id ffacd0b85a97d-48def7ae6d3mr16320685f8f.17.1792161686279;
        Fri, 16 Oct 2026 07:41:26 -0700 (PDT)
Received: from z13-ek5.local ([151.41.28.233])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4ecac3sm5949648f8f.27.2026.10.16.07.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 07:41:25 -0700 (PDT)
From: Ettore Chimenti <ettore.chimenti@linaro.org>
Date: Fri, 16 Oct 2026 16:41:19 +0200
Subject: [PATCH 04/10] ARM: dts: omap: dm816x: Fix pinctrl range
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-patch-ektor5-dm8168-dts-v1-4-b4ce30217028@linaro.org>
References: <20261016-patch-ektor5-dm8168-dts-v1-0-b4ce30217028@linaro.org>
In-Reply-To: <20261016-patch-ektor5-dm8168-dts-v1-0-b4ce30217028@linaro.org>
To: Paul Walmsley <paul@pwsan.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Christopher Obbard <chris.obbard@oss.qualcomm.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Linus Walleij <linusw@kernel.org>, 
 Rouven Czerwinski <rouven.czerwinski@linaro.org>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-gpio@vger.kernel.org, Ettore Chimenti <ettore.chimenti@linaro.org>, 
 Christopher Obbard <chris.obbard@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792161680; l=1218;
 i=ettore.chimenti@linaro.org; s=20261014; h=from:subject:message-id;
 bh=v9YLfutCH496XMWZUUrGKakURi5WnlthJdHwA43Dlyc=;
 b=KmXjd5n+++ZyEda3KXujKTa1Z83U7uC/nkp9jH+tQZUgpwg9nc1vAtNIf1S5HgiRFvr4E1LHP
 r93ByMs+fqZAzTXD5QsHto+lcEIDxIip0Y7/KMFlxK6N+53Zi7rMIRQ
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
Signed-off-by: Ettore Chimenti <ettore.chimenti@linaro.org>
---
 arch/arm/boot/dts/ti/omap/dm816x.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ti/omap/dm816x.dtsi b/arch/arm/boot/dts/ti/omap/dm816x.dtsi
index de4d48babf77..9c9d5e296e90 100644
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

