From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: Query: Num GPIO lines
Date: Tue, 7 Apr 2009 05:09:43 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702EA9675F9@dbde02.ent.ti.com>
References: <63374.207.214.87.58.1239059885.squirrel@webmail.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35523 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751314AbZDFXjz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Apr 2009 19:39:55 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n36Ndlo5011524
	for <linux-omap@vger.kernel.org>; Mon, 6 Apr 2009 18:39:53 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n36NdjUU001871
	for <linux-omap@vger.kernel.org>; Tue, 7 Apr 2009 05:09:46 +0530 (IST)
In-Reply-To: <63374.207.214.87.58.1239059885.squirrel@webmail.xs4all.nl>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


Why for OMAP34xx is number of GPIO's 160? 
As per 3430 TRM, there are 6 banks [0 to 191]

Signed-off-by: Tom Rix <Tom.Rix@windriver.com>
Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
---
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
