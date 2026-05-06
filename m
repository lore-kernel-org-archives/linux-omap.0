Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEE04218B3;
	Wed,  6 May 2026 12:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778069605; cv=none; b=bjgLzvbRSarWkWYu2akb+L1ps1KXTpIoKX5Tc+NNsnrq1sFKMrLkTLTp0Ej34OwBZyLTZPXcRNL9/sOhgeE50/vBnHi73Ohqr0oQkbMt8vA01If4lQOODGawOmBTgwGJ6f5w3B8f0d8HDZ8nWmdRCiEgjv77jh66pZGH/IGh40E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778069605; c=relaxed/simple;
	bh=6BJoT21okPC2svqqJmM994ukAh1veI+pOrQYZfGGSpY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dDAFP1jt5fEjkV8GM8R1NjdgPJ9CQdO8V8IHyNLqIUgr44qkD9JaSQe6g36V1ABwzEhptvI6jvvsXurcvdZlB/4MUhNbrYVzxwFDfZThsGwpo7/aejGAiS2IQqydLEGz1SxNflrF3pXXeXfNGxZWTpjlhkR2iKC0CA4oUbfju4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BpbUx1wH; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BpbUx1wH"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 3FD794E42C09;
	Wed,  6 May 2026 12:13:17 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 008846053C;
	Wed,  6 May 2026 12:13:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 00927102F24F4;
	Wed,  6 May 2026 14:13:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778069595; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=Vd35ht/9TSjl6+pyCixaHialcFScMPkKoQR0kl6TV64=;
	b=BpbUx1wHl4l/vykUGLe1EPapL9UV0maolQ+M/WmDdcFypq0gbewdaJQr0W0XqQKmPn+p5I
	41Ys+CLOqKWZsenpy2Vuh2cQbBmQatytU5Vf/PI2yjIv+e9zpf5oOmVXC8zwkNeEecPPcU
	Qd8K0f9JUxkUG8/U9hsCkKRsoDNBQTjNdVGDXZ4TAxRr2t8dgepeySmfObarBVT1gd4/Vy
	LtTd2wf27IariUqWU38IJJEu8eL9dDnLoTC1RcTQLkpaHIXN6mAwiOIFbU6Rmud2toYoxQ
	ImojO6QNt6sYEotnLfcVXy+0JjHBoVQfeVZPsKotDZmPL8Jp4CqpxlGEHTApbA==
From: Thomas Richard <thomas.richard@bootlin.com>
Subject: [PATCH v2 0/2] Add USB Ethernet controller (LAN7500) node in
 VAR-SOM-OM44 devicetree
Date: Wed, 06 May 2026 14:13:02 +0200
Message-Id: <20260506-b4-var-som-om44-lan7500-v2-0-b8af59ab877c@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE4w+2kC/3XNQQ6CMBCF4auQWTtmSouIK+9hWBRapAl0SEsaD
 eHuVly7/F8y32wQbXA2wq3YINjkomOfozwV0I/aPy06kxtKKi8kJWGnMOmAkWfkWSmctK8rIqT
 GDKavhTSygXy9BDu41yE/2tyjiyuH9/Eoie/6MxXJv2YSmGGjjbHXioSS9455nZw/9zxDu+/7B
 1z82mXAAAAA
X-Change-ID: 20260330-b4-var-som-om44-lan7500-09dfdc713d39
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-omap@vger.kernel.org, Thomas Richard <thomas.richard@bootlin.com>, 
 Nicolai Buchwitz <nb@tipi-net.de>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

In this second version I added LAN7500 and LAN7505 definitions in
microchip,lan95xx.yaml as requested by Krzysztof. I also added Nicolai's RB
tag in devicetree patch.

Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
Changes in v2:
- add Nicolai's RB tag in patch 2/2.
- add LAN7500 and LAN7505 in microchip,lan95xx.yaml instead of creating a
  new file.
- Link to v1: https://lore.kernel.org/r/20260403-b4-var-som-om44-lan7500-v1-0-0dadde850143@bootlin.com

---
Thomas Richard (2):
      dt-bindings: net: microchip: Add LAN7500 and LAN7505 devices
      ARM: dts: ti: var-som-om44: Add USB Ethernet controller node

 .../devicetree/bindings/net/microchip,lan95xx.yaml         |  2 ++
 arch/arm/boot/dts/ti/omap/omap4-var-som-om44.dtsi          | 14 ++++++++++++++
 2 files changed, 16 insertions(+)
---
base-commit: b50159d9eaefd95ad4e58bb94bc797761aeb9d8f
change-id: 20260330-b4-var-som-om44-lan7500-09dfdc713d39

Best regards,
-- 
Thomas Richard <thomas.richard@bootlin.com>

