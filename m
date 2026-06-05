Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCDA3B27CE
	for <linux-omap@vger.kernel.org>; Fri,  5 Jun 2026 20:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780692983; cv=none; b=L0PKVLK2VUXiOQS/8jv5NdD6MIB9FT4TewBjosUcnN8KG4h9X3vIfIC8qBj6XMZAi+LtZrZRvsaGes8BXt0frGRyg4T5p0zfP89TD/B7Y8bDsvhgjvxi6FciPHvp2lRiIghMER011wjRt8d/57fPZAEF8JMTW+ek3+pZcGYvjkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780692983; c=relaxed/simple;
	bh=8bUD9x4wOou8wQASyhytt6PqZWOsrt8nWYzwb9KNst0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bqYarm6muDwxJZWwXq9WFTN+He+Z6MUv4UvBSl+GdrFA/DR+0e1WYqe9zAaMcyorWqif3fBjXM/137UUSQhy8kFeDHOIwwXOMWvLi5Wq3x/8ZCuUO/iR4lCNEPYISMiO3lrMjeMNkIXMmdPKB0HbkjN8bg0mKtaG68sVb/s+gfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R/TA6/+f; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/TA6/+f"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2c0c355f711so3489555ad.2
        for <linux-omap@vger.kernel.org>; Fri, 05 Jun 2026 13:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780692982; x=1781297782; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OjzwKrMQNmV3nC64BV60pa2u05CadfM/qOaHGnybv9k=;
        b=R/TA6/+fD+UwFQxC++pIOBZ1Ix5ovHvacyEb+uquu8CAxGKMw8jGvqHMs6UgfY96vV
         7SRhgkFH4qvcyKYSYNFLSr3rBwP+u0G+nbmB0CjK0POzLsHLwslWg7/J4iD9hWw4w0dA
         LA7Tg+KjY+OrFsJA8iA6Z0LhIEVCKoa4dS6N6mqqIZ6XtDZrm/VBD/ffNNYVlSdTkXTY
         z9q7AzeXSGZbP2+RclP1r0gMFUbzlKWecMw8n2al2c5rU6uiFcJs2p0ftBkavQMHwTeI
         58HSdyRZsnENZaryw+ZbSe7MQ2wSTyQ/khLXPckIwBBkIuLvgkjiNHNaaUX0he66u70S
         jWxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780692982; x=1781297782;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OjzwKrMQNmV3nC64BV60pa2u05CadfM/qOaHGnybv9k=;
        b=KRBQ8PYpTs6G7xlfp/8cUr3dqpPdYhstQ29mawIuNh3uTfBBSvC/0/Ma8b/pfW3MN9
         71Tog6rZsnb+ZUAQSx7dFw53ZYa7LWtJFJuc4P1f125lVjqdjc8YWSdVpjL6dfX4Ux3S
         upTtUtQyH2g6g7NJ9hcFdQj+OOlQ3MrLcJEzNXeqRPtFAdfvJ7pkDA7b98hZh69Uc/N9
         ltyGRSEJdfFk5qve2BoqBWnKRqwlWSEeQ9pRbZD/9Id5VnZAmbrhmdWl81RS9TNLL0vz
         fkJCXq9n2WL971dGZ+UNCz0wp6L1aIUu5wFfsqcw3/x09Jswbw2kbqpiPIN8SsD3IZho
         UxoQ==
X-Forwarded-Encrypted: i=1; AFNElJ/eYYQaFSNVq277lTiUArBD7Gcm1sSeUrjtVgHX9H1v90tDucb+RFaK0fkIPK8urCMqOJvF1twnUxa6@vger.kernel.org
X-Gm-Message-State: AOJu0YzlB9yiAu0Gn8YM0JIwQNbLqg6FBRK/RKQlvBkqG0IyZ4mKoFAh
	R8j3tS6FoCPQsQlQZ1EUYipZeif8LmGi8nJSwjmHqQQzzxM1uJI+lGrh
