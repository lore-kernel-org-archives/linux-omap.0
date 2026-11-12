Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794509675;
	b=KMVjXaYt+FkOCY1769oSN1a2r+M8V421KvvvACKypP7tPaoj5JWtK7S8G7tkcjDxDwXI
	 CxjVR4576HS6IehJhe1VPKcKr2jJfHSId1LIj4pFHFGhOqSlgrNlFu3U79WDjRLotcKlt
	 oCxTxPM0U6+TJX4KLhyfMdP5tmodtOR/4/3gLVccMNHW14rRo7yK0F4/vvaLImW1n6iOG
	 8iW52JaeEU2NfLWilU29jiXJ9r2Dpxainmwp+qkW5VUHuKlxj0yIxx8S911lozjEtRCY7
	 QEGhqqPd7LEtuDQtxa1RBZYKPTMvNt+NBL3WQqjqevOduo+UDnnEPm3HD0cXVlw/2YQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794509675;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=jeIbt2k2gIGUcVGK5YRi1yFkDF0bqtPi9E7+l8WvSWw=;
	b=nT/Lu1O4L5fV5vuT31t+kTwhZNyvO1FABTesIB7jGHlcQgdq1HQrrEyp54CbTlE2vkXP
	 dZUYOuys10JzADxhIZPYbuOvCQk37c1p3BGea0UPBNiJCSv88efrSXdJN/8JEUJO8a2jh
	 AySQIdimP2ggXi4/ODCnkcxYS/nET+Tf0UI5QxFMc5tDaSueIMmneyf21sKO79hvs78XQ
	 +q7ZQo2cKNXUs3S19O0pfecaqj3eDq6aee4K/cVxBu6Sc9chuiY7tOowPh1bg8/b8wBNy
	 cMjBwrN1IesldrOafptMXNxbg7lFMEG6vTfa9OuIVXscgYU7YcVpf1HY/nvmVQRrhjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EVjHZ6fN;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5254606A321
	for <linux-omap@vger.kernel.org>; Thu, 12 Nov 2026 18:54:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5254606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EVjHZ6fN
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-3719e3cb82bso24754eec.3
        for <linux-omap@vger.kernel.org>; Thu, 12 Nov 2026 10:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794509674; x=1795114474; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jeIbt2k2gIGUcVGK5YRi1yFkDF0bqtPi9E7+l8WvSWw=;
        b=EVjHZ6fNXPaLODG6sUnP9vMWLY/UNtlt1EcihhyvGRME3dlPKU8PFigIin1smL+oVC
         w+M9PGYePcmJg3Bph8LjByEcrDSuFLpPiW9JEnnHndpHl0QgzGhZunY87WhK38dWpbLE
         liGVCQWy1iNTbN+VOxKdsisyWBk+m777tOAm6Dy/sKDAOALpEkMq+DL9JbeXY09Yl5jX
         R/MTcz9+KPqhmBi1k32OpPUGIUNKZ4C/WLSbtp4wYsuBAnQAeHJa+cAcKkfgQ3x3Cif6
         ePqQI4qEIzNbC9Yyn5WCqtqrCSLImfJvDPv3y4Iao4v6EtAgTI09m2+G/IIZxdZlY6Cn
         egSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794509674; x=1795114474;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jeIbt2k2gIGUcVGK5YRi1yFkDF0bqtPi9E7+l8WvSWw=;
        b=DF8hZpteSHEt0XP+VoIrvLuDT0LxhwrjDABvIdAaie9+l+rPmEpMA9byJMOVBeTErh
         N/6O89kNXS0FOIuy/ILYp6VD8EsF9Tn/scbMLdlf4i4Q+piX7hviuTU93XpmEvsFIDfU
         pcHxHS/twfBkTUAhBX/BPejveyWlor1VoJx8uIBCLdqviMetPZ1Pe5dfoW+IYO/UakUb
         v8gE4K0H92YY0Wjul8jntiK8WA1D+vc3TaSQidGMGLReVw5qxAbWgUDbadMj/US9hxIo
         y6HkPR94usAm4tOMRyEmdzTdAtXtvMrGC93yu/IuV1pJJJIUofm7xYUl7tSWdOzqgM2L
         ZikA==
