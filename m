Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D759C35BDC7
	for <linux-omap@vger.kernel.org>; Tue,  6 Oct 2026 06:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791266510; cv=none; b=Mr376RJzwqoq9NTRUUrp7hLR9elxYUWijEzdj7ZkIYz+42rxnSW2KPAzla9ZqpkuDA3FnNwbjg7TLP+0NZ7pjOlGZSpNW5JVGaMTPJgB1AAH66ghlb55jNpe5No+yCoHsH8u52yrAAcxw/S4abLGMdPevy4lro61v52lRKuhdVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791266510; c=relaxed/simple;
	bh=qFfPZZhbChgmtuc8g8bCU2zjESAKk50aYwARcV0yTnc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AQthhEKx1dZcMUvQJdSOVH/fDynH9fognumMSh1xQddqNqo83Oi7j6n9eVXUMsAexXGiR77YDro9i353pfzvXunHX5SROY8o23Yb/bOAyO1MB3FWDC2hCn67J9CPfvBfTY6LfeQ1kcfZo0EPGyV7qDgbT24g74+GZDxED4x/Kjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rwnApu3m; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rwnApu3m"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-144f7915346so536686c88.0
        for <linux-omap@vger.kernel.org>; Mon, 05 Oct 2026 23:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791266508; x=1791871308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AW+mqH2re19ne9O4KJFVEoTrC+YDZvk13b6+8e/Lv9w=;
        b=rwnApu3mnIKEfNwLG9O/sPpz9nHLMe/TpcfV70EapjxVwiJLvv86QgHbd3vmKMyunY
         scdGPq8MCrMVH4mi+VGh89unnYNDCqcffiyJyxdbxw0zfPmSbyYh4EpdopPD7b69kRqh
         QPb8ozXPpqF5deP/IiijnxR/Pg1NpqZw4/yFUjidhs+4CPJ/5z7Reawg5evPFcRvNens
         Z8fvXaFPuZO7Qivuyj6B/bw9kBwQG51pSFTi2GgIGz1Yv0x+bkrdisZXPheNoo/FhV/C
         7P4vj4jlahTnHiCTaW1aL9/MtE0YcrKfaokxcqrnf6MbcRY1eCbbNh5rgJ4gjBMsp6TF
         Ls7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791266508; x=1791871308;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AW+mqH2re19ne9O4KJFVEoTrC+YDZvk13b6+8e/Lv9w=;
        b=zTl1zr8Kgvo1tt89E3+dyyk43S/tBFw392au/cUdxMccKEqWXkt16wE+JGSwpTGUcO
         j8dd4pMMgn2xKnt3vCDMmirg7M7FxUuRd6UXIzCLha4NwErOAN8HO2Rr7OMNjOGvcP5l
         K2Af3YMHz1ddtH0HYxQ9TYWyxNqEY3OSjus+xKkp7QDpPKbfXnkAUsVVC8p9xdAdjRkt
         asO+Lpgqs9NNzYXzca2YhGp4hjboizf6oSaufE8f22XsshWg6GFaOA/d0TuM7SrURP61
         fCsVFmZM1gDVTQ7f1IEBuPdK5+frPbX2kw44CRf24mcReDke+8bN/u/ts+EeGw2/JZ0E
         MCRQ==
X-Gm-Message-State: AFuF++lOVsP3VT5XEXwbXmH5ClMdLc7obRQxaJ5DLT2oPWUAkGgxbr0D
	5KsZHB3qcuGev3L1yGBjgKftn6ZrvFIziNpUn3xJ/nvjOX+G9AOJMsQl
X-Gm-Gg: AYBFou0mByrvorpWBdQD99P3rqr2oBxbqPFZZ//PQEqEZ3DA+R9Pb0kTU3M05mWJMD9
	u73d+qICElos/6eKXCrVs0WVcGESiASf3n9PcvodJk7yDCeKlxG2RyAjN5eSOz5z0X5UW5XoGFx
	WVnQeonEvUIQ3R8d8Jk0Vnb94qOTUwMaq+FIu5zujwVW0ioKWr9fn44b73dF1Yzxi7u8HvhZetU
	x5bIstbFVAyOi/sQWYSJWKWynWJp443Qa2ZxMl7D7XDHUbHaZtZzil+P2bUQIIExD1AXe3xiyDm
	SLWW23M4apnG3fS6OJKb3FPhDIGPOSbO2W10av7hnx4Ph9qZd0naBYv/MknwfYElxaZhpSHrXHI
	lM9Ar5YPUtUGqr4odFbygJ7M26mQ/HQxPIy52YwKf9PLbmuMzAkmiq/cSsg2NP/LU++e1W+5m0I
	YFac/oFgoMWlRkfSTJWu1QhGNk2pFnEgPr7userr6tkraNxJZMAbK+6mgxwQgcYlvMoaq/2r00W
	oYjj9lxY2eXfccDtHH+Zk0=
