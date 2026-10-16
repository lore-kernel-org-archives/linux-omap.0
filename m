Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FCA3563FB
	for <linux-omap@vger.kernel.org>; Fri, 16 Oct 2026 14:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792161685; cv=none; b=ai0sS3nLjzdXOHMXDq5WXjcFtKn7/mZO2+8kR6sr2mXpfLfz7JwFTXKdbMkexJFMqG6SAQzP6JKdShZFLgJ9esaVBjWy8rN0253XvYi7v/+LPp7XVgIpgv9lYxcV5GX8kk0091Y+VBKj149OZ9I3Wiq1r0c0/6SE2DKrDfP5yR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792161685; c=relaxed/simple;
	bh=WZNjPntmTxKB6PnwoW9tTwXddGro5Tl2X0NnzaRRwkY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B10Iai834cJWQfhVELcssy3u/ZW3WLVmg+WKkqWx1p0v3hYxiLoaBOLhi5pkAqNwW53aYftZ/HLViDraSx68vUXDk7s95BtQgAvtlRJRo/+a5WMKFqlVe5MdhGO57+EOfvUFJnkMBcuj8hHK6bTgd87/6H70rSrruh8rRbf3o18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MqKaD/wd; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MqKaD/wd"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48df0fa43c5so44556f8f.0
        for <linux-omap@vger.kernel.org>; Fri, 16 Oct 2026 07:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792161682; x=1792766482; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H/7VUpAGcux4fjxIdlTVJM8GX+izz1YH+HzRtvPUJ78=;
        b=MqKaD/wdSsX0fGn/qjcGxznbE4DDVX5Vuv/qRP9lUxDHhm5ra4oBvmEwABBF2UGKgy
         0IwFFzkqpXQtRNp2hcvXdL60Tlz5PMzMZBt/mn0WFgPUFapxtxHeqyqkadJjWGLapUTY
         p+4UcKzqeIuGv/QYiBfefFUE0bQ7ohA9g2A954GGIg8fnVuRaBDFuRX7YhwKHwADhGf0
         yApBytXdUuqR+Upt+uJH6SlplIabLkGbmiM46IEt5QpFiFllUXltW6FYjlfV2+DzMvh4
         v/9Dan2Zlt6Nbnj5D+lXuGwTCqY9eWb58Q0cnjBoq/q/tGUUE1TadR+MfQUAT5EW/BjO
         XWUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792161682; x=1792766482;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H/7VUpAGcux4fjxIdlTVJM8GX+izz1YH+HzRtvPUJ78=;
        b=iMJ4lkm5FzPup8Ipwl1rIqrmzZckBTzuynj92NMvuG9id69i8j35FCvZ1jxnEZzluO
         WkFCrh6YzvyP1uCMIBGDrG5JIp38+s08V5sRtJ/BL/QpF2bVx/ZJiYaWD6kQDbpwI5dm
         Z8Bdy4JTwvmMR2go+6FnU2NISnzp217qLARdVFmya1F0figOQTWCsrLGfvClxz/gOB+h
         EWWAZjnJmExTbCx2fxvczHrfYNlf853vfu3H2oox2elzdn2A7DtR064FMhGNoe1retGV
         GVMrtjuixRq1aqOlU/3ZFAP8+vP/FS8BaTE8gLmtiFyqsh2OMOahDoLqkT/pQMqGEEa6
         oT3w==
X-Gm-Message-State: AFq9FYJUCLrm0+f7NQ/sNFe6UhcoI/Ocx41W/bgHGzRKA8NVeDWjY9+S
	4ULy3NyJfrWB/pQBwWL+riyjn1za72UvZ3x4SlvcS9OyUDb4FJ8Vl7B1EmpotVuaWUzDEMEyAJd
	Uu/h718w=
