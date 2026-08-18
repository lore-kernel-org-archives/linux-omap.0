Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03875377563
	for <linux-omap@vger.kernel.org>; Tue, 18 Aug 2026 14:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787063359; cv=none; b=eUmazCqNb6Wfn+b6AVUC27uBvP3+ovLDh2LWQwbO34h+zFyX6f58GBJy/Z501uEsugeJUbiRG5M75MvmFrq9I34y59BP9Qp15cRcC/IXb7Y4+HN74LiDUld1P+90jdej7mOpoxTBntVRzNfl658av3pQsrqphYHlNRgMhxEewkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787063359; c=relaxed/simple;
	bh=JGfyrv6YsEMW3ySMnbJnC0enIp8myRb40Fox7M1f5A8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Dsi/UlNB2BbGRxp6q7RRKLW2hlMWkz0VWIKdslPPTwXQz1vgcB9voz3tcne9sBvE5iuVbXmNXZA40EZKv06vhlxKALjAH08iIvWuYf2IQfC4EWBWo8dTOyNWIL1gQ2EPKu8a/ikcPdn/O+8GSCqFcb/TSto5xxRrGX/xPWdaEFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jc0QgWIQ; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jc0QgWIQ"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cbedf082ba2so23816a12.1
        for <linux-omap@vger.kernel.org>; Tue, 18 Aug 2026 07:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787063357; x=1787668157; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ODrlCcCoU3q8OoWZI3Z+F20E6MLxBbiDOF0rGC7y2kc=;
        b=Jc0QgWIQ1qh0dGxyvqNcvcmURorFEdKsFq+o6AL2zUuNr531JGFlcGJFkITbjpHNNS
         4ZF5k0tvEr217kStjZIS1GbAYGJxUIUfLQHmsKQfhqKgMWHYbhHbaLNq9ZcN9eLANTTJ
         DRea0GLJ/ucGSSsYaWwu5M5bP6fV8j/iZvLDENnbjO0tJfoh2dGHpQWcw0iBnXD2GR8m
         MHUsdwXvV2/eSlmV2mj2siOYj81RUOlEaua+7Er8znISt/Ow1rVv0ZM0PDfn+ba9WM2d
         M6C3YeblQpowXbMG+kZibdElKVzlBUfsVHoTN2wWO1B+H5SGNki0iKCfXeZdIhPnVA5H
         xgXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787063357; x=1787668157;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ODrlCcCoU3q8OoWZI3Z+F20E6MLxBbiDOF0rGC7y2kc=;
        b=Y41abH8wycl7xDnD84gzIzB1kcEglk95KecAkM/x1h+0+dUmfPj7Vi/5o5mwp4sZAn
         tQoHTBJFkmLo8wuCcbiejIPfg6wGG/wG35/pjdXD4syRw5slot6Fw25Vq7qDWSM6ZquK
         VpSIfVyQYlju144t+qmKwLqpoc2eQrnCp+WoHxs1ULiCl45F6JS76i6LODCN/kvZTM7k
         MBwl6l5EcOGIyw03mk1qe0zkcFUZPKde9NZsDq2Uc/I6jTTgmcMj2155JOALnmXCoHo/
         eRe9vgdlFsTqEzxFpypW5C/ME4HzXwBXyMtWXODdyx3GSkxppLBHXnoQKmRHIeOml+IX
         fZAg==
X-Forwarded-Encrypted: i=1; AHgh+RphOTVier3kndLBhmoHypfGxEvyxk15BZ0GSiKDXqyFKcXJDPXPR2c7iEamJpaWYmAbRu7WJPQO4PQV@vger.kernel.org
X-Gm-Message-State: AOJu0YwKE0WdtZWA7v4n843xGEk07d918RabKyiWTJ6QKnXpSEZ7tNKF
	ubwCmtJat82yIOvnJqVbGpwtpeibnX/ICkpYnK6UqnCLv0QU/OaxdT09
X-Gm-Gg: AR+sD10XhbRDNXEXm2XeT0a+w6eGhrfzGcDwYYZJJBO7S3hli18Gzc1bW/10/Q1k+vD
	tSlWGzQgK4MPSqGur40HGr4fxiFJne91e4XDVeiLOUddHjBXqMZdR2WTutIRRYj6n7Yngx61Psy
	s4Gwih82BoApNIIPpQKS6QYX7vCLO6Qbf6A1jy1dH/8dh5/NHG4fwNYja0+GJr/t3liMjn1+0bo
	8zgguyOYnGQYOvgAPb61usOAuyQmyLBc3WqFGY6SfPozoulgtsA8Dd5h8LdMhUtLvhvqx24xKdK
	iM8Nb/v4HDxn1HGe1VZsBzRAUoGJtwqY7PjyyMgMJNSUOAYGhcrEBIJSpEbusHX9bvNpqDBbPtf
	9CDSX33I8Pvq+SI5xlXjnvqnPzpiEWde56NXuan20ZR4/aZcKSfdLtXHr/C20E7fAwJqa9sxwT4
	eFuMYLldQpaYLTbf77RpCPt1HVG2ntUXtH1gMkW7VVgo0GfvrIidSmkCCky5QwZJD8OCV8k/xG
X-Received: by 2002:a17:902:850b:b0:2d5:cbd3:8eb1 with SMTP id d9443c01a7336-2d5cbd38f48mr47861085ad.3.1787063357187;
        Tue, 18 Aug 2026 07:29:17 -0700 (PDT)
