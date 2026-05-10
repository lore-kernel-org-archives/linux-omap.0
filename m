Received: from mail-dl1-f67.google.com (mail-dl1-f67.google.com [74.125.82.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C98634DCC7
	for <linux-omap@vger.kernel.org>; Sun, 10 May 2026 05:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778391761; cv=none; b=X4hDKGf4eH9XJGGP4DUTzT5zEzG/xjC2hGhPdixMiQfkN74VXUqWvQ+kX6X/IRrvPSadKxBvE67J/oWx3WEuGtACi1JPc1LnHiJCreY4tNSxy7vLDKHSfkq+MovRdNp15FjOJXJ4/+CrR5lXHWME7pllOv7IC5NHCw5I0Fziy60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778391761; c=relaxed/simple;
	bh=Ihxi4KNOEEvlmd2zoiWy17HenaFDDKThY+SN88NDvYg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uwzRR5MbkbHdRzgjrHaTXfj4hqgbxDeTqL4C9gi6Dk5YJ4ZVvLyTt2mhCT709vjVusZ731NngozTEFW2Meye7pQJ9vtofuRfMms4xLZSVJiZaEIusPNIATXA1tGZnk/Cohpmk04TMQ5jrilCr2gH3vWFayzXT79F5yUgo+xfnCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rlG0ZtGi; arc=none smtp.client-ip=74.125.82.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rlG0ZtGi"
Received: by mail-dl1-f67.google.com with SMTP id a92af1059eb24-12c8ccc7755so4766581c88.0
        for <linux-omap@vger.kernel.org>; Sat, 09 May 2026 22:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778391758; x=1778996558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8enRmADSeIqpedQJEEHvSBxiqLlAtmUEe6kyexwW70I=;
        b=rlG0ZtGi9i4yyFM8Fi6RwU4PzTZwdeuGwcIdk997Jn8qVBiG+sigjcsF/bo6PdlpS3
         YdBvO0MgZeEfnh0GmhNUKMt1pKdaRvdvNG0j8uLsTPMVHfivpuu147U2OOPbltayaffn
         skN4ibOtcaDr5JbhZ0uFhq3WmLVkL8VbYqS4J2ZnWTwq95WlWJaAceh+w/bSywX+gsKB
         vfEx7srwoI5o2qIx/WL+PDFw/TWh8hOrfvq6zhfvS7zUCM71Aqze3T0rTyGFekhjrJg5
         eAiYVv0UCANr1TRxcQy54V+HrbcTcgUmYp8Uz6cGaAXs+Q5GY8rcJIoKrt8Fv3odryRg
         1pUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778391758; x=1778996558;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8enRmADSeIqpedQJEEHvSBxiqLlAtmUEe6kyexwW70I=;
        b=TUMDHQv559pZ88SdBSJ8FCNPS5g/2qE5W42f6K3rC0eYzYeyH8GSO4+24094iXGQQL
         CmrA5bLYZKBneN7VA2o3TTf+ARbuaS920181Vf9BYiAfXhUbYTlwd+91KUJXCGOR4bh+
         drE++4Bcnr7q1chBAnHbA6b5zqCSg31S0QlL/wv1E4cIy77R+49f4e5rn4My1PPk9tmx
         J5QSLwryvfcFTbZgE/l/Gu4e0YhEV06mYnkrQkdKRFV2rYilaFSjyl5GqoDhCTsAnXwi
         DrJmK4KrD8zoV6hvMmt1EsKV01kr7nVVyEu1KW5AHDX9SSHvLFOLAfaurXMBcXyVlpf5
         ZRtw==
X-Forwarded-Encrypted: i=1; AFNElJ/FxAOUExjY5l9G+PEfahDhZuTYOeOSmSurjd7IBXAJG2OSCpNz/Ig4fJe238o3qFnEReg6hVhG9Udj@vger.kernel.org
X-Gm-Message-State: AOJu0YwDsdzAdUP0MNSp9AIWfw6voY9vv9PBafLSaOOkICIsMHDbB1wL
	328tQ1AdRd9nra1ZoyGmjkM1cLJpN/lsoBxIo4HuHjTklGGNxF+I+5cB
X-Gm-Gg: Acq92OEwf0QNOs4d+mIvdl6jezzUe+Ddf0gPYmogQH0Ia7HDxtFOmAonlLGUucXKcWD
	8X7CBmR6jhcmIYqWTkzT0x/MoQbwlRvmGrjK/pq31X/rd4GzEi0B/KclTSXbVTdPKMOiZxpsase
	zg4naAwtwYKIkunnBvxpvplH29aN776d+IRmn2O7bAkrftpa+Udx/T+cuedNjFrDIiMtNe28SbK
	GkRHO6nEBg36csYBei8V+qYFM3o9IQIrUGB7G8zszboGcgzQUwgIHB5Y7RUTF6EWo1+wMVY96bz
	O4yLVO49mznAll19z1M0cYBm9JFvinSmS6LgLMzbcu29iULUnCoMiXcO3UPLUIiVZqo9pdBMaO4
	JaCthu/3cCX46HQ0xeYP/dNOxS3ObdakOMUSKJm9tGyeta6VrbeobopEb4rKjA6cePRCdE1u05h
	EScXwEVElGmaREDNmBNQf47PMnm8G5cJsLmd6+9ssoHJmVyJdpHGJsD8OXE/O7g4PmmfurAsv6V
	xUvDbb1UsxhfZuvqQmlX/rLpqqghanlRmqhUJ5EUygVATPoaMFld5UTymhkewhfV95SJ+myrlBl
	+pWqQMK7iNugMxpKIg==
X-Received: by 2002:a05:7022:f10b:b0:130:9b78:b180 with SMTP id a92af1059eb24-132a8715f72mr2229438c88.43.1778391757910;
        Sat, 09 May 2026 22:42:37 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8862d429asm8820237eec.12.2026.05.09.22.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 22:42:37 -0700 (PDT)
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
Subject: [PATCH v2] ASoC: ti: rx51: remove stale reference to machine_is_nokia_rx51()
Date: Sat,  9 May 2026 22:42:14 -0700
Message-ID: <20260510054214.564950-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rx51 driver relies on the machine_is_nokia_rx51() macro, which was
used with the legacy board file dropped in commit 9b7141d01a76 ("ARM:
OMAP2+: Drop legacy board file for n900"). The use of this macro
prevents the removal of machine IDs no longer used by the kernel from
arch/arm/tools/mach-types, because the machine_is_*() macros are
generated from mach-types. Drop this unused code.

Tested-by: Jarkko Nikula <jarkko.nikula@bitmer.com> # v1
Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
Changes from v1: Fix mistake in commit message - machine ID checks
still work with DT booting if the bootloader passes the ID

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

