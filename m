From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: [PATCH] DSPBRIDGE: fix incorrect reset in bridge_brd_start
 function
Date: Fri, 11 Jun 2010 00:22:54 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53043E7CD941@dlee03.ent.ti.com>
References: <496565EC904933469F292DDA3F1663E602CB7A83DB@dlee06.ent.ti.com>
 <4BF54A33.7040909@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43180 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754446Ab0FKFXF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Jun 2010 01:23:05 -0400
In-Reply-To: <4BF54A33.7040909@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Chitriki Rudramuni, Deepak" <deepak.chitriki@ti.com>, "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>

>From: Chitriki Rudramuni, Deepak
>Sent: Thursday, May 20, 2010 9:42 AM
>To: Guzman Lugo, Fernando
>Cc: linux-omap@vger.kernel.org; Hiroshi DOYU; Ameya Palande; Ramirez Luna, Omar; Felipe Contreras
>Subject: Re: [PATCH] DSPBRIDGE: fix incorrect reset in bridge_brd_start function
>
>Guzman Lugo, Fernando wrote:
>> From 595a54c6a886d8e707e04cbf5d0d9b6d6de7c6ec Mon Sep 17 00:00:00 2001
>> From: Fernando Guzman Lugo <x0095840@ti.com>
>> Date: Tue, 18 May 2010 20:14:20 -0500
>> Subject: [PATCH] DSPBRIDGE: fix incorrect reset in bridge_brd_start function
>>
>> IVA mmu reset was not being done properly, so dsp bootaddress
>> was not copied to SYSC register. Given as a result DSP was not
>> booting from that address after reloading baseimage.
>>
>> Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
>> ---
>>  drivers/dsp/bridge/core/tiomap3430.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/dsp/bridge/core/tiomap3430.c b/drivers/dsp/bridge/core/tiomap3430.c
>> index c7b0d83..805e6f3 100644
>> --- a/drivers/dsp/bridge/core/tiomap3430.c
>> +++ b/drivers/dsp/bridge/core/tiomap3430.c
>> @@ -443,7 +443,7 @@ static dsp_status bridge_brd_start(struct bridge_dev_context *hDevContext,
>>  		/* Reset and Unreset the RST2, so that BOOTADDR is copied to
>>  		 * IVA2 SYSC register */
>>  		(*pdata->dsp_prm_rmw_bits)(OMAP3430_RST2_IVA2,
>> -			OMAP3430_RST1_IVA2, OMAP3430_IVA2_MOD, RM_RSTCTRL);
>> +			OMAP3430_RST2_IVA2, OMAP3430_IVA2_MOD, RM_RSTCTRL);
>>  		udelay(100);
>>  		(*pdata->dsp_prm_rmw_bits)(OMAP3430_RST2_IVA2, 0,
>>  					OMAP3430_IVA2_MOD, RM_RSTCTRL);
>>
>Tested by: Deepak chitriki<deepak.chitriki@ti.com>

Pushed to dspbridge.

- Omar
