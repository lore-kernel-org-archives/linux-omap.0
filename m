Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8EC3D47BF;
	Mon, 30 Mar 2026 13:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774878263; cv=none; b=LH8rsYBBIuLnMulAjkf3C81JRo5X8EBumT1mmjUaFFrQ0dv/HH4Z8mDdykaVVydembkNl3jPNUPlAsJLGYnQNmbmxt4S/Vf+uGrqW7WsQQ1qn8yhP0Oe093hLh8oEA9ZvkNFlP2FxmrU4Df7EI15bwECpGQsJegP3cgDCTdIF3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774878263; c=relaxed/simple;
	bh=+Y7TLAq98zcY/oaWAkRsZvxZyWqb/caZue0PV8k6/Z4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ut/GaElXcYW2g9dQ2ZrwQggzaqPYsR88lViKpRasZJz8skEf6E3rXxbexqgjYA6elB7O85DU3J7QUmD0xBtwEW/4K0bqAQuhUN3uOOinBYPUYK2Fudt3t5hq8ooSJeadu0PQlfYuH0DEpDi3B9B5Ir3FsQXqGT1U6gvFfVe1uJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=1IyQ4faE; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="1IyQ4faE"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 7DFE1C5877C;
	Mon, 30 Mar 2026 13:44:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 65CDF5FFA8;
	Mon, 30 Mar 2026 13:44:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 76BC6104505B1;
	Mon, 30 Mar 2026 15:44:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774878258; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=HSiS+OkbFmD8VHzHUNa7mH8CPeiFd4KbJHDL2dlh9AI=;
	b=1IyQ4faEkTtBXF+cDn5+XAEYRVDMhiewCUDng4Cls/W4GjA6qAUMNfPOMzUK4nVO4mCT08
	VRJr0Xz3o0z02d19auIX4wlZUQBPZKxqrnAmR0T71ka3fn/hgM29IV3JMUYvqC3okKbECN
	3eVGNgRCnpq0PovMoj3vktIe5l3I0O/ibwtVvTqbmACLVMqUD1TIbyczfCTRVBSg87yRGy
	qkDD4Kemz13MWyEm5ckw90GsAJlrXEozyaeKVbKk+kuQ8R0Ky4VooHKBsmIf+tH8FsG1GL
	GKf7zh8X23w0pfeUob/vsqH/wud+LGCZHmbEcjOPSl3Kr75SmA6z4mm60/XwLw==
From: Thomas Richard <thomas.richard@bootlin.com>
Date: Mon, 30 Mar 2026 15:43:59 +0200
Subject: [PATCH v2 02/11] dt-bindings: regulator: ti,pbias-regulator: Add
 pbias_sim_omap4 regulator
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-omap4-fix-usb-support-v2-2-1c1e11b190dc@bootlin.com>
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

Define pbias_sim_omap4 regulator for OMAP4. This regulators drives SIM_VDDS
supply and allows to unlock USB I/O cell.

Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
 Documentation/devicetree/bindings/regulator/ti,pbias-regulator.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/regulator/ti,pbias-regulator.yaml b/Documentation/devicetree/bindings/regulator/ti,pbias-regulator.yaml
index 3e020d87701b..908fbb46b5cf 100644
--- a/Documentation/devicetree/bindings/regulator/ti,pbias-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/ti,pbias-regulator.yaml
@@ -89,6 +89,7 @@ allOf:
               contains:
                 enum:
                   - pbias_mmc_omap4
+                  - pbias_sim_omap4
 
   - if:
       properties:

-- 
2.53.0

