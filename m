Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69303BB9E0
	for <linux-omap@vger.kernel.org>; Fri, 16 Oct 2026 14:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792161687; cv=none; b=YUIXh+Ae9es7wnKpWEtuLPF7CbAG3VM+NehcDT46lafN620hh3Cqp2FcxNpjv1ryQ9ReEF7lw8sD/QqQvHhTWDAOiRU5xT4VKWnfFT+bWe8I7OV8qm/K2lEvEhktPhQCaSR5PUvWwCWBNt5xgRvtYp67+YeJq6WLiPWol3r97TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792161687; c=relaxed/simple;
	bh=Ldmay9QwO3gg+IGIDPYY4zVrqDjxeT9i+JqWgm/7kgE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gMDcz0x6K6ntJj3exB9FkUg3BYnmThZ0JzImBox6YyZpkQuXFWgXmNTtSmJhoQ5MzZF+E2D3AkIHiBbwdh8mUCbI3/yFwjuF4T4RcEDUo2xBNdut6lWXnVmoXEwlFXz+Vvnza1p/vveWt5XEWjYHqJ/zdDpxTnrXL6kZZo5+DPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o5m7nBNB; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o5m7nBNB"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48afcfc4bf5so1365055f8f.1
        for <linux-omap@vger.kernel.org>; Fri, 16 Oct 2026 07:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792161684; x=1792766484; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tKla0beewDRf+y6czDuhAfCVHpAbSKZ3cp1Ezxdtm80=;
        b=o5m7nBNBVTUX58PYxitBc2IxPcPEMPKiEOgPlNrQT5K4CPXnLaal6gANRn09plABR7
         dyCoU3cX0EZjmCVI0+2Riy6mxgHNkq2G/svUrzh7IaKz3tqG1xYsGmNV+sHDK43OZWfp
         +/EcAf/C4pHuE/FYz4gpujVqSe0EMxFUkAXKA1rtaGh/l5QugtTQGjNY1Z2ZpeDXVafT
         P0ZX1kVHnCclA0u4YOGH79nS3Ta4UKqCh8DBlISK9KFDCsIPg+/lGy53BgzlkeMyhvc4
         rz/cCu+GxQK9d3/ud7N/Vtz0MxO+lLDtkZ97fn9ylbnlaKDaRzr4o1yjAOwihyGIN6F4
         dmzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792161684; x=1792766484;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tKla0beewDRf+y6czDuhAfCVHpAbSKZ3cp1Ezxdtm80=;
        b=Ama8xF/cwH6PJpGhjj7uqUPFQ9fmQiAZCHUU+WKynq2T2gxKZ5i8bNVto/RZYa3xvn
         9HlvgpQXnloKSD7SKMlmW54NkPItVocN20KKJ3hapvrTdKJwZAWZH3PpnJw9XVh9ORjX
         fG2npzelvkR2ox+UqnWIbg3Gc5ikGiPpuJDWlzimsYPDbtmPq1tjizkymlsYVWxs8daS
         6uypw++635m3fZir1WfsgzMkKtmx4XcYZGxisEMFAtDZR0ds6IieembTHEGToxLQV1L2
         05mCVXxw5l6dpaFSeXLJVN0TUDe32Blph/P9rwaGu0A9qRe9u2KG0aOK6HUSU4D9XQwC
         3jtQ==
X-Gm-Message-State: AFq9FYL+dWorH/97NVy6olTrXxZmT226X/qkDnPsUuoV77Mo/lfNSDe9
	UfDGyUUB3Qr5LIybzMbXnu7N11dV+EV91xY64vZGeSA3fdYPxCwXZJGxScLhCwwTH84SNz60Aov
	glVaB0Tk=