X-Forwarded-Encrypted: i=1; AL+hErH54Tpe/Q8qOoxNhwhwgcosSx0fLiDuzMr50bU1yuWk/RxZWiBBEZIWH9H6Kcp3BqlBze0qFfMf92t8@vger.kernel.org
X-Gm-Message-State: APuU4Z8ELvxEl5VKvyOeX7JLOJBbbc8yTHuJIGLws7N2gj6NaNF3YZEN
	+pcblojNFVOp97wcuXl35AYRmqHrGciOwNPLN79q6YMFfAMCsmOLd4Gb9CalZQ==
X-Gm-Gg: AYBFou3upoFVLCengH5JyYRQWYbfXPxg1W5L5nLjpUtWDT6XKRAuUmMJ/QQQyuO4reH
	Gmh/tcw43roU4IsEsaxnY5BnBKSWSVN3BGhgB4gAvKJr3YHCtM2oJssVcdCFqQy7EV2BIqEjOyf
	LS3T/Qid5GaatagKgJYsEEKtXPdf4csB54h18auyBVls8RPOalKxhf2gFNiQzfeyCU2LqCNGjUi
	8ZJRmnVRI6lmCv77nnObQAjQnBtDA1tqgBp+9K8mKlVBUdwzxS1EG7qAFPfvvm/l457uvYINQsN
	psqGz1q5IP6YBgnjQbkXbpT8ECKmGrNRrW4U/vZ5fUfaFMWaJbDNHkmS7N0JjZSv53mcc5vJhaH
	HmmLbNjSYamRadKDjEQ1TRIoP+OvjFDe+TnplZsfsmgcEAuHsyUS2w6e55dls7bWk/DyGYUy9IJ
	h544r6j0UJgdq9Y6MHBV/IpJV+/b7WilAfduhHFKVlGlUi2XpcZBIOjw91c7lmBHBdHVGorQMLb
	0n5+MBWmIgiw+QS30ZisaMKVcbRL3Igotube1MYMTfgesmHThet+5X2X+r49z+4vf8J3ClHyNG1
	dwUMeIBXhleukdRUH34Gw9vrbcXO87SCS0ZYZA==
X-Received: by 2002:a05:7300:c00e:20b0:35e:d21c:f33e with SMTP id 5a478bee46e88-379651ecb3emr98122eec.1.1794509673785;
        Thu, 12 Nov 2026 10:54:33 -0800 (PST)
