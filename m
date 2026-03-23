Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EA63B3885
	for <linux-omap@vger.kernel.org>; Mon, 23 Mar 2026 15:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278186; cv=none; b=huDcEfLNEd44dCsn51eilt1A697dWk4LdPRHElUk3/SYZD9bSdywBzgUlUrWJ3xRndFkefv/I/nZsItOLh7VwH19/Zk/bcL6RE1t18nWKdP2F/J112wNoOrKU+k5XmRNcAFNhN1ZQJLmAuyD5Us2PN4FTGVnWoEOdo5Y1E+5CgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278186; c=relaxed/simple;
	bh=0fceF0cVwQlCGxddCO3QL7u/MrNVgrZpDC+/xLKaCHM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fUk5wbODb2J2JtOf6IpQdGDyl6eaSDGVD5ZiiEHUPt4v5IuKOFiz8I1gozt50fGsWmfg651urnJweYxUAjWHh3amdWObbiDkJAWQv16Cmi0G6neObRe1BTJlZMopcFr2O4lN5grTSCmXoyj++6rJeVhyyRWMPKuGVbYj5YowQOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JgW3SLpI; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JgW3SLpI"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id C44024E427B0;
	Mon, 23 Mar 2026 15:03:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9A9ED5FEF6;
	Mon, 23 Mar 2026 15:03:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9362E10450FE4;
	Mon, 23 Mar 2026 16:03:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774278182; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=49frKNUVvOfaVYtlewLBdpOk3TUCuKezoYZbv3SlSSc=;
	b=JgW3SLpIat/2bTNFofkY32z+zAVCNtcNe24J3VwTFZvv25KZnbvKcRn5hiFTGsoGEYG6lO
	vqUQasvwK1Wi2tjGa2BhZ0dCtCG9vGVtrpXjUFqZjBe8FiVZUoivSonBYc80tsUMkGzBSO
	aOnZ/2x5fgFu2zeAteJw4QIm0qIWPx89fQQDZsalVEjMapThfU9AjmbMr7tUHqsiC6rn5O
	Z4oY0/btggCuMCb4Fr6UM2L/VUJx+7binQ7K+r40Rv2q5RwNcNNIjX73z0PHnE6hChXm8k
	jH7d1EHo2Dqrn1PbsAEePn4E1sa8IAXfDwCs4CPwlnPPJ+p0AqWW/ER5YzkcMg==
From: Thomas Richard <thomas.richard@bootlin.com>
Date: Mon, 23 Mar 2026 16:02:47 +0100
Subject: [PATCH 6/8] dt-bindings: mfd: ti,omap-usb-host: Add 'pbias-supply'
 property
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-omap4-fix-usb-support-v1-6-b668132124ac@bootlin.com>
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

Add the 'pbias-supply' property, it is used to specify the voltage
regulator that provides the bias voltage for USB cell.

Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
 Documentation/devicetree/bindings/mfd/ti,omap-usb-host.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/ti,omap-usb-host.yaml b/Documentation/devicetree/bindings/mfd/ti,omap-usb-host.yaml
index 7831ad891229aee650d83adcd82405c9dde472a8..8ec354ac2bcb6e381744506f6afc57a04d460df1 100644
--- a/Documentation/devicetree/bindings/mfd/ti,omap-usb-host.yaml
+++ b/Documentation/devicetree/bindings/mfd/ti,omap-usb-host.yaml
@@ -56,6 +56,11 @@ properties:
 
   ranges: true
 
+  pbias-supply:
+    description:
+      It is used to specify the voltage regulator that provides the bias
+      voltage for certain analog or I/O pads.
+
 patternProperties:
   "^port[0-3]-mode$":
     $ref: /schemas/types.yaml#/definitions/string

-- 
2.53.0

