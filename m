Received: from mail-dl1-f67.google.com (mail-dl1-f67.google.com [74.125.82.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE8E2BE7BA
	for <linux-omap@vger.kernel.org>; Sun, 10 May 2026 05:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778391635; cv=none; b=RPOeO2dE4W/URDOIe+ETqt3wG03wreWzYXrJUP+mW8yYx5Hl8DscSza/QcjJNPxNXcMCdLilZ3y+aL8Lds7+nacUJ35hj6B4Rny7AXkTqDVDP89qSBfiRBnzGrfFEjuBKpxuZVWGKHZUVl6Yx+vA8Habh+LizPZhP2lo4bd/qJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778391635; c=relaxed/simple;
	bh=iP0HS/HLlu4FSR08s+1ugp91NqbcYpUtUQJzpGS71ho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BAx9BKw2Rh2Erj2jn0onpO968d6HQJieufomvsap4lWr8mv4yKWM82i+QUdkXfkVF69TX5LYnD+bK4tJYSfDyftx2uWHvgUGyRRBA0RA7LLKj0QpoFEYW/oawO+Z5V550FjuGoGW749DWpaxb+JhXrrKwGyoGS9bSQpBy/L3i5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=flWkVIVL; arc=none smtp.client-ip=74.125.82.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="flWkVIVL"
Received: by mail-dl1-f67.google.com with SMTP id a92af1059eb24-1329507c387so4124475c88.1
        for <linux-omap@vger.kernel.org>; Sat, 09 May 2026 22:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778391633; x=1778996433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hVZCxepUXI6VbaWLkk5Nz4duOdKuuxdBEgD5x+djGnI=;
        b=flWkVIVLMqK8COMKGF/7b1Rnw4Hhd97IrG/oOV7rhQ/3aKht/+x0xR0YlHMTTshsOx
         /iBUc+xBZoZuf3QvJ+zJGCegMFIUVSXFpYQVzj0pPgdUhc6a5Mh1cjYukvIaPfoXe+eP
         YM5cEMxlTVvW3uAVjTuuTeQqMlnZ6EbSeh5LrSGhZ1vLyoESkT/6FULVQF4ms8wfREu/
         j8uGN6f2Vkys4Z/cFTFz3ZmmhfGddzYsh2yYlRMjQybGzpzQq8gCzt8OfW5MEdijj1MN
         ZxmElqp7PhlCDCvRJx9COqU7cCrIrEJsaarl0VHvR2lsO83ShUFNNFNcaQQ9xhEW06Qj
         6AxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778391633; x=1778996433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hVZCxepUXI6VbaWLkk5Nz4duOdKuuxdBEgD5x+djGnI=;
        b=pSxkfYz0E6u2OR6Uxxsy16n/YqXU0dI4zx9aAmbkdbhNJMCF0MaDGPWjRFPE+nAexA
         KP+m5LGM/VwzgeWM3asjs3fIwKS1XYasHWvf2QTOy3fCHHEqHEcA2TSRLSSNQXRrbO55
         bf7YsAAZDJDGImTZQHGA/KSy4HSdPZHLRMlUsTmtqdBvreG/bD3Gi0Xw1XZAf/eTyuES
         nc4oOBQD+Aixnb3mIuDrqrxus0w2iOargIss8GgpjGzViXBqp3vMJdBw/Hx5+77hRhaD
         PgQujDG1a2aonhglek//310D5EBZcrm0ekXoHCzYvbLuBOElCfETQop9VflPnVHFpH6j
         sOQA==
X-Gm-Message-State: AOJu0YxBbGqn7YGiPuOmQLIqirN4rWxB8a0RsEeSJjea0Kk0Vu4k7asQ
	ZkWwv89FOCG9GozHIifiShXkLRy1RMO/gy+UoxzZc1wDqoY+bcyVPSYk+Z1XtpGUZvI=
X-Gm-Gg: Acq92OF0pfPSYHbuEcz18pAoQ8Hw3tOg5drJ2GDSDOf4Jw77DeD9QbJORWnpRfNZJQZ
	AnBh2RI4fmxq5jkGC17S2FKizHahbtZvcwZ9Yc+L1lYUFCzLB9wrOACDDXMBi1NGOyxxfeepxD7
	g3R4KLqD4qV8Supe/5y706Ow9DC3Vzw8FRCtnmtWGm13V0zLn+pI5c+6a9rZoHAuuP1Wj/Shx4B
	kJ0YGZewt6Qe97gPXhQi0xWugYQTlKSwJ5Hath2TeWueXnQ5+7WDV5kH96weJb3UvrFcPpDhXzs
	2Y/e3275ooKX5xUSqtyUpnW/BPHqIsuyHjKDsbmN9nLsX2gO68xoqk5cR9jdBVDTIassote6ws0
	3FAmYOQ5ubntNEV5YBgXo/zfwc1b8Jpm4Tmt4Lvkft/EKJPsT5+cocX8F8wvNkoENaAiJpA2hD4
	aZrKii1/5LkeKHEmMuSlX4AMhVYjVeIIwSX0Th+SLBvC4JamtXjC7c03dcy2BL3TRqOBReToC8W
	PokkGUV+gsk8zGYGO6NjhW7foCniHitk24VO+MYkzPYHzMX+mAqxDnvWwUJezApciAEX5mlDIFN
	i7vzPgmrUU0l5GfkzvgCZkQEY94P
X-Received: by 2002:a05:7022:3d0e:b0:130:5ec9:7ad4 with SMTP id a92af1059eb24-1319cd36afdmr10450781c88.29.1778391632937;
        Sat, 09 May 2026 22:40:32 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1327810ffb9sm12680781c88.2.2026.05.09.22.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 22:40:32 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: linux-omap@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Lee Jones <lee@kernel.org>
Subject: [PATCH v2] mfd: twl4030-power: update checks for specific boards to use the DT
Date: Sat,  9 May 2026 22:39:36 -0700
Message-ID: <20260510053939.564314-2-enelsonmoore@gmail.com>
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
---
Changes from v1: Fix mistake in commit message and remove Fixes tags -
machine ID checks still work with DT booting if the bootloader passes
the ID

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

