From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH] musb: fix power field to hold all possible values
Date: Tue, 23 Feb 2010 15:16:44 +0530
Message-ID: <1266918404-17715-1-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41645 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750909Ab0BWJrG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Feb 2010 04:47:06 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o1N9l3LY013871
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 23 Feb 2010 03:47:05 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Ajay Kumar Gupta <ajay.gupta@ti.com>

MUSB can supply upto 500mA such as, AM3517 and OMAP3EVM Rev >=E and thus
the 'power' field has to hold values above 255.


Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
 arch/arm/plat-omap/include/plat/usb.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/usb.h b/arch/arm/plat-omap/include/plat/usb.h
index 288e29e..b181297 100644
--- a/arch/arm/plat-omap/include/plat/usb.h
+++ b/arch/arm/plat-omap/include/plat/usb.h
@@ -46,7 +46,7 @@ struct ehci_hcd_omap_platform_data {
 struct omap_musb_board_data {
 	u8	interface_type;
 	u8	mode;
-	u8	power;
+	u16	power;
 };
 
 enum musb_interface    {MUSB_INTERFACE_ULPI, MUSB_INTERFACE_UTMI};
-- 
1.6.2.4

