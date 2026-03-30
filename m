Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A363D6CCD
	for <linux-omap@vger.kernel.org>; Mon, 30 Mar 2026 13:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774878266; cv=none; b=bF1eLpsXlCRHekXC2n1KcKooYG4llyGdGQBtJTAThxTaFtfSSC6C0dznYIb3HLPCFt4CNHoEQ4OysP2YwBQCWz6IzuIWFQTL+IZicYDkN+uw8yzgq6khYwGyylSPFj233/R6pNBt6yFR7h4pXSBLv2EXLRFR4C2Lyui1xHRv4Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774878266; c=relaxed/simple;
	bh=8MNJ+Bv8ub/FB+MlzfuB1FeinooVr5Q/BD0cOEEfkQs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lpoZ4/iRpAW23V5uNGsCmqlkcB6GLYv2BuVYYykjOodrRzmWWYxmXnPY6IOnLzIceSgagwnbIohJ+dC3RAi4b+MF3B9tP0yf/dBJk5ZjvRJeddGGW8mPK/wJBzUHVobWQDKZvSOMONJYlMGPsKN0WTTHisqIxib0652yLV8cZ4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SaQpQPuO; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SaQpQPuO"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 4B3101A3087;
	Mon, 30 Mar 2026 13:44:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 18AFE5FFA8;
	Mon, 30 Mar 2026 13:44:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B756B104505CF;
	Mon, 30 Mar 2026 15:44:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774878263; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=akodHWaK7HBoRiEufEd2ype+lPOoEWK24aZSCPGAgS0=;
	b=SaQpQPuOuZPVNi/q4U+sw84KswebIOIl/burexQ7dqTQ+TCUvsw2vWUXAQyXODcZSTMQD/
	fXaOq1/sh2HXG7MoUGcCfXVcO1pVIvy0z4VJ50Ucx/RTgZ+06fQ0kHDTZbfAYqWhScf6tr
	RfL3J1e5/fIUKdMtrEvrhr6WqddppJc8WeJJ0iCra7fXwRBIev+Kj1PppuPOEYSLVC7J+9
	+1fDVNr7QUHR3Nc2n1xinmT7OLsgYKm5Axvl+hqimtm0W+MPIBMJgwwCQlGT8O2sOjUfTh
	dEQi6LxlZ7uv7HzJDe0hmvj0xh5hFcAtVgFdRXr5HRxvhip++KEg2jzJhP5sGA==
From: Thomas Richard <thomas.richard@bootlin.com>
Date: Mon, 30 Mar 2026 15:44:01 +0200
Subject: [PATCH v2 04/11] ARM: dts: ti: omap4: Add pbias SIM regulator
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-omap4-fix-usb-support-v2-4-1c1e11b190dc@bootlin.com>
References: <20260330-omap4-fix-usb-support-v2-0-1c1e11b190dc@bootlin.com>
In-Reply-To: <20260330-omap4-fix-usb-support-v2-0-1c1e11b190dc@bootlin.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Thomas Richard <thomas.richard@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Add the pbias SIM regulator node for OMAP4.

Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
 arch/arm/boot/dts/ti/omap/omap4-l4.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/ti/omap/omap4-l4.dtsi b/arch/arm/boot/dts/ti/omap/omap4-l4.dtsi
index 4881dd674393..6904a84a1700 100644
--- a/arch/arm/boot/dts/ti/omap/omap4-l4.dtsi
+++ b/arch/arm/boot/dts/ti/omap/omap4-l4.dtsi
@@ -697,6 +697,12 @@ pbias_mmc_reg: pbias_mmc_omap4 {
 						regulator-min-microvolt = <1800000>;
 						regulator-max-microvolt = <3000000>;
 					};
+
+					pbias_sim_reg: pbias_sim_omap4 {
+						regulator-name = "pbias_sim_omap4";
+						regulator-min-microvolt = <1800000>;
+						regulator-max-microvolt = <3000000>;
+					};
 				};
 			};
 		};

-- 
2.53.0

