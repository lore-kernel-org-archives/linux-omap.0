From: Nishanth Menon <nm@ti.com>
Subject: [PM-WIP/voltdm_c][PATCH 09/11] OMAP4: PM: TWL6030: address 0V conversions
Date: Wed, 18 May 2011 00:17:32 -0500
Message-ID: <1305695854-9638-10-git-send-email-nm@ti.com>
References: <1305695854-9638-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33809 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754755Ab1ERFRk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 May 2011 01:17:40 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p4I5HdQO013904
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 00:17:39 -0500
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id p4I5Hd1l002954
	for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 00:17:39 -0500 (CDT)
In-Reply-To: <1305695854-9638-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: kevin <khilman@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Nishanth Menon <nm@ti.com>

0V conversions should be mapped to 0 as it is meant to denote
off voltages.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/omap_twl.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-omap2/omap_twl.c
index fce7e6d..8b1e93c 100644
--- a/arch/arm/mach-omap2/omap_twl.c
+++ b/arch/arm/mach-omap2/omap_twl.c
@@ -95,6 +95,8 @@ static unsigned long twl6030_vsel_to_uv(const u8 vsel)
 		is_offset_valid = true;
 	}
 
+	if (!vsel)
+		return 0;
 	/*
 	 * There is no specific formula for voltage to vsel
 	 * conversion above 1.3V. There are special hardcoded
@@ -127,6 +129,8 @@ static u8 twl6030_uv_to_vsel(unsigned long uv)
 		is_offset_valid = true;
 	}
 
+	if (!uv)
+		return 0x00;
 	/*
 	 * There is no specific formula for voltage to vsel
 	 * conversion above 1.3V. There are special hardcoded
-- 
1.7.0.4

