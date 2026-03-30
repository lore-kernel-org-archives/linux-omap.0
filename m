Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971153D75D0
	for <linux-omap@vger.kernel.org>; Mon, 30 Mar 2026 13:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774878268; cv=none; b=Hmlxg/Ql8kmPlOsB91JGd4G7d76bB3r2Pv2/TfYrXnBN8LIVHlBxo3XpLdDbUU9SB5LLsgrltrPPRu2WhSS9oLB/WzzEp4+LqGSzIDCgHTa1OA6kGkh2udUON5NfNpfSmEmIpR93rzGzDp5wWkhv4O9KDUiylUiI5lIV4FOF1iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774878268; c=relaxed/simple;
	bh=xqH9HBUo2uKq07iV0LT/eXOI7R30mY5ED8Qnvvev/JU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kWTGMx+O5Tf8r26oz1ZrT6UrDBkMId9OHp2dXih/58mDcbNvImPQIiwdLHopAeI8AgZFoaJsvTbtITk3M1/K8ClD/l1UIrorGwzpnD1lWjm8TW+NW5azTAqmXu7xON1+AZDix2lYDKm7rxaVVCsLxG7Ove0fDqlJHXd1GSu+w+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=r3gDV2bK; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="r3gDV2bK"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 36A804E42877;
	Mon, 30 Mar 2026 13:44:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0CEA15FFA8;
	Mon, 30 Mar 2026 13:44:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7A72E104500D7;
	Mon, 30 Mar 2026 15:44:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774878265; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Ph5+0Z1fEKxt9hAWE1vd2W1+4iqUm1ikNOhACalKAVY=;
	b=r3gDV2bKgkU4V8h0E7DToblrybrUr5jUoQg5e8VL0PUd20dyWoyDMXUOziG9Oqo9R9INsV
	EnuLVyUUCUQjfJGVTXFbf8UPsBEZLlezX9C5Pa8PQVR1ceTAnUB6nir1RH8nc2QrJZK7XV
	SpgCruRZw5Wvfr24jJ4zGct0aSuT4EVps2BWj5RmOPx5GmhhGQYeVukEsRsSu6JLy/srFn
	RsvnRa6Fvp7DV9XH6K88+FGAw4vRBQPbrB1qIcfGpTrNuoCx2PgYu1umA35cKPa8TwoO0V
	CT36rEbX9w/sW2DyK0oCE3sqeu+1l2RdkL+6FKLbilcYx93ZckSymu6y1S60UA==
From: Thomas Richard <thomas.richard@bootlin.com>
Date: Mon, 30 Mar 2026 15:44:02 +0200
Subject: [PATCH v2 05/11] mfd: omap-usb-host: Cleanup header includes
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-omap4-fix-usb-support-v2-5-1c1e11b190dc@bootlin.com>
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

Remove unused includes (linux/kernel.h, linux/types.h and linux/delay.h).
Sort the remaining ones alphabetically.

Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
 drivers/mfd/omap-usb-host.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index 4d29a6e2ed87..4e066a17cef0 100644
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

