Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429F046983B
	for <linux-omap@vger.kernel.org>; Fri, 11 Sep 2026 09:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789118322; cv=none; b=Cd1hBJt0Ek5jdmXgYI4utxp1lZ27v+LReOkiJeM4d4D/xCvECwk4fQO+1M7YEWO3E1Ge66R3RFUoY2R8x8zC0zZr4nnG8evUwNIXRuz6Sd2ObX4lLXTcpxlVQJ/NytEBzIYW+wDnuS1Hejp8IqLt6Xcn+nrxcA6do6mUEPMCrDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789118322; c=relaxed/simple;
	bh=FNdJQg1nU9szWM1z+WQDgA68h3ZDQ7o49HjueSGBOds=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DlzaSU8biIX/vKOjrkqp2OF94b7NIDH1dFElcgiMYwMRCSCgxuuYcHundmpnPNeaxwViAWU+tALYpF7ycO5ftdioyWeMKEzU7GByywiEn6ojb05uEYNZ6UHF/E2zUNrm/d12WbJhWm8aBnpY6C710p4W51MiSdM/RjfOd6tSUjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ESSRExb7; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ESSRExb7"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 5F314C653FC;
	Fri, 11 Sep 2026 09:19:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A75A8601DE;
	Fri, 11 Sep 2026 09:18:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 89F2011C7AFA0;
	Fri, 11 Sep 2026 11:18:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789118317; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=d41CLK7NzVUywqJkormRGEPI2n24qzm1kyA+ft/gceU=;
	b=ESSRExb7lLsINACTLsll/7Z92NOsbCm569SBzGLpAbI19WD63QbinrrUcSEjmrERpqb4NE
	1nniMmffq4N3NDcDzcmv2vx95Ciu8oCavP78t5NDmGDV4qGJ0AyHcDZm9NCDUV+BF/YLwp
	eTkKiPVZYpFrypemBrCIoW1pFjHJ9WDNTWaatKOy3UGHonhyd0TuUxQ6Ib0zT0I/Bd1ho4
	ss0ryVrbvt2/zY0RLYvxCGBOQR2laaElzP3pdYXaIq6AkxnnR11UCm6MK4EaJAWoJpNSMN
	YfYEvAoWKZUnbxMhjGEmaPIOb2wf54Qwe9E9RFweaknBu3ZZvY22ui79QbVeyg==
From: Diogo Ivo <diogo.ivo@bootlin.com>
Date: Fri, 11 Sep 2026 11:17:34 +0200
Subject: [PATCH 1/3] watchdog: omap: Remove duplicate start() with
 early_init
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-omap4-wdt_boot-v1-1-637d778a4a1e@bootlin.com>
References: <20260911-omap4-wdt_boot-v1-0-637d778a4a1e@bootlin.com>
In-Reply-To: <20260911-omap4-wdt_boot-v1-0-637d778a4a1e@bootlin.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-omap@vger.kernel.org, devicetree@vger.kernel.org, 
 thomas.petazzoni@bootlin.com, Diogo Ivo <diogo.ivo@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=921; i=diogo.ivo@bootlin.com;
 h=from:subject:message-id; bh=FNdJQg1nU9szWM1z+WQDgA68h3ZDQ7o49HjueSGBOds=;
 b=owEBbQKS/ZANAwAKAQa+fFtWXslFAcsmYgBqo8dn3OqUkE0x8xLdxpcWjYTljiyg1JHdVJWWT
 mkF+6//T6qJAjMEAAEKAB0WIQTma35o1i1081e8B2UGvnxbVl7JRQUCaqPHZwAKCRAGvnxbVl7J
 RSSGD/9aA2bZUMvTaB1XFp4j5tZe/C4bDRaq6jXK0qUrImz4bGNcRSDbX3Z/scHOQBmp6b/vwwk
 v7v49VCnwbhagy2jdtmmlLwRdLDu8zLg/SI8uQiCGDcLr1o7+NnFsKS/z6qCrG9/+f5tRBZTdKI
 1gnwi210Tv8tve3ZmaMggVZO0UNSuOLAOmp01jjqFjzsjAje+/dQKHQzIZW0h5lx+VjS/9fRSXx
 EsUfM/8YSgqMX/w5uyonaXvq1shxCbPkynJD+7bgpZP0smVGR/UY3qfvMwHpMfo1s07A1u7ebMw
 A0zee3/D9mn+OeTr0giAM4RRdyY6WBAnv9+J9AzcOj80DGo20os92DHNeJ+LszXNnpIkwtkaeai
 HLmvWyFTeTcQ77k63HKTTSg0k0Mc1NlXGF4Dd3TIJQUD6RmxH3quKrJYaNeMQO2s9d4kecdsOlV
 fFpUDonWiQmSXEHx56GOGiiofbaoyk0kcsWBELPEHDcIHCtzrAuWV7k7myRj/zzU1TUm+cQGVBL
 GvfLEBOyxPibYI2RJrZEbanqNEw9PSwh5rKCzDzCvGQ+ZXtBdloXyuNploAolEncYrfXXWy8AEk
 Z6ngeDrx4Oaf1VNl99iVRznWYTQl/xVh0v0Mq/FWgueWk26YVkY00Fv6Yif1UPIYO+SMauMxos7
 NdnF94m10JICW1Q==
X-Developer-Key: i=diogo.ivo@bootlin.com; a=openpgp;
 fpr=E66B7E68D62D74F357BC076506BE7C5B565EC945
X-Last-TLS-Session-Version: TLSv1.3

Commit cd004d8299f1 ("watchdog: Fix OMAP watchdog early handling")
reworked the handling of the early_enable parameter and added an
explicit call to omap_wdt_start() in case that parameter is true,
but left the call that was previously there, which became duplicate.

Fix this by removing the unnecessary duplicate call.

Signed-off-by: Diogo Ivo <diogo.ivo@bootlin.com>
---
 drivers/watchdog/omap_wdt.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
index 2482a1982c8b..e6d869e36c43 100644
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -286,9 +286,6 @@ static int omap_wdt_probe(struct platform_device *pdev)
 		readl_relaxed(wdev->base + OMAP_WATCHDOG_REV) & 0xFF,
 		wdev->wdog.timeout);
 
-	if (early_enable)
-		omap_wdt_start(&wdev->wdog);
-
 	pm_runtime_put(wdev->dev);
 
 	return 0;

-- 
2.55.0