X-Gm-Gg: AYBFou2ogktDRpXl4i5Lw8LQ962ZJPnjxZM75UjPJSo0lVqysFxTkjV82Xa5GQW2GkI
	gb7iKZEEnBvmJsdEqhpvIc5kSGjfHY+UGveYJutSxw0JGYvzXlninf2ppnLep5PrLSIFe8grMtX
	uhiQLfheE5l9o1ONS49aA+vJeW38AVeaM9UllJJLXSetgnT2FpMgVOplU6mqf25W2nc789y8BO4
	dEiiaoUYOLXnPuUMTtC+1K1sv5k6meH2rLF2zXuykeREAWlq+G1eUT9w4ghI2hF3Hsre94k6yR5
	QJAYoGY0NWkKg1IlMNqJBGjDvc3ehv23EqzV9i8cd3hAC5aC7xrS0PKRmXKHZ3UtqLUSBteKN6T
	7MGvLUVAaAY2olk9j6UVVA1c+QZbu6VhhApu0I8EyaevO8x5ZEaGdsS/PmCSc7SV1h/99MlzsZb
	fSf9F6nPZzhQ4f3+8RmzO6rcoLJ0Mhyo3WeBV2m/6dt3tL90n+1BhTtojgtxUva5jsAY/UxBjRM
	dD8TiKx4CLyDDzc+2N4XLrioEOT8Zarn+GXZJvACiwrZU0xKe5IbSOJvEkQZ5yq2J4ZKyE=
X-Received: by 2002:adf:edd1:0:b0:48d:f1ab:faf9 with SMTP id ffacd0b85a97d-48dfae1ee24mr6334662f8f.16.1792161682381;
        Fri, 16 Oct 2026 07:41:22 -0700 (PDT)
Received: from z13-ek5.local ([151.41.28.233])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4ecac3sm5949648f8f.27.2026.10.16.07.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 07:41:22 -0700 (PDT)
From: Ettore Chimenti <ettore.chimenti@linaro.org>
Date: Fri, 16 Oct 2026 16:41:16 +0200
Subject: [PATCH 01/10] ARM: ti81xx: Prevent USB being put into idle
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-patch-ektor5-dm8168-dts-v1-1-b4ce30217028@linaro.org>
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
 linux-gpio@vger.kernel.org, Ettore Chimenti <ettore.chimenti@linaro.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792161680; l=1058;
 i=ettore.chimenti@linaro.org; s=20261014; h=from:subject:message-id;
 bh=vkbGDt2t9O3PEQmqq3WpWoBfMDyf2l0F94OzzH0Lqck=;
 b=G/D+U2sPat3Xx8BIZaPIsfhCX1A7J15eqsyRChroWg78s4J3EXHdoTbuWHyx0L7PknTnAfqwn
 IH65RPB9BFLAvsjLEHx+wXWjp9HH1vccFQxAVZoS1qKHUm/WAA8zm1l
X-Developer-Key: i=ettore.chimenti@linaro.org; a=ed25519;
 pk=wCaUblFVaqhuBTQt/hAtysafsAaEsqj/yOD9SPlz6NM=

From: Andrew Goodbody <andrew.goodbody@linaro.org>

There is an issue with USB being put into idle with DMA enabled and that
is mostly prevented with usbcore.autosuspend=-1 on the kernel command
line. Stop the ti,hwmod code from putting it into idle by setting the
appropriate flag. This stops the log entry 'clk:0058:0: failed to
disable' being generated.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
Signed-off-by: Ettore Chimenti <ettore.chimenti@linaro.org>
---
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
index 9b5c728fb7da..2f55dc32e150 100644
--- a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
@@ -650,6 +650,7 @@ static struct omap_hwmod dm816x_usbss_hwmod = {
 	.name		= "usb_otg_hs",
 	.clkdm_name	= "default_l3_slow_clkdm",
 	.main_clk	= "sysclk6_ck",
+	.flags		= HWMOD_NO_IDLE,
 	.prcm		= {
 		.omap4 = {
 			.clkctrl_offs = DM81XX_CM_DEFAULT_USB_CLKCTRL,

-- 
2.56.0

