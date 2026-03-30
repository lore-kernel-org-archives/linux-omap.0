Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E193DA5B3;
	Mon, 30 Mar 2026 13:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774878279; cv=none; b=iBSztiBqcl1ivVO4LcECFlIU9PK0k8xjP+Rph5jgR5NYrn5tZOqXyGa+X7Cn8OfH4nWPhIIVW1hZfjvyXRx6KINvjt3cVTT04A3b9dhkQMvk2M//GHLQCay9skSWOqS1fP2meEDDD7T9tESryrX2KjmWPgVNcjckax9qdTY6DJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774878279; c=relaxed/simple;
	bh=S+9pZnIR4Ii2mrRay+00UvKlRFHb53jV5wYXLigv92Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gTUVm6Z3efVf+XZoz/psPBDuQviwHjAH82BVHR/3Ym9k0meHOOkYBTR6m+PkBSaQoZKZRrqSvlpHz7rAQYxNZKH+HI4HpffltCG8kptiVtgBiBdW+UE80jQnwOrdUGE2d0TcKTwHuC+3pxePWW73YN803YjdQXT5AMtU4aCzIRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=rzSDKMu+; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="rzSDKMu+"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id A825F4E42868;
	Mon, 30 Mar 2026 13:44:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7E40F5FFA8;
	Mon, 30 Mar 2026 13:44:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 37E1E104505F2;
	Mon, 30 Mar 2026 15:44:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774878275; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=+LBatK0e2tx9BdeCCJcMioLXnURJiMafU/RyqrJOQxo=;
	b=rzSDKMu+Xjq51PHLzGbLDefJ3u9lP54GkkfzPTPl7gCixCnE6+M/f0dZhEe62jutxt1jxp
	VI7DxfUoBkra0+5SxG+Ta1eDJCxBgrXoKiKtmo0Qdt7B1fYFL7XoB0n8XlPjmX1ycRfXWh
	IPZ1oLfBuGubkZH2x8WBPC+4J829F++Wgo0Vk0N2sDa8cbqdaRjQWI/LdmjJEvjvejGAQW
	S7e4RvbdbKpUlUpuMNekbnkyO0RuRjB7STTEuwpUbF9c2d+C2opSvb5UUkznnW6TJrFIAP
	fEWSpuPShlf1yFZfVzr0qt2XzqurdTyCLFuB3uP8lUv29Cxjf3TVRQBTjkYgQA==
From: Thomas Richard <thomas.richard@bootlin.com>
Date: Mon, 30 Mar 2026 15:44:08 +0200
Subject: [PATCH v2 11/11] ARM: dts: ti: omap4: Add pbias regulator to the
 HS USB Host
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-omap4-fix-usb-support-v2-11-1c1e11b190dc@bootlin.com>
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

On OMAP4 add the pbias SIM regulator to the OMAP HS USB Host.

Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
 arch/arm/boot/dts/ti/omap/omap4-l4.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/ti/omap/omap4-l4.dtsi b/arch/arm/boot/dts/ti/omap/omap4-l4.dtsi
index 6904a84a1700..c5e097f9cd17 100644
--- a/arch/arm/boot/dts/ti/omap/omap4-l4.dtsi
+++ b/arch/arm/boot/dts/ti/omap/omap4-l4.dtsi
@@ -301,6 +301,7 @@ usbhshost: usbhshost@0 {
 				clock-names = "refclk_60m_int",
 					      "refclk_60m_ext_p1",
 					      "refclk_60m_ext_p2";
+				pbias-supply = <&pbias_sim_reg>;
 
 				usbhsohci: usb@800 {
 					compatible = "ti,ohci-omap3";

-- 
2.53.0

