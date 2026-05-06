Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67B043E4BE
	for <linux-omap@vger.kernel.org>; Wed,  6 May 2026 12:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778069605; cv=none; b=MaF3+mrnre2PAvIhozYbKVAz8+EYxwvhjSsh9TDuZ62FQ9gXpXiDVv6NB1YKDapAwm8TAOnedEKI6Q4sD31DU9QE88f92OWuliYBCcZ7w37MWYW4p7P4H+mYzRGqJc7FomeHoVwgo+jcphJpEjM+nxH7pr0QhrG0CcT+pTrZj6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778069605; c=relaxed/simple;
	bh=AbgaqMlY8wz59xHBG2bGUq3n4kCOawW5putw5NBuBb0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IK64oB+Lhc6Z9JWePpFUnrNkECg9ltesmbGrgPXNGhFqhiOULRx6UHF1CE0c6lSfFX+5Ew3HgdQud/1mD/DZISLZjNvHooh2RcJsVldb1l9d1j4V9QP4PMsIA985jI38XtZ/d85cuRyEMM1hNy42DhRtdU9UWpYqu/wcB9Bc3iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YYomtWi+; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YYomtWi+"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 90EB14E42C0C;
	Wed,  6 May 2026 12:13:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5FD2C6053C;
	Wed,  6 May 2026 12:13:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3AB4B102F24CF;
	Wed,  6 May 2026 14:13:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778069600; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=BediO3/S4l8G16E9hVv9C+1Tjoz4d/x+7MVR9kWDJF0=;
	b=YYomtWi+mfVKhj/kqvcvf9ofTPciHa4WBhrKSFyo++2sZ17ZdZC6lwq8nYfkbOqE9tlJRB
	QLafsoeC45+OXHbcGKv+O3KoZk13a4vGiIOakz3tTP9zWbZkKbP5dtOMh7Ho13t/ayXuIB
	pwtzTQUrE43fX+DiDYbvrKNc/fbiru8BMYsor5IoVsYtGG0te9tH2PqmH8C7qblsl6v2Rf
	0QHf3ftmZcYJLk9bVvdE/lFwbS/t+WoPZO8UBmTu8oc6S1GFvfSBPreop9nZJInM/XfP7o
	pinMhhXBKZStZhyMSDQv/V3wzAdMuFcykOf57u5EB2miZPk9pcm6qsBbrJaD9Q==
From: Thomas Richard <thomas.richard@bootlin.com>
Date: Wed, 06 May 2026 14:13:04 +0200
Subject: [PATCH v2 2/2] ARM: dts: ti: var-som-om44: Add USB Ethernet
 controller node
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260506-b4-var-som-om44-lan7500-v2-2-b8af59ab877c@bootlin.com>
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
 linux-omap@vger.kernel.org, Thomas Richard <thomas.richard@bootlin.com>, 
 Nicolai Buchwitz <nb@tipi-net.de>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Add USB tree description, including the Gigabit Ethernet controller
(LAN7500). Adding the LAN7500 node will allow the bootloader to patch the
devicetree and set the MAC address.

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
 arch/arm/boot/dts/ti/omap/omap4-var-som-om44.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/ti/omap/omap4-var-som-om44.dtsi b/arch/arm/boot/dts/ti/omap/omap4-var-som-om44.dtsi
index 37d56b3010cf..9e04aa70f982 100644
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

