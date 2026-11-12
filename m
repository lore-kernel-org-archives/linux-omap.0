Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794505917;
	b=nnWMrcnG80x2AjZpXWrkAn0grP06BMC8d72nsD8WcLsQao1VkKlHSebwcNtT9XeVl/Qi
	 VIoJRKMJspV9mIyawwNDwy80GcfOmrYAjsQq0ZPPj9G7H1sdTv5xjig88FBYJuZMnCkig
	 3vcrZ4WJDpYpoXVGxdZ6ugQNecGmR5jV/ckxG8BFdNzBNZ17ZNP+80PpcNr1Cc7YPJ5xn
	 94uCePHAl/cqt42NYvYg+RFsSqe2Q5VrKqpdYSoyvFjrJPUqCe6pMOII/ijiB86DG64vV
	 XTMiFRC8F2zYyZ7KBROhSxuxXb+U4alit1cSkp2IXT96keQuRQ+EtD4+r2cB1yKgmxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794505917;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=fWLnRTHzq44+Vxh7KKtStPCPVQVw0PPt5S1VYLelmew=;
	b=CRQgGys40crDoI5PiMDxJzBW48l7tMOiYBrQ3YnRupOiRQasPvyB/8U8WGR1QPzfZDto
	 w9iBq5zB6+F+1RS5HqUYbozZw/FXKHsUjcPihmo+ihjuM1DBjmJeecfUrxaELFMhdiQvy
	 DO5XUusHvjWXYgQ/SRFz8xwzlimd/J3ENkM0M6uXKUA1XhWibJLVr1Ij44EpdbpDb6VWR
	 DCqWCZKWZTo9+DFvUmBYEP06bWmklaJvk7sLMCA+PxMJm2P9ZPmajJJlUvocPQCMe0cn9
	 QjuamExgWLUQNlma/TtcFddUgfposeJTKCstO2eoFDTyHTUi/J07+qPtDDSs0prP3fQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wPLZHWUw;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62548606A33B
	for <linux-omap@vger.kernel.org>; Thu, 12 Nov 2026 17:51:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62548606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wPLZHWUw
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-372cba0ecf9so13844eec.2
        for <linux-omap@vger.kernel.org>; Thu, 12 Nov 2026 09:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794505916; x=1795110716; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fWLnRTHzq44+Vxh7KKtStPCPVQVw0PPt5S1VYLelmew=;
        b=wPLZHWUwS4SkAzUrIEj/S9yspQRsPrlBsgwP/pUKdTmQxCGl6I4PfcNMjKMgcxJLat
         7+8eZmhhmNfZnSbUIEvhYhcaviJPQktGzGZsPSmo9Ijs0zO2ed2Ja6wGnwEbFPe0LpVD
         NoxN2ku7SKy9yA8c8w1s3vDjVSJm3K3bJrYgRSnepc0SFwtxTYaW58fbEuARLZ7IiDft
         bBAUZmoVDe2eS6Fx7N4aAAgFMN6e380of1eLKWiBHzCnt/lZYtrj0gzTwgrgWmWHoQpg
         dzrczmESX/20YnGx2F7NFukpMI0/+H8Vr2m5xM/5ZW1wT0Zg3MYtPrjGdXV/hi++r+Wv
         KZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794505916; x=1795110716;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fWLnRTHzq44+Vxh7KKtStPCPVQVw0PPt5S1VYLelmew=;
        b=pczTZbDA1tLlr8TIzTIae+CUb7laATsITWzwF/tRNx/aaMHTz07vEq/2bvF4oUo7yT
         SKuriJTkJNzDL1CRXZcpJ5asRex5ZoZBqA6z/+jQ3GO3NMB2+GS0NztsZ8cxBP9mMpg1
         /O2qRqT7JKvEZyY8WDDxTnErX+MtZV2WZOORdXZo6XxBWzt6csXiA2KrA6CHis2U3WUa
         4ohneucKPnJ8DdVVAnxG0AMGj7mHWVvRKgXg4fuB9/c0U1s+/Ji5oN7qqLz0RXse05z7
         f6MUovn6/+eEvkp0DGk49MjSY/jAnJ26+PZU2Vx7vDqnR5Uv5yatLN+JEtdVEN1ngEt5
         1M3A==
