Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835F72D876B
	for <linux-omap@vger.kernel.org>; Mon, 17 Aug 2026 21:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787003261; cv=none; b=l05UwG8EnP1myEaeQ9TV3rPy1IIbabhZoxoQWHUME2Q8qVFE022FMB9ZVBKySoNdhjikABAgnP1VsgRiTYya3sTSgfbn36Rusp67miNKojcrUPvUsmzSwT6QFqL5cmzQGRG7zePZuumbVJANEK3PC55cy7psB3KB60gdBBQASnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787003261; c=relaxed/simple;
	bh=x82f2rFO1TTjFpVekp+USEIM8EAiJutd+tABMnyaNHw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PlIx1bEW22oHp/OI4kUb0g6U3OlKvditZ9iK9hnsGEfNRiCXLP/vRPu9cqM2zx7TBT/AShAhTToDzbgqVRrWDkGjHkgCM2zwDPiJvS8DGF3+HKO6Rtmd0yXc+LW6NLkFBso2FYA2+s7CjRs8/FObBTAVKL6QI/MSYlZkyFj+cXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W8oNtf3H; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8oNtf3H"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cbe4592c193so222086a12.3
        for <linux-omap@vger.kernel.org>; Mon, 17 Aug 2026 14:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787003259; x=1787608059; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AbV7RIHYMEgMD35kCL1q43FBlvr9xDn3Pi9g2Kfmf8I=;
        b=W8oNtf3HxAr5/459feLBN3L0OjoxB0x9QD31SdmVurBjCbsuJXbT5GHWcpEv39xtKH
         woUSU35uCzlKrmWek+Y9xy6hmlYTD0PE+PnYHiCkZvQB5Us5UEbRJKQfr67v1BL4FrDQ
         KVI/K5SaZNY52KiZJPqpj8GE6fwvwpE1gOd06yanGpItDJNrWM4HLf+mJPy7Sn7EnJZO
         JbB4NraqEaHjRQ0HDY5E8vwoQqlTKCf+w89lJRu4najIY9rUouElbrLNTjt45+TvqEPR
         mXdMf0D7kUtqfwXL06XPhx6IsnNJYv4PeELefdPDf/TC5/ayDPdeRN+guyBPVLSRBPdU
         5o7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787003259; x=1787608059;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AbV7RIHYMEgMD35kCL1q43FBlvr9xDn3Pi9g2Kfmf8I=;
        b=a0TtHLvIsKykbA6HIzYX3/Sf8+INVLQ5BVZ0gCLlPG+UmCVh9k3EEyHTF1FH4R30n4
         UqwBw6Nbd+OzOPXNm6sP5PnG1HLXpH70QeV/BsosO4vlynggqV63Iq2dfLqYVKm6mODx
         Why/wn4eAKRyNSVF1AYoLySTQ2W2wP3kzqCy/H48NoY8s+M46X3emG3kiP1LROgGNPbv
         X6wPs4iYx9YUxZFVjiCPnDAXEwXVbTCuDjom2oDxgV4KuWOOdMoqG0apKGlRFgZ8A2tZ
         qfZzYqUuwLEmnO9YHEuJRg+Z/oe2EewMaAi1qyOE3Yssc8zsccfJtumULin7AQUAWRM2
         GoDg==
X-Forwarded-Encrypted: i=1; AHgh+RoWAofIDP+U2HsgVofliGDQhUQ18rX8xDcL8rTkCDiJ/vdyb893gi4KNIojXkw8RTvTNhham2FV60fc@vger.kernel.org
X-Gm-Message-State: AOJu0YzMtNR2vfLqMSUZdBZtf9/Vzmnf43GsOci187343SwZeMLPFB7p
	7F9cSBFzsS4CF8AGVsZZEyO+5r7AMFOSfk3yf2+m4qB0KM+bZdbhhMJ1
X-Gm-Gg: AR+sD11P9+/LaxF412KjCcwneO+XkRMcNhiWgDYztsXB2qSh7jdi4fcyiZHNMrOZPtm
	FoaDPAnLHEcDGrnCQRrK6XjRRT/T3mqjHR/uPCwcvlKsEVdGIPZva/CqIso0BcyTDpwPGV0gweu
	jLHZOm/brpGAZd8EJtDJy5KY09CI2DdfAZhcg8nq/m0XnaMS0HmsHQ5Lg2dkRjl/oypy3dmyXXY
	okc+wtV5pyvRg65lS93ESTMa7EHDxKacNTbsProU6+uInMFfpL2QbrI/v0AaKQUyXVcdKKySbWD
	gSqq3GtX19Z+wegKji+vINYyLJQ4+kqFQawE3kYVfE9kHcZLXgTIeVGHA5rJsog08YYdkYicJTq
	stMvHxOwE7Kao/xDMyHdAed2L2FWBeClj/1DPnzRvttD8QiqpA8RQNZ/wQGmstkrkWN0kDhLqOW
	rjrN8CvBYm24xtdCXR7abY6kvCEcpHK72BdFW4X0/NwyjWFmHN5/qNOZX4GKzSUn5bU7IT2KVm+
	A==
