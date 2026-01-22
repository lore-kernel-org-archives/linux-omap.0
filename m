Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E911355048
	for <linux-omap@vger.kernel.org>; Thu, 22 Jan 2026 17:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769104474; cv=none; b=GBOPmAHd2ThG7MHcjx4hN3IrSIrOq90/vDokE4BrPAcpq7S0iRB6qRGYlntY+gU2AbwFMUADYou5beAB93/6fL4CzM3/96z8FIZrwmg+DpRoaPnEcbEsn0DOLx3/spFQZ80qeGLJMbM/Fxi0tBuWnYgOL5X+eCb/nz9g+pEq9mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769104474; c=relaxed/simple;
	bh=/5KChL9587C9y5j3aCCxaDWmoc9qI7T4dqowE01qbDQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qYqJ1ETUT8pJAxmOqqsDxDGyRTuIWh5btSJBULB9y0FN/zZAHMn1ad9D1ZUv/bPvxv8zavKcdYftWShrIiDUPy21OkAEI2CsBi8Oa2hhNMrR/O+XVcpLpTnOrPqjp3M2Qt8HeTfmGMRUk6EIEPA0UpIJZY+qxMpNukVgJeD2TjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jrTgTLMh; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrTgTLMh"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a2ea96930cso8788195ad.2
        for <linux-omap@vger.kernel.org>; Thu, 22 Jan 2026 09:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769104463; x=1769709263; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IzyR4xVrpsSybc4UKBr7Yf9UVEuXH3UQn5bgnz7MscY=;
        b=jrTgTLMhN1DTUcDfvTcA/IE94RTeMey8NvVuTTMW4DnQ10XnsWwnhjpoPfTu2eSh2F
         6kxxvDA2h0CH1YPOFX8d75HV2r1fn35l4A+WGLocKw7YodYO5aeydCYRQ7IzX1moQ1lr
         XwWJm+/1+GgbDR7dYAstxLTvKkeI3plbC3f5KpoJynKHlG54uANZPMYRkisoztg3Injx
         2SiD5elZHPOdiRLcjIBRO2Rs70k5OI5lT+umOYNxalt/fATbVY+UPOb28NqQ1ZUpRa+1
         ot+QLo5ekrxZNdUzYwSOFBTmNnMlBYvI6puea+yBwFjWny3Wb2Og+FGyp0qg1dsbwxVm
         NllQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769104463; x=1769709263;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IzyR4xVrpsSybc4UKBr7Yf9UVEuXH3UQn5bgnz7MscY=;
        b=iPND/IhXy+nYaZpCRn+3I6rro5CPb7Ls5X4l4R0amy6WUUsSYtUeSKvMCUHLReee+E
         cNngTs8RdqFyhOKYKrR5WxCz381lpUFy/VbMiDVBQIv7/A8cuCX4ASEm1F+SO+o0qLi/
         PYAhJ5T5/kIZY7r+Lg3R+JgC7qfVWAzxzi6bZUR1j1X3z3LROVNPhV0DSNjznH94zXUm
         UhZ9mb2XJnFOHEJGQc5CdbRCHs8gCESI2DL/O0lTZUFbJbd0PlwA+cWx292OhfrtpZeS
         V4KhB/BUC5n4CtO0EE5lt6VwX+Yp98xX8NK76vQPd8FQ8xWiKFL2/FY0w/5ZM7PfSnSd
         WPYA==
X-Forwarded-Encrypted: i=1; AJvYcCX4Uzrd8uPArJPaLFFv3hsuxG2Xwn9NJsH8kXN6p7SJCYcQ8FKroLVKpo5tEkqYwcRlVnQkH1M5SzTy@vger.kernel.org
X-Gm-Message-State: AOJu0YzfKffZ6oBCp2eTqvfr8I+A6rg/DEj+gRdgV3Ons9hdl6+5XFwP
	QzJq9irkvUqgQ8ahKwGi0U/JIqV146iJQKJVZoGGRcZim3zLwx3F+Q+d
X-Gm-Gg: AZuq6aL1ka9MoF7bDdiOV+r6drlYLF7Zp9m5ZG3C6fAt7zRXvQHtCfmXXuvZxBTAfSL
	MgdlMDzujGDMtKI6vsZfWc+F65Y2KnJGyz+hbspwevgmBHQreScBHSkGH1pCcz0/xiPN77B6D/S
	byN55CPCdHhN5iDszFeWCfxtpiEbc3frnbL/rv/LrLYc+dt0dI2pna8WGX68j+PyFlzJS/nxKca
	gQkwXzJ6N3kq0GM3Qkjr5oti3ROds/ggvk9xjNFKqgHuzSAQBnvCEugCNLGRFxKzo+K0KrjFleO
	eiuSCQWGXqdJhcAB3sVPefcrH7TjVTX1WNRFAW0mY22reNcsBzKegNjCY6fLA0ZJQJAjmOu4q+T
	L9a4fk6l6s1UA1cdTLKUnXWygCnwi8tQ8cTNT2jW8sVrX88K03vR+JjyvjpehUnlH8KoJMh+EEM
	enBTrHEH6JED8yq3a8aSBhln904WTxnEMM2Q==
