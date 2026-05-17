Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39ECC30F7FA
	for <linux-omap@vger.kernel.org>; Sun, 17 May 2026 02:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778985459; cv=none; b=PKlaNHS0eiJJ9zxnRkNyiHF2Pj8lmeSCm1zTahUZt+u/Lvlic/q/5mnLoWd6ISSt0aQ4T4YaX2/kXgQzL9ifechGHe0qZF/BZOIcgrR2pGd/ltCZ10XG74L6kqQn262Hg8cCvQ15+kxrmUwsiPLXgzWRvvSM+4WhctIvn6bA6xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778985459; c=relaxed/simple;
	bh=nkr8/NF0Epi/NaFan8Kk2N3mFZHQBA8PazqHLbcxLsA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fnx0/nRd+q8TCbgEkbciivTNwBxcgQdUqnEzgO3VTSX57a27Ui3ezaVcnXt7m5ouF/5YJihTlwjw/38oPeg5zX63Q7e9gw3qQ6ns7kivRjZX9hwEaceKLrnMLFa3CA8v4l8UnMtG7vNljKriaBJAGVzTuOOO3e2ze5NO/cG3wDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZYWDxxbN; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYWDxxbN"
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-2f03d6cf77bso1106075eec.0
        for <linux-omap@vger.kernel.org>; Sat, 16 May 2026 19:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778985457; x=1779590257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=64N9mxUmbn95xk3hRi+FhhFjawkaA9BLaMqdL0SOqL0=;
        b=ZYWDxxbNH78fpsHmWy4jfQP+Z7FN2qLNCL85kFGHbz9vy7cp9lagEwi1ucK4qrnKd8
         MZ3LwIBpjxkV9OVbo41buzWERVMupXHW/XE4SkBBmARTnVoXufwwegJDZQCzsl0+Ry8x
         +k602T7iT4LcoIuNhtaT1ODLPLHu00rSkfRR33TRXCELN+t7ivve2DTlylKpzxX6U1bM
         siOqcp0Om6FIG3Dnc9Swtub5ATUJ3Gs48dkS4dHybRFqxUF1IwnWRwxkYDfmu/gs2R+H
         FmGURDQCoK+YiHM5A13huCfJ/QfnlbZjG+heY2thShE4tSoqmv2VsK6FNZNVzA2hD0ul
         LxOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778985457; x=1779590257;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=64N9mxUmbn95xk3hRi+FhhFjawkaA9BLaMqdL0SOqL0=;
        b=MThMH9E/0Ig2MzExJxibX7B1gZdna+7UmAqMByh4CFRU6ku8f1naz6Dnih8uTpX93I
         PGqw/0bDbLu5kPvTrIla14HtNjUQfYMb1RaTQf7KCP+ayrgW9Lk8wkYV+5Piv9w8DCKr
         pGueE0kzl91g4WFABHTyND+ad1y2LOPvXxUiWveKdVOuwGjnqDVhwr7xkSbGpdzJcwCg
         m6PPKEvF94sNHrezgRtNef4nkG3O85m5C2llJNyb2Ylk4T/G15AKIHx05qMxnP7qgmP6
         stYNp+5EJb5wvOpZ+PIM6CI306YL3hFPiZHYOejEea88Jt20mC7VsKeovxVgx6vTuvw+
         4NHg==
X-Forwarded-Encrypted: i=1; AFNElJ9PrgkLLHIwz9COk1DsEUTIF2ixtyfx5VHvGuZOpbLQwkT+l4DC4hd/NhrmFZn6/1d/ZmcoPGN5lOir@vger.kernel.org
X-Gm-Message-State: AOJu0YxAl3P7zS5Lk4PKZZZKPwOXKqviKeGdJz1FOgNGvz4i/RnNIUKg
	BsUUiniKaI+oojpxsyxuj+Gdk3Pw9KrOHnDZS3uxhBect4PPcEx7nsey
X-Gm-Gg: Acq92OFCsgaocO3bjL6rLA9dpcyP5KXicXiIrVs3zj9SoLkl6S1NiiGwHPDC40GUn6i
	UB7s9SZBebBmF/nGO/0M3R3zBCkgAjvH/DyVUUR5DOrKIZQu3Cu0pcaLjTOlsmszCWHuwWMlSG6
	MxP885NYE9h8EthU90G/2g2gz/jTG9wrmZ3laWm3s9nREF89sVmDifFQu8+eM2jO99n6uoiOPs2
	ThXr/xQPkC0KhZm9AwVjN3z1POdCiNjIxJqMGQxQTS357/NBcRBniM3Q2civdT9I7Uwar3ssyx8
	8rm4JIQTUwYt4uaGBV98hcU9hnfhlCRRWH28hwRE/qJWc04kzAd1t1XzmjMRgJsRE5230yL3AQR
	CdfzV8Cc6QYFM/28uLU1LhReBvN4zhOqaEfH4VgBX3Wrbpjvjm7fRJCSy5OXxHnhR9oCTekBo6Q
	Pvi4/D0OVxEDvMkVZnWuUq2b1HGrcQAhHDhvvATL/f1cR3zddQUACCoMi/R6fTghWremFN+6kcr
	z6E5aUZgaFcbM1MPMpaxRAAI8mARWKk/uA01p/UQcbef2G+oYNnDGW8VVubmGay6Y5tUdwrD6fg
	MnjfiTrmSQFFztT8mIBQwZ57yENi
X-Received: by 2002:a05:7300:5708:b0:2c7:3a7:c792 with SMTP id 5a478bee46e88-3039867717emr4432185eec.20.1778985457292;
        Sat, 16 May 2026 19:37:37 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302978b1a79sm10850097eec.28.2026.05.16.19.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 19:37:37 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: linux-sound@vger.kernel.org,
	linux-omap@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Jarkko Nikula <jarkko.nikula@bitmer.com>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v3] ASoC: ti: omap3pandora: update board check to use DT compatible
Date: Sat, 16 May 2026 19:37:22 -0700
Message-ID: <20260517023723.92731-3-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com> # v2
Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
Changes from v1: Fix mistake in commit message and remove Fixes tags -
machine ID checks still work with DT booting if the bootloader passes
the ID
Changes from v2: Correct changelog formatting (there were two ---
sections in v2)

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