X-Received: by 2002:a05:701b:4287:10b0:15a:4155:3daa with SMTP id a92af1059eb24-15ec93fdd16mr672452c88.15.1791266507680;
        Mon, 05 Oct 2026 23:01:47 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-15d84ec510dsm5486567c88.13.2026.10.05.23.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 23:01:47 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Russell King <linux@armlinux.org.uk>,
	Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] ARM: OMAP2+: fix typos in comments
Date: Tue,  6 Oct 2026 11:31:39 +0530
Message-ID: <20261006060141.43425-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos in comments, reported by scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  One further misspelling of
"peripherals" in powerdomains7xx_data.c is fixed as well: it is not in
scripts/spelling.txt, but it sits on the same comment line as one that
checkpatch does report.  Only comments are touched, there are no code
changes.

Assisted-by: LLM
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---

Notes (v2):
    v2:
     - Split the single "ARM: fix typos in comments" patch up per platform,
       so that each one can be picked up by its own maintainer.
     - Also fix the second misspelling on the same comment line in
       powerdomains7xx_data.c, which checkpatch does not report because it
       is not listed in scripts/spelling.txt.
    
    v1: https://lore.kernel.org/all/20260907064849.23086-1-hemanth.selam@gmail.com/

 arch/arm/mach-omap2/omap4-common.c         | 2 +-
 arch/arm/mach-omap2/omap_hwmod.c           | 6 +++---
 arch/arm/mach-omap2/powerdomains7xx_data.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index 5d924b85b694..633451b6f548 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -96,7 +96,7 @@ static void omap4_mb(void)
  * interconnects.
  *
  * This situation can happen only when the idle is initiated by a Master
- * Request Disconnection (which is trigged by software when executing WFI
+ * Request Disconnection (which is triggered by software when executing WFI
  * on the CPU).
  *
  * The work-around for this errata needs all the initiators connected
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 03cd523dff87..0f4ba19804c6 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -646,7 +646,7 @@ static struct clockdomain *_get_clkdm(struct omap_hwmod *oh)
  * @oh: struct omap_hwmod *
  *
  * Prevent the hardware module @oh from entering idle while the
- * hardare module initiator @init_oh is active.  Useful when a module
+ * hardware module initiator @init_oh is active.  Useful when a module
  * will be accessed by a particular initiator (e.g., if a module will
  * be accessed by the IVA, there should be a sleepdep between the IVA
  * initiator and the module).  Only applies to modules in smart-idle
@@ -674,7 +674,7 @@ static int _add_initiator_dep(struct omap_hwmod *oh, struct omap_hwmod *init_oh)
  * _del_initiator_dep: allow @oh to smart-idle even if @init_oh is active
  * @oh: struct omap_hwmod *
  *
- * Allow the hardware module @oh to enter idle while the hardare
+ * Allow the hardware module @oh to enter idle while the hardware
  * module initiator @init_oh is active.  Useful when a module will not
  * be accessed by a particular initiator (e.g., if a module will not
  * be accessed by the IVA, there should be no sleepdep between the IVA
@@ -1706,7 +1706,7 @@ static int _ocp_softreset(struct omap_hwmod *oh)
 		return -EINVAL;
 	}
 
-	/* For some modules, all optionnal clocks need to be enabled as well */
+	/* For some modules, all optional clocks need to be enabled as well */
 	if (oh->flags & HWMOD_CONTROL_OPT_CLKS_IN_RESET)
 		_enable_optional_clocks(oh);
 
diff --git a/arch/arm/mach-omap2/powerdomains7xx_data.c b/arch/arm/mach-omap2/powerdomains7xx_data.c
index 921cb1b29cb4..18cd74915b4b 100644
--- a/arch/arm/mach-omap2/powerdomains7xx_data.c
+++ b/arch/arm/mach-omap2/powerdomains7xx_data.c
@@ -223,7 +223,7 @@ static struct powerdomain mpu_7xx_pwrdm = {
 	},
 };
 
-/* l3init_7xx_pwrdm: L3 initators pheripherals power domain  */
+/* l3init_7xx_pwrdm: L3 initiators peripherals power domain  */
 static struct powerdomain l3init_7xx_pwrdm = {
 	.name		  = "l3init_pwrdm",
 	.prcm_offs	  = DRA7XX_PRM_L3INIT_INST,
-- 
2.47.3