X-Gm-Gg: Acq92OFRq9vDH/tI7MWfDUjAc6zD5juA3LqdiDbESXNOmKZRCHYdS5zhHslnOdKsf7y
	7SSmXQdc0DSWQgsKlTtkclWV20Ef2bKjReRed2bAH7trvOE7dwW8g+6yyh4rNN2R/5I/UmNRmB5
	x50MvAPqgLjD7y01eSlfZuVG4bjRH8W4djRwkK+2Vv7KxjV1hToZ3YkGd0Ci2rwQYBhDdtJgkY1
	9IYVXWdPTER+YG81S/kwnBp8wOCPcVQlTfC6KREi5IjaiSmNOL5SN2RPPBQjIiZBuFGOgnML6r2
	5QA7H72xxssRMRyt+S11aFtMTIqdWJzpReChHGKaitYLsVy84+ZBwJc+RIrKimjmE+rcbrFD9mL
	wSTEYGAL/X+TgS89q/ratgeljphib6NBjmcdfcgvp2l7UjeygBzuRlR5jzKaBl04WcTWG/4315Y
	RvvfJznbfV6uG5H0L0P9sQ2PEvctQ0ZxZ1X3v0UpzsaNynmdrY8gc8
X-Received: by 2002:a17:90b:35c1:b0:36b:54f3:64d5 with SMTP id 98e67ed59e1d1-370f0b54c09mr2508256a91.6.1780692981525;
        Fri, 05 Jun 2026 13:56:21 -0700 (PDT)
Received: from [192.168.1.3] ([2401:4900:881c:baba:b3d5:d6d:608b:987f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3712fcb2607sm2197036a91.0.2026.06.05.13.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 13:56:21 -0700 (PDT)
From: Bhargav Joshi <j.bhargav.u@gmail.com>
Subject: [PATCH 0/3] Convert ti,irq-crossbar binding to DT schema
Date: Sat, 06 Jun 2026 02:26:09 +0530
Message-Id: <20260606-crossbar-v1-0-f67f7cb9ee50@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDUyML3eSi/OLipMQiXaMky0QzE8MUI0MTMyWg8oKi1LTMCrBR0bEQfnF
 pUlZqcglIv1JtLQDI031WbAAAAA==
X-Change-ID: 20260528-crossbar-2b9a641d2146
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Sricharan R <r.sricharan@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-omap@vger.kernel.org, goledhruva@gmail.com, m-chawdhry@ti.com, 
 daniel.baluta@gmail.com, simona.toaca@nxp.com, j.bhargav.u@gmail.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780692975; l=1324;
 i=j.bhargav.u@gmail.com; h=from:subject:message-id;
 bh=8bUD9x4wOou8wQASyhytt6PqZWOsrt8nWYzwb9KNst0=;
 b=/eR3ZJOIkfskq17CqohJCaBfvzb880A6wx1qSIIujYuL3Z5BErE6Yt3iCoE59dGvYmyOaxRcN
 dBtrQoj+KbqC3j2UdNNZs0lW02e2SSo7tfExOuRHnqOXZ2dfsjcNkPk
X-Developer-Key: i=j.bhargav.u@gmail.com; a=ed25519;
 pk=IqNDwUZKECEA+n8wXctFLBbYL9NhFstZNbOznm/nX1k=

This series converts the TI IRQ Crossbar binding from the legacy text
format to a YAML DT schema and resolves a property name conflict with
an existing binding.

The property name 'ti,irqs-reserved' is already defined in
ti,pruss-intc.yaml as a uint8 bitmask. while irq-crossbar uses it as
uint32-array causing dtbs_binding_check errors.

To resolve errors following changes are introduced: 

  1. Rename the property to 'ti,crossbar-irqs-reserved'
  2. Update driver to accept both old and new names.
  3. Update DTS to use the new name.

Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
---
Bhargav Joshi (3):
      dt-bindings: interrupt-controller: ti,irq-crossbar: Convert to DT schema
      irqchip: irq-crossbar: Handle renamed irqs-reserved property
      ARM: dts: omap: dra7: Use new property name ti,crossbar-irqs-reserved

 .../devicetree/bindings/arm/omap/crossbar.txt      | 55 ------------
 .../interrupt-controller/ti,irq-crossbar.yaml      | 98 ++++++++++++++++++++++
 arch/arm/boot/dts/ti/omap/dra7.dtsi                |  2 +-
 drivers/irqchip/irq-crossbar.c                     | 15 +++-
 4 files changed, 111 insertions(+), 59 deletions(-)
---
base-commit: eb3f4b7426cfd2b79d65b7d37155480b32259a11
change-id: 20260528-crossbar-2b9a641d2146

Best regards,
-- 
Bhargav

