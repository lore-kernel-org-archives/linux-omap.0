Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01383CAE76
	for <linux-omap@vger.kernel.org>; Sat, 11 Jul 2026 16:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783788510; cv=none; b=eHcLAv6dkdM5/3fxify9sSA8FldONwrGn6mnHxlWkh7LndWENrz1Fnyo5H6rb9ktLinTrLdqxhLpusLjeZvIYaRMF5KDuXp+KkdyfCfq9ilWUKZ6ATUd62pBonCAP7VuuK3xhN6ajgMukBzWjfb4Dv2I52u9TLe8DzD2IyqIXU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783788510; c=relaxed/simple;
	bh=rrLo2METxAPvW/Kvl+v935lLmIy60Gg/5rsQY3LkAQI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EMNgJsPpJ2jpwigl5I8SRd1JMbEqRujcgov9DSg0LLpgZs+xKSM9rODlc4BGmqxMVZv0NOR9G5sxlgr4iqxdKnK2u4WWygtFwqpkvJhXQFcAkL66bcSSmdgrbXUVbN1uqDPMBVC9h4xrJ+ZHtFBv6cr3k6vJv/RRJ9zSjj7dEHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CTbo8JvV; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTbo8JvV"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-472326ca506so1455745f8f.2
        for <linux-omap@vger.kernel.org>; Sat, 11 Jul 2026 09:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783788507; x=1784393307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ovaR5Pw/la2QK7dtVGwmXlwaYYgjdR7NRcQLElGlwYM=;
        b=CTbo8JvV/2tDtnkbraf1mKjiLGCdEj/uCPEo5msQ2fWddssinHzY1BCRdcoEiMzPet
         hltcm/IWk1qdwXugx5gqzpsQju94Golx1+KfuXKUNnh6BSUU12SOC04HaX95sfiig+pE
         zyyFXSiptkq+Tig0px/Lx8PfclHSRB9R78wsb6dO/jG8Kq9YvJ0Dq592q50tY+2DTjm1
         M7+gPUPMgL8KBvM82DbLmvazEQtPAiHIGzsbeZh8iTkh3syl/sIgJ1Y5wZ2jP3Z1DEQK
         rxjUN5swjkylue9OWc5Rp3o3kouHMGS0rpCgTAWR0QpZp8H4Z2v9nHmM5Ti9igEk1K6l
         t5xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783788507; x=1784393307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ovaR5Pw/la2QK7dtVGwmXlwaYYgjdR7NRcQLElGlwYM=;
        b=gxmA/puWt+WDHVbcxaY78u0AJs1p9FPOaUyUOWUocAXu7oTcBTLI4W93rPW1OfTp/J
         qJrqxIy8tfKBMe5nwmVjrRHcnWvtlGwIq7job/JB08YnvD7vYNTMsJepxeeC0Tp0vrsS
         /hogCYEFsC4coQs2n1/Id/rCQjHsu8nxqaaS5PKFcr+s3BHD1rviL+KYLt1r7+avuiWe
         D01Ta3f9b0glFDkTnTnsIWw5NVU3I3wZz14ysuTqMnABXJUhnnpGs+JMalf66m/viJcH
         8g2EaanoH/v9QDqKgXSR//IEtbRNGdUDe05q29PBnmwX4h7GhErQ/EgUPmALJmpF5Su9
         uQ9w==
X-Forwarded-Encrypted: i=1; AHgh+Ro/rZ5kubA1BqHCF5mq0RtEUUTd64S7FkAFXPhfSPFO/e6yu7JMY3oS24glOybOlu1Ozxdrnyfjb4y3@vger.kernel.org
X-Gm-Message-State: AOJu0YymnEKwcGZ8aZpYfARde4nQY4b70Bp0JUBFby2GvimiPjmwzVOj
	AbKpK8ofvVgTdD6OO39TMG9LOGZ/ryOdLUY3IfYrOY/jMusJwdPDSD0x
