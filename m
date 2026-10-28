Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793203588;
	b=35UM+Q0aIZcza96AkkUN22f+dGMLyUYqnAz+YcllsWkeXE8uPYbZxo+ifWh5zuO7NL/i
	 KWVPklFP9ntAE/TRml9ZQNpF+xVqKe39+sCxO1ROPOLZjy8reljlWePN9Hzi6TtBLt1dD
	 1HzBAcHukPe+YcPmGv6k79GsrlLL8x9Xz1+DIaxxuAnZmvhQOCuRtRkdjqIIYvyG5PdJi
	 Wox91wSIzYKdvjjqV5vVgsDoUh/HzMSzpgUuWRO2BPBb1J7wLdPMCiBVdEeTz0WDZ6iah
	 1HEqeuhPHqt7mefJfYV/aXHUh0H37W8G8NHfxCdDExjvYPkWzESvjNABeyA69HyqLhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793203588;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=4A7a+lLbAYsA78ZT0ERLpUjSwA13WWgnKlHJO2aUu+k=;
	b=GBhHrYTuwW8xlL72483GO9uKaTdrC+8LhFlTZs9iQ4A+nfFUzj/NugnZ6WzwcFfRbxIs
	 KFWygt+qlCXY88g7AL6T1UYOsav30CYRDnCQ5pLc9DcS2X+EH/s0UYw+AxYkn2D/2O0Cq
	 mU7YJew1m8SDAn88GKjiq9/OSX4JXAxl7X2MmYoWeVhWAIKHqzLoU5ovXEphSOczoBrGB
	 fsaxE61Yv3bYdZOjiZKg6MFUEojS7rDyH/9rSqiis8I5K8JM2ENR6UklnDVv5jnB8s2de
	 q1DuCtY9y+6AFymGl4d4FwQF6TP/NVjPqEOm92DketfXO1HRijPZXf/EFXPRaSZQsaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b="f54qcOC/";
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C88B606B24A
	for <linux-omap@vger.kernel.org>; Wed, 28 Oct 2026 16:06:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C88B606B24A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=f54qcOC/
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso12064245e9.3
        for <linux-omap@vger.kernel.org>; Wed, 28 Oct 2026 09:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793203586; x=1793808386; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4A7a+lLbAYsA78ZT0ERLpUjSwA13WWgnKlHJO2aUu+k=;
        b=f54qcOC/BNNPwNgviROshFOqzIxuWEsty56PgH1QsUy0urArJbS6m8tOujoIIck2uh
         HEKjYJgDS6gAZxhF3RcCvii0/r5qk6ySKJv1OO643paYjrBMTkgd8Iji+CLMgS+nayN+
         tbfotU49LGIWkEUPN8cqkpw0fz21tXTSfmBI2e22W2Vl8ew2kBxo68GuXPQ5SMAVQ2Mq
         Tg51IU7bIFnZdCOXB4UApuCX7LUY/KW3TIg9Yi0EQWnOozXKcih+sWbH1QMd2mXtx1xl
         Oc7Zqo3fDYQPPSMi74tFDN0QxoM3CuiwH3OCbijQB3qwSJoLhBi/R7VhhmkxB3yxvG9W
         xHDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793203586; x=1793808386;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4A7a+lLbAYsA78ZT0ERLpUjSwA13WWgnKlHJO2aUu+k=;
        b=m9xOUmjdazGGIVwHrbivt+HMkq1XqAwQZSqLg2HyJqH4jHt4Cqd59905aSeysQfIjA
         wk4+nftnLg2v4goDZC+zt3PlhA5pSU57ZQm9bcyutAXrw7bBFPRYyt7j70nGTg2QrZBu
         E3EA0ywUVhK92QZ+pyywJW07cPkXHetURQBx5TIHiAlCS/YIrxHzBiiE7EYhsptehz7L
         lYhsA8ldfoPmmz6TDOmYgyR25ii1xTKFUifJeY5HVlXZDo5cQ4hwh+sRrJs90chJa1Qa
         7iexvdK0AdQ993W/3LNuaEbUw1bDllnF/gVLAZPooKH5aO3ZePSfwVc4u434UDTl5uFM
         fvYg==
X-Gm-Message-State: AFq9FYI+z77Tf9zBZfc904NMyMyAMA3wmLQlYu+KGpTXJMfkIwN1u2qh
	xipRMRnG5YeFIO88v41WPcOPXs0UJiywgDgNxXCx4TE+lozIBctUh2mHyH7XtET36uw=