X-Received: by 2002:a17:903:2ce:b0:2c7:ef84:c58e with SMTP id d9443c01a7336-2d3b0827041mr219544715ad.1.1787003258858;
        Mon, 17 Aug 2026 14:47:38 -0700 (PDT)
Received: from [10.112.173.252] ([2409:40c2:5053:3384:1c8f:aa2d:e07e:6d3d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3267c388e3csm10153024eec.21.2026.08.17.14.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 14:47:38 -0700 (PDT)
From: Bhargav Joshi <j.bhargav.u@gmail.com>
Date: Tue, 18 Aug 2026 03:16:32 +0530
Subject: [PATCH 2/7] dt-bindings: phy: ti,am335x-usb-phy: Convert to DT
 schema
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-ti-am33-usb-v1-2-69ac5f92df45@gmail.com>
References: <20260818-ti-am33-usb-v1-0-69ac5f92df45@gmail.com>
In-Reply-To: <20260818-ti-am33-usb-v1-0-69ac5f92df45@gmail.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Vinod Koul <vkoul@kernel.org>, 
 Frank Li <Frank.Li@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Andrzej Siewior <bigeasy@linutronix.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Ravi B <ravibabu@ti.com>, Kumar Gupta <ajay.gupta@ti.com>, 
 Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-omap@vger.kernel.org, 
 goledhruva@gmail.com, m-chawdhry@ti.com, daniel.baluta@gmail.com, 
 simona.toaca@nxp.com, j.bhargav.u@gmail.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787003201; l=2477;
 i=j.bhargav.u@gmail.com; h=from:subject:message-id;
 bh=x82f2rFO1TTjFpVekp+USEIM8EAiJutd+tABMnyaNHw=;
 b=xQkPjwuZse8OJWLFHr5jkhzUEk1s0slcPTBDT1bUKVvPkldm8oswiucbLVPFXWOV3PZZEUBPk
 OnGAKmqQ+gIBh2C+PSzghXuJkChgNxDAZePiB4N03yFOUP1Unchuq+e
X-Developer-Key: i=j.bhargav.u@gmail.com; a=ed25519;
 pk=IqNDwUZKECEA+n8wXctFLBbYL9NhFstZNbOznm/nX1k=

Convert the TI AM335x USB PHY text bindings to DT schema.
Add undocumented vcc-supply property to match existing DTS usage.

Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
---
 .../devicetree/bindings/phy/ti,am335x-usb-phy.yaml | 49 ++++++++++++++++++++++
 .../devicetree/bindings/usb/am33xx-usb.txt         |  9 ----
 2 files changed, 49 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/ti,am335x-usb-phy.yaml b/Documentation/devicetree/bindings/phy/ti,am335x-usb-phy.yaml
new file mode 100644
index 000000000000..b28cd42ece5e
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/ti,am335x-usb-phy.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/ti,am335x-usb-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI AM335x USB PHY
+
+maintainers:
+  - Sebastian Andrzej Siewior <bigeasy@linutronix.de>
+
+properties:
+  compatible:
+    const: ti,am335x-usb-phy
+
+  reg:
+    maxItems: 1
+
+  reg-names:
+    const: phy
+
+  ti,ctrl_mod:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: Reference to the reset module node.
+
+  "#phy-cells":
+    const: 0
+
+  vcc-supply:
+    description: Phandle to the regulator that provides power to the PHY.
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - ti,ctrl_mod
+  - "#phy-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    usb-phy@47401300 {
+        compatible = "ti,am335x-usb-phy";
+        reg = <0x47401300 0x100>;
+        reg-names = "phy";
+        ti,ctrl_mod = <&ctrl_mod>;
+        #phy-cells = <0>;
+    };
diff --git a/Documentation/devicetree/bindings/usb/am33xx-usb.txt b/Documentation/devicetree/bindings/usb/am33xx-usb.txt
index 8431de346129..8832843c7d7c 100644
--- a/Documentation/devicetree/bindings/usb/am33xx-usb.txt
+++ b/Documentation/devicetree/bindings/usb/am33xx-usb.txt
@@ -17,15 +17,6 @@ Reset module
 - reg-names: "phy_ctrl" for the "USB control registers" and "wakeup" for
   the USB wake up control register.
 
-USB PHY
-~~~~~~~
-compatible: ti,am335x-usb-phy
-reg: offset and length of the "USB PHY" register space
-ti,ctrl_mod: reference to the "reset module" node
-reg-names: phy
-The PHY should have a "phy" alias numbered properly in the alias
-node.
-
 USB
 ~~~
 - compatible: ti,musb-am33xx

-- 
2.55.0

