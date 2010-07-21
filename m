From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 08/11] staging: tidspbridge: remove IN modifier
Date: Wed, 21 Jul 2010 10:05:43 -0500
Message-ID: <AANLkTilRVJ5gZ-HGExhPjeO553FSRJ0wiRBOcY0pQHjp@mail.gmail.com>
References: <1278975369-7687-1-git-send-email-nm@ti.com>
	<1278975369-7687-9-git-send-email-nm@ti.com>
	<27F9C60D11D683428E133F85D2BB4A53043F0B2C09@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:50913 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932293Ab0GUPFo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Jul 2010 11:05:44 -0400
In-Reply-To: <27F9C60D11D683428E133F85D2BB4A53043F0B2C09@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Ohad Ben-Cohen <ohad@wizery.com>, Ameya Palande <ameya.palande@nokia.com>, "Guzman Lugo, Fernando" <fernando.lugo@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, lkml <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>

On Wed, Jul 21, 2010 at 9:59 AM, Ramirez Luna, Omar <omar.ramirez@ti.co=
m> wrote:
> Hi,
>
>>From: Menon, Nishanth
>>
>>IN modifier does not exist. remove it
>>
>>Signed-off-by: Nishanth Menon <nm@ti.com>
>>---
> [...]
>>diff --git a/drivers/staging/tidspbridge/include/dspbridge/drv.h
>>b/drivers/staging/tidspbridge/include/dspbridge/drv.h
>>index 020bed0..753a317 100644
>>--- a/drivers/staging/tidspbridge/include/dspbridge/drv.h
>>+++ b/drivers/staging/tidspbridge/include/dspbridge/drv.h
>>@@ -70,8 +70,8 @@
>> #define OMAP_DMMU_BASE 0x5D000000
>> #define OMAP_DMMU_SIZE 0x1000
>>
>>-#define OMAP_PRCM_VDD1_DOMAIN 1
>>-#define OMAP_PRCM_VDD2_DOMAIN 2
>>+#define OMAP_PRCM_VDD1_DOMA1
>>+#define OMAP_PRCM_VDD2_DOMA2
>>
>
> Unexpected change?

wooops... Sorry about that..
>
> Regards,
>
> Omar
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
