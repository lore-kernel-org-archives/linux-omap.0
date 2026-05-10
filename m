Received: from mail-dl1-f65.google.com (mail-dl1-f65.google.com [74.125.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8CC2BE7BA
	for <linux-omap@vger.kernel.org>; Sun, 10 May 2026 05:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778391646; cv=none; b=GmdiHiUIc2So4hqSHoMPqnS6n6dmnWa/6NLrzesB14qOmERT3ZhvwEQZ0ZLXMux0AwBPd971xJQoQ68KJgNH+mbN2Pc+aFnbczlgGh91Jr+Upqlo6OX9l4MHQGkJ1pCF3ypOf6amw153uKVwLyRYmBjo5Cqj2RdsquOJi69PU0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778391646; c=relaxed/simple;
	bh=Ze3N2P7b+kULf2hS46CSlo6/HJ8z0yKo2mp0TlBtSgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iR8NkLLCPia+vmJUM8eAmDY17nPCEpPQWtM1Lj5zarT65GYIitZ91V023DriLfsXuCLD8sXLCoBmkCj9HjsvkzCBE3O6mW7AETyMYoBHBc8sFm4VEfAtEH8ZUK5tPjA5uWgGZ6MnudEpgoTDWmR+u/IUxutYOSn6P+RlbAMFNz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G4WNvd+Q; arc=none smtp.client-ip=74.125.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4WNvd+Q"
Received: by mail-dl1-f65.google.com with SMTP id a92af1059eb24-12c45281a06so5448478c88.1
        for <linux-omap@vger.kernel.org>; Sat, 09 May 2026 22:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778391644; x=1778996444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W9BUvuTqBLTWKBWNyf45iIUB6rq281Dcj31xs6Yv1Eg=;
        b=G4WNvd+Q5rd4CvVgaImsGFn3q2++dwELkQZyUgD6dtE2i2E+VBCek6yg78BcyP2TRB
         2HGGMikCp2cZMo7xVKcjT1X1nTN0jQrcZcyQ3ImB7jSXQPuGIn2zNz950OytVN4waqf+
         +RSWD2gGKjbf1WVSpakbJrZShldyMtMK1xe8pRZ85ggDah1VxHKmAGBtWKBepnEI55rk
         Oa+Ku9eB6gCDauAiveK6nJ9GfcRvNBDrTuCvA8adWmDemLur43he66i/T+KmSQEQtAG6
         XVvFFMGI3HdGO7x0fxcMdf/IxyCYTMAgl3hyolK4oTFXRZ62reRcFvaF+n8O7r8apQHu
         LAPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778391644; x=1778996444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W9BUvuTqBLTWKBWNyf45iIUB6rq281Dcj31xs6Yv1Eg=;
        b=OZFOgfn6dB21bT+4CT5OTR34d9rM1aplQ8w2Wr6BXuLQgewyIU+VJBXkcI27Ycmumr
         78mP/wyBfCFeCeJZHX/Ye85nqiXZzFouxi85LHRTa2UHOLpu6LGrgp7DTBFOSxebVEqz
         7ThGpjRc5pLBUzFRz49DpNMZNZIEltXSgt6PcoP0QJ+5jDQa3NiMdOvz2DUcicByV3QU
         Yv+J7iAH4q4PNbq5iluQ/enOc8sK9qFm7XeAInkpq+65IG/ug4QvIhQryhCHQlUmik2e
         nrlQyzf70zO08r4pGyoQi8B4KAN21fMYUZ2gMvm6Au4WbLvocOkn8H1WxA4woiy2xY5H
         0a0A==
X-Forwarded-Encrypted: i=1; AFNElJ+fPvTfAvuJJPGx+HAMhyRrCFBH56B9yk/J+49BnzaJ0ynmGLHCsuD9TSwdSbGAs9NC0lulTX4AP1aL@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5ND3m31in3s55bcBGy7JFEelZY3rWWjfkbsd7tPmJHAqjAc2L
	FiH+4ztytFrHXJaWwPYxHESGT5u9umoHo66aYOAS3kcj1I728Nlxdtkp
X-Gm-Gg: Acq92OFHFwuYAz2wcxE9tcH6GtADSk6V2op27NkulabWcsn0Nc6EmjrOjzbjhQ9N6qi
	NxeBgAM9WrfpysLGisdy1HlZmNqOmbwks8CyfCqyAJk6wz9ARpMSJSu93Va7bvPiVhNUPvG6jDu
	Y80/Ii3vjBGGDmOC+vx5l6+id8AnxgyCk67sKoxN7R+mrbi7mBdqqAhNjSSMHaenLpkUoJDnXVT
	bMbbOdjobEpHW+HVtrtUM+w1GBUE+wFyoy+MVj95l9nbm2BNspX/GAYjgS8uyHQK1pL4xnh/TKL
	MMKP1wLbmcMw4G8A+a02g7gEToC2C3fNFRvXV/ObAJA60bjFcS2iJ3GOQDmrxfF/agMTE7Fp9yh
	8P9TR4efBqIr+GmuAP1rxGMqeR7dsZywJht43ZAlFHhHj3lSmbQtG+ZuhB53kgCu9GSHX88WNsM
	gHojdC+eJt4jKpoqDdjItII9LpADIkXmLLQDqSYRLS7twoLrhMMnsr2zUKEEdjYnRjvaF8BLOyh
	Xvn4sSG+hfmiK9jEOp8iol7aJRIUZhCJTfvAglxPxZOMYKHavDfiLlGRoJ2y2AmXUtBzElROC/7
	QmQlipcDjn5nWa5Dxg==
X-Received: by 2002:a05:7022:3d05:b0:12d:de3f:d853 with SMTP id a92af1059eb24-1318ec61008mr9190082c88.44.1778391644273;
        Sat, 09 May 2026 22:40:44 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1327810ffb9sm12680781c88.2.2026.05.09.22.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 22:40:44 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: linux-sound@vger.kernel.org,
	linux-omap@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Jarkko Nikula <jarkko.nikula@bitmer.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v2] ASoC: ti: omap3pandora: update board check to use DT compatible
Date: Sat,  9 May 2026 22:39:37 -0700
Message-ID: <20260510053939.564314-3-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260510053939.564314-1-enelsonmoore@gmail.com>
References: <20260510053939.564314-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The omap3pandora driver contains a check for the ARM machine ID via the
machine_is_omap3_pandora() macro. The board concerned now supports
only FDT booting, which does not use machine IDs, and therefore the
code should be updated to check the DT compatible property instead. The
legacy board file for this machine was removed in commit 7fcf7e061edd
("ARM: OMAP2+: Remove legacy booting support for Pandora").
The presence of this machine ID check prevents the removal of machine
IDs no longer used by the kernel from arch/arm/tools/mach-types,
because the machine_is_*() macros are generated from mach-types. To
resolve this issue, use of_machine_is_compatible() instead.
---
Changes from v1: Fix mistake in commit message and remove Fixes tags -
machine ID checks still work with DT booting if the bootloader passes
the ID

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

