Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99274391501
	for <linux-omap@vger.kernel.org>; Sun, 19 Jul 2026 14:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784470237; cv=none; b=FWZfpTLORIypENe0r1f13TGOx1xKkuTrIeKOWx/EKiXvgaUDPfJrMub9/p578mgznJEI+rsXUvdFh5AEArHkCu0S9qXcbFHJ0zNqTc/472BeC39pdkDHzEZ5AAYRlP2Ly2zE4gEXP5m9908ZNTGiUokrMhDykiHC/1fS6XC3V+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784470237; c=relaxed/simple;
	bh=yGYoDUH0GpngWJRM/+2oKxqx2lbtMA4BIRUeJWrnKho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i9xS7klUMdSHgaBvPBEh7hmxbP0bkMZ7WDGjiMnP0UIu5L8prxf4CsHgtGvTtxt1AZArp4hub2THZnbR/TI980q7fk/vsQs/xQ9kDqPFOF+s5c1qfXJcWYyj+D+rurwv/hTBr6/pKtM+JsM0ZwqYjANZpn/4YYKcZCQTYuW9Deg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BMexMDeJ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMexMDeJ"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4954df200ddso9396875e9.0
        for <linux-omap@vger.kernel.org>; Sun, 19 Jul 2026 07:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784470234; x=1785075034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VPyP+KaxXd4uhOrdQI9yUrxfXv2oT9xTCa0+/ekjFvQ=;
        b=BMexMDeJK0nc2M82nT/iykR+MOCN0r6K9J5C8ruvgPnU3OGF2vknw32nHwCZ93JyMV
         pGf/bKqhLsrAvkuhuEBlsvbYy6XS66AWi7fcENDSsia6SiQdw65vj6bkjfQRqcDfCDCP
         /vJnHrGKY4h12bhOH6uAJ9taR+oO7NBAlLB/yH0YYjuIWvcUsHDjoX4oJgRyoIsxO0bk
         MZUPwe8MEBwRbEjHcryGXG/d/3miXFkq4oD25+/GeL4npmF4eRmifnWR50GXQLKw5ywT
         o57ytqaYfNGRdjKfCEzRb3oJf4AmGprkEEossZZdqHHbvl5jsIospHnX4dqg4skb+qjP
         kILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784470234; x=1785075034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VPyP+KaxXd4uhOrdQI9yUrxfXv2oT9xTCa0+/ekjFvQ=;
        b=Wn7Zb955686XQryMANnbUOY/GT9MGVE3MAF5sbYxRPYod/teDD0Viahe9Gw4ngwvDr
         RYaI2mfshD21S0UuQG370myEerI4MttJtnZ61lGZ3xfipnQEx49VXMLT8iGL20c3+t4u
         7aMo9dKy4uuLhmSGr6GD9e96DdIfZEUzDfX1G14AKEydYR0DS2tH2oUd+Gad3aZFc/Wj
         GupCardpOk2YF1nXVCkV9QEvpo/HYB5QLAN0WtHuerT2B+8fHNXjpQGtgQJjHG2lS/l3
         S/M5KM7aKa+Zh4LbMtm8D0f435dL8BQHAoE6/Isg57njIOlG82g3j1HlUVvhCP78ruhi
         EUSw==
X-Forwarded-Encrypted: i=1; AHgh+RqTgqpFzlWBktmETckk+7QkNmzgztdH+1ShHCky14eDnOD1zuaJmb1GCKj2h2raDGB+j83JmVCHy4eK@vger.kernel.org
X-Gm-Message-State: AOJu0YyvtjaE1QT83yOF7MrXy6J1oyivLOgetEgU9OSAT3RDpbL4PSj6
	8Bmv7JnOjZtpTl+4A6qWeKKnHkVrtTCa7ZgyUqR1Y/vlGq+bq777jSmk
X-Gm-Gg: AfdE7cn39CgRCPx0KloWpY0BXC4GEKZJiSDi5WGeGeTBFAXPAssihHf5R5REoOFib9u
	AO+DlYfkOllsOfaVWoPCm5AIaNbJjBbk7jZFiRLABlli4L2tkKEjvHW3ZVfQEmwfkLoJYOIZYAA
	02QHCrAe4kHXpTbQ8283j8QodFpFdsKH24tSlxtNowvQKh2U7npIcpblj7LHU5hlhmadqa/2Fvv
	do8/PPhQdPq4Bsh5RViTh8iFDa28W80FYJxYE36jpWv6QXXqbBV6wYw7UQAPXNQB7s22zTZRYDy
	0iJ3/HqvbVn8mwxU6w6SUjTuRKw+A0HZWH/TOrjtVdRs6BAKbVFFOlz2IXCIYUYEkdyUAg2m2J4
	31suaV4PC6OqZxazTj14BKwpDCCn/rzfsFEcuVdDux1+Irpr0cWsCLqGabyXEkjm1njo8jK607C
	CFS2AF4vxg4Tt34RC4BZx6f3mccZNt/WktTinLTfhcGDrb
