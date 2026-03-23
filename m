Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4623AEF50
	for <linux-omap@vger.kernel.org>; Mon, 23 Mar 2026 15:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278181; cv=none; b=K0+lhfC+VuNHVkaM6A551ZKogMaHLxsruN8V/EP6lwI4aq8C5taLS11VxZI4RZSWj2HEHqmt6tCCgei269XCbPqQNl7JXc4n/quE6/Zf/nFmoIFH69PtzhAHTs2A93dNum3m65TnNWAIAsgdiAg9K7FJslzTfdW8b7uyEArFgak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278181; c=relaxed/simple;
	bh=SNBxAyWvlbMQrJWj5T5wU/4LhKzcMaoZk2JRIEOETlE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RDYUTWyyqWKOpiIbRHMWcSLTrrqUMZ/4FgfA8f9l/20VohKP8lRxJuET0GASzC+o6/JWE3ZLwwm3wGYgZZ1DHvYHIPHGnHq37VL7k5qwF8T7BJs+JLlOkA1A9ngPdSsBBwjum2bXhn2kAxkNqHY83WZf6mzNUfxC/hcoP+PEx+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pmOmFRo/; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pmOmFRo/"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id EF2854E427B0;
	Mon, 23 Mar 2026 15:02:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C56715FEF6;
	Mon, 23 Mar 2026 15:02:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C19BA10450FFB;
	Mon, 23 Mar 2026 16:02:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774278177; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=oz2H0XLN3AH8WWxUIwmA2AJxtlH1SW2FIDqDP+bCqtQ=;
	b=pmOmFRo/o8H23SQfKGnLfOZIFvfUv01uLjr+1EPWeMTJ77CdTbTXknT64+jls/0YOirXni
	LyHI3r2cl9Ouk2xIzrtcOBCYdiWiUk4VEibzBIlaPCACKP0K/OnDXjgvEQjYlJTiTuJSP6
	JSxUFO9S8zJPhc17xJu6v3r71gsVUs2aA36GMSYbEyfMTwTpF62LQ4RFunwh2wQgRYCkAa
	Jfqhl6jrW/jjXISGVRvnRpNvEkXQSXYbGSZ8zwFaAhOdkTZrYUVEIJt16J7eTIKaDGvf9s
	MFE8UprTLmsfE7QnOAyTYmuNPgbVmWCnB+e+HRq+dXceMzREHX8boYTxMyftPQ==
From: Thomas Richard <thomas.richard@bootlin.com>
Date: Mon, 23 Mar 2026 16:02:44 +0100
Subject: [PATCH 3/8] mfd: omap-usb-host: Cleanup header includes
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-omap4-fix-usb-support-v1-3-b668132124ac@bootlin.com>
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

Remove unused includes (linux/kernel.h, linux/types.h and linux/delay.h).
Sort the remaining ones alphabetically.

Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
 drivers/mfd/omap-usb-host.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index 4d29a6e2ed87abf2a0f6d5a704525baaa6f0cbcb..4e066a17cef0400edbfcb3012a16ceee06e52140 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -6,19 +6,15 @@
  * Author: Keshava Munegowda <keshava_mgowda@ti.com>
  * Author: Roger Quadros <rogerq@ti.com>
  */
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/types.h>
-#include <linux/slab.h>
-#include <linux/delay.h>
 #include <linux/clk.h>
 #include <linux/dma-mapping.h>
-#include <linux/platform_device.h>
+#include <linux/err.h>
+#include <linux/module.h>
 #include <linux/platform_data/usb-omap.h>
+#include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
-#include <linux/err.h>
 
 #include "omap-usb.h"
 

-- 
2.53.0

