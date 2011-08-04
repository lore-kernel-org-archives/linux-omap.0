From: Bjarne Steinsbo <bsteinsbo@gmail.com>
Subject: [PATCH 3/4] usb: musb: OMAP4430: Remove incorrect call to omap4430_phy_init()
Date: Thu, 4 Aug 2011 20:02:18 +0200
Message-ID: <CAFULf_xEyAzJjxm6U+eVbdidSa3soVmn8J9NcJ=w8Fhf65yQaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:62169 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751856Ab1HDSCS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Aug 2011 14:02:18 -0400
Received: by mail-vx0-f174.google.com with SMTP id 9so389804vxi.19
        for <linux-omap@vger.kernel.org>; Thu, 04 Aug 2011 11:02:18 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Don't call omap4430_phy_init(dev) before dev is initialized.
The real omap4430_phy_init(dev) call is done at the end of
this function.
---
 arch/arm/mach-omap2/usb-musb.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index a65145b..19e4dac 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -137,9 +137,6 @@ void __init usb_musb_init(struct
omap_musb_board_data *musb_board_data)
 	musb_plat.mode = board_data->mode;
 	musb_plat.extvbus = board_data->extvbus;

-	if (cpu_is_omap44xx())
-		omap4430_phy_init(dev);
-
 	if (cpu_is_omap3517() || cpu_is_omap3505()) {
 		oh_name = "am35x_otg_hs";
 		name = "musb-am35x";
-- 
1.7.1
