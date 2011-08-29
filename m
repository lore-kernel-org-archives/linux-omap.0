From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 3/5] OMAP4: PM: TWL6030: address 0V conversions
Date: Mon, 29 Aug 2011 11:15:19 -0700
Message-ID: <1314641721-5172-4-git-send-email-khilman@ti.com>
References: <1314641721-5172-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:52282 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754416Ab1H2SO7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Aug 2011 14:14:59 -0400
Received: by mail-pz0-f47.google.com with SMTP id 2so11291373pzk.6
        for <linux-omap@vger.kernel.org>; Mon, 29 Aug 2011 11:14:58 -0700 (PDT)
In-Reply-To: <1314641721-5172-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

From: Nishanth Menon <nm@ti.com>

0V conversions should be mapped to 0 as it is meant to denote
off voltages.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/omap_twl.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-omap2/omap_twl.c
index 5def7c2..b30adf3 100644
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
1.7.6

