From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 7/8] ARM: OMAP3: Fix number of GPIO lines for 34xx
Date: Fri, 15 May 2009 08:07:09 -0700
Message-ID: <20090515150708.GC19742@atomide.com>
References: <20090514175116.12080.12871.stgit@localhost> <5A47E75E594F054BAF48C5E4FC4B92AB03056A0CE3@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="z6Eq5LdranGa6ru8"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:61064 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751845AbZEOPHT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 May 2009 11:07:19 -0400
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB03056A0CE3@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tom Rix <Tom.Rix@windriver.com>


--z6Eq5LdranGa6ru8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Gadiyar, Anand <gadiyar@ti.com> [090514 19:29]:
> > 
> > From: Tony Lindgren <Pandita>
> 
> Typo?

Thanks, fixed. Updated patch below.

Tony

--z6Eq5LdranGa6ru8
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="nr-gpio.patch"

commit 22c76ab3882a15542567c34bf2ed548401ff8cbe
Author: Vikram Pandita <vikram.pandita@ti.com>
Date:   Wed May 13 10:33:05 2009 -0700

    ARM: OMAP3: Fix number of GPIO lines for 34xx
    
    As per 3430 TRM, there are 6 banks [0 to 191]
    
    Signed-off-by: Tom Rix <Tom.Rix@windriver.com>
    Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
    Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 17d7afe..ee0b21f 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -307,7 +307,7 @@ static inline int gpio_valid(int gpio)
 		return 0;
 	if (cpu_is_omap24xx() && gpio < 128)
 		return 0;
-	if (cpu_is_omap34xx() && gpio < 160)
+	if (cpu_is_omap34xx() && gpio < 192)
 		return 0;
 	return -1;
 }

--z6Eq5LdranGa6ru8--
