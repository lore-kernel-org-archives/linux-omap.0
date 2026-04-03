Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0256335AC37;
	Fri,  3 Apr 2026 19:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775242970; cv=none; b=P5sNL4+R4lQuoJw1nHrIVvz5EiF7xNxwx1+sGQI7od1smfAEEtMzX4m6EOhE1PeAdW7dcLKzsu+X6gTe5TGYIVh6ShMcx+6+IlPTLu+W8rvNPeF1VX5h0/1aIhvBtlatINn9rmbEfIza3s0I8K54wJrK7EqKWUS5FUWe41nZPqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775242970; c=relaxed/simple;
	bh=82E1gNqQHbMmQCdl7prDr0d+QbB+S0A7xhvVfG/XcdM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CgEChUIyAX5WDRbBaF43aTGuj1Z0biGyxVCAQQQiosFFunfnKT4SsDWYYaD4DAVpaL3V0RP2wtiEUOyCwLzt6c/LVnamMIx7LAxPNG9D7/8xcTf88JJjb3Zky+t66j+tFHrxOYNaYgy7dY4q3yKMDJV5VnEFhnt4LG0kfS99x2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=szKzb5ej; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="szKzb5ej"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id A88324E428D9;
	Fri,  3 Apr 2026 19:02:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7D11E603C1;
	Fri,  3 Apr 2026 19:02:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3625C10450100;
	Fri,  3 Apr 2026 21:02:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1775242966; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=2gFAv0dcUzXb0YHZi0Q5hVFzBQwFov8rssI1Wgkp5+g=;
	b=szKzb5ejqSC8vuo21XdOCnskZXlaCPQhacWmUb0f/c4E8e/pBCAScYiD0wtvQXbl2VHXRp
	/qdGQICv6I7Wgdmm1QKoIdA4gzDF32XegR/fUrtSf3RHr1Pi405Uh58mJGEl9nIsdwgvBk
	Owo18Ta5CuItWl5z2R5UE9QJ3bNoDGinz3EaGQqvk+r5xEki6Ffm02/8xTtRaWc2GKCR++
	/o8PMUnaRtrjnrbIlqbNjAT+0RMBR1Y3t4MxZGdBcvlBG+P3oEes04KRoIvHOqOtGiYgQ/
	8oqsKz0WspqOhTmK5Qm0gkHQF8bNAozabOfSJGAQ+DS78tgL2Cue8LiNymgpaw==
From: Thomas Richard <thomas.richard@bootlin.com>
Date: Fri, 03 Apr 2026 21:02:23 +0200
Subject: [PATCH 1/2] dt-bindings: net: Add schema for LAN75XX compatible
 USB Ethernet controllers
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260403-b4-var-som-om44-lan7500-v1-1-0dadde850143@bootlin.com>
References: <20260403-b4-var-som-om44-lan7500-v1-0-0dadde850143@bootlin.com>
In-Reply-To: <20260403-b4-var-som-om44-lan7500-v1-0-0dadde850143@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-omap@vger.kernel.org, Thomas Richard <thomas.richard@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

Create schema for LAN75XX compatible USB Ethernet controllers. The smsc75xx
driver only supports LAN7500 and LAN7505 devices.

Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
 .../devicetree/bindings/net/microchip,lan75xx.yaml | 52 ++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/microchip,lan75xx.yaml b/Documentation/devicetree/bindings/net/microchip,lan75xx.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..b84022976044ffec2024cff9fc0aa5016723abed
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/microchip,lan75xx.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/microchip,lan75xx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip LAN7500/LAN7505 USB Ethernet Controllers
+
+maintainers:
+  - Thomas Richard <thomas.richard@bootlin.com>
+
+description:
+  Device tree properties for LAN75XX compatible USB Ethernet controller.
+
+allOf:
+  - $ref: ethernet-controller.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - usb424,7500
+          - usb424,7505
+
+  reg:
+    maxItems: 1
+
+  local-mac-address: true
+  mac-address: true
+  nvmem-cells: true
+  nvmem-cell-names: true
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    usb {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ethernet@1 {
+            compatible = "usb424,7500";
+            reg = <1>;
+            local-mac-address = [00 00 00 00 00 00];
+        };
+    };

-- 
2.53.0

