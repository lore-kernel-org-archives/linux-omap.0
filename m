Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2632D7DD4
	for <linux-omap@vger.kernel.org>; Fri, 23 Jan 2026 15:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769182766; cv=none; b=Uc7eNyqVTQw/UtjyKo7LwyxqhsrtTAUb9MJrcJhJNHs41y1+xRVIXB1kfw50oaavcjAu55R/Mh/BZSJSFBgjTH1Xrk4mwyhwcDlhvGkb4KfAE4mft4z4ZHM/OcjdZJozdJJ8642sTOFS/PVeNCXt5Bd0oXccDOkmtmY2uAghqCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769182766; c=relaxed/simple;
	bh=TaWr/LrmzAvRMdQNjiFtDzTvQFMrR1wI9b5D5QJZUhI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qTadWG36fSUkdgmaV/h09lqU6a7KlWAS9NLnnFBdaAQJdH11k1gTOpDIuigXIcqBxtNd7Seudj8JXZUKlH6+4xHp3vPKxda8sWpOXvjQ81po2r/dy9ouhYwCFC+E7woAuvmJGaYpXsESeF5GSCHbZLCadIsyVlBk4CTe1pchGZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ieT9eYqk; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ieT9eYqk"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a79ded11a2so14617595ad.3
        for <linux-omap@vger.kernel.org>; Fri, 23 Jan 2026 07:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769182763; x=1769787563; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AN7Bijlws3Yf4aNS4iNAiLjf2TZ2e4vGXijmqIVGBpI=;
        b=ieT9eYqkDZYxsZ9N/D8v+/DZ6AXVBS9lLms4gt7c6atOzDIKuoW1c+/Jdx5SV4JLUa
         A75htOz6XQISBCiED7oipZ0QTFNZV7rgPJitYq0jmDH7wXMZea1pno3iFXLL4OtakGW9
         nAlZhDYdrb2S0TLBaWdzA1RNtY/l0AdC9N6CiqLEW5QprpJgQ7dYkunc9RdUwPVtovgp
         MGD+1XogCnFFkSGkw8bn79XMmAmNs+bcVdYD6OmwtvB8WatnLd93fVKxjNbPzMqetzLg
         SlTldqQSw3WACfCRZE2awRl3zCsqyTbo0sD7en3z0ltUfiA37gLSFwYvylmTEg1ziBct
         qYNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769182763; x=1769787563;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AN7Bijlws3Yf4aNS4iNAiLjf2TZ2e4vGXijmqIVGBpI=;
        b=OGrxr+I0Fe82+xdNVT/8p8Wp9fzbm5YPN0nwkBwjTKJpo6AkH3luwM+pfZ3qJ+nzI9
         7K6lj5w/gcSdpehkkrsdgFq821iHmTWsBhCW7vs+/c2LZ4JeGC+ILb5d7d1j5P1fl432
         T8W17hcbTLnzvUPoPu6HpKAjzGnH3ALW3iqhHwVaaxFLbdK8RG9RdC1TGcy0wnYxB74N
         yoloNQphJwBdKWal0ymFgea7MzeU5FX0sTA09+2R2BLyGj4yW6BfJMcTRiHrKauguoPB
         ICAYls86YW+192HSTFVHZRy1WmT5nN2b3uzMNOo0VxV1WzXd3O+XzCHLOgJ0OQywxHr8
         1kig==
X-Forwarded-Encrypted: i=1; AJvYcCVGaD6nKI3i33KRlmRaLjOsw5wRNyb3XmcdNPRS1FKVlWv6LbMUWnlWGQA075gXBxGt+uxAxZnE9gJb@vger.kernel.org
X-Gm-Message-State: AOJu0YxvpsJkEYMgmHwAHBSFNZd8WCrbn+VHG4LwtXm6M+F1Usl8bk6z
	PTZ+3B8e8AUfPUp7VXONoRW0aLISgaxJ3imOvr3xInme6ucQP+7qXS5q
X-Gm-Gg: AZuq6aI1RDa2thxW6VPxujjZS7bKifpDnuNc7zmjO6tdnLiFa9sFUxriG6mO813Qahc
	01lk0HUAvh6Ia/mnJ+KNSEZq0Jrf1YMheV/AlRhswc9HfQ9l+Jb7+deU3dJjMntypq60tR6P0kZ
	b51W4EckuJc+Qvea8qt776775g4ITi3u0u2Mw1x4QkKWFcwH4x8UqxFkwA7xt/8fvf0vRjvb/BI
	lOyeyw8pzkQkcMdJUqXUpyL7Fl9XvztXwAR31Lts8J+B51ycQ2wmml0db1/XEwWJ3HHPczceaNe
	Ec6SQQry2klJt4km5l/QOi+6L0hyHhJL2trTfVKXRzrP9V5w01Bzq82M/Bj+yC9LCNv2N4oELMI
	IKpxjUDKHAfv6WdZ+9o52g/i4FP65AjixANAiikzYBeIpKOoXBI7pQ/xRzyX1c8osRu42zFMcjP
	FMtxw8P2x70kTwcoLEJUCHreJef4PyUKprrg==
X-Received: by 2002:a17:902:e5c5:b0:2a0:b461:c883 with SMTP id d9443c01a7336-2a7fe747425mr32040215ad.45.1769182762932;
        Fri, 23 Jan 2026 07:39:22 -0800 (PST)
Received: from Black-Pearl.localdomain ([115.99.251.203])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2a802f9769esm23732205ad.60.2026.01.23.07.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 07:39:22 -0800 (PST)
From: Charan Pedumuru <charan.pedumuru@gmail.com>
Subject: [PATCH v4 0/3] dt-bindings: phy: Convert TI OMAP control and PIPE3
 PHY to DT schema
Date: Fri, 23 Jan 2026 15:39:01 +0000
Message-Id: <20260123-ti-phy-v4-0-b557e2c46e6f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABWWc2kC/12NzQqDMBAGX0Vybkp2Y4z21PcoPWhMNFB/SCRUx
 HdvFCq2x/nYmV2I185qT27JQpwO1tuhj5BeEqLasm80tXVkggwFIAc6WTq2MxV5VRWa58qogsT
 j0Wlj33vo8YzcWj8Nbt67AbZ1S2QMGP8mAlCgueJGaFRVnfF705X2dVVDR7ZEwLMmDw0poyVoh
 TJlYIz51/hJQzw0HjUpIINCYpHyn2/run4AG9J8JgoBAAA=
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
Changes in v4:
- ti,phy-usb3: Limit phandle arrays for optional properties to one entry.
- ti,phy-usb3: Use lowercase hex for reg values in examples.
- Link to v3: https://lore.kernel.org/r/20260122-ti-phy-v3-0-751619729433@gmail.com

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
 .../devicetree/bindings/phy/ti,phy-usb3.yaml       | 138 +++++++++++++++++++++
 Documentation/devicetree/bindings/phy/ti-phy.txt   |  98 ---------------
 arch/arm/boot/dts/ti/omap/dra7-l4.dtsi             |   4 +-
 arch/arm/boot/dts/ti/omap/omap4-l4.dtsi            |   4 +-
 arch/arm/boot/dts/ti/omap/omap5-l4.dtsi            |   2 +-
 6 files changed, 242 insertions(+), 103 deletions(-)
---
base-commit: cc3aa43b44bdb43dfbac0fcb51c56594a11338a8
change-id: 20251231-ti-phy-58bb9e38cfc9

Best regards,
-- 
Charan Pedumuru <charan.pedumuru@gmail.com>