X-Received: by 2002:a17:903:2406:b0:2a7:b412:6cbf with SMTP id d9443c01a7336-2a7fe76fd29mr2007125ad.55.1769104462539;
        Thu, 22 Jan 2026 09:54:22 -0800 (PST)
Received: from Black-Pearl.localdomain ([115.99.251.203])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2a7190eee4fsm187745195ad.42.2026.01.22.09.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 09:54:22 -0800 (PST)
From: Charan Pedumuru <charan.pedumuru@gmail.com>
Subject: [PATCH v3 0/3] dt-bindings: phy: Convert TI OMAP control and PIPE3
 PHY to DT schema
Date: Thu, 22 Jan 2026 17:52:56 +0000
Message-Id: <20260122-ti-phy-v3-0-751619729433@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPljcmkC/02MywqDMBBFf0Wy7pRMUl9d9T9KFxonOlAfJBIq4
 r83Ci0uz+WeswpPjsmLe7IKR4E9j0MEfUmE6aqhJeAmslBSpag0wswwdQukRV2XpAtjTSnieXJ
 k+XOEnq/IHft5dMvRDbiveyKTKPUvERAQCqNtSsrUTaYfbV/x+2rGXuyJoM5a/tcUSKiQjMpvE
 q21Z23bti8Tq0Qw0wAAAA==
X-Change-ID: 20251231-ti-phy-58bb9e38cfc9
To: Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Roger Quadros <rogerq@ti.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, 
 Charan Pedumuru <charan.pedumuru@gmail.com>
X-Mailer: b4 0.14.3

This series converts the old text-based DeviceTree bindings for TI OMAP
Control PHY and TI PIPE3 PHY to modern JSON-schema (YAML) format.

Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
---
Changes in v3:
- Change maintainer to "Roger Quadros" for both YAML files.
- dts: Split node pattern updates into a separate patch and align node
  naming with standard conventions.
- ti,phy-usb3: Update node pattern to follow standard conventions.
- ti,phy-usb3: Refine the reg-names property and add constraints for
  optional phandle-array properties.
- ti,phy-usb3: Redefine "syscon-pllreset" dependency on the compatible
  "ti,phy-pipe3-sata" in a correct format.
- ti,control-phy-otghs: Update node pattern and adjust maxItems for reg
  and reg-names.
- ti,control-phy-otghs: Fix the conditional handling for the
  ti,control-phy-pcie compatible.
- Link to v2: https://lore.kernel.org/r/20260107-ti-phy-v2-0-a1ec27401fff@gmail.com

Changes in v2:
- ti,control-phy-otghs: Update commit message to reflect the latest
  binding changes.
- ti,phy-usb3: Drop the obsolete "id" property from the schema.
- Both bindings: Update maintainers list, modify node pattern and improve
  node descriptions for clarity.
- ti,phy-usb3: Introduce new YAML schema with properly defined optional
  properties for the PIPE3 PHY.
- Link to v1: https://lore.kernel.org/r/20260103-ti-phy-v1-1-8c3f5e2cbd63@gmail.com

---
Charan Pedumuru (3):
      arm: dts: ti: omap: align node patterns with established convention
      dt-bindings: phy: ti,phy-usb3: convert to DT schema
      dt-bindings: phy: ti,control-phy-otghs: convert to DT schema

 .../bindings/phy/ti,control-phy-otghs.yaml         |  99 +++++++++++++++
 .../devicetree/bindings/phy/ti,phy-usb3.yaml       | 135 +++++++++++++++++++++
 Documentation/devicetree/bindings/phy/ti-phy.txt   |  98 ---------------
 arch/arm/boot/dts/ti/omap/dra7-l4.dtsi             |   4 +-
 arch/arm/boot/dts/ti/omap/omap4-l4.dtsi            |   4 +-
 arch/arm/boot/dts/ti/omap/omap5-l4.dtsi            |   2 +-
 6 files changed, 239 insertions(+), 103 deletions(-)
---
base-commit: cc3aa43b44bdb43dfbac0fcb51c56594a11338a8
change-id: 20251231-ti-phy-58bb9e38cfc9

Best regards,
-- 
Charan Pedumuru <charan.pedumuru@gmail.com>

