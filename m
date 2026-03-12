Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37535365A03
	for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2026 14:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773325039; cv=none; b=HXiiifW5Gwy4U+FHDw3HIOkjYwDCSipp9LYNX52dl7EXSntxQ+TSb5Y0JXcSGXt146fs8IYHgEFiLcaGnbJtWL6x82VxBTqPKVKWP57QwwYnw6CYRyzNb496ybSgeVFTJtdLIx9JYc5Xf0mkLVaZQ8PPv4XYhil01jxX5uyZHeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773325039; c=relaxed/simple;
	bh=SARy8VEzsEDdpJbYNnKTnv8sN+N/AGYzaEfpN1XAaEk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Eqqw6nyyQHwNTazfDeAUlzVv/z23M8t++pb5N7o/nhihYqbDcrIbarBfebQW8jr6tPAG+lWJ8EtoohhtSKn8vI6jDC+4rtr+m0yqNcQxEzPKqXvWB1P7Gu+Vp/ks5ro12eZ8ALOf2jITRO+c/PT/pMC3SwO1epWL8C2QqeT8KvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IEQCmaNJ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IEQCmaNJ"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso10038205e9.1
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2026 07:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773325035; x=1773929835; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xr82Hs2jDNHg3VJOi+/ZysrSfr6DqCub9a4ab2Pxz4I=;
        b=IEQCmaNJ7dNln0Y/hR0XH2ivzF9DOdNz+9iB1NAJtD+MKWUu5XP9FSGPuNNF13XGCU
         QgQ5NDJ3xWnPMLOt9aaYmpCyoCFexo1ttVJqyfOW88y0IGzdKMksZbr9rtrl2sC5/85e
         P7WW3h5j3nT5KeIu13mjF+jl+mbv37sULnwvLBcl4Vf6IeYd/mEH5E6ltmMtxqkpxUG8
         yDnVYuSm24YmLbB0mIUVSHt6NIyb/HFi9UQE6g6XUzkE1uUNcUjuPpcdCuYPxShRovHp
         vXxWhMQtk2c6tNdayUYsC2p/hd3IXmFrqysz8F4QF/42VKnH4+2BVh7HDlXivC3D80ws
         3abQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773325035; x=1773929835;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xr82Hs2jDNHg3VJOi+/ZysrSfr6DqCub9a4ab2Pxz4I=;
        b=qn65x+yGcpu549LXRVN3mf5moGdQVB4SDxAKGPNuuZj0kHNOv63tRbvqdzukdz0MK2
         88SdwEuAfGJrseUi9CZApQ31XolDgDuDgXbe2C4zL6loX0mOQESY9v0Xtrouft5rqEFM
         qzdfYXKTanXGlUAwKwCHdrcU/RzBSWHbS68eA9KNLMBlietr/2BrA3v0oYHHC/lO83qz
         Ryuwiz4uCq8K5KcBIqv6GaioMp4gMDlgN0Kn8STphSiFXPCPe4g+IlmMygFjWRM9kuMe
         8iV1DSZzYMTjVB+6NH97JM1TaP5oVr3+A4LAXI4wuz+FIW/cMSF/mzau5mVisrpmxP4q
         5OBA==
X-Gm-Message-State: AOJu0YwFsPqHaQFCIVyN7c1UNBRuHHsqfl4C2DORn1TG0CKRNVkknqr3
	tdDV42Ka44RCtEz27yeEY4JT5IlUIK0OJEWLfPxI3FZ8lLs/Z7oVi9r/50IhRH4Tehk=
X-Gm-Gg: ATEYQzxtAL5l5nqzU+FcFd6rnbyrUn7vojP6eh+nvIyJ76LybIeTrWovWWq8wZT3OYs
	u4rme81rNf4UaAkhCid4QTjkiKOqUo5sy+bgqcC+3FKWNca4nMgSBRBLUe6JcTetUQHIEhWI2qN
	viVfOKm27DejIV9rZX5p5JCSpJxM0elmvqE9l+WoW5VNjnMG8H0xWvLDx1EqeTwNIQKgHzg5dQr
	sNtRUFnRa62RiQMO0y9Rs78kAoLk/3zOsfIE+0k6oDBWZopp5ZLD2/Y9gB7UylGQSHTMv7RFVih
	AoIyApAns1r242Fkig5hNN+gU2kKUEPrXWOCc1pA44gZNnEuZE5UDdcYt2QzX7rVNo/xmLGVvTV
	GgPki0Qpf82d53dRS1tJBUvcW6Jr9HoWXajTTF2v59aGs1OzOQjlIe1R7eLwUax5yMf7vT15CpB
	mclRWL9ZYeqUFdI65BI/wE44VlTFOPuLlj2wVyzp6nquDpQ14U1ss=
X-Received: by 2002:a05:600c:4512:b0:483:64b4:79da with SMTP id 5b1f17b1804b1-4854b124e7dmr108714785e9.26.1773325035381;
        Thu, 12 Mar 2026 07:17:15 -0700 (PDT)
Received: from artemis2.elfringham.co.uk ([2a0a:ef40:eeb:3801:59ff:f478:8b7c:4ecd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe19ad9asm9407142f8f.7.2026.03.12.07.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 07:17:14 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Thu, 12 Mar 2026 14:16:57 +0000
Subject: [PATCH] ARM: dts: omap: dm816x: Correct pinctrl register
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260312-dm816x_dt-v1-1-ed3370b20799@linaro.org>
X-B4-Tracking: v=1; b=H4sIANjKsmkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDY0Mj3ZRcC0OziviUEt3EpFQLC4s0Y3OjVGMloPqCotS0zAqwWdGxtbU
 Azv3dUFsAAAA=
X-Change-ID: 20260312-dm816x_dt-abe888f372e3
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Christopher Obbard <christopher.obbard@linaro.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.14.2

The delcaration in the pinmux device for the pinctrl registers is not
correct. These registers are actually 32 bits wide, not 16. Also the
mask for functional bits is also wrong. Functional bits are 0-4, not
0-3. So the mask needs to changed to 0x1f.

This information is taken from the TMS320DM816x DaVinci
Digital Media Processors Technical Reference Manual.
SPRUGX8C March 2015

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 arch/arm/boot/dts/ti/omap/dm816x.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/ti/omap/dm816x.dtsi b/arch/arm/boot/dts/ti/omap/dm816x.dtsi
index 407d7bc5b13a364548087dd5fb2659286bbd8537..a1e0e904e0f05cd725e71da70bffbde2dd2b2e38 100644
--- a/arch/arm/boot/dts/ti/omap/dm816x.dtsi
+++ b/arch/arm/boot/dts/ti/omap/dm816x.dtsi
@@ -94,8 +94,8 @@ dm816x_pinmux: pinmux@800 {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				#pinctrl-cells = <1>;
-				pinctrl-single,register-width = <16>;
-				pinctrl-single,function-mask = <0xf>;
+				pinctrl-single,register-width = <32>;
+				pinctrl-single,function-mask = <0x1f>;
 			};
 
 			/* Device Configuration Registers */

---
base-commit: f90aadf1c67c8b4969d1e5e6d4fd7227adb6e4d7
change-id: 20260312-dm816x_dt-abe888f372e3

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

