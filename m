Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EC83D5237;
	Fri,  3 Apr 2026 19:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775242972; cv=none; b=hHkMPDs9oE1jCnnRhMK3khxwOqHgdCo5BUn5HyEx8sVclANo1Akx9bk7x1D31Goesb8Fom0k5SkNEjiq9Axk2/BfQhrP/6Qc060nsE6HGf+6Mls+7Ew0epGSL8NJ4dJyGB5aTu6o8yTZunIy8nz9CeF1cA32lK4/1gStMci8N94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775242972; c=relaxed/simple;
	bh=2TMI09FpamYZahfXr+RTwRjwuJl1OVYR05Rg8UryZp8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pxODs0JahM8lTsOJPW3UwzYKMFbFP34xRb7TkbvELfnWNLBvEeM4thn5qC8Z8QNDP3LkyUCn/G7sHDk/y+Pl19uuY0RR8uI5r9Y+6WPAvBilomQZzh0TzXOAdDjPxS1fKwQXmd9tTdSE9i/mv6HZ8adLnf5PR6NVMvxcL2nAGho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kWdjJYP6; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kWdjJYP6"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id A8689C59F65;
	Fri,  3 Apr 2026 19:03:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9E56A603C1;
	Fri,  3 Apr 2026 19:02:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A9F4C10450104;
	Fri,  3 Apr 2026 21:02:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1775242968; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=4Wv5yQvuj+rgucDv+ANDjV6mURH+Y6I5nT0NY+ugpFU=;
	b=kWdjJYP6WePo47HuUMrKVu7jaB7aJj6o2/xliAwiE/AHbeZUC0k5aHOlloTu22oZ0BLhOb
	XWVVV/zTuJotoNUYH+4bw7C+iB6B9iWjBJoxJSATWqxMC8UZa6ij9nukwouAattEP7nVyy
	3ckAfhzzHo7RLfa5mXyphOw+2tEUzaydA9rnvxh63l8xZ262AsodvUwyhJnEYUiYpp0BZL
	C7OkZpY0rSU5OAbSaeQajy+uepYZbl+0vZbYmT4/gPONFEhXL3uGzwW0aLJP3FAK6ouUtu
	MuMgxMz7hQuupXrYB+0YiLxwIXUQFNdzG6IM4BvQEYWA2xkG5+wnfnrpzKFZkA==
From: Thomas Richard <thomas.richard@bootlin.com>
Date: Fri, 03 Apr 2026 21:02:24 +0200
Subject: [PATCH 2/2] ARM: dts: ti: var-som-om44: Add USB Ethernet
 controller node
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260403-b4-var-som-om44-lan7500-v1-2-0dadde850143@bootlin.com>
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

Add USB tree description, including the Gigabit Ethernet controller
(LAN7500). Adding the LAN7500 node will allow the bootloader to patch the
devicetree and set the MAC address.

Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
 arch/arm/boot/dts/ti/omap/omap4-var-som-om44.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/ti/omap/omap4-var-som-om44.dtsi b/arch/arm/boot/dts/ti/omap/omap4-var-som-om44.dtsi
index 37d56b3010cff0f6ea6208289da0aba7328067d5..9e04aa70f98227ac0054fea6cd4521ed1323ecbd 100644
--- a/arch/arm/boot/dts/ti/omap/omap4-var-som-om44.dtsi
+++ b/arch/arm/boot/dts/ti/omap/omap4-var-som-om44.dtsi
@@ -322,4 +322,18 @@ &usbhshost {
 
 &usbhsehci {
 	phys = <&hsusb1_phy>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	usbhub: hub@1 {
+		compatible = "usb424,2514";
+		reg = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethernet: ethernet@3 {
+			compatible = "usb424,7500";
+			reg = <3>;
+		};
+	};
 };

-- 
2.53.0

