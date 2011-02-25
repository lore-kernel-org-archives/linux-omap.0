From: Sricharan R <r.sricharan@ti.com>
Subject: RE: [PATCH 5/5] omap2+: board-n8x0: Change the flags for the serial pads.
Date: Fri, 25 Feb 2011 18:51:55 +0530
Message-ID: <f88ef87c82bfadec043ed5b21ce887dd@mail.gmail.com>
References: <1296191298-17545-1-git-send-email-r.sricharan@ti.com>
 <1296191298-17545-6-git-send-email-r.sricharan@ti.com> <20110223184956.GY15225@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:43381 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755636Ab1BYNWA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Feb 2011 08:22:00 -0500
Received: by mail-vx0-f175.google.com with SMTP id 7so1598811vxd.34
        for <linux-omap@vger.kernel.org>; Fri, 25 Feb 2011 05:21:59 -0800 (PST)
In-Reply-To: <20110223184956.GY15225@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, paul@pwsan.com

Hi Tony,
>-----Original Message-----
>From: Tony Lindgren [mailto:tony@atomide.com]
>Sent: Thursday, February 24, 2011 12:20 AM
>To: sricharan
>Cc: linux-omap@vger.kernel.org; santosh.shilimkar@ti.com; paul@pwsan.com
>Subject: Re: [PATCH 5/5] omap2+: board-n8x0: Change the flags for the
>serial pads.
>
>* sricharan <r.sricharan@ti.com> [110127 21:05]:
>> The flag for remuxing uart3_rx_irxx pad is changed.
>>
>> Signed-off-by: sricharan <r.sricharan@ti.com>
>> ---
>>  arch/arm/mach-omap2/board-n8x0.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-
>omap2/board-n8x0.c
>> index 9b52e2d..bd51356 100644
>> --- a/arch/arm/mach-omap2/board-n8x0.c
>> +++ b/arch/arm/mach-omap2/board-n8x0.c
>> @@ -751,7 +751,7 @@ static struct omap_board_mux board_mux[] __initdata
=
>{
>>  static struct omap_device_pad serial2_pads[] __initdata = {
>>  	{
>>  		.name	= "uart3_rx_irrx.uart3_rx_irrx",
>> -		.flags	= OMAP_DEVICE_PAD_REMUX | OMAP_DEVICE_PAD_WAKEUP,
>> +		.flags	= OMAP_DEVICE_PAD_REMUX_IDLE |
>OMAP_DEVICE_PAD_WAKEUP,
>>  		.enable	= OMAP_MUX_MODE0,
>>  		.idle	= OMAP_MUX_MODE3	/* Mux as GPIO for idle */
>>  	},
>
>This should not be needed when rebased on my patch to replace patch 1/5.
>
Yes correct. This patch should not be needed now.
>Regards,
>
>Tony