X-Gm-Gg: AfdE7ckS33c+ffedXC/KxY+/9+wlFiW/tk8aL6aiKMLsqUw1uNEVviZujU9/0euxDQ6
	4sKccsUVnDTgBN7NAMAe87eo8ES4fqU4uaUrJLq43kg2ahFUEMRXiwC77Yd4cPKLSPIKX0cgNEj
	YxBTy/ct9u3+DVATSnIqEIU6MaYB575MqrK1imSiyYaj81mFa/8/vvVGlqUPMKYNwoZcnwmncBp
	QZHUcrt08ezbexKTFKokdkyHWlxDCIn/53V6vFmr04GVojWhl5mchLbvp9xniAQvG5B1XzB6NWC
	RA/vY0MlvE7qYXoqNnLl+RRLl2evW56tqYmIhqYcxEs/Frk8nn0yOsb+MgmikXdIvXglv/n8T+5
	+JbOSXIgE2CE8phkextX0PQ+RY05uWKkPMiY8prcXJ8YJ6m2t47JQrLOhk75m+vpsFnEBpuX7Cs
	S2/kBiudrIm4xz3DZQaYDlQdG4g/PSR+HGtw==
X-Received: by 2002:a05:6000:24c9:b0:477:80fa:f474 with SMTP id ffacd0b85a97d-47f2dcf400fmr3364939f8f.38.1783788507031;
        Sat, 11 Jul 2026 09:48:27 -0700 (PDT)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d83bdsm69152875f8f.13.2026.07.11.09.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 09:48:26 -0700 (PDT)
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
	Bartosz Golaszewski <brgl@kernel.org>,
	--cc=linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-gpio@vger.kernel.org
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH v4 1/6] dt-bindings: phy: motorola,cpcap-usb: add chrg_det interrupt
Date: Sat, 11 Jul 2026 19:47:49 +0300
Message-Id: <20260711164754.185565-2-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260711164754.185565-1-ivo.g.dimitrov.75@gmail.com>
References: <20260711164754.185565-1-ivo.g.dimitrov.75@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the optional CPCAP charger detection interrupt in the USB PHY
binding.

Update the example DTS to include the corresponding "chrg_det" interrupt
name.

Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
---
 .../devicetree/bindings/phy/motorola,cpcap-usb-phy.yaml   | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/motorola,cpcap-usb-phy.yaml b/Documentation/devicetree/bindings/phy/motorola,cpcap-usb-phy.yaml
index 0febd04a61f4..d6d52d21280c 100644
--- a/Documentation/devicetree/bindings/phy/motorola,cpcap-usb-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/motorola,cpcap-usb-phy.yaml
@@ -20,6 +20,7 @@ properties:
 
   interrupts:
     description: CPCAP PMIC interrupts used by the USB PHY
+    minItems: 9
     items:
       - description: id_ground interrupt
       - description: id_float interrupt
@@ -30,9 +31,11 @@ properties:
       - description: se1 interrupt
       - description: dm interrupt
       - description: dp interrupt
+      - description: charger detection interrupt
 
   interrupt-names:
     description: Interrupt names
+    minItems: 9
     items:
       - const: id_ground
       - const: id_float
@@ -43,6 +46,7 @@ properties:
       - const: se1
       - const: dm
       - const: dp
+      - const: chrg_det
 
   io-channels:
     description: IIO ADC channels used by the USB PHY
@@ -91,10 +95,10 @@ examples:
         interrupts-extended = <
             &cpcap 15 0 &cpcap 14 0 &cpcap 28 0 &cpcap 19 0
             &cpcap 18 0 &cpcap 17 0 &cpcap 16 0 &cpcap 49 0
-            &cpcap 48 1
+            &cpcap 48 1 &cpcap 13 0
         >;
         interrupt-names = "id_ground", "id_float", "se0conn", "vbusvld",
-                          "sessvld", "sessend", "se1", "dm", "dp";
+                          "sessvld", "sessend", "se1", "dm", "dp", "chrg_det";
         io-channels = <&cpcap_adc 2>, <&cpcap_adc 7>;
         io-channel-names = "vbus", "id";
         vusb-supply = <&vusb>;
-- 
2.39.5