X-Forwarded-Encrypted: i=1; AL+hErGpXr9ZoII6+q1VGSqaYKvNc6n2wW9gcYdAWxGsvnJZQpDFN+2drp91+4Fb6KiSWwMBHFgHhPl2Cto/@vger.kernel.org
X-Gm-Message-State: APuU4Z/AuyUx2qmzO+vd4Q3EuC32sZCpivjoFOF5ih/8nYLsjKJVfbd7
	cJc5gcgM9uqOdn6eRlTJjNVUOQcRgtHYwY8GUccYthFHcqsuSEOxp9XI
X-Gm-Gg: AYBFou1wA3D1WDSBzAW+vOCC8qp5SjsGvaa7p4RHktEldqMViFGxOD4q/SAuU2w0h9x
	drcBwI+vV1OK8nkgRgVKPnNmxsPJr2wN5WLWyfmo6vjnzSSPWow2DfKoJTEsoKVfSv80vnXzL+o
	WW1SWzJE+Jm0759NGryWTMdOSgcIUQRDGs/GHr2QIqABD7v5bp/zPh7FH6cEDj4JDoEAukNdfle
	WXNS7XBnsGdRgscptAwkxM3oYoOQDai26QXwjcau/ew0L6/q42gxN56VQoc/DOtPLgIiyE841Xa
	9XQICM1TNj5erYMve5dO6XFWd6DgX7g9WP7zN3yrEEtBoG7VuXBOvOSlMXnSGhHnYqILV7QZRKH
	4UNqOqpJ9X95cWWdAbA/qVtO/DnBMOkqoYyHnB3bOcSxjvPanIa6NIxZ/7LX/40Fjz+erQz+fGj
	KfrPLcgHptHY3tEVKyvQadL0/9JqlNIz9b90JiiMRLIYBSKtyzj5EUbZOWsaQeiEGoGQc52CO6t
	grKeXLlMy0B2dVKwDcqhkU626AVFc1lthe+VHgC3bdLF0+4uuPY9KHSL6epbj/9j9t+bQKfdAf+
	y6ifXwRQleXIa1pQEQ5hwzZ3wcwgm4lWk0vU+w==
X-Received: by 2002:a05:7300:5621:b0:36d:cd5d:d809 with SMTP id 5a478bee46e88-37684af683dmr9424431eec.1.1794505916366;
        Thu, 12 Nov 2026 09:51:56 -0800 (PST)