X-Received: by 2002:a05:600c:4ec9:b0:495:4589:707 with SMTP id 5b1f17b1804b1-4954a3ec5ecmr132249565e9.5.1784470233698;
        Sun, 19 Jul 2026 07:10:33 -0700 (PDT)
Received: from localhost.localdomain ([188.26.50.240])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-47f63eddd1csm21264859f8f.29.2026.07.19.07.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 07:10:33 -0700 (PDT)
From: Eduard Bostina <egbostina@gmail.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Andreas Kemnade <andreas@kemnade.info>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Eduard Bostina <egbostina@gmail.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>
Cc: daniel.baluta@nxp.com,
	simona.toaca@nxp.com,
	goledhruva@gmail.com,
	m-chawdhry@ti.com
Subject: [PATCH 1/2] dt-bindings: rtc: Convert TI Palmas RTC to DT schema
Date: Sun, 19 Jul 2026 14:10:07 +0000
Message-ID: <20260719141008.3562347-2-egbostina@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260719141008.3562347-1-egbostina@gmail.com>
References: <20260719141008.3562347-1-egbostina@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Texas Instruments Palmas RTC controller bindings
to DT schema.

As part of the conversion, declare 'wakeup-source: true'.
This documents the Palmas PMIC's capability to wake the system.

Signed-off-by: Eduard Bostina <egbostina@gmail.com>
---
 .../devicetree/bindings/rtc/rtc-palmas.txt    | 32 -----------
 .../bindings/rtc/ti,palmas-rtc.yaml           | 57 +++++++++++++++++++
 2 files changed, 57 insertions(+), 32 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/rtc/rtc-palmas.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/ti,palmas-rtc.yaml

diff --git a/Documentation/devicetree/bindings/rtc/rtc-palmas.txt b/Documentation/devicetree/bindings/rtc/rtc-palmas.txt
deleted file mode 100644
index c6cf37758a77..000000000000
--- a/Documentation/devicetree/bindings/rtc/rtc-palmas.txt
+++ /dev/null
@@ -1,32 +0,0 @@
-Palmas RTC controller bindings
-
-Required properties:
-- compatible:
-  - "ti,palmas-rtc" for palma series of the RTC controller
-- interrupts: Interrupt number of RTC submodule on device.
-
-Optional properties:
-
-- ti,backup-battery-chargeable: The Palmas series device like TPS65913 or
-	TPS80036 supports the backup battery for powering the RTC when main
-	battery is removed or in very low power state. The backup battery
-	can be chargeable or non-chargeable. This flag will tells whether
-	battery is chargeable or not. If charging battery then driver can
-	enable the charging.
-- ti,backup-battery-charge-high-current: Enable high current charging in
-	backup battery. Device supports the < 100uA and > 100uA charging.
-	The high current will be > 100uA. Absence of this property will
-	charge battery to lower current i.e. < 100uA.
-
-Example:
-	palmas: tps65913@58 {
-		...
-		palmas_rtc: rtc {
-			compatible = "ti,palmas-rtc";
-			interrupt-parent = <&palmas>;
-			interrupts = <8 0>;
-			ti,backup-battery-chargeable;
-			ti,backup-battery-charge-high-current;
-		};
-		...
-	};
diff --git a/Documentation/devicetree/bindings/rtc/ti,palmas-rtc.yaml b/Documentation/devicetree/bindings/rtc/ti,palmas-rtc.yaml
new file mode 100644
index 000000000000..ac64f0589c84
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/ti,palmas-rtc.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/ti,palmas-rtc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments Palmas RTC
+
+maintainers:
+  - Eduard Bostina <egbostina@gmail.com>
+
+allOf:
+  - $ref: /schemas/rtc/rtc.yaml#
+
+properties:
+  compatible:
+    const: ti,palmas-rtc
+
+  interrupts:
+    maxItems: 1
+
+  wakeup-source: true
+
+  ti,backup-battery-chargeable:
+    type: boolean
+    description:
+      The backup battery can be chargeable or non-chargeable. This flag
+      indicates whether the battery is chargeable. If present, the driver
+      can enable charging.
+
+  ti,backup-battery-charge-high-current:
+    type: boolean
+    description:
+      Enable high current charging in the backup battery.
+      Device supports the < 100uA and > 100uA charging. The high current will
+      be > 100uA. Absence of this property will charge battery to lower
+      current i.e. < 100uA.
+
+required:
+  - compatible
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    pmic {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        rtc {
+            compatible = "ti,palmas-rtc";
+            interrupts = <8 0>;
+            ti,backup-battery-chargeable;
+            ti,backup-battery-charge-high-current;
+        };
+    };
-- 
2.43.0

