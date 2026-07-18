Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF87379C5D
	for <linux-omap@vger.kernel.org>; Sat, 18 Jul 2026 21:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784411822; cv=none; b=G1o0pyT1RHXqTpHdnBX0GrLVXv0PmnEpKWg6IbOMnE0fP4rpqSzKxlLQCo3RltOgkZiy8hCLF8wk+u3lausxyZ4kTxvE912Ovm4De9LlC+BXK9Y80G1uOta8xdJijASsan5Liy0SbX3R1y/CEBCblpcBGxXPLnXWghPsN7Z3I1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784411822; c=relaxed/simple;
	bh=Hd+tupI66QuP1tLRrv+1JWvd/0wH4IvI6LIN4P/a8dQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FV+Ic9u0XtaxBxn2Z0fH3lEBdYK23ivWxM+UKTHxtGb+m12Li+ySNI87Di+IKRh3uNgMmtuFS3HST6fbgIwOsy3S/s+wq1Vx2i3mslhAWVzwcK6Sg2KBwXaoAVhGvPN3iEQ00FddGJn475itx3+u/x++LGGG2Xunkf+hpbtHECQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OsbNm/Ug; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OsbNm/Ug"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4954f5e8020so4313745e9.2
        for <linux-omap@vger.kernel.org>; Sat, 18 Jul 2026 14:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784411817; x=1785016617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6hEJAtA2FmuGbMms2Cfe5VvNicgq5ngesjv9wLRLgDE=;
        b=OsbNm/UgKUmH5sFpZ2FcAzQTGBhgEPT9CWuSvzX2jSx4+stmpAYbcER8e6tJXIVxfX
         2cR7HFu4X0T1MO9NdTJbh9hIOslRyy6yU4I3nbf3OX2+vXbxt4Z1/bhnmfj86Y8rVZ/g
         X9mlOWd6OuuLP9+0Kk+vcViemvgX9b5YPIe8XT2x9kk4kkmZ3xPutN5ZlSz1B6qjoTRj
         UjsofnAOpI4bx7g1BoTfq0blow1A7dNfeBbn5PjntPu6GK5UfFVUa/SVYvSPec+NcxN0
         czPQifhNWt4/I9kFkcoaIW+9qn5HfL+GQe+LAE+wIUWKHK1PjCeaziiKMYBDnGMd+Yfa
         DvzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784411817; x=1785016617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6hEJAtA2FmuGbMms2Cfe5VvNicgq5ngesjv9wLRLgDE=;
        b=tAnk9hmAnAqM8NtIMpwpW1YweHbxmrf02KYtSjYBOn+p2Fh/ysseI4yI/VKP4J6yL5
         nWV85UI1XijvKzO9FLpmcFKNkzUh6M3fpglDczdmUKo5CPR2cqmfL6qYBGnLr7s4AeJf
         LaRt25WFx96GwyyUSs+n/dcX1NI6vS2KcJQjiuk8b/PvtmgDULTV2HZJIYQefwEYFvzy
         vcNz7p6+o8u71I1wFCrA6tUO1WUNCCeufaGPpjzkRfaRsOs2Fsso+Ywyts2mjEboefTX
         CXFk9Ug0iFM9AqXZwhSjWjD9U5FGQS6UdpxAvZBiQ/plmD+6L6hZWccljiR0coZQ5zcm
         xnqA==
X-Forwarded-Encrypted: i=1; AHgh+RoEys68xtw9qNQdb74iO/ywDt5dJQyIjk9GOsrTZSNSd25TZuRGeaqxZa7whrk1swNxDNNpqD7UHzOL@vger.kernel.org
X-Gm-Message-State: AOJu0YzAnOgWIPmo0gvQ1ADfekMFmRkhgRrWEDxRAsUKGj/dBBzg+J0e
	dRBm42UwuRytXsUSsyX12aGZ4sGtYe13gotSr5Ya/73+sfaSkIXDyOle
