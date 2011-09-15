From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [RFC PATCH 5/6] OMAP4: PHY internal: Add msleep_interruptible to charger detection function
Date: Thu, 15 Sep 2011 19:50:02 +0530
Message-ID: <1316096403-6013-6-git-send-email-kishon@ti.com>
References: <1316096403-6013-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38655 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933718Ab1IOOR5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Sep 2011 10:17:57 -0400
In-Reply-To: <1316096403-6013-1-git-send-email-kishon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, balbi@ti.com, heikki.krogerus@linux.intel.com, gregkh@suse.de
Cc: p-basak2@ti.com, kishon@ti.com, balajitk@ti.com, x0153364@ti.com, m-sonasath@ti.com, vishp@ti.com, hemahk@ti.com

From: Sergii Postulga <x0153364@ti.com>

Charger detection is given 500ms to complete until which it loops continuously
taking all the processor time.  If we plug USB-micro cable to board during
playing video or audio we have a glitches. This patch frees time for doing
other things during waiting the charger detecting flag.

Signed-off-by: Sergii Postulga <x0153364@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/mach-omap2/omap_phy_internal.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_phy_internal.c b/arch/arm/mach-omap2/omap_phy_internal.c
index 55918ea..2334de8 100644
--- a/arch/arm/mach-omap2/omap_phy_internal.c
+++ b/arch/arm/mach-omap2/omap_phy_internal.c
@@ -135,6 +135,7 @@ int omap4_charger_detect(void)
 		chargertype = ((usb2phycore >> 21) & 0x7);
 		if (usb2phycore & USB2PHY_CHGDETECTED)
 			break;
+		msleep_interruptible(10);
 	} while (!time_after(jiffies, timeout));
 
 	switch (chargertype) {
-- 
1.7.0.4