X-Gm-Gg: AYBFou3e5xXURadAkbU4LaaspQCC9YSQfT3LtxzKIDvbFqAJNQI0ZsSn6PzfdpFQex6
	7dHlQ53uhrhI7nYZGUzuagWh2C8Ji8xDrR5sxK2YDDc1o8/wTBxtzRNOGWTD9p9ijCHFFeAoSHP
	HNnkPdAN1LQt2F5LVD+CT/gRplH7l1qCiuntT4BhbKFAjwSKcz2xgKRfbt3+kngdclbq8ZzScjm
	T8gHRafOEtJCwP0MFRrPT2FEDoVllbbJ5STZvOvBNCEBoWZY8m9211yza/bWwaZeWrdhM5Exgvp
	Fiy94hq96oqJc2+n87OIGqchwXMtvK1IPOFZOerp9XnP526xcg+MWF5/r6KeLwMlgPCdJYA1jgr
	Wjj4UCGVa9yVPfrkCAyhiLYg2Md1YgPEeLIpWJXVSredGEOs2RLAcORAoGwhV5jIbXbRFeoKdI8
	mrrrfoH3uT3vpDErNf7+NCUY3Anvr/EZZXGSwBN7DCTRnWu21KPQrNpTCt7DLOqZewgALFvgqUI
	A2bc8H5wWU/x7A8xjxzS2YWNsSVn7S4JIW+xeFSuVNg+eU3KamEI+4Ul3Y4TjGG5jFlGnIZ397u
	EXMgO5+XOLrOUCystkrsBDqSoyk/IL6/BsMJJALh78uXIbfvecmhAChpHSt7IGFbQ4fb6Exzi8F
	L9LWZfSuSOtfjYEHzevOUqoG9VQ==
X-Received: by 2002:a05:600c:4f89:b0:4a2:1612:637a with SMTP id 5b1f17b1804b1-4a966c4110fmr63881135e9.16.1793203586322;
        Wed, 28 Oct 2026 09:06:26 -0700 (PDT)
Received: from z13-ek5.local ([151.40.161.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa81a896ecsm1625875e9.9.2026.10.28.09.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:06:25 -0700 (PDT)
From: Ettore Chimenti <ettore.chimenti@linaro.org>
Date: Wed, 28 Oct 2026 17:06:03 +0100
Subject: [PATCH v2 2/9] ARM: dts: omap: dm816x: use dedicated SoC pinctrl
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
Message-Id: <20261028-patch-ektor5-dm8168-dts-v2-2-4544429251e2@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793203582; l=1104;
 i=ettore.chimenti@linaro.org; s=20261014; h=from:subject:message-id;
 bh=h6W1WAoyAkjjjopOOo1a7vzZ6TBDQswOUA1Q/6FeKLI=;
 b=gvU6qdCGfmNuZ9+vLONQblCUNyQ/FTfMv29wXGHB3AHN77+6/hhoHgJy+LfWIKEOD86B1AR7Z
 Hk2Azj1uAdRCsEawkL0a93nWsHJgLJT0KXiPrySo2NVpfiA6SqFhUl5
X-Developer-Key: i=ettore.chimenti@linaro.org; a=ed25519;
 pk=wCaUblFVaqhuBTQt/hAtysafsAaEsqj/yOD9SPlz6NM=

In the TI Sitara DM816x SoCs, the pinctrl configuration macros are not
identical to OMAP2/3. They are actually inverted between Pullup/down
enabled and disabled (third bit in pinctrl registers). Using dedicated
DM816x pinctrl header to differentiate between the SoC families.
This changes the effective pull configuration of the dm8168-evm NAND
pins. Tested on DM8168-EVM with no functional impact.

Tested-by: Andrew Goodbody <andrew.goodbody@linaro.org>
Signed-off-by: Ettore Chimenti <ettore.chimenti@linaro.org>
---
 arch/arm/boot/dts/ti/omap/dm816x.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ti/omap/dm816x.dtsi b/arch/arm/boot/dts/ti/omap/dm816x.dtsi
index ee0090f7aa64..261ebca8863d 100644
--- a/arch/arm/boot/dts/ti/omap/dm816x.dtsi
+++ b/arch/arm/boot/dts/ti/omap/dm816x.dtsi
@@ -3,7 +3,7 @@
 #include <dt-bindings/bus/ti-sysc.h>
 #include <dt-bindings/clock/dm816.h>
 #include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/pinctrl/omap.h>
+#include "dm816x-pinctrl.h"
 
 / {
 	compatible = "ti,dm816";

-- 
2.56.0

