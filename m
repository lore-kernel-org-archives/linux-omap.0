Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717C225B091
	for <linux-omap@vger.kernel.org>; Sun,  5 Jul 2026 10:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783246285; cv=none; b=W+4x2lb2dqvu609ieumJV0jI3JMYlQyw7lnxaCM+TKkw7UicfWs+iizDUamH+KgTFddAD9h1XkZGOWLpMEEvYvJhqLXVVknY3SzTgM5MeKtIF1hgQCNO2PbNk/ZC3+GfkU96MPxwwXmPgbQD5/8epjfX4Y8x0S5lXcA2r9a6qWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783246285; c=relaxed/simple;
	bh=e7sepBvKllOJE2cVjyGxRX7LbgzcAMO6ZZ+f7CeIci4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e+nY/kbF0bbIiQUUJQvQ7c5ZmRyalOM1O2VrmHlrRRIR6l7zZ/gAJ24J63t3lCgcS4FIQIhRJ1D8z4g0beH7YY72gWLRSwY4DtLUxolzP7wadsnEyUIOBlSTAmCNGtIoTsVGOyAhoznd1o8x9tVei5jFJykAEkmKqUByBmOzb1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QcaJhpYF; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcaJhpYF"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493b6f1b14bso7166355e9.0
        for <linux-omap@vger.kernel.org>; Sun, 05 Jul 2026 03:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783246283; x=1783851083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NTQQYukmPEeRXmpWGMDD6xv10gI6rwVhTPfZN5h8J8Q=;
        b=QcaJhpYFWgkcCFWbBoW1uh/+SKCXoIMlzSfA9ney64+s7TVu57hjoWuUB+S3CpSINS
         YPD5Vpw8V8Quo0D3cV3I25PWO6aat7m2iEqibeA8jFviCcR6ejv+50Om/AXzKz2CdOHJ
         WGHgZilxYjcRBoeO1qS3TrNgw4buM+Rdl6cT7yU4gWyIvIP4hWGa1qlwALKHJztAZZZM
         lMyKE/r77xcjXEEWdUZXKdgSW0ArZmvZ9uXEV3y1FMxQf1suy98XfB9uDqDlCcpaXNHG
         5iINZDqI02vjSZ+F9JJAEYUaKwq3N29KjzrSG4OXaw2r6L7/We1qCohJqpI4JNptQ74+
         CMZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783246283; x=1783851083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NTQQYukmPEeRXmpWGMDD6xv10gI6rwVhTPfZN5h8J8Q=;
        b=YQbVPLirNKLlmDZqPch6Q4WFnUXbk3Ssv9xiqBjc69dgUh4W3fyQqAy2xjrM+Z1rO2
         GKzKGVrpIijAiIQRCGKykiigqrQaXZPI46BNDc9IjxJcCQfHVrBhl1uPuLqO9Czv5oCy
         S96qF8+3LZDHkMasOAvF6gTKZXHZe/G6ZJ0DHStrwHYgj7TGaWXwAzPV6EZcWAmaJn6+
         pMEZkKEp51KzdnqyRJVNwB9vaAp8ewmtdyP/gv/mlalfVu5tXK6jfMgeqJWvnWP0cy1y
         w461ajqfFOSBUN+uQul7+phCKRp6iSm/XNmCxQWjKiYxl0q7ZZcMI52W8PWeSe2oO7xr
         8HgA==
X-Forwarded-Encrypted: i=1; AFNElJ/TKFZbWOspZAocTuby1zJCPrjDWQqJLxQuAYOfJDg2hB0+7OIR1Eh6/4BhaQAYOj6LCc9WGNoF3Ia3@vger.kernel.org
X-Gm-Message-State: AOJu0YxsAyBV2tJ5umYXcQLog4tEcg7KSy88GRX2IRFs3OXKmVFWGFvR
	AZJT6HuYiscd5OBMJAZgkY9jSJUr775lKZOcqyYgvCy1XhKqlAOdPTDU
X-Gm-Gg: AfdE7cnd+Q+uniJUdbo3DaSBd4zIpebE1UvUu5sKuxgqauKKq4SQk2yFuIo9c4NOTAq
	4V6V9aQrRqbZP2ohUoiIrI24M4q5u6mjay9AdVgJJ/3sJnqWyVekt6yPyFt+oUZdqciJA1iwKvZ
	UIQDOWHBuV0Mdmv8AbzPfQyFcHOeOouPamMJUJZVDaROq0eY1ML4e0KBETEOGM8bldkxoHhRYoF
	U09Ys6p3qokfBNMKkiZeSsLK/SQ97sy0IC3oXgVmi769gF3wm2WBhVCi990tmTQmXadlfnnkwyf
	/NP3l9X9JpfejvX1vD/UCPUDWoA8BoNwloQibPhAa5DfoJzLTpPMst3YFzfj+byajVsavRoUavU
	IBN8FA+VJko63qKP6WSBzwINgv4acWnAscJIjSGQowgeynnfqzqbndqol9oJqT5sJZWJENwuF4o
	Xb/16ukFiFgudLyVhINBaZHfehptMY4VskzA==
X-Received: by 2002:a05:600c:64c5:b0:492:4c2e:9613 with SMTP id 5b1f17b1804b1-493d5e61ff8mr29175395e9.18.1783246282611;
        Sun, 05 Jul 2026 03:11:22 -0700 (PDT)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c637bbcfsm261382715e9.6.2026.07.05.03.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 03:11:22 -0700 (PDT)
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
	linux-gpio@vger.kernel.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH v3 1/4] dt-bindings: phy: motorola,cpcap-usb: add chrg_det interrupt
Date: Sun,  5 Jul 2026 13:11:02 +0300
Message-Id: <20260705101105.1798069-2-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260705101105.1798069-1-ivo.g.dimitrov.75@gmail.com>
References: <20260705101105.1798069-1-ivo.g.dimitrov.75@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CPCAP USB PHY driver uses the CPCAP charger detection interrupt
for DCP detection.

Update the binding and example DTS to use the corresponding
"chrg_det" interrupt name.

Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
---
 .../devicetree/bindings/phy/motorola,cpcap-usb-phy.yaml     | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/motorola,cpcap-usb-phy.yaml b/Documentation/devicetree/bindings/phy/motorola,cpcap-usb-phy.yaml
index 0febd04a61f4..523a8f8480d0 100644
--- a/Documentation/devicetree/bindings/phy/motorola,cpcap-usb-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/motorola,cpcap-usb-phy.yaml
@@ -30,6 +30,7 @@ properties:
       - description: se1 interrupt
       - description: dm interrupt
       - description: dp interrupt
+      - description: charger detection interrupt
 
   interrupt-names:
     description: Interrupt names
@@ -43,6 +44,7 @@ properties:
       - const: se1
       - const: dm
       - const: dp
+      - const: chrg_det
 
   io-channels:
     description: IIO ADC channels used by the USB PHY
@@ -91,10 +93,10 @@ examples:
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

