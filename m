Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937903D3327
	for <linux-omap@vger.kernel.org>; Fri, 18 Sep 2026 02:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789700011; cv=none; b=FxsUF/WMGcCH7Evak5HFDFWpz7dIuDT2zDF9P81wnGI0fWhY1aVDd7JIJJRbhMlPAqYu3CITgFtp5QRt0qS1VbxeaYw2Ri3028dEk0Xjs02Oylei84Oq4/iiA/eAjW2GUt5qAgwLQhqjQpIESpxIb/wQYCCS5vUxTZE6/Gn7z9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789700011; c=relaxed/simple;
	bh=zzHsRzTnISK2K8w8vUHCUmPheGZ3MPqjwYYhzJWAONo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gJuT3wu5U9L41jZTpMxG2VYIagNrq9Y8I5MgsHXdiKUB0KQQ3wP6UlZxR1Wrm70TRZfaTtnHx13Iory4iTpRtHRBscc51HlETAEKZ3LZrn/HUgzuAxx9e8j/LJTxpjhdgjDLWKFvbpfF1kzJSziurSG9L5KNtLEQ+Rxj7DCnZLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cim0i/Sr; arc=none smtp.client-ip=74.125.227.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cim0i/Sr"
Received: by mail-pj2-f4.google.com with SMTP id 98e67ed59e1d1-3896ccc93b5so72179a91.1
        for <linux-omap@vger.kernel.org>; Thu, 17 Sep 2026 19:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789699999; x=1790304799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Rk+KoXta3dbAs20TzM2qXCVHC2ImAPUr9Ofh7+moDVo=;
        b=Cim0i/SrEKRhI5mcnq7TG91T8N2EnyxST6Y7mUBvlBsYw/oJe8tBcavNvXK+HrUohy
         qtL3VIyhKsX7dSX/uGwODwWzNuvlYXL0bLBzbKtFr8ROuMPl/kfq8aAdAgDxNC4ANWTC
         cmjBS03UTr8P1xgVOcLW2qqPFvcqlulkclhH9kr4g7ZxVjLj6cDlWYirK6Lbyqe8+SVA
         8QdBhShOSFv0XO8dCvm3g+qjm7IYIW0PHUtEuevcj8/LFKJD0vnTnQDPVlIOmFyYZG97
         r+qY3PKcuiOAbPj+Uf/UJPhxzlwbgcpRLJ5q5zEE9LU0aGLL2ksomwnXSgKcwhut5MiO
         n99w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789699999; x=1790304799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rk+KoXta3dbAs20TzM2qXCVHC2ImAPUr9Ofh7+moDVo=;
        b=lY3dCP11bZYfyTGluZfBFyxfioMaPxaz0jkbMqgBkGUi2LgzcTXR3Wv7xLxdF6xlZP
         mgbSQkqsjKHlEm+OEsqPhAhwtbNuHrBKBnw2iSIVaxFG+ALYl4uX4fZN4bpLh1DZ5OnY
         R5WpXPsyC6j2X2hVEzDMmT19QO5ohr4am2yXKQFsIeGDA+7B7XCLFt2TLgwFeSYxGFQ5
         52A8xUsDh6+puwTXFttkdnBGe0PCxwzlWxWP3jr7Ge+dRfMtCzAxilaiXQTysxCRg5CY
         0sBkynVTmBiYxas3m7RNTUT/LzEhMuCPr1CZcRDgUozLpcyf6ZfuwfksVL75cwhQFj+l
         3afg==
X-Gm-Message-State: AFuF++mjKZcW210yTd9nPtRNq0KE9Gc2iETzfBbUWI7zoX00RQTNOzhx
	Jms2w2RQmpC2Jerl1mXKH2CWfWdy7Yr3jRnF6fW1fLoH548oGP2wBhyArRnNNv8ov84=
X-Gm-Gg: AYBFou1FtdB2C1DX+Yd3RfvAYqdAbnX8VbjJAxQjHQcPgPDYusjtSlclwZx8iDld5Ut
	elCui66CkGQdZbs/F+vnkGikC/Q6xQ99Hx7PWcxo91NiNePMMhdNKmcfVaIhbEX8Vvduxx1GjWr
	jTbm0+57smVTaDl19BXlWZ0Bb7BY60SZl7Uc1UoVteJrbQBokO1jiHFzbDKIV74NsMWZazzNulj
	/EyS0nXRprTXpNnsvHxjed5Z7CE2m8q+5c62irYMutHAJxcYeO7MkUhxNJvdReX9+es39qKbwlh
	IfFCWRErliIUPBSbOw/0mEMJL2upI2gTfCokOFDahyI9FPSNw/ak+OXHSs5LgHOxEbHFvysEQkC
	t0X6ZaW8aR1VC9pIcrHeG/Ab0HDqtp2v3DdeyuwUwOtthrgHo2ABOFYJVrffjG9hj/s1GRbz0N0
	N+0XJTYWgGzm2pWkQPNzKdAJ0+P1a399Mhj2bzTFm07jqRpNulBA8j9be8EwqcXOKkyacAhND/P
	u8DvqwoatqzV/y1LCO7F6TfBZu223DVoKLC+qmjOE/4WbPPbtCN5ydeY7585yrAMoLWnairKeIU
	yzzzE+zOOI8asFvfTUrMUJf335W0kmxlDU/OWMnifSe9Ng2BPbO72QZ4MFlb6sS9Lg==
