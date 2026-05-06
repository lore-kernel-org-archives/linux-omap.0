Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA7E43E48A;
	Wed,  6 May 2026 12:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778069602; cv=none; b=NHimv2BXcnf6P++UVfoij5VdTZ3eTU28nYey1wCZsCxAGpUsfRLkSvQQJbUxzCSlw7XTz7xobzGUkzfyrAGUj9gm5jArANM6V8sOqiD37psgsskQn28tTsQSVJusvYBDF+YXySvsb/8KJ/ocWNUaN+7rELpCmAQz+tQPc7KUtes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778069602; c=relaxed/simple;
	bh=BqRIpDLr7rVzUgJkbG90HbIRQDuqqbmvbhPoK4luQkA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YLw8DnmU4BpLbENQWGSTOFqxueh18jquajli6FrOa36uKU2aavNTyae+Q1fkIQRSVCn5eGb9tVvZA0lHPYGE+VxtaJECLaoXLqj/fSu4biHjkJV5Ti69Y3JK5wzVQvKva4OfkPIVUnsht/qy6wVaXIxtpftMHa0JIOgo56WJ/Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BU3uyVtn; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BU3uyVtn"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id BC7271A34F2;
	Wed,  6 May 2026 12:13:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8FD5D6053C;
	Wed,  6 May 2026 12:13:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3BB4A102F249F;
	Wed,  6 May 2026 14:13:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778069597; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=JrByJcZnfJtR3+8tc0KQIAYGzCTs++XROEk0eVTBCXs=;
	b=BU3uyVtn2w3LMV6K9tJ2k6nNovRnwaEo/KhOaxDetr3taqjlNddpooWLPspE/VQ0AxJtEh
	ZLPPNHNodbbQucZzMRWe1DJ5mJupIi4tLWFbtgukCTMqa0Ez/i3VzECt7W3dIpZxs8qrJj
	BdlA4Epa6yCd10WaBnWiO8B4gEEmoKnPxUcvPk/fnjNptrFJsxt4JCEjg9o84BCEAlEMoe
	tVEgBGgXInsk105MGEtv1DdgJTCv4bYaNxAy3UZp6fmqgMjf6TIh+/oYPqNi8q42ptBJ/W
	Fx5bBbtGYUaybFU4j4HgWZQc1zB5Gl9GHmeFji4HgbeAQQwF4wJcePgIc8/xUA==
From: Thomas Richard <thomas.richard@bootlin.com>
Date: Wed, 06 May 2026 14:13:03 +0200
Subject: [PATCH v2 1/2] dt-bindings: net: microchip: Add LAN7500 and
 LAN7505 devices
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260506-b4-var-som-om44-lan7500-v2-1-b8af59ab877c@bootlin.com>
References: <20260506-b4-var-som-om44-lan7500-v2-0-b8af59ab877c@bootlin.com>
In-Reply-To: <20260506-b4-var-som-om44-lan7500-v2-0-b8af59ab877c@bootlin.com>
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
 linux-omap@vger.kernel.org, Thomas Richard <thomas.richard@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Add bindings for LAN7500 and LAN7505 USB Ethernet Devices which are similar
to LAN9500.

Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
 Documentation/devicetree/bindings/net/microchip,lan95xx.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/microchip,lan95xx.yaml b/Documentation/devicetree/bindings/net/microchip,lan95xx.yaml
index accff93d38f8..b9c394009040 100644
--- a/Documentation/devicetree/bindings/net/microchip,lan95xx.yaml
+++ b/Documentation/devicetree/bindings/net/microchip,lan95xx.yaml
@@ -20,6 +20,8 @@ properties:
   compatible:
     items:
       - enum:
+          - usb424,7500   # SMSC LAN7500 USB Ethernet Device
+          - usb424,7505   # SMSC LAN7505 USB Ethernet Device
           - usb424,9500   # SMSC9500 USB Ethernet Device
           - usb424,9505   # SMSC9505 USB Ethernet Device
           - usb424,9530   # SMSC LAN9530 USB Ethernet Device

-- 
2.53.0

