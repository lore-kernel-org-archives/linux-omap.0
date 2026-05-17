Received: from mail-dy1-f194.google.com (mail-dy1-f194.google.com [74.125.82.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F365B330D22
	for <linux-omap@vger.kernel.org>; Sun, 17 May 2026 02:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778985457; cv=none; b=NOXFab4fpHwUu5laDdUK1gIGNWeO26XKrBR4dbmxbbu2v30jPGHtJiBEOF+6mhyzLYLhdJzF9CP8ilItt88u+e5+7RmAcZiaWBbzOqtyaeKtKW4Ilm0mouj8MFcNytnsDgNNSoBJZUzI+eOhvA20auzoLPn6oXOdH+9ZqdKiTZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778985457; c=relaxed/simple;
	bh=CIK9ZQ0DaM/1VYQiCFieJ/ag2SeQsY3cnpJe49YS4W4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ugVJhtNql1XmK5v8D8gG49fUPvtTJeBNNYIQMhPucYJSaKAUCTtWlwczmoT6SvbrrDcLpczo83FRMtUfrJl9kkpJHkQprEITLx0MKjbr5C0NVW/rCmGQBDiSJJJJYP41wa9jRvrUcWkDnzRM90GM6CxGXJI/ed5n81zg40Y4icY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AKID+ce5; arc=none smtp.client-ip=74.125.82.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AKID+ce5"
Received: by mail-dy1-f194.google.com with SMTP id 5a478bee46e88-2f7ca62a3c4so976458eec.0
        for <linux-omap@vger.kernel.org>; Sat, 16 May 2026 19:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778985455; x=1779590255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XPXVYMayPtGYPlEKSpXH4Jjo0oxxzH6LuWNXJqq8lSU=;
        b=AKID+ce5oHzgTR10FQi1Li51w6EIDf6wRMVmpesIOyxEedi7QmET+WIAMuBoZA1cNs
         pBbjGh4sVRYRu8GAFG3FcHmleo2wstYCnmRqqB6iJgLkZ3rWvCdn9rTB9Qy5haQctKVf
         dx7qbbDUdQRxZtlQkEU3+4CfDEPQgYN6YjbfoJhZljWdOicV5hEKBEvma8qc4UrJy0Q5
         koWmKEGHSyMyjWukCNPW4dMhYh5EWjZobO65EFa3CM7dKUK+LBD1MxF3iPGO21LSM33H
         DGWhNNzjncFnYXfm8zJ8n9GuOqRGmdEw1WwX2bdMidrqgME0f0I5YtKirV3+B7oyO9j6
         OaIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778985455; x=1779590255;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XPXVYMayPtGYPlEKSpXH4Jjo0oxxzH6LuWNXJqq8lSU=;
        b=EE6sJDG/71c9qV70aHUz8acvOEeaFdWojscrRRXPLa1GjwB7xJvrUFcimutvcq3nhh
         wXNDUO9Qbv/XiNUDS66InKQKDoCbRGiDJB6CKtP9R2G2JcZFFfNLariuG8pUeUfeNQWp
         gnqatYGy+zdlr4q4sipjCq0lf4Atr1GlyMyjDZQPBV9lQ6anMLo6t2jMlgcaKvSKPJSI
         J8nfOIsFE9mjvNO3Owfx8FIFbqMl8dD7Od74o+VMtEV9UlJ0LI/5Pp5H6vxDT3C74f2f
         8eaiC+YX69pnZ+ahVlMeLPKO8TCuUgTwGlCotxcAWPsvFRQSyyO1xgXFEvc9nood0vij
         0b1Q==
X-Gm-Message-State: AOJu0Yw5mdUZ2661vgiMheeFDGlOSm4V9WZJQs3o8KfVqy6JaoroiLGF
	IWFpWaJ62QIp2CMf3i7jhx2R1k6Ai4X69ue6JYwxK75hrSV2SDYYfC+9Xzg7gKtbeYM=
X-Gm-Gg: Acq92OE1D9WixQaLH8J3P8y5TaY96DzxRwuJLC12z/rcpUCiBYcf7tbDRD40RHCpmMB
	DGrEywu+YWCzAjj+5OjeZEfK6o2prTJjiR4y56qxJ94qdHrPWSXCGWxOXRkvu2PZPI6doyvGTbh
	GniITnu0XPqdIi48OA76w7+JGZecQGYjxZ84y6rPuTTmB2N7y+pugR2i9u7gMmuWrLFe7YmAoti
	rES5WsE7mM32dfxjkc6drAoGxveCRtIJ0zoCcwNS6AhHDIXfRLTXmq1JMN9dASm5/c2NOfxw8bl
	oxV4b3cBBwWHJUqgXWkqIae01rdXv9ZHDx2Qk409qHKGs9cghsEmdPJ11Sc6X1NBuOK6MX07UlX
	MpcbdE7bylfHchbD0nwk85kMjEf4nYfBQ0kwS97hijXpLq3XHYe608+DjMH3bufl96vJ4Lc9SUQ
	GDwSHJ4Rikdc3U8SdDcyJ7qW8bTurR2zd1YHDKt8eAxqNQg2CSm8VFl6EAKXYdRBrQXydabbC8t
	jywtFDBKxA7NQB7H0snJ3bfzwJD8oUbb/Vdvd8eWKZlW1d9c5rr4T2zlGPR1DdrGKs6cCiMhxSW
	jnpYOuytdhj6ahY0VA==
X-Received: by 2002:a05:7301:608c:b0:2df:c5bb:3720 with SMTP id 5a478bee46e88-303984edb2dmr5400767eec.15.1778985454902;
        Sat, 16 May 2026 19:37:34 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302978b1a79sm10850097eec.28.2026.05.16.19.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 19:37:34 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: linux-omap@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Lee Jones <lee@kernel.org>
Subject: [PATCH v3] mfd: twl4030-power: update checks for specific boards to use the DT
Date: Sat, 16 May 2026 19:37:21 -0700
Message-ID: <20260517023723.92731-2-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The twl4030-power driver contains two checks for ARM machine IDs via
machine_is_*() macros. The two boards concerned now support only FDT
booting, which does not use machine IDs, and therefore the code should
be updated to check the DT compatible property instead.
The legacy board files for these machines were removed in
commit 1b383f44aabc ("ARM: OMAP2+: Drop board file for 3430sdp") and
commit e92fc4f04a34 ("ARM: OMAP2+: Drop legacy board file for LDP").
The presence of these machine ID checks prevents the removal of machine
IDs no longer used by the kernel from arch/arm/tools/mach-types,
because the machine_is_*() macros are generated from mach-types. To
resolve this issue, use of_machine_is_compatible() instead.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
Changes from v1: Fix mistake in commit message and remove Fixes tags -
machine ID checks still work with DT booting if the bootloader passes
the ID
Changes from v2: Correct changelog formatting (there were two ---
sections in v2)

 drivers/mfd/twl4030-power.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
index 0bca948ab6ba..fc1cf316c236 100644
--- a/drivers/mfd/twl4030-power.c
+++ b/drivers/mfd/twl4030-power.c
@@ -30,8 +30,6 @@
 #include <linux/property.h>
 #include <linux/of.h>
 
-#include <asm/mach-types.h>
-
 static u8 twl4030_start_script_address = 0x2b;
 
 /* Register bits for P1, P2 and P3_SW_EVENTS */
@@ -294,8 +292,8 @@ twl4030_config_wakeup12_sequence(const struct twl4030_power_data *pdata,
 	if (err)
 		goto out;
 
-	if (pdata->ac_charger_quirk || machine_is_omap_3430sdp() ||
-	    machine_is_omap_ldp()) {
+	if (pdata->ac_charger_quirk || of_machine_is_compatible("ti,omap3430-sdp") ||
+	    of_machine_is_compatible("ti,omap3-ldp")) {
 		/* Disabling AC charger effect on sleep-active transitions */
 		err = twl_i2c_read_u8(TWL_MODULE_PM_MASTER, &data,
 				      R_CFG_P1_TRANSITION);
-- 
2.43.0

