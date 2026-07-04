Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDE239446D
	for <linux-omap@vger.kernel.org>; Sat,  4 Jul 2026 07:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783150765; cv=none; b=SpNc3nh1iAyfQbVxUF5ofRvsyhgM0cncy469KPE5X1snP5OTKnJB5lEDuh4cJ04JsWDJTbC1/RzVcZ5gfZKzRpuQ8+jOytJ2T11FDLYbsTebt8zbvMZnHugyKxhYfOBWFyOmdcPLnyA9sAPGLAx7Wc4WLMZ3Jd1K8o17CSPNdKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783150765; c=relaxed/simple;
	bh=Zy71/fJ74FRfR9wQcyuWyoy8vYdmBl8U1Rx2deFcctA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bX8bvPtcimCbDJ3jztxh3n6niNpVT8WJBpUd+ZJWgrnR2qHzqkp+SqLkaVqZhWYBmCMVbLcNCWKUt4pU1v/Q47k30iyQ9j1TjCjWeXrGkK2se7924Q9EwCBSlTMD+BfvtfHcdthdqtN2WD5ZEOq6LaUS/VZJZf+IGFMogGPnmbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gcLvoWZn; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gcLvoWZn"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-476d8e647e9so1158766f8f.0
        for <linux-omap@vger.kernel.org>; Sat, 04 Jul 2026 00:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783150757; x=1783755557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bI47Dpz0RBIpr5k7Gwsk0lZ7yNT7k5Nfr3De7ezpTc0=;
        b=gcLvoWZnA8//jfq4fnf7YN1picdvuNsL1yvJaetALPyyebcjtolT40+p2iJYjOvsmq
         FtZ+6BzQl1FJ85gNVkyCBeAgten25ynRxFqDFCoeHqfS8wLWYrgyw0dpVzDlBckGRNL9
         Ua9sK3cwYpNi62Z0NMRVHupbpM2pe5SgI405RE0p/5hG6ULjj3MDIxMNCfo5S2HBgIBz
         g5ayx60l3kl2A7xQb8pEQbWUm8MwPb9zxDpU9/XNTHjwl6Qy4x554Vg1YfS4hx8eM6fb
         FzMRV6CE4nfDx54BGlpX5RjXYtfXfEVkiPmVmZoI3wqwWNYa1fLzOPtIJve5dv3BrNZx
         LOwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783150757; x=1783755557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bI47Dpz0RBIpr5k7Gwsk0lZ7yNT7k5Nfr3De7ezpTc0=;
        b=dcEsBGkX9hm8gCDRmiATwHd5hj2Bu0bUOZ8UgYu8kYUXji2sUeyEWtmjnk149Nr6Gy
         KkPR/xwXZi36M2HlMilXinoqkZ6Nlq6C+pSC/exJXQldhOtM8AnBv3o9TvKFnXpEfgns
         lsxAdd1vUnbsihxT2P2zhgXNsyWbFnojmRqY366OQlr3na2u0EkMTeQY2YnuFwZ+GrF/
         xLDhpbGcmm168JQLtwVJlfD8u9VUGbcvideEZlkmtQR/8Frs/9riOu7ML9jMUh1Vb/pp
         iJ0Ezr1GgTlX3tkx+cSJRFgTCL54JIL/pSVusJ8asQlprDsCco71fQCphTY5Jmpog5Mw
         IU1g==
X-Forwarded-Encrypted: i=1; AHgh+RrIYAXeuBhseKf96HRqaFk3pcGH6/yKR7XhS7FAX8R0Or2YNboG6pidE6RCyWVTrcHQAl+wnM5gz7ro@vger.kernel.org
X-Gm-Message-State: AOJu0YzLBFtc4gb/pOiOxUIS8zoXRLXeKIkbZknJRRci+H2SwkbLXtM7
	a+vmrVtCHa8DQK447fYUdEOR0rUQi9bMG/y+H/d1UzUAAhumVImcGhxd
X-Gm-Gg: AfdE7cnelZPly/bhSnyU2u00iifRwrAIOm6sPa+pvWQTqnyUv9qP3oKVQdQVPc8U13S
	LrJokl3i35qgEWY2Ui6+SzKuxFUEVCDGF2D51DaudP9q1iABcx+F4cWZEbaTxBygeiGIXWVh9Ci
	rFtd5O5pmy/QPgrS/FkPmx170/qwUgQYPaZmPgxov7yU1AfCGHKjj8c3drY5JZC530IgYl7qiVs
	G10b/jdpQXjohusTMU08Xvoi+4tD0Rt9W4QnYR7a3wyOEguqmQ4ELYZyRwYS/0kAeQxxYODYmck
	IAUek+jhvcZPUrv3fL2IuT23Q4c73xmj08EYhMmruaOSEyleUi6rZk5j8efdyboZGXwQ8YkcK1t
	oVXELY3zf0ReM+Wo/cwunBXQBgUc+u0BgEEmQqWW3X+BADHLlpIuoUYP7Uk5012+fUMUhHblZ27
	1VRNkg/n3vkxww01jlOtelpiwhpBEEjLLHtw==
X-Received: by 2002:a5d:588b:0:b0:471:2631:9d7e with SMTP id ffacd0b85a97d-47aacab5251mr2777565f8f.27.1783150756651;
        Sat, 04 Jul 2026 00:39:16 -0700 (PDT)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1e736sm6565488f8f.7.2026.07.04.00.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 00:39:16 -0700 (PDT)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH 1/5] phy: cpcap-usb: Prevent line glitches from triggering sysrq
Date: Sat,  4 Jul 2026 10:38:39 +0300
Message-Id: <20260704073843.1750458-2-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260704073843.1750458-1-ivo.g.dimitrov.75@gmail.com>
References: <20260704073843.1750458-1-ivo.g.dimitrov.75@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tony Lindgren <tony@atomide.com>

We can get random sysrq events on switching from USB to debug serial
port mode unless is temporarily disable sysrq for the mode changes.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/phy/motorola/phy-cpcap-usb.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/motorola/phy-cpcap-usb.c b/drivers/phy/motorola/phy-cpcap-usb.c
index 7cb020dd3423..c6cc8fce6940 100644
--- a/drivers/phy/motorola/phy-cpcap-usb.c
+++ b/drivers/phy/motorola/phy-cpcap-usb.c
@@ -20,6 +20,7 @@
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
+#include <linux/sysrq.h>
 
 #include <linux/gpio/consumer.h>
 #include <linux/mfd/motorola-cpcap.h>
@@ -413,7 +414,12 @@ static int cpcap_usb_gpio_set_mode(struct cpcap_phy_ddata *ddata,
 
 static int cpcap_usb_set_uart_mode(struct cpcap_phy_ddata *ddata)
 {
-	int error;
+	int sysrq, error;
+
+	/* Disable sysrq to prevent random sysrq events on line glitches */
+	sysrq = sysrq_mask();
+	if (sysrq & 1)
+		sysrq_toggle_support(sysrq & ~1);
 
 	/* Disable lines to prevent glitches from waking up mdm6600 */
 	error = cpcap_usb_gpio_set_mode(ddata, CPCAP_UNKNOWN_DISABLED);
@@ -448,6 +454,9 @@ static int cpcap_usb_set_uart_mode(struct cpcap_phy_ddata *ddata)
 	if (error)
 		goto out_err;
 
+	if (sysrq & 1)
+		sysrq_toggle_support(sysrq);
+
 	return 0;
 
 out_err:
-- 
2.25.1

