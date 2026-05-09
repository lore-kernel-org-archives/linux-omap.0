Received: from mail-dl1-f66.google.com (mail-dl1-f66.google.com [74.125.82.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396BE1C5F1B
	for <linux-omap@vger.kernel.org>; Sat,  9 May 2026 02:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778292507; cv=none; b=VGmWgENNW3XQRF922o+CljIeV5vIbYssgdOp5+NEDs6n1aK3awqqHZwS2K33bRBa1yMsLVKft+mh7pVfVWMQMrENcs8a3cdridzYkJDdBTFrbfLJf2YFa7KIe+uvqhAxwwS4PAKB+tDbyIxZAFuKDWWoO5JFNXG+Vlny9cZ/7X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778292507; c=relaxed/simple;
	bh=SU+hHyKOv1UwoAy5W/MYlY8U0fwS9OgvizqU7s+S1vM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m8Sz0kd5nSbrjHrxvkOPGIN5wkW4zeqnl/b4midl5KeUE0RTDO9KnIlmBKVdWfSiBBPcgrFYpub9fN9FiBxmDD42B2seSmsRip4nNccYoCQNCAxNgmsiclMGTs+nke+5mksoQpN/D5UAItRdBgAZ/puCPCpObbOW/gi2JHhOUXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HMLe8EDF; arc=none smtp.client-ip=74.125.82.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMLe8EDF"
Received: by mail-dl1-f66.google.com with SMTP id a92af1059eb24-1329507c387so1655240c88.1
        for <linux-omap@vger.kernel.org>; Fri, 08 May 2026 19:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778292505; x=1778897305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+bFJzQA8V6grxSKW5mpCmQoAxXzJUQzk3wcMN3B8fCY=;
        b=HMLe8EDF6M6PXnLNN+GnJSMrPyi++6jeE9feeHByf1C6KK6iTGV8aW26booz70YwP8
         LQBWKEZRuGtbFVDtuiifqOg6rP6+S95KxPKW1kC3g7Vr+CTQ9z15cNme6BPxmGo94Jmd
         0Hbj+HF8vE7woEcxWraj0/LfATzoC8A6uWlpakT5fh39WFHizDeXMJS4jdFXz6gHqLZc
         lkfQpqbAW+Ent7pWlwcEGZfcWcSt3i4IJ8/TI5yJH+txv/gfiFgygnNErJUiFvxEgM8B
         KNtcbor5GUpIaJOYVh2DdMvR15YowKEAYRj7h1LD/jyjnXCNaeUF8GKRqia7pTI6jML1
         P3JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778292505; x=1778897305;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+bFJzQA8V6grxSKW5mpCmQoAxXzJUQzk3wcMN3B8fCY=;
        b=aFSDipIOly7X/Z+D4ztTeiM9cJLwjCLguXttYoENBeAPoz6h4BD9ezzuW0DTAcaSev
         PP7OTIXfd/h4kw08btGmcI7W6iMp8xBJrDjK7d/F6WdEEp3cy2Ra3SE5O3JABsesTm2B
         6Jl3xMk0UOZrtA71hYehGKXZGylaQ8tU8tYdUJ36/PGNXOAmYdKzl0fawunrSOVVgovP
         gvVJ0YcAS/mEy1fPJx3svkALgdjFqGTGmybp5ATDfj8i7NSHRK7O4R0AWyvqEJWQ2ED2
         J48CSUAvK+FTrDzYL0GI1vQsQl0Bt5VeNNoLEcvwOombawXZ94tBHRKtXQ1cx3cfCsYJ
         g0ww==
X-Forwarded-Encrypted: i=1; AFNElJ8RF1rNyK41AWVIbzpXDSLZX5xyXVx+twQOUlDnoZBhogpXfbW+1w8zdPrUd2O3GiqDddR5fk1hY0H7@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0oUw48nKlOYB5F4kJ3MDjnO9h1ViylZBrLIllYAYS+oTNQmzb
	klLS16okYJQq++V8eZf8w/iJG6T6QgtwZ9NIwHRsArZAoo5fcvz922Y+
X-Gm-Gg: Acq92OF0o3K07YhOa0iSptPZd7W5JsSDD7IZMr6/fnnxejNp2q5aSoleK16roYIppc/
	zP9mJBShQq5oqoYVhNjgyeXo8vIRZqFkAPiFEZLU18tabsmGCxUqRu62qg5pH9/VqepyFyvdQ4L
	rq4ePheZK01pWLGnsIUW0yAjtCapfMCSoyPWY71KA2v/hSmhEByx3RON/KW3ScM9fdV9pVHKk9v
	Cy/MrUv/zhuidX/fGWAHc+ovw0Cqe/C8LsRE128kP5dy48/dmNdsrkJ5L/zLc34W8DXhtSD2XTd
	dN+Ku4irN2SdARw/U+LMHNiYnBNPOeefXYHFMUZHgwzT4stRN1kY+eYtZyoruYm3qDU78O9vvhO
	z/rvd0aLjrGaBz0i0IaxvGlreSeM+tC/uqqLvPFXH5HV8nNeU6VlCxblHwQ+ZbbnQ/IoMexZ4za
	u+Z8Y3X+sRBBohZHyoSgQwSX3BYcTGh3bJFSG360qvqL7Ny11hFoOqX6pWXkxExs0DKh3hjaDrw
	xvo1PwmO2elKig2yoHTlh59qQM84Pre3GLPv83/fcRkJdwUICNQuD2/mxDSozxLuzgsBb3fCX0j
	E3X05/+og412ZOribA==
X-Received: by 2002:a05:7301:e0b:b0:2e6:e504:5431 with SMTP id 5a478bee46e88-2f54cc681b9mr7932458eec.22.1778292505264;
        Fri, 08 May 2026 19:08:25 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f88847502fsm5423080eec.14.2026.05.08.19.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 19:08:24 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-sound@vger.kernel.org,
	linux-omap@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	stable@vger.kernel.org,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Jarkko Nikula <jarkko.nikula@bitmer.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Grazvydas Ignotas <notasas@gmail.com>,
	"H. Nikolaus Schaller" <hns@goldelico.com>,
	Tony Lindgren <tony@atomide.com>
Subject: [PATCH] sound: soc: ti: omap3pandora: fix stale ARM machine ID check to use DT
Date: Fri,  8 May 2026 19:08:08 -0700
Message-ID: <20260509020809.33060-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The omap3pandora driver contains a check for the ARM machine ID via the
machine_is_omap3_pandora() macro. This check is incorrect because the
machine concerned now supports only FDT booting, which does not use
machine IDs, and therefore it will always fail. The legacy board file
for this machine was removed in commit 7fcf7e061edd ("ARM: OMAP2+:
Remove legacy booting support for Pandora"). To resolve this issue, use
of_machine_is_compatible() instead.

Fixes: b715da74deaf ("ARM: dts: omap3-pandora: add OMAP3530 600 MHz version")
Fixes: 9ccd0106c9db ("ARM: dts: omap3-pandora: add DM3730 1 GHz version")
Cc: stable@vger.kernel.org
Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 sound/soc/ti/omap3pandora.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/ti/omap3pandora.c b/sound/soc/ti/omap3pandora.c
index f11b1d8a1306..6c9c184cd9d6 100644
--- a/sound/soc/ti/omap3pandora.c
+++ b/sound/soc/ti/omap3pandora.c
@@ -11,12 +11,12 @@
 #include <linux/delay.h>
 #include <linux/regulator/consumer.h>
 #include <linux/module.h>
+#include <linux/of.h>
 
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
 
-#include <asm/mach-types.h>
 #include <linux/platform_data/asoc-ti-mcbsp.h>
 
 #include "omap-mcbsp.h"
@@ -225,7 +225,8 @@ static int __init omap3pandora_soc_init(void)
 {
 	int ret;
 
-	if (!machine_is_omap3_pandora())
+	if (!of_machine_is_compatible("openpandora,omap3-pandora-600mhz") &&
+		!of_machine_is_compatible("openpandora,omap3-pandora-1ghz"))
 		return -ENODEV;
 
 	pr_info("OMAP3 Pandora SoC init\n");
-- 
2.43.0

