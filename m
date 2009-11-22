From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: [PATCH 1/3] [OMAP1] MUX: Add omap7xx-specific USB mux pins
Date: Sun, 22 Nov 2009 13:26:01 -0800
Message-ID: <1258925161.11242.2.camel@runt>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:53478 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755742AbZKVVZ5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 22 Nov 2009 16:25:57 -0500
Received: by pzk1 with SMTP id 1so3539235pzk.33
        for <linux-omap@vger.kernel.org>; Sun, 22 Nov 2009 13:26:03 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

In order to successfully use USB on omap7xx devices, the
pin muxes implemented by this patch are needed.  This
had been done manually in board files used by linwizard --
this patch ports the required changes more properly.

Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>
---
 arch/arm/mach-omap1/mux.c             |    4 +++-
 arch/arm/plat-omap/include/plat/mux.h |    2 ++
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap1/mux.c b/arch/arm/mach-omap1/mux.c
index 785371e..5e183cd 100644
--- a/arch/arm/mach-omap1/mux.c
+++ b/arch/arm/mach-omap1/mux.c
@@ -50,7 +50,9 @@ MUX_CFG_7XX("E3_7XX_KBC4",        13,   25,    0,   24,   1, 0)
 
 MUX_CFG_7XX("AA17_7XX_USB_DM",     2,   21,    0,   20,   0, 0)
 MUX_CFG_7XX("W16_7XX_USB_PU_EN",   2,   25,    0,   24,   0, 0)
-MUX_CFG_7XX("W17_7XX_USB_VBUSI",   2,   29,    0,   28,   0, 0)
+MUX_CFG_7XX("W17_7XX_USB_VBUSI",   2,   29,    6,   28,   1, 0)
+MUX_CFG_7XX("W18_7XX_USB_DMCK_OUT",3,    3,    1,    2,   0, 0)
+MUX_CFG_7XX("W19_7XX_USB_DCRST",   3,    7,    1,    6,   0, 0)
 
 /* MMC Pins */
 MUX_CFG_7XX("MMC_7XX_CMD",         2,    9,    0,    8,   1, 0)
diff --git a/arch/arm/plat-omap/include/plat/mux.h b/arch/arm/plat-omap/include/plat/mux.h
index ba77de6..436c12e 100644
--- a/arch/arm/plat-omap/include/plat/mux.h
+++ b/arch/arm/plat-omap/include/plat/mux.h
@@ -219,6 +219,8 @@ enum omap7xx_index {
 	AA17_7XX_USB_DM,
 	W16_7XX_USB_PU_EN,
 	W17_7XX_USB_VBUSI,
+	W18_7XX_USB_DMCK_OUT,
+	W19_7XX_USB_DCRST,
 
 	/* MMC */
 	MMC_7XX_CMD,
-- 
1.6.3.3


