From: Bjarne Steinsbo <bsteinsbo@gmail.com>
Subject: [PATCHv2 3/4] usb: musb: OMAP4430: Remove incorrect call to omap4430_phy_init()
Date: Fri, 12 Aug 2011 17:28:07 +0200
Message-ID: <CAFULf_xk4xWLq4zhGokpTqoh95eUe3sg1vvVg_KCbJ3VXDkkRg@mail.gmail.com>
References: <CAFULf_xEyAzJjxm6U+eVbdidSa3soVmn8J9NcJ=w8Fhf65yQaw@mail.gmail.com>
	<20110812094824.GQ19467@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:35866 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752534Ab1HLP2H (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Aug 2011 11:28:07 -0400
Received: by mail-vx0-f174.google.com with SMTP id 9so2453955vxi.19
        for <linux-omap@vger.kernel.org>; Fri, 12 Aug 2011 08:28:07 -0700 (PDT)
In-Reply-To: <20110812094824.GQ19467@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com, linux-omap@vger.kernel.org

Don't call omap4430_phy_init(dev) before dev is initialized.
The real omap4430_phy_init(dev) call is done at the end of
this function.

Signed-off-by: Bjarne Steinsbo <bsteinsbo@gmail.com>
---
V2: Oops.. Add missing sob.

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