X-Received: by 2002:a17:90b:270d:b0:39d:b1bd:b384 with SMTP id 98e67ed59e1d1-39e54d0edbcmr2520801a91.17.1789699999069;
        Thu, 17 Sep 2026 19:53:19 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144ce02b063sm726939c88.9.2026.09.17.19.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 19:53:18 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH] ARM: OMAP2+: remove unused ctrl_module_wkup_44xx.h header
Date: Thu, 17 Sep 2026 19:53:13 -0700
Message-ID: <20260918025316.375757-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The last use of ctrl_module_wkup_44xx.h was removed in
commit 6bf588595913 ("ARM: OMAP4: Ctrl module register define diet"),
but it was left behind. Remove it.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 arch/arm/mach-omap2/ctrl_module_wkup_44xx.h | 89 ---------------------
 1 file changed, 89 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/ctrl_module_wkup_44xx.h

diff --git a/arch/arm/mach-omap2/ctrl_module_wkup_44xx.h b/arch/arm/mach-omap2/ctrl_module_wkup_44xx.h
deleted file mode 100644
index 414f14d1e0a0..000000000000
--- a/arch/arm/mach-omap2/ctrl_module_wkup_44xx.h
+++ /dev/null
@@ -1,89 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * OMAP44xx CTRL_MODULE_WKUP registers and bitfields
- *
- * Copyright (C) 2009-2010 Texas Instruments, Inc.
- *
- * Benoit Cousson (b-cousson@ti.com)
- * Santosh Shilimkar (santosh.shilimkar@ti.com)
- *
- * This file is automatically generated from the OMAP hardware databases.
- * We respectfully ask that any modifications to this file be coordinated
- * with the public linux-omap@vger.kernel.org mailing list and the
- * authors above to ensure that the autogeneration scripts are kept
- * up-to-date with the file contents.
- */
-
-#ifndef __ARCH_ARM_MACH_OMAP2_CTRL_MODULE_WKUP_44XX_H
-#define __ARCH_ARM_MACH_OMAP2_CTRL_MODULE_WKUP_44XX_H
-
-
-/* Base address */
-#define OMAP4_CTRL_MODULE_WKUP				0x4a30c000
-
-/* Registers offset */
-#define OMAP4_CTRL_MODULE_WKUP_IP_REVISION		0x0000
-#define OMAP4_CTRL_MODULE_WKUP_IP_HWINFO		0x0004
-#define OMAP4_CTRL_MODULE_WKUP_IP_SYSCONFIG		0x0010
-#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_0	0x0460
-#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_1	0x0464
-#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_2	0x0468
-#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_3	0x046c
-#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_4	0x0470
-#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_5	0x0474
-#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_6	0x0478
-#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_7	0x047c
-#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_8	0x0480
-#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_9	0x0484
-#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_10	0x0488
-#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_11	0x048c
-#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_12	0x0490
-#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_13	0x0494
-#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_14	0x0498
-#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_15	0x049c
-#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_16	0x04a0
-#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_17	0x04a4
-#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_18	0x04a8
-#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_19	0x04ac
-#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_20	0x04b0
-#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_21	0x04b4
-#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_22	0x04b8
-#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_23	0x04bc
-#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_24	0x04c0
-#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_25	0x04c4
-#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_26	0x04c8
-#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_27	0x04cc
-#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_28	0x04d0
-#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_29	0x04d4
-#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_30	0x04d8
-#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_31	0x04dc
-
-/* Registers shifts and masks */
-
-/* IP_REVISION */
-#define OMAP4_IP_REV_SCHEME_SHIFT		30
-#define OMAP4_IP_REV_SCHEME_MASK		(0x3 << 30)
-#define OMAP4_IP_REV_FUNC_SHIFT			16
-#define OMAP4_IP_REV_FUNC_MASK			(0xfff << 16)
-#define OMAP4_IP_REV_RTL_SHIFT			11
-#define OMAP4_IP_REV_RTL_MASK			(0x1f << 11)
-#define OMAP4_IP_REV_MAJOR_SHIFT		8
-#define OMAP4_IP_REV_MAJOR_MASK			(0x7 << 8)
-#define OMAP4_IP_REV_CUSTOM_SHIFT		6
-#define OMAP4_IP_REV_CUSTOM_MASK		(0x3 << 6)
-#define OMAP4_IP_REV_MINOR_SHIFT		0
-#define OMAP4_IP_REV_MINOR_MASK			(0x3f << 0)
-
-/* IP_HWINFO */
-#define OMAP4_IP_HWINFO_SHIFT			0
-#define OMAP4_IP_HWINFO_MASK			(0xffffffff << 0)
-
-/* IP_SYSCONFIG */
-#define OMAP4_IP_SYSCONFIG_IDLEMODE_SHIFT	2
-#define OMAP4_IP_SYSCONFIG_IDLEMODE_MASK	(0x3 << 2)
-
-/* CONF_DEBUG_SEL_TST_0 */
-#define OMAP4_WKUP_MODE_SHIFT			0
-#define OMAP4_WKUP_MODE_MASK				(1 << 0)
-
-#endif
-- 
2.43.0

