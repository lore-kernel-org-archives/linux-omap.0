Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90B33191CE
	for <linux-omap@vger.kernel.org>; Sat,  4 Jul 2026 07:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783150773; cv=none; b=SeLfOc9v4g0EBq08sDx7pRcdjKURBjBnvVdKdH7AzIrkmH2FJJAXg96gM3v3RUIXZiQVWABTlu1/eys1qo13p5t3kiZ3Gy+d7JkaTDn1Cb97WVSOHev1X4Zlbq/w0QaxOrc0oIeyAklziKBeM+vbcjI12t64T7+tzBF+BknvgzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783150773; c=relaxed/simple;
	bh=p0nFlcc0G71zRK9tMWoufvLKeY4JW3NRg9nSuniWkNo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RWvYQPAxyF4c7mETlHtvZVw7D/LFIhHyeOXd/DJACHIQ5D5KbvMTAmyBzDMtK7BCs0u3x3tKV9yTSfo4eGCtI0gGWUQyTsfWOwZ2Hc9G9Nj0zzp/W55F7r/TriBGkVulVC34W3YjxQe4AHREyQsT5XctVr972XY563kQRUFWCb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GCFz9/1A; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCFz9/1A"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493c55d5c7aso11916975e9.1
        for <linux-omap@vger.kernel.org>; Sat, 04 Jul 2026 00:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783150760; x=1783755560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Ujun7RB7FUF9dZLPZwQwz/fZN6r2PvMJI73ZhiW7os=;
        b=GCFz9/1AVAEbAgluk2yKp9vZrPjb9yAg2b200Fg6rEGXLy0/PhKUaphFocoHbZvJfO
         XYJ0Jazq/YnytfwelmGG3snlwIuiHtHLeHUOJUO+eDbZQquzKT48aqK7itkj+UUW4lXJ
         c1oDJEucmQ0GtlCQnfx+dM+CrphtsOJBy3Q5m+OYComWZoFd96nArcYEgIK5QQ3QJr3y
         2PKHLl5HB9Tnt2Ypuxu1msWKfS5w9islgTZKiEOdWfY9TvoCebThXme6ISbRBMkHwyLI
         Jgs7bBRxHhklFUPLScaSwJ6sCASXDE6uwOI+iJcFfewXX8t+EWobAfV2GzHBYFhXbz4C
         E/pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783150760; x=1783755560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0Ujun7RB7FUF9dZLPZwQwz/fZN6r2PvMJI73ZhiW7os=;
        b=YULdWIdM/GG6iL9PtoWfwWnwq1rYyFqAZ9ZKOEJhk4NtoTZfV2dmVQJD2HKCmu9yIk
         q+3WK7/tI6TDZYFoH9db20a+BHS6o6R0EDfhZ4Izlqsh27YLYFqQ02MvYoaG1ersICyk
         RXimclVb+QoUI0iwXNThU3178j1Fv0J5IOJ4sN1uQ1emmcRLRWVMJQKHWeREYnK+XkWz
         3TozDBidC2FHsR559YHhh6gZrmDyCM9/0ZsCTUPhjSIMG/6mXJSRLTrEXDwhLzQ6jeW/
         xTOjqsW361E/iy7JzoevRa3BrWAPhDW9V50LvruvqV9v6HHkhQ5ahcdYwSMYcR0/6tWS
         Xayg==
X-Forwarded-Encrypted: i=1; AFNElJ9cAWbpGYlLO1lnCHmHhF5gWI6I5wFdSk/dofSEcs6nymPSok2khngL2Vh6/0oqD/7s47lMZ9PXSfI7@vger.kernel.org
X-Gm-Message-State: AOJu0YzmfMGXl28WWmJF/jmAjYPTGwLwkul2xZC8YdaGJLg5X9NfcOrS
	dOJRykyz0JESBUTjFINTEYtvOHfGf7jxArLNgFNCA38WJI75ChIXMHaG
