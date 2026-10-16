Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7D0379C3E
	for <linux-omap@vger.kernel.org>; Fri, 16 Oct 2026 14:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792161688; cv=none; b=IWPdmJbq95QCOwUYxOaLFZU0xp/LSCczML+FzFRyMSMjlNscTvWCM4XSNW5k87I/s7e3+yaD3fLfmf0a/ngOUHqYGdc6rY8FBjsaAXrRVSJ5pGB7oa/F5Un78etmvSrASsR2NnArl46w5x30Nn4hTmvPDQkh/jJjaAAxdlUX3fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792161688; c=relaxed/simple;
	bh=rQYMzDtVh44VYgzn8ZF81rVqoyDsHoJv3ovI5wxNPaA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lXuF2zbL3K/ZtBhjK570M/YzhXF7V0r+9zN3pVoBsfKNrXsNoV8m4Iil6yYC2JVveUf7V2bjbieclrbYbQ1TTXfpJsjzPDgmrGxWYYbNOUm0KoEaTazB8g6lMMmSdeC3h01e02rkXgxIfXozIV8zatXke1aOz/lTjRiOnsOHnIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ULH+ggqs; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ULH+ggqs"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a1d665a5efso263995e9.3
        for <linux-omap@vger.kernel.org>; Fri, 16 Oct 2026 07:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792161685; x=1792766485; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pte3u3WxOgw3Qgy52tQrveaoQhV4YTR7h3cZS1HtB1I=;
        b=ULH+ggqsHjUAOiZdLsxQxRGfbE7CedKqmY0pprZ9bw+KNwL/ajYt3B1CiGPSvzlE80
         vvXIIh7Rlo+lowlX+oFWptW6aGwiMEDJ9pQLNplMqCF2vsEW+9WRjAWHSRSldB+OuWqF
         /CsfJVzUUlTLRdmUzPNl8j2+N8PfQWj+fzu3Yk6m5/Zt9QuWRZzEzmcYUfhBEbEc6qqR
         jhet7+jBjwQZi+X3jAk78ikLIroOL33chgIFHqXJ6XCG+Dl05UowFKiWxrDtOCus/xw6
         2ivxDfS7AJx+zrp4iwhoRXgLxn3BUMgwUcwBnLTTTXEsIWpGY/JZafApO5oj/h8N06u9
         xNOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792161685; x=1792766485;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pte3u3WxOgw3Qgy52tQrveaoQhV4YTR7h3cZS1HtB1I=;
        b=s06t/BdxD1jrzAljU8QDgSqXAM7AWWCivRqIieRMAtVylcOIyB2QVfU3Xwie3Sf9xX
         35O87oT3DTaY9cn79s7hXLc8dhOhHDis1QlP8YiAgdMHxdcKWXd9akf9mpWGFv2UWUXA
         twkUkeLdm7GS92tT7+RB3f9DO/44hQpiPPjMojlQiBuXvx8v+cF+eEzS9achEGLRb+8v
         Fvy7L9z16ibed51Nv6jHeOrWaYbst8g0P770S5CzZvyqeCv7bhOQJyiIhByg6ZsDLIbM
         /YLp6sMjc/nOIR9irGOR3vsiWwjTUAAbhgkwFZ62GchvrX1D3yBG/DCdR64rM8uCiv/R
         zACw==
X-Gm-Message-State: AFq9FYJFYLaUoqv70GIIbUQHvXhYO1Wlllu4s0xuVq7dRED8ENUEAd+Y
	nLijlsDqQF1ODxzTdEhhHdoRh7rQeDcY/iuThIDMBxzSHeBD9ZZI6INCrByn8LjhN0A=
