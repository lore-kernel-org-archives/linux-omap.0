From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: Query: Num GPIO lines
Date: Thu, 23 Apr 2009 06:46:50 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702F4C296B6@dbde02.ent.ti.com>
References: <63374.207.214.87.58.1239059885.squirrel@webmail.xs4all.nl>
 <FCCFB4CDC6E5564B9182F639FC35608702EA9675F9@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46751 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751174AbZDWBRD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Apr 2009 21:17:03 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n3N1GtIl020973
	for <linux-omap@vger.kernel.org>; Wed, 22 Apr 2009 20:17:01 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n3N1GrM3026554
	for <linux-omap@vger.kernel.org>; Thu, 23 Apr 2009 06:46:54 +0530 (IST)
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702EA9675F9@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


Ping. Any inputs on number of gpio's wrongly defined for OMAP34xx?


>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of
>Pandita, Vikram
>Sent: Monday, April 06, 2009 6:40 PM
>To: linux-omap@vger.kernel.org
>Subject: Query: Num GPIO lines
>
>
>Why for OMAP34xx is number of GPIO's 160?
>As per 3430 TRM, there are 6 banks [0 to 191]
>
>Signed-off-by: Tom Rix <Tom.Rix@windriver.com>
>Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
>---
>diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
>index 17d7afe..ee0b21f 100644
>--- a/arch/arm/plat-omap/gpio.c
>+++ b/arch/arm/plat-omap/gpio.c
>@@ -307,7 +307,7 @@ static inline int gpio_valid(int gpio)
> 		return 0;
> 	if (cpu_is_omap24xx() && gpio < 128)
> 		return 0;
>-	if (cpu_is_omap34xx() && gpio < 160)
>+	if (cpu_is_omap34xx() && gpio < 192)
> 		return 0;
> 	return -1;
> }
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

