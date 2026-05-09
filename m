Received: from mail-dy1-f193.google.com (mail-dy1-f193.google.com [74.125.82.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27D623BD1B
	for <linux-omap@vger.kernel.org>; Sat,  9 May 2026 01:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778289777; cv=none; b=UF/5+nTIb8UjqLzHh/tGgWs2ssKpXEKGXbUX/x4aR95QhaCVwLz1c1FnUYjmx32MlILynnvwX8VovSSECfRYpwIJlAC9IJ1C5jdDvIpxQ8rvGh7Y6w4BeGQEOoY1s406XVqxjTegvps3BgjljvR7y4Y3cH6ESEw7JC9Ab2DybDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778289777; c=relaxed/simple;
	bh=wdkxV+TyQvL0uyh201nZr6hlEdrLsEZvNEemWHe8Wnw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FHuI+Y+F429nYL8COEQcr1Tz3MTMQALk3QCyE0VVB15RFyo1XPV5qeoOAyyv+lTxk+QmNDYaisw524eQStH0LlFGsGQajpEBdbgmCZFiFcdCHwOlerZM5YvKCxwhRRaahKRsuB7zNFYUhlZ6pRIEcW+ZhireRJ5QJ2IBvz4zxVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=If+5QXsq; arc=none smtp.client-ip=74.125.82.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="If+5QXsq"
Received: by mail-dy1-f193.google.com with SMTP id 5a478bee46e88-2f36da5c8fbso2644047eec.0
        for <linux-omap@vger.kernel.org>; Fri, 08 May 2026 18:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778289775; x=1778894575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G0cHu/AZOFkLjDuxm2JV8SwCnwjEcedfmgM9JUvSLnc=;
        b=If+5QXsqUIqOwVjciTZoKJ3dop7rqS7YxhvLjngRqEL7lit23rK691sMmugEUgoZ+7
         wS960rcRT34LkrfWduiiAHeaE7mBV4ulTkMBptZU/6ieC3zWQf5snbPt8LoZoGwQI+G3
         85XeGqZdQaQ0JzRMJ/6LCp4jm1ap6CG06WyEfRbYWWRzDft5Xn3VgXkylYrUsl9QNoH+
         X85JAAvBVpnBKDuL3RA8oeo/vCKjGfyZy5Ugt7CY2rCVV69PIjktpR2l8TWBMmpMTcQL
         laBfLhjfui+GowosRk2ycATQSrfbDbjA8D/K98rn0owwwyhl+stMEpv9RZMsfIDyBFfG
         kG2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778289775; x=1778894575;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G0cHu/AZOFkLjDuxm2JV8SwCnwjEcedfmgM9JUvSLnc=;
        b=ZUdn94YJVrL2qJe8oZqi8W2ysbpGEbexjcUPO15CaPLcnl2URW7j8HyuSUqHm6BfID
         7MQQavwPBgUoOZK8uwpQhsuoinrTJzjh2vu2PeKZQtVpIa4juyAGZ5/UPSJ8aincBCl/
         0V3UkJTKeMKaf5BHuMcG3bwIdWkTP3tmV2LvCuoA8JZm4cfGAwJigWXrNTyaKEeevmXx
         uK4dAmtURKUwvhwnunEwP/Xsc35qqT6N1+3Xz52RXMAVyl5fu2BCGuJJDLEF2reS/le1
         d4pE1T0NZ7RrPyv21QJ2YuZ//8WbwwZutGaOGP2sOeXH8qqDva3M2Q/NNj9bnelN07PM
         OJ7g==
X-Forwarded-Encrypted: i=1; AFNElJ+zFpV4cKyWyp1abkcuWzydDRhr/Rf0RGIZgaj75/5nklnPLMD7JzYVxk4tUjALxDAmER4ResrwaCTf@vger.kernel.org
X-Gm-Message-State: AOJu0YxA9mEYkMSHtR8MyrFQppwXTrR1tcqPrdMYSCUbdtoko/DxCo+4
	zUHLJ1OW0u3BwcWC/T6YBrdEIrA1v2wC/DI/hIf/PLgIWUe3/Q5gkhir
X-Gm-Gg: Acq92OFWucfhVQOD3UcvjDyMXbZvNiVU9YFifo+l6EtaDfbfzAFyrayza2Q464fpZwM
	Ef3s2QeYYDEQnP+Vw5CVecsHniLGHhrlRmjufe7ul4Ku5GVqfQqdWKiPdM8LxKkqXBDWZnspAlh
	Eaj+pnc+mb6EHGbG6+Au/9lBR5TmJdzJgztfRIdP1heH9Jr3/z9JSrrlD2xlDaS+eHu+4+8weI9
	SrNVPZ5mKFIfDTR3aAJ35sj5Kg99YXrQqe3BXFk7UhztXmeewc0OibUY29oltbnw37UyfPzHMcY
	gPhtA9x9INXorpIfEOpmpo6jxY8r+7wN0PLnVu+SoxokwebVkzGSOBwZoJ1zBFKdOYS4xrb+xUy
	lJZpR8HoBABCJ+rBcm3zCObXd1fTeVVBBkjZ7Jc7U+m/TNbMW6xUqm9GtAiEXGHbMdqvQrR9iPD
	1CnYBZ4r8BDH1DRcmJjQBT/zP9izw/fxqQNYL/M98u/kuuaL/f+/5NFYS35gC7Zae16ZH0Pfu96
	IznGdLMH53fQbR3j0qHtsVvlfY0/TnTXhykfHv/whdKoEHRSI78W4eZBJVDLEIWyb7zc4TQ1+4G
	aNK8xqOEeQjYwgg7JA==
X-Received: by 2002:a05:7300:a508:b0:2d0:239a:23cb with SMTP id 5a478bee46e88-2fb4d68f9f1mr209442eec.16.1778289774801;
        Fri, 08 May 2026 18:22:54 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f88914523csm4457310eec.29.2026.05.08.18.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 18:22:54 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-sound@vger.kernel.org,
	linux-omap@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Jarkko Nikula <jarkko.nikula@bitmer.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Subject: [PATCH] sound: soc: ti: rx51: remove stale reference to machine_is_nokia_rx51()
Date: Fri,  8 May 2026 18:22:46 -0700
Message-ID: <20260509012247.14990-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rx51 driver relies on the machine_is_nokia_rx51() macro, which is
always false since commit 9b7141d01a76 ("ARM: OMAP2+: Drop legacy board
file for n900"). Its presence prevents the removal of boards no longer
present in the kernel from arch/arm/tools/mach-types, because the
machine_is_*() macros are generated from mach-types. Drop this unused
code.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 sound/soc/ti/rx51.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/ti/rx51.c b/sound/soc/ti/rx51.c
index 7eeb12e5066c..cfc23e0838c2 100644
--- a/sound/soc/ti/rx51.c
+++ b/sound/soc/ti/rx51.c
@@ -19,8 +19,6 @@
 #include <sound/soc.h>
 #include <linux/platform_data/asoc-ti-mcbsp.h>
 
-#include <asm/mach-types.h>
-
 #include "omap-mcbsp.h"
 
 enum {
@@ -364,7 +362,7 @@ static int rx51_soc_probe(struct platform_device *pdev)
 	struct snd_soc_card *card = &rx51_sound_card;
 	int err;
 
-	if (!machine_is_nokia_rx51() && !of_machine_is_compatible("nokia,omap3-n900"))
+	if (!of_machine_is_compatible("nokia,omap3-n900"))
 		return -ENODEV;
 
 	card->dev = &pdev->dev;
-- 
2.43.0