X-Gm-Gg: AYBFou3xXZFsfqrUrL9oDTDFgaNbxKx++uQtNkgkLlV9+fP4zclB7bc+VIOZ3ymFaBT
	4qzaFFwa68ZPEJMa2kh2E6g2fDyDcqmKWJYRNt+sqIve3KUdLClnVxitXEs5UaFfnSe8bFBLVMb
	9FuHZ2k0wYIdhTjqnqdlMq34/v4ynCyF8mG9QQtvZSdq2pgF9/h7g3KlfAoDHxRDmLgBaPNnZV0
	tY5aKcw0KxE+pPwKICEGrVKzcL03/omv4KmARQNCCJtoMm/koi1ibwy8/lBmVGpE+wg5sjesFEq
	Q7ZaZtGHbS/CpMbPhmYekUW2JU3uegIoVSBNHkOKRw3mfK2NVSV+VmdL0LiG2rxY4AcBt3tBfyf
	coxR+09eLuZmtY22xeTdz/hcITr7ofwipjdeXQKRpWqhiI/MrlI9hrsWEvzvfeTAlaz55SvKJJN
	EYzeQuFn/L9GPrYYeog0AT5g9mcldLvQB+UIYhzD/HEBBebsbnhokuShY9HFYKuaSRdte15wuOO
	8s7MwGBKGvcSYb3/QfUMRFsoYG4ozsNq4/Zfk6crB5rLfP9vR3KGY/AQwjI3ewLBEIdaw==
X-Received: by 2002:a05:600c:1394:b0:4a1:d492:1604 with SMTP id 5b1f17b1804b1-4a1d75f2524mr381415e9.11.1792161685121;
        Fri, 16 Oct 2026 07:41:25 -0700 (PDT)
Received: from z13-ek5.local ([151.41.28.233])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4ecac3sm5949648f8f.27.2026.10.16.07.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 07:41:24 -0700 (PDT)
From: Ettore Chimenti <ettore.chimenti@linaro.org>
Date: Fri, 16 Oct 2026 16:41:18 +0200
Subject: [PATCH 03/10] ARM: dts: omap: dm816x: use dedicated SoC pinctrl
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-patch-ektor5-dm8168-dts-v1-3-b4ce30217028@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792161680; l=991;
 i=ettore.chimenti@linaro.org; s=20261014; h=from:subject:message-id;
 bh=rQYMzDtVh44VYgzn8ZF81rVqoyDsHoJv3ovI5wxNPaA=;
 b=3S50pMz7zQmvtFmL+2YZ1KgPdiCvRypjaxgUOOH+3aWGkFuLX2ipy1EzPmzd3M2yImYr6voQo
 syqhbr54WckBewNboAWAqmAJKY/GJNXAurDQYOCbAHJZBNcilzj5MjP
X-Developer-Key: i=ettore.chimenti@linaro.org; a=ed25519;
 pk=wCaUblFVaqhuBTQt/hAtysafsAaEsqj/yOD9SPlz6NM=

In the TI Sitara DM816x SoCs, the pinctrl configuration macros are not
identical to OMAP2/3. They are actually inverted between Pullup/down
enabled and disabled (third bit in pinctrl registers). Using dedicated
DM816x pinctrl header to differentiate between the SoC families.

Tested-by: Andrew Goodbody <andrew.goodbody@linaro.org>
Signed-off-by: Ettore Chimenti <ettore.chimenti@linaro.org>
---
 arch/arm/boot/dts/ti/omap/dm816x.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ti/omap/dm816x.dtsi b/arch/arm/boot/dts/ti/omap/dm816x.dtsi
index ee0090f7aa64..de4d48babf77 100644
--- a/arch/arm/boot/dts/ti/omap/dm816x.dtsi
+++ b/arch/arm/boot/dts/ti/omap/dm816x.dtsi
@@ -3,7 +3,7 @@
 #include <dt-bindings/bus/ti-sysc.h>
 #include <dt-bindings/clock/dm816.h>
 #include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/pinctrl/omap.h>
+#include <dt-bindings/pinctrl/dm816x.h>
 
 / {
 	compatible = "ti,dm816";

-- 
2.56.0