X-Gm-Gg: AfdE7cnnddi8v7Jo/HOM7DcQ7bpRyzf/4uZE2VDjOJV9S7I4sagGHyXtiZPQY2yCgaz
	zOjfZQ46b6U7pD782pTlzroKKJIJLRNNwmUUt00NWwmrov0REqsMzwnMUnZqw/kudEUZgQdOlrT
	11HSVU6EZQVnZv9CQ64E90zacEglQPTMY+nbsBIDFmm6t3k+1W2NloTMzV5UslkOcIYlxKPwWW1
	1Pxb2DCMmKRi3DwBYUtV8agWKWJFbFOcxKHNOoj8mHaSjcZi3+uTT77Ql8Tib2l35MHO0Fm8tnX
	zTSQ1rSG98l0RwX2iWMkXlLuYKbT94JyVYVoeYVRGVfGnqAizjARu/mTycCdxfPNsQnqajQtjDG
	uZxjIeHDOfHLk8zxzg0g59Swnp7xeYmu+S7XnAaF7MiefdACwJklWwnLbmnjO/cnjkmvWeYNgHh
	goXbqtd3XdVjQRUMK7Gg5F8m8RzI4EXQZBIgEzDJIUeNouFiYHnwNB9aM=
X-Received: by 2002:a05:600c:1d18:b0:495:3e08:ad19 with SMTP id 5b1f17b1804b1-4954aa1a264mr86084215e9.9.1784411817252;
        Sat, 18 Jul 2026 14:56:57 -0700 (PDT)
Received: from localhost.localdomain ([188.26.50.240])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4954c0a81f7sm101199835e9.1.2026.07.18.14.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 14:56:56 -0700 (PDT)
From: Eduard Bostina <egbostina@gmail.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	devicetree@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	dri-devel@lists.freedesktop.org,
	Eduard Bostina <egbostina@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-omap@vger.kernel.org,
	Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>
Cc: daniel.baluta@nxp.com,
	simona.toaca@nxp.com,
	goledhruva@gmail.com,
	m-chawdhry@ti.com
Subject: [PATCH v2 2/3] dt-bindings: input: Convert TI TPS65217 power button to DT schema
Date: Sat, 18 Jul 2026 21:56:31 +0000
Message-ID: <20260718215632.3295049-3-egbostina@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260718215632.3295049-1-egbostina@gmail.com>
References: <20260718215632.3295049-1-egbostina@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Texas Instruments TPS65217 and TPS65218 Power Button
bindings to DT schema.

Signed-off-by: Eduard Bostina <egbostina@gmail.com>
---
 .../bindings/input/ti,tps65217-pwrbutton.yaml | 42 +++++++++++++++++++
 .../bindings/input/tps65218-pwrbutton.txt     | 30 -------------
 2 files changed, 42 insertions(+), 30 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/ti,tps65217-pwrbutton.yaml
 delete mode 100644 Documentation/devicetree/bindings/input/tps65218-pwrbutton.txt

diff --git a/Documentation/devicetree/bindings/input/ti,tps65217-pwrbutton.yaml b/Documentation/devicetree/bindings/input/ti,tps65217-pwrbutton.yaml
new file mode 100644
index 000000000000..3526d8b045fd
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/ti,tps65217-pwrbutton.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/ti,tps65217-pwrbutton.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments TPS65217 and TPS65218 Power Button
+
+maintainers:
+  - Eduard Bostina <egbostina@gmail.com>
+
+description:
+  This module is part of the TPS65217/TPS65218 PMIC. It provides a simple
+  power button event via an interrupt.
+
+properties:
+  compatible:
+    enum:
+      - ti,tps65217-pwrbutton
+      - ti,tps65218-pwrbutton
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    pmic {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        power-button {
+            compatible = "ti,tps65218-pwrbutton";
+            interrupts = <3 IRQ_TYPE_EDGE_BOTH>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/input/tps65218-pwrbutton.txt b/Documentation/devicetree/bindings/input/tps65218-pwrbutton.txt
deleted file mode 100644
index 8682ab6d4a50..000000000000
--- a/Documentation/devicetree/bindings/input/tps65218-pwrbutton.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-Texas Instruments TPS65217 and TPS65218 power button
-
-This module is part of the TPS65217/TPS65218. For more details about the whole
-TPS65217 chip see Documentation/devicetree/bindings/regulator/tps65217.txt.
-
-This driver provides a simple power button event via an Interrupt.
-
-Required properties:
-- compatible: should be "ti,tps65217-pwrbutton" or "ti,tps65218-pwrbutton"
-
-Required properties:
-- interrupts: should be one of the following
-   - <2>: For controllers compatible with tps65217
-   - <3 IRQ_TYPE_EDGE_BOTH>: For controllers compatible with tps65218
-
-Examples:
-
-&tps {
-	tps65217-pwrbutton {
-		compatible = "ti,tps65217-pwrbutton";
-		interrupts = <2>;
-	};
-};
-
-&tps {
-	power-button {
-		compatible = "ti,tps65218-pwrbutton";
-		interrupts = <3 IRQ_TYPE_EDGE_BOTH>;
-	};
-};
-- 
2.43.0