X-Gm-Gg: AfdE7cmrnxg/M8XjnVneQIE4vKTrfP8sVKd80lewYf0wb557cr3KlBW8UM09Vee31N6
	Wo46zM8ZU7ChQbICa+QvhbcMd5evy4wAhUgV42hW1RSA+ZcraqhHNmzNQCEFGzu8p47DorLp2xY
	EQvpyXsfNqL18tCALeCTa8CFfA4gW9iPJC5GEHpQiynoK5k/3GkS7+tKJx8tPd+4Os4xzSjU1mh
	U+fH0lZdxOmQKeZ7dS6/W5N5TLf3lAEPGKWG9yaa6wn8RNc5Z9tfJJ6K7e3tOZM+hLRgsPUBhD1
	6hjV2Jc1OOiPqGSBymdsPeeJb1E5p8S8bXUfXZWwKAvglVbZ2Y/smlIyZbRxxo4i1k/NSxzrG5b
	4qIs01srda+uBkvthcSp4zmXXokqJA13W0ZbLthcnrhb/b4M/L8JYxRbaEZESWL33On3i4/TLIq
	o8HnGHey9YE0rQHjRKpuRzoitSW7Uu7tmYdp1+PeYOCHAB
X-Received: by 2002:a05:600c:a00c:b0:490:d38c:7836 with SMTP id 5b1f17b1804b1-493d11d26d5mr25933205e9.3.1783150759893;
        Sat, 04 Jul 2026 00:39:19 -0700 (PDT)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1e736sm6565488f8f.7.2026.07.04.00.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 00:39:19 -0700 (PDT)
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
Subject: [PATCH 3/5] dt-bindings: phy: motorola,cpcap-usb: replace se1 interrupt with chrg_det
Date: Sat,  4 Jul 2026 10:38:41 +0300
Message-Id: <20260704073843.1750458-4-ivo.g.dimitrov.75@gmail.com>
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

The CPCAP USB PHY driver uses the CPCAP charger detection interrupt
for DCP detection rather than the SE1 interrupt.

Update the binding and example DTS to use the corresponding
"chrg_det" interrupt name.arch: arm: dts: cpcap-mapphone: xxx

Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
---
 .../devicetree/bindings/phy/motorola,cpcap-usb-phy.yaml   | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/motorola,cpcap-usb-phy.yaml b/Documentation/devicetree/bindings/phy/motorola,cpcap-usb-phy.yaml
index 0febd04a61f4..81c5f3b5997b 100644
--- a/Documentation/devicetree/bindings/phy/motorola,cpcap-usb-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/motorola,cpcap-usb-phy.yaml
@@ -27,7 +27,7 @@ properties:
       - description: vbusvld interrupt
       - description: sessvld interrupt
       - description: sessend interrupt
-      - description: se1 interrupt
+      - description: charger detection interrupt
       - description: dm interrupt
       - description: dp interrupt
 
@@ -40,7 +40,7 @@ properties:
       - const: vbusvld
       - const: sessvld
       - const: sessend
-      - const: se1
+      - const: chrg_det
       - const: dm
       - const: dp
 
@@ -90,11 +90,11 @@ examples:
         #phy-cells = <0>;
         interrupts-extended = <
             &cpcap 15 0 &cpcap 14 0 &cpcap 28 0 &cpcap 19 0
-            &cpcap 18 0 &cpcap 17 0 &cpcap 16 0 &cpcap 49 0
+            &cpcap 18 0 &cpcap 17 0 &cpcap 13 0 &cpcap 49 0
             &cpcap 48 1
         >;
         interrupt-names = "id_ground", "id_float", "se0conn", "vbusvld",
-                          "sessvld", "sessend", "se1", "dm", "dp";
+                          "sessvld", "sessend", "chrg_det", "dm", "dp";
         io-channels = <&cpcap_adc 2>, <&cpcap_adc 7>;
         io-channel-names = "vbus", "id";
         vusb-supply = <&vusb>;
-- 
2.25.1