X-Gm-Gg: AYBFou2KTAYxIEkQpZg5XttE72quTxRBqQeqhT8MQ5WPAs/DXrBzUfPnmvyDtV6FFMS
	YV+oWg6oTgXEZs1ZH4fAMeh/Er76y50a1xk9Yk7nB50NC98FhfA4GOvji+ZN5M7XaSizLHECUz9
	22kDXzdx3ASbbn9m1koJxLxHgh66LXuszd/TKLH4R5uB7IRULI3zwimEeJr7UK5j271qzLqLxgL
	XVIweF3u3tDvu8XNAjx/eG1D3t9ek1JIfBJCsGka7fdYBFTvaASj+zF020QRQ8GeP5tKSrw17DT
	fW6ggrHpawtivRiIHvIMsaSzcXWBN/qL5Rm8OjVQRwB7Yb2YHVpxhU29GUd65SeqfUNjjtC5kkM
	pLcBIAjXhIe9LrQH/ME4bt2uyw1DpptQrhUntlMKS3n7u0pYJniBqLhw+CqatJcyy3GZTyPgxba
	YWRPWtIXFF3B/C7kTo42IPYDEta7ysdBCX7Q9CSMiNS6R5LmTWIzlxeAUBwXmS8Ah5GXfaKrzLM
	5nL9e1264wDIK58spujZwts+8rAIbDWOLN+dRr5cwHHY1kjkalPAiBmYNDPuYIK/BEphw==
X-Received: by 2002:a5d:59c9:0:b0:48d:f58f:c91 with SMTP id ffacd0b85a97d-48df58f0dadmr11842710f8f.19.1792161684079;
        Fri, 16 Oct 2026 07:41:24 -0700 (PDT)
Received: from z13-ek5.local ([151.41.28.233])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4ecac3sm5949648f8f.27.2026.10.16.07.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 07:41:23 -0700 (PDT)
From: Ettore Chimenti <ettore.chimenti@linaro.org>
Date: Fri, 16 Oct 2026 16:41:17 +0200
Subject: [PATCH 02/10] dt-bindings: pinctrl: Add devicetree bindings for
 DM816x SoC Pinctrl
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-patch-ektor5-dm8168-dts-v1-2-b4ce30217028@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792161680; l=1087;
 i=ettore.chimenti@linaro.org; s=20261014; h=from:subject:message-id;
 bh=Ldmay9QwO3gg+IGIDPYY4zVrqDjxeT9i+JqWgm/7kgE=;
 b=66GZw7iCsiX/A3jlcZvBstNeIKCIcwPkl/zB0PXA811CviVeXsTSD5ExJbsaK9vOJ/ACie66C
 jOHvBGugEGNBh6gznhogp46BBqamrLpOy/a6hSFeItYsAo2Cv4BVwW0
X-Developer-Key: i=ettore.chimenti@linaro.org; a=ed25519;
 pk=wCaUblFVaqhuBTQt/hAtysafsAaEsqj/yOD9SPlz6NM=

Add devicetree bindings for TI DM816x SoC pinctrl configuration.
Using same definition as OMAP2/3 except pullup/down enable macros, which
are inverted in this SoC.

Signed-off-by: Ettore Chimenti <ettore.chimenti@linaro.org>
---
 include/dt-bindings/pinctrl/dm816x.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/dt-bindings/pinctrl/dm816x.h b/include/dt-bindings/pinctrl/dm816x.h
new file mode 100644
index 000000000000..15aa15bca9bd
--- /dev/null
+++ b/include/dt-bindings/pinctrl/dm816x.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * This header provides constants specific to DM816X pinctrl bindings.
+ */
+
+#ifndef _DT_BINDINGS_PINCTRL_DM816X_H
+#define _DT_BINDINGS_PINCTRL_DM816X_H
+
+#include <dt-bindings/pinctrl/omap.h>
+
+#undef PULL_UP
+#undef PULL_ENA
+
+/* DM81xx mux bit defines */
+#define PULL_ENA		(0 << 3)  /* Pullup enabled  => 0 */
+#define PULL_DIS		(1 << 3)  /* Pullup disabled => 1 */
+#define PULL_DN			(0 << 4)
+#define PULL_UP			(1 << 4)
+
+#endif

-- 
2.56.0

