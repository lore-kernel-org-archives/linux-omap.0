Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0843B4E8E
	for <linux-omap@vger.kernel.org>; Mon, 23 Mar 2026 15:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278190; cv=none; b=sBSPJhttUrpzimDmHdaX+SjKelClx/qpB8y3aFsNQAkscd7ciKQ2yELsKaflNbyaQWu8hZkJ62tryiP1gBs8aDOlCwbqOJ4yxspJBQFItSwJLTpHplFeuCaJscjPb0IyKiZUvdRiJ30WcRyvRcOkSWvjZ3X6L/6J993tUX347HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278190; c=relaxed/simple;
	bh=ZPVCXjWtMahTBEvZJUWDRcuMUceBoTdYYYSPZeTrreY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oeVk6OcTQCEq0VQMFjo+a10VawM2QFdYpy+9M9aSMcOsZWs36NhV54aD2mChVJNsRfNucH9mOTvh4FkjgJKo/tHXgqZuZMDgv3hHRPjsTy0d20mlGVgcWckmZKbYycUQ3O1rwtApvnB0qiUZAJJEJ7HJGpQW5ePNlKIxU2N+jpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=02c7ku1U; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="02c7ku1U"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 460FCC58080;
	Mon, 23 Mar 2026 15:03:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 65BF55FEF6;
	Mon, 23 Mar 2026 15:03:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 081E510451002;
	Mon, 23 Mar 2026 16:03:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774278186; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=N/VF95md6eNMeBqvNWEaFR/cXPvLYmIHkRFLU2V6JHY=;
	b=02c7ku1UVuYDZY44tBfDUU5ANEl13AV8VYnXu1CRg4OT8sy4W5u904KIRh407fvt/dlG0C
	7gyVKW28uG/wKD74J6Mtc4r5jahOI161+Ody5YUF1ekRySxtUy0mBINgYblgOn9ko8WicL
	8KzgQut43gCxG+dViw3foV1sAKwKcCOiKEavUV/eFBX90OHqHLBoB6Kwfj0L5bP876G/Ji
	zrFWe6I+Kmq7tc6A9cO3tn3wCiPjkoRYxqkY4q+ar/rvr5p3MmEAAEbdj4rlxZ26ZkdGNk
	SZOZ5p0QZaMVTbuyRVJfAWYvEVQ2YYANAYc44/+v9smsFpy+waQDtZZB1HKpEw==
From: Thomas Richard <thomas.richard@bootlin.com>
Date: Mon, 23 Mar 2026 16:02:49 +0100
Subject: [PATCH 8/8] ARM: dts: ti: omap4: Add pbias regulator to the HS USB
 Host
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-omap4-fix-usb-support-v1-8-b668132124ac@bootlin.com>
References: <20260323-omap4-fix-usb-support-v1-0-b668132124ac@bootlin.com>
In-Reply-To: <20260323-omap4-fix-usb-support-v1-0-b668132124ac@bootlin.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Thomas Richard <thomas.richard@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

On OMAP4 add the pbias SIM regulator to the OMAP HS USB Host.

Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
 arch/arm/boot/dts/ti/omap/omap4-l4.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/ti/omap/omap4-l4.dtsi b/arch/arm/boot/dts/ti/omap/omap4-l4.dtsi
index 6904a84a1700527443cee19f62870904082eb48a..c5e097f9cd17b0ff0966437a9deeff3bdf8134a1 100644
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

