Received: from mail-dy1-f193.google.com (mail-dy1-f193.google.com [74.125.82.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79CB274B43
	for <linux-omap@vger.kernel.org>; Sat,  9 May 2026 01:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778291025; cv=none; b=DSt3TmukztGZHYZ80XuomxuPK8b0t/CvPDsp3qE0nBwVX3UT4oE1CQxTYSYT0yrP0tyXYEpQD2seTFzexythyI0MxLn9o4R4GMHwoyQRhIrGIB/ANSFb5lTo/TOiOBkc9A4jOqBkW3OBwMMiH2WrEcgqGIbH49FomovAj07ECug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778291025; c=relaxed/simple;
	bh=gZcvL712PtEp/DN5bfBX90/0l6jiDpx5pdukpqsGraw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XQtq0Ilz3Qqz8GO25OZQFMvVa+2fIswnVzm1LMqz1onDcimkZb4rNk26IVkhy8NseaBTK7sheFuUD0hEDRY0F0UVh0rAB9eo1ttxPDDLbYhWP8tn0nmffBQnB4SkGiwgDNzXvC6jfCNtnrFiUfGPepnMBqAMBWJ+0MuVDkV8az8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ECVcODfp; arc=none smtp.client-ip=74.125.82.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECVcODfp"
Received: by mail-dy1-f193.google.com with SMTP id 5a478bee46e88-2f3c623322bso4228145eec.0
        for <linux-omap@vger.kernel.org>; Fri, 08 May 2026 18:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778291023; x=1778895823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zJhfFQR9+98S4XKgeWbqpNJRqJ3OzaJN3o2IixMMcYk=;
        b=ECVcODfpxEKhvYBej3QkODP+1HEuYZd8uWDtMX0SOolvoTKGLlBXBVVzPC2Fp+kuah
         u2G6sAMbKCKRP25KJqsJsCmdF7yDVGpmXXt94Mkmlx7aTwoDVldP5vOcNTAiuuZ/Zs6p
         ySlLsd4GAdBUwj5TVhYm0FbZT+8Xbhe23mdG4cMEMQr5X/nHUX3MWI9r9G3W/h8bRV67
         dOJ/zYnHA9nzOetwKf+57tU6+3fNONmrBUruxC3SZhufabUC58XIk9E/WkuLIAKJk1CA
         j0n8jUK2nHRnanDK/ge2qh39j1nvERtRjJEU/TWSSU8kMdUZ/EUFgGyQ+P2iCGQqcRrt
         bQiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778291023; x=1778895823;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zJhfFQR9+98S4XKgeWbqpNJRqJ3OzaJN3o2IixMMcYk=;
        b=etSmmUo4Nf+o/tdsHeu2Ru2A8EI8umyNvb4IgsqFFY8+6DxoMz6pHNGoK/6HwS5Bll
         +rkFaLaVuda6sowMgv7IN9wmMinGZanmm31+jPJ10E8GijadALdpzFKwTI4BG5hn4q4W
         mqeQMi7YAVCnMv8Jjjby1SavbzBqKLpBQU9/DQVBg0bkvW0PR2pmF4YgQX2hQFSsz8ET
         oooKXdpZnAq9NEfCSX+Wr2BHKnRqmwrbjYxwrygo/rRcHWPRoHdhKr4o+WoHddBXXahG
         z9ymnzsfncj3242ZywukEPYuNy+T87CC3ReyTS6x2mIJOL4aw04P7EzfwMpnEqYhrSXQ
         J2rw==
X-Forwarded-Encrypted: i=1; AFNElJ+vU8fJFNtz6uwpnCxKAYzcudh5PHZr3mFmEPqJDU9HyK/dgW8BiPu1feZHeExBJF5noiOtE7YRqpb+@vger.kernel.org
X-Gm-Message-State: AOJu0YycBQFOEEkaIDGzsuTZdCO32De8p1ZeLnzeFJya7iuA2jJz2ZDw
	1KWE2DEPB3BW+923E/ObSL6ECX6Sw2hySAH1vHRDojM4P4pBGE3kA/Cc
X-Gm-Gg: Acq92OHsOVyRhHZIQM3DRX1D7CVx/vS1bt4O1dJ9llNtZT7ceRIaHFuG/NhwEYIUOF5
	nFkCkuGgbcrUG6D078V9DFBlifFFff80nESvBh/W04ah1ht74w/hRs/BTekn7juBYfZObRPshqs
	3uh7yIaAbmOfJjznN9Vahu2f70lyVNHHbzdtOrXt1JYWjQZCXH1l4hrI42L4fKCxNPJfjHx5GuO
	yrAeqdQHGFJQDLFUXC1u0KjkKeUTmcn8kgHgldWZ8KFHtaqP1Tahp/h7cRbl6i0E05e/4Ildgk1
	/7wRwfRTbNKAgO2BDFrxT3VNC2WasA07B8MajmKoqKBTj4TP/pPdCZ+9/CHY7UgaB3jpZnZHhgi
	g479tjS0po/v0EDjFDJY8rlr4kC3HluyRtDXRSo2MypljQR2M085xHmgCxlMkMw9bDOE+ytr8Au
	7S8NveJGS20ah9Uvrl1mGWhRepGZyzMxYeuwcvoJLZwG0jmclnY0GdSac4Xd8RUnSlNgLHlSene
	iT6c7F7gctFm/d2XqdF1qC2EYLKekngATcHNanZlH44Kjb4g8IMiDCrVVG08NZ7x68wBYAhdBsE
	j5T4FDZLvsDn3wmdaA==
X-Received: by 2002:a05:7300:6da5:b0:2ed:e12:376e with SMTP id 5a478bee46e88-2f54d67a686mr7456372eec.30.1778291022819;
        Fri, 08 May 2026 18:43:42 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8893441absm5991640eec.31.2026.05.08.18.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 18:43:42 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-omap@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	stable@vger.kernel.org,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Lee Jones <lee@kernel.org>,
	Jon Hunter <jon-hunter@ti.com>,
	Benoit Cousson <benoit.cousson@linaro.org>
Subject: [PATCH] mfd: twl4030-power: fix stale ARM machine ID checks to use the DT
Date: Fri,  8 May 2026 18:42:46 -0700
Message-ID: <20260509014246.21649-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The twl4030-power driver contains two checks for ARM machine IDs via
machine_is_*() macros. These checks are incorrect because the two
platforms concerned now support only FDT booting, which does not use
machine IDs, and therefore they will always fail. The legacy board
files for these machines were removed in commit 1b383f44aabc ("ARM:
OMAP2+: Drop board file for 3430sdp") and commit e92fc4f04a34 ("ARM:
OMAP2+: Drop legacy board file for LDP"). To resolve this issue, use
of_machine_is_compatible() instead.

Fixes: 678fac419382 ("ARM: dts: OMAP3: Add support for OMAP3430 SDP board")
Fixes: bd5fc6fa657c ("ARM: dts: Add basic support for omap3 LDP zoom1 labrador")
Cc: stable@vger.kernel.org
Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
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