Received: from [192.168.1.4] ([2401:4900:881d:321d:eb39:71d3:15f6:5fe0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379563e6b6dsm237865eec.21.2026.11.12.09.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 09:51:55 -0800 (PST)
From: Bhargav Joshi <j.bhargav.u@gmail.com>
Date: Thu, 12 Nov 2026 23:21:23 +0530
Subject: [PATCH v3 3/3] dt-bindings: bus: ti,omap-l3-noc: Convert to DT
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
Message-Id: <20261112-ti-l3-noc-v3-3-7281b1af8030@gmail.com>
References: <20261112-ti-l3-noc-v3-0-7281b1af8030@gmail.com>
In-Reply-To: <20261112-ti-l3-noc-v3-0-7281b1af8030@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Santosh Shilimkar <santosh.shilimkar@ti.com>, 
 Sricharan R <r.sricharan@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 goledhruva@gmail.com, m-chawdhry@ti.com, daniel.baluta@gmail.com, 
 simona.toaca@nxp.com, j.bhargav.u@gmail.com, linux-omap@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794505884; l=3333;
 i=j.bhargav.u@gmail.com; h=from:subject:message-id;
 bh=WKKUN2jQjfC7QZp1fenPy2OkomRsdptL4bsEgub5sUs=;
 b=OC1C4RTN4l9W6mCWrzTTZAIVvuxMqR6iLq406lkQSIet3W+nLW5+HVOeV23STNKKosuTOx0K8
 RNQ4WzO6L0xDdaIcp5dmJ+GepcTWaTfrbCKBQongjNDNIlYSmlU7CJy
X-Developer-Key: i=j.bhargav.u@gmail.com; a=ed25519;
 pk=IqNDwUZKECEA+n8wXctFLBbYL9NhFstZNbOznm/nX1k=

Convert the TI OMAP L3 NoC binding from text to DT schema. Drop
deprecated ti,hwmods as it is not used anymore.

Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
---
 .../devicetree/bindings/arm/omap/l3-noc.txt        | 22 -------
 .../devicetree/bindings/bus/ti,omap-l3-noc.yaml    | 71 ++++++++++++++++++++++
 2 files changed, 71 insertions(+), 22 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/omap/l3-noc.txt b/Documentation/devicetree/bindings/arm/omap/l3-noc.txt
deleted file mode 100644
index 66548395fbdeb..0000000000000
--- a/Documentation/devicetree/bindings/arm/omap/l3-noc.txt
+++ /dev/null
@@ -1,22 +0,0 @@
-* TI - L3 Network On Chip (NoC)
-
-This version is an implementation of the generic NoC IP
-provided by Arteris.
-
-Required properties:
-- compatible : Should be "ti,omap4-l3-noc" for OMAP4 family
-               Should be "ti,omap5-l3-noc" for OMAP5 family
-	           Should be "ti,dra7-l3-noc" for DRA7 family
-               Should be "ti,am4372-l3-noc" for AM43 family
-- reg:	Contains L3 register address range for each noc domain.
-- ti,hwmods: "l3_main_1", ... One hwmod for each noc domain.
-
-Examples:
-
-ocp {
-	compatible = "ti,omap4-l3-noc", "simple-bus";
-	#address-cells = <1>;
-	#size-cells = <1>;
-	ranges;
-	ti,hwmods = "l3_main_1", "l3_main_2", "l3_main_3";
-};
diff --git a/Documentation/devicetree/bindings/bus/ti,omap-l3-noc.yaml b/Documentation/devicetree/bindings/bus/ti,omap-l3-noc.yaml
new file mode 100644
index 0000000000000..85f314f177379
--- /dev/null
+++ b/Documentation/devicetree/bindings/bus/ti,omap-l3-noc.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bus/ti,omap-l3-noc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI OMAP L3 Network On Chip (NoC) Interconnect
+
+maintainers:
+  - Santosh Shilimkar <santosh.shilimkar@ti.com>
+  - Sricharan R <r.sricharan@ti.com>
+
+description:
+  The L3 interconnect is an implementation of the generic NoC IP provided by
+  Arteris.
+
+properties:
+  compatible:
+    enum:
+      - ti,omap4-l3-noc
+      - ti,omap5-l3-noc
+      - ti,dra7-l3-noc
+      - ti,am4372-l3-noc
+
+  reg:
+    minItems: 2
+    items:
+      - description: L3_MAIN_1 / L3F
+      - description: L3_MAIN_2 / L3S
+      - description: L3_MAIN_3
+
+  interrupts:
+    items:
+      - description: l3-dbg-irq
+      - description: l3-app-irq
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - ti,omap4-l3-noc
+              - ti,omap5-l3-noc
+    then:
+      properties:
+        reg:
+          minItems: 3
+    else:
+      properties:
+        reg:
+          maxItems: 2
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    l3-noc@44000000 {
+        compatible = "ti,omap4-l3-noc";
+        reg = <0x44000000 0x1000>,
+              <0x44800000 0x2000>,
+              <0x45000000 0x1000>;
+        interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+    };

-- 
2.56.0