Received: from [10.90.163.252] ([2409:40c2:501a:6e15:dc3f:c23f:e55e:d03d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327b43d488dsm9043527eec.29.2026.08.18.07.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 07:29:16 -0700 (PDT)
From: Bhargav Joshi <j.bhargav.u@gmail.com>
Subject: [PATCH v2 0/7] dt-bindings: usb: ti: Convert AM33xx/DA8xx MUSB
 bindings to DT schema
Date: Tue, 18 Aug 2026 19:58:42 +0530
Message-Id: <20260818-ti-am33-usb-v2-0-66fd44d66824@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/1WNyw6CMBBFf4XM2jGlUB6u/A/DopQpjBFqWiAaw
 r8LGBcuT3LuuQsE8kwBLtECnmYO7IYN5CkC0+mhJeRmY5BCZqKIcxwZdZ8kOIUaU5UWVpLKBVn
 YFk9Pll9H7VZ9OUz1ncy4J3aj4zA6/z7u5nj3fuXirzzHKDArtVG2lI1N1bXtNT/OxvVQrev6A
 bHjDQi4AAAA
X-Change-ID: 20260817-ti-am33-usb-4548f2e570ef
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787063337; l=2756;
 i=j.bhargav.u@gmail.com; h=from:subject:message-id;
 bh=JGfyrv6YsEMW3ySMnbJnC0enIp8myRb40Fox7M1f5A8=;
 b=9giuNSenfwjusCj/dLjQXYCk5quKNspVE/tzT8aHCiTbMgmU5VX0Hd6wozCgezLFxIvzYRC+m
 ezTX+JHv/U7C/ZWvHRReZiDvw2g5pyp+tdnBTdHyWcA5zP/tKO+xt+a
X-Developer-Key: i=j.bhargav.u@gmail.com; a=ed25519;
 pk=IqNDwUZKECEA+n8wXctFLBbYL9NhFstZNbOznm/nX1k=

This patch series converts the legacy TI AM33xx, DM816, and DA8xx
USB/MUSB text bindings to modern DT schema.

The legacy am33xx-usb.txt and da8xx-usb.txt bindings was historically
structured as a single, monolithic file that documented the entire USB
subsystem (the wrapper, core MUSB controller, PHY, and control module)
all together. This series converts that monolithic text binding into
proper, distinct DT schema files for each hardware component.

Patches in this series:
1. dt-bindings: dma: ti,cppi41: Convert to DT schema
2. dt-bindings: phy: ti,am335x-usb-phy: Convert to DT schema
3. ARM: dts: ti: am335x: Fix redundant interrupts property in USB nodes
4. dt-bindings: usb: ti,musb-am33xx: Convert to DT schema
5. dt-bindings: usb: ti,am335x-usb-ctrl-module: Convert to DT schema
6. dt-bindings: usb: ti,am33xx-usb: Convert to DT schema
7. dt-bindings: usb: ti,da830-musb: Convert to DT schema

Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
---
Changes in v2:
- patch 1: add interrupts as required property for am335x-cppi41
- patch 4,7: add pattern constraint for dma-names
- patch 6: remove deprecated property ti,hwmods from required
- Link to v1: https://lore.kernel.org/r/20260818-ti-am33-usb-v1-0-69ac5f92df45@gmail.com

---
Bhargav Joshi (7):
      dt-bindings: dma: ti,cppi41: Convert to DT schema
      dt-bindings: phy: ti,am335x-usb-phy: Convert to DT schema
      ARM: dts: ti: am335x: Fix redundant interrupts property in USB nodes
      dt-bindings: usb: ti,musb-am33xx: Convert to DT schema
      dt-bindings: usb: ti,am335x-usb-ctrl-module: Convert to DT schema
      dt-bindings: usb: ti,am33xx-usb: Convert to DT schema
      dt-bindings: usb: ti,da830-musb: Convert to DT schema

 .../devicetree/bindings/dma/ti/ti,cppi41.yaml      | 109 +++++++++++
 .../devicetree/bindings/phy/ti,am335x-usb-phy.yaml |  49 +++++
 .../devicetree/bindings/usb/am33xx-usb.txt         | 200 ---------------------
 .../devicetree/bindings/usb/da8xx-usb.txt          |  81 ---------
 .../bindings/usb/ti,am335x-usb-ctrl-module.yaml    |  38 ++++
 .../devicetree/bindings/usb/ti,am33xx-usb.yaml     | 103 +++++++++++
 .../devicetree/bindings/usb/ti,da830-musb.yaml     | 113 ++++++++++++
 .../devicetree/bindings/usb/ti,musb-am33xx.yaml    | 113 ++++++++++++
 arch/arm/boot/dts/ti/omap/am335x-bone-common.dtsi  |   1 +
 arch/arm/boot/dts/ti/omap/am335x-boneblue.dts      |   1 +
 arch/arm/boot/dts/ti/omap/am335x-bonegreen-eco.dts |   1 +
 .../arm/boot/dts/ti/omap/am335x-osd3358-sm-red.dts |   1 +
 12 files changed, 529 insertions(+), 281 deletions(-)
---
base-commit: 8d3ae59288f1e7d58d76558a6ee96d533bc5019f
change-id: 20260817-ti-am33-usb-4548f2e570ef

Best regards,
-- 
Bhargav

