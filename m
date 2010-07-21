From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: [PATCH 08/11] staging: tidspbridge: remove IN modifier
Date: Wed, 21 Jul 2010 09:59:22 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53043F0B2C09@dlee03.ent.ti.com>
References: <1278975369-7687-1-git-send-email-nm@ti.com>
 <1278975369-7687-9-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50844 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752123Ab0GUPBy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Jul 2010 11:01:54 -0400
In-Reply-To: <1278975369-7687-9-git-send-email-nm@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>, Greg Kroah-Hartman <gregkh@suse.de>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Ameya Palande <ameya.palande@nokia.com>, "Guzman Lugo, Fernando" <fernando.lugo@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, lkml <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>

Hi,

>From: Menon, Nishanth
>
>IN modifier does not exist. remove it
>
>Signed-off-by: Nishanth Menon <nm@ti.com>
>---
[...]
>diff --git a/drivers/staging/tidspbridge/include/dspbridge/drv.h
>b/drivers/staging/tidspbridge/include/dspbridge/drv.h
>index 020bed0..753a317 100644
>--- a/drivers/staging/tidspbridge/include/dspbridge/drv.h
>+++ b/drivers/staging/tidspbridge/include/dspbridge/drv.h
>@@ -70,8 +70,8 @@
> #define OMAP_DMMU_BASE 0x5D000000
> #define OMAP_DMMU_SIZE 0x1000
>
>-#define OMAP_PRCM_VDD1_DOMAIN 1
>-#define OMAP_PRCM_VDD2_DOMAIN 2
>+#define OMAP_PRCM_VDD1_DOMA1
>+#define OMAP_PRCM_VDD2_DOMA2
>

Unexpected change?

Regards,

Omar
