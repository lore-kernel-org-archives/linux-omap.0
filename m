From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: Padconf not working on pm_defconfig?
Date: Mon, 14 Dec 2009 15:33:51 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404372AAB54@dbde02.ent.ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB030ADD4EFC@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40184 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755453AbZLNKEE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Dec 2009 05:04:04 -0500
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB030ADD4EFC@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Gadiyar, Anand
> Sent: Monday, December 14, 2009 3:24 PM
> To: linux-omap@vger.kernel.org; Kevin Hilman; Tony Lindgren
> Subject: Padconf not working on pm_defconfig?
> 
> I'm seeing some strange behavior with linux-omap-pm branch
> and possibly with linux-omap master as well. I booted up
> a 3430 SDP with an image built using omap3_pm_defconfig.
> (I enabled EHCI in the menuconfig).

Check if CONFIG_OMAP_MUX=y set.

-Ajay
> 
> 
> The MUX framework reports that some padconfs are being changed:
> MUX: setup Y9_3430_USB1HS_PHY_STP (0xfa0025d8): 0x0218 -> 0x0003
> MUX: setup Y8_3430_USB1HS_PHY_CLK (0xfa0025da): 0x0200 -> 0x0003
> MUX: setup AA14_3430_USB1HS_PHY_DIR (0xfa0025ec): 0x1700 -> 0x010b
> MUX: setup AA11_3430_USB1HS_PHY_NXT (0xfa0025ee): 0x1700 -> 0x010b
> MUX: setup AA8_3430_USB2HS_PHY_CLK (0xfa0025f0): 0x1700 -> 0x0003
> MUX: setup AA9_3430_USB2HS_PHY_DIR (0xfa0025f4): 0x1700 -> 0x010b
> MUX: setup T4_3430_USB2HS_PHY_D3 (0xfa0021de): 0x1708 -> 0x010b
> MUX: setup T3_3430_USB2HS_PHY_D4 (0xfa0021d8): 0x1700 -> 0x010b
> 
> (some lines edited - this is just to illustrate that the MUX
> framework thinks the padconfs are changed)
> 
> 
> 
> But, a dump of the registers after bootup shows many pads are being
> set to GPIO mode:
> 
> EHCI Port 1 padconf
> 0x480025D8 = 0x00040004
> 0x480025DC = 0x00040004
> 0x480025E0 = 0x00040004
> 0x480025E4 = 0x00040004
> 0x480025E8 = 0x00040004
> 0x480025EC = 0x00040004
> 
> EHCI Port 2 padconf
> 0x480021D4 = 0x010B010B
> 0x480021D8 = 0x010B010B
> 0x480021DC = 0x010B010B
> 0x480025F0 = 0x00040004
> 0x480025F4 = 0x00040004
> 0x480025F8 = 0x00040004
> 
> 
> I'll take a look in a while, but if someone already knows the reason
> for this, let me know.
> 
> - Anand
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