Received: from [192.168.1.4] ([2401:4900:881d:321d:eb39:71d3:15f6:5fe0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379565d07b3sm339008eec.22.2026.11.12.10.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 10:54:33 -0800 (PST)
From: Bhargav Joshi <j.bhargav.u@gmail.com>
Date: Fri, 13 Nov 2026 00:24:03 +0530
Subject: [PATCH v4 2/3] dt-bindings: bus: ti,omap3-l3-smx: Convert to DT
 schema
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
Message-Id: <20261113-ti-l3-noc-v4-2-5084dcf4ffb4@gmail.com>
References: <20261113-ti-l3-noc-v4-0-5084dcf4ffb4@gmail.com>
In-Reply-To: <20261113-ti-l3-noc-v4-0-5084dcf4ffb4@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Santosh Shilimkar <santosh.shilimkar@ti.com>, 
 Sricharan R <r.sricharan@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 goledhruva@gmail.com, m-chawdhry@ti.com, daniel.baluta@gmail.com, 
 simona.toaca@nxp.com, j.bhargav.u@gmail.com, linux-omap@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794509656; l=3174;
 i=j.bhargav.u@gmail.com; h=from:subject:message-id;
 bh=MxSg2MkwbXN7myq3Mkcqj4G5zZktmzhof0tcCBB1PGg=;
 b=JRt6nSNlb85XdtArL63nkiepL6Da+0yUqR3qJt2OdDLJM3jkrZYyrTTd7rrZO5cFiV3mwRxpa
 Fa83lVMojAZDke/lQ0rNOFaKrQETDdRJcIZeZmc0ooQ1BffJzLCATav
X-Developer-Key: i=j.bhargav.u@gmail.com; a=ed25519;
 pk=IqNDwUZKECEA+n8wXctFLBbYL9NhFstZNbOznm/nX1k=

Convert TI OMAP3 L3 interconnect from text to DT schema. In text binding
this was grouped with omap4+ L3 noc interconnect but since it uses
different hardware IP (SMX). Add SMX variant in new schema.

Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
---
 .../devicetree/bindings/arm/omap/l3-noc.txt        |  5 +-
 .../devicetree/bindings/bus/ti,omap3-l3-smx.yaml   | 68 ++++++++++++++++++++++
 2 files changed, 70 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/omap/l3-noc.txt b/Documentation/devicetree/bindings/arm/omap/l3-noc.txt
index 161448da959d2..66548395fbdeb 100644
--- a/Documentation/devicetree/bindings/arm/omap/l3-noc.txt
+++ b/Documentation/devicetree/bindings/arm/omap/l3-noc.txt
@@ -4,10 +4,9 @@ This version is an implementation of the generic NoC IP
 provided by Arteris.
 
 Required properties:
-- compatible : Should be "ti,omap3-l3-smx" for OMAP3 family
-               Should be "ti,omap4-l3-noc" for OMAP4 family
+- compatible : Should be "ti,omap4-l3-noc" for OMAP4 family
                Should be "ti,omap5-l3-noc" for OMAP5 family
-	       Should be "ti,dra7-l3-noc" for DRA7 family
+	           Should be "ti,dra7-l3-noc" for DRA7 family
                Should be "ti,am4372-l3-noc" for AM43 family
 - reg:	Contains L3 register address range for each noc domain.
 - ti,hwmods: "l3_main_1", ... One hwmod for each noc domain.
diff --git a/Documentation/devicetree/bindings/bus/ti,omap3-l3-smx.yaml b/Documentation/devicetree/bindings/bus/ti,omap3-l3-smx.yaml
new file mode 100644
index 0000000000000..3fc5fae7b37ba
--- /dev/null
+++ b/Documentation/devicetree/bindings/bus/ti,omap3-l3-smx.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bus/ti,omap3-l3-smx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI OMAP3 L3 (SMX) Interconnect
+
+maintainers:
+  - Santosh Shilimkar <santosh.shilimkar@ti.com>
+  - Sricharan R <r.sricharan@ti.com>
+
+description:
+  The L3 interconnect for OMAP3 is based on the SonicsMX (SMX) architecture.
+
+properties:
+  compatible:
+    items:
+      - const: ti,omap3-l3-smx
+      - const: simple-bus
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: l3-dbg-irq
+      - description: l3-app-irq
+
+  ti,hwmods:
+    description: hwmod names for each domain.
+    $ref: /schemas/types.yaml#/definitions/string
+    const: l3_main
+    deprecated: true
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+  ranges: true
+
+patternProperties:
+  "^.*@[0-9a-f]+$":
+    type: object
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - "#address-cells"
+  - "#size-cells"
+  - ranges
+
+additionalProperties: false
+
+examples:
+  - |
+    bus@68000000 {
+        compatible = "ti,omap3-l3-smx", "simple-bus";
+        reg = <0x68000000 0x10000>;
+        ranges;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        interrupts = <9>, <10>;
+        ti,hwmods = "l3_main";
+    };

-- 
2.56.0

