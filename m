Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE34746D08D;
	Fri, 11 Sep 2026 09:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789118323; cv=none; b=Th24ZfUoKLiafAI/kxiOTXYCG1Huw7VNzJ3Njo1jYc6vQ7ExpglRggybfu6Y8BvgofLKZEo3lW7TIuLk7SOgthD0PfcTExJor/nw7bav1r6Ta/MicZ5x/rrFAGb/VbsIg62zMlmlvT45+rNpDq4Glh0dseSDu90ScDZSoLAxIKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789118323; c=relaxed/simple;
	bh=JwXiDJvvKQIv9MV0uZmtmaGOF+sqPSMXOxUVlZBM3d0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=akmrWvK7nnVyAyH8y2JLjuxpNmtFwOE+TTNhHQNYEEzFRx+S2F7nRcyoCqTzoWNfEcALR26zE2q8dhvh+aZFQq2VSpM42dp4yNDvHC7J+0bVkPS3eL3AHdqYAncjwqzoE1YDLSicNoLpohrd0oPe3mc4cgeNFrg0TnI0nLHBJGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=15IFO/PY; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="15IFO/PY"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 78DAC4E401D0;
	Fri, 11 Sep 2026 09:18:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4E55A601DE;
	Fri, 11 Sep 2026 09:18:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C20AD11C7AFA3;
	Fri, 11 Sep 2026 11:18:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789118319; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=kcsovVivfSkskH+qrQru/srukBjicvHQEB/3X3BkSK0=;
	b=15IFO/PY1s8WbVXRaw1MlwN/EHA6V87YyB5bJLaqTwILGJ13WuRdUxTCLQtJ0/rv0/gEed
	7UhBDh6mT4evTKhJ2fh06x0ecWJa/L+fP4LavtD1opYyuWKWMtBGUER2VWgQxTuhuGeTUk
	bb13n3KoCylRD1oTxr3hac74z9qQw8xsAsarO6qHCl4baR33z2PCzT9zcI6BOI4ehoMdL6
	Es3Rmdwt3QQD/AtAYRD/hxrUjhZIWhasY5cE1bXo6KSt6+BQCnEXfUTaRme89mSk+W7Vzs
	+cGdmmVzDrI3/iItkQQ9OcSljU7d2IzZahgkKZhfMyH89wacI5AiH+Vkx8WqlQ==
From: Diogo Ivo <diogo.ivo@bootlin.com>
Date: Fri, 11 Sep 2026 11:17:35 +0200
Subject: [PATCH 2/3] watchdog: omap: Add support for reading boot status
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-omap4-wdt_boot-v1-2-637d778a4a1e@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2617; i=diogo.ivo@bootlin.com;
 h=from:subject:message-id; bh=JwXiDJvvKQIv9MV0uZmtmaGOF+sqPSMXOxUVlZBM3d0=;
 b=owEBbQKS/ZANAwAKAQa+fFtWXslFAcsmYgBqo8dnuO+8H5t1mjrBtVxWjuixihy/gr4WcRfsz
 FtarJ/GybOJAjMEAAEKAB0WIQTma35o1i1081e8B2UGvnxbVl7JRQUCaqPHZwAKCRAGvnxbVl7J
 RUomD/4+GJOqk5iHlZLw1gUn9Xj7kcA0QMEW65YtwheY1y+T0GMddDKhNmv+lL6qzT28MFs/BtQ
 sYsbAXdlLjYgsGjd7issx4cK/YrFei5UmXIgpSGoFF1vNCKmVTm3qIYba3pEQmF2ITZ7LNMOITg
 iYdYEFXBZTEJmYJY6xPHR/QCZG5+kbKeUrZUK9YPjbLteCY1XEJzAu0DYAcyQPVhNhXs62Rqz1t
 TJJWV5kpbwPp38l3Eh5Y7fdVx8sJr24urFvghjOreyTAPZp1a4cgL7HLQulioXDZUsSAHNmEJAK
 QNtN4Hl1tq1/Iyx8UFytH3RfCHkUM3fn9m8cfLsir0pZuRp3djNHl9YpfoifWScWty1bFyZda4z
 B4waI5f/mGNO3BrAVNvD9KBc56qnRrI/JWPmAIrmvVbpaMH0zCw9P+nbzjaX4LK5uRAfbJJJGJ8
 Un/W2iIf4UDnJ2qEO3+fSk6j3vl5CxI41AE5uahahc1rqEV0g40T1wbJ+Yv7tsxjE0NcUaTqAsP
 BfmE2n9+TjpJqt3zYBEvznzenDIlwuP/URLwBKRiePMZW/2+kplFFijuFIaxZRLZFC51SeYIHtJ
 OS8PZ6kUuA1zH0Mr19nVQrl5h62oTc4g/ePdhj7rYUkydVMz97RQabyNddsGMNN+ZoeilAp4Hje
 5rdlLrpjZEN1Igg==
X-Developer-Key: i=diogo.ivo@bootlin.com; a=openpgp;
 fpr=E66B7E68D62D74F357BC076506BE7C5B565EC945
X-Last-TLS-Session-Version: TLSv1.3

Add support for determining the boot status of the watchdog.

Signed-off-by: Diogo Ivo <diogo.ivo@bootlin.com>
---
One case worth mentioning explicitly here in terms of regressions:

Consider a machine where:
 - the bootloader turns on the wd
 - early_init = 0
 - omap_wdt is compiled into the kernel
 - CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=n
 - userspace does not service the watchdog

The behaviour of such a machine up until this patch was that the
the system would not reboot as the watchdog would be unconditionally
stopped. However, after this patch such systems _will_ reboot since the
watchdog will be kept on and nothing will service it. In practice, with
just this patch this will not happen since the ti-sysc.c driver (that
probes prior to the watchdog driver) will anyway stop the watchdog, but
when adding the next patch in this series to stop that behaviour this
regression becomes a real scenario.
---
 drivers/watchdog/omap_wdt.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
index e6d869e36c43..7627d3c626c2 100644
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -26,6 +26,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
@@ -42,6 +43,8 @@
 
 #include "omap_wdt.h"
 
+#define RATE_32K 32768
+
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started "
@@ -225,6 +228,20 @@ static const struct watchdog_ops omap_wdt_ops = {
 	.get_timeleft	= omap_wdt_get_timeleft,
 };
 
+static bool omap_wdt_is_running(struct omap_wdt_dev *wdev)
+{
+	unsigned long period_us = USEC_PER_SEC / RATE_32K;
+	void __iomem *base = wdev->base;
+	u32 value;
+
+	value = readl_relaxed(base + OMAP_WATCHDOG_CRR);
+
+	/* Give the watchdog some time to count if it's on */
+	usleep_range(period_us * 10, period_us * 11);
+
+	return readl_relaxed(base + OMAP_WATCHDOG_CRR) != value;
+}
+
 static int omap_wdt_probe(struct platform_device *pdev)
 {
 	struct omap_wd_timer_platform_data *pdata = dev_get_platdata(&pdev->dev);
@@ -267,7 +284,7 @@ static int omap_wdt_probe(struct platform_device *pdev)
 			wdev->wdog.bootstatus = WDIOF_CARDRESET;
 	}
 
-	if (early_enable) {
+	if (omap_wdt_is_running(wdev) || early_enable) {
 		omap_wdt_start(&wdev->wdog);
 		set_bit(WDOG_HW_RUNNING, &wdev->wdog.status);
 	} else {

-- 
2.55.0

