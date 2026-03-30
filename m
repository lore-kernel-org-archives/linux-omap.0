Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10353D8911
	for <linux-omap@vger.kernel.org>; Mon, 30 Mar 2026 13:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774878275; cv=none; b=pKJD0ic2SfPa6m9eDbdM42uY/GlRKpsetgig6L3//ZnTMYfOGJz21RNQXy0A7C+z2TB73a2JfOkBwOpmjjRCMNB8UQRO3REojIw4a+Xt7kEpOYyPkTNEQMbvMxLOxCnN6/5DMBRehB2bxbfJgzYO6J1uNgUMzOxIaurLqsS4+ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774878275; c=relaxed/simple;
	bh=Cj9NeSyIEXVLj6Wm/QzFWa0yRNXVyI3XsroWdRrWvdo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p6ACSizjHZoSFfszVz7xyH+0sBjdykG54BC+qQ07oyVBl8X5nstj3ovoFHVbR2JoCjvpD1WEF2I5TwnqCCL8gt9DIC3DKCj5Rw1HwX6BsKX6TPO2epx1dU3V66C75sWoP38z7Ak0QVc5e6cx4D6loMAKdrMznmMAPaAM7HRjdy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JxQRX60v; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JxQRX60v"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 687FB1A3091;
	Mon, 30 Mar 2026 13:44:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3FAB15FFA8;
	Mon, 30 Mar 2026 13:44:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EBBFE104505E4;
	Mon, 30 Mar 2026 15:44:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774878272; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=8xwevEUsFI6/9OT1toXO+j+2rG7UZIPi3hL72XUS8G4=;
	b=JxQRX60vgz/BDxDBIepClqWMsCZBoyX3V3XfO5uL1yNmKi0szXlwJ/sGIWm4YobGuIGUXF
	nOiz6P2R3Am0AP0r4atQukbLCunTbyzDMqMnUJeAAxFA10ihkUHoT5HalB6puV4KRuiKho
	V4vyf/o+cSxov0QmflYEd5MD/WXGFamUFo5DDkQuCKhSB5QCY5DwDw92XA4n7l66nyehgz
	Eg1EL/3GTJR1sOZMRN97ZgLTSbdIjsk80tiirFC7/egQRv0MCUhykjghH1Q2yjkFkJE06w
	8aFrs/7rYCSDpGIz3asxPu23ifSP87dDkqW4riO5CkWs0gcK1nN03VGJWBAgoA==
From: Thomas Richard <thomas.richard@bootlin.com>
Date: Mon, 30 Mar 2026 15:44:06 +0200
Subject: [PATCH v2 09/11] dt-bindings: mfd: ti,omap-usb-host: Add
 'pbias-supply' property
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-omap4-fix-usb-support-v2-9-1c1e11b190dc@bootlin.com>
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

Add the 'pbias-supply' property, it is used to specify the voltage
regulator that provides the bias voltage for USB cell.

Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
 Documentation/devicetree/bindings/mfd/ti,omap-usb-host.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/ti,omap-usb-host.yaml b/Documentation/devicetree/bindings/mfd/ti,omap-usb-host.yaml
index 3b5b041f0321..d0a61dec4961 100644
--- a/Documentation/devicetree/bindings/mfd/ti,omap-usb-host.yaml
+++ b/Documentation/devicetree/bindings/mfd/ti,omap-usb-host.yaml
@@ -83,6 +83,12 @@ properties:
 
   ranges: true
 
+  pbias-supply:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      It is used to specify the voltage regulator that provides the bias
+      voltage for certain analog or I/O pads.
+
 patternProperties:
   "^port[0-3]-mode$":
     $ref: /schemas/types.yaml#/definitions/string

-- 
2.53.0

