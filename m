From: Sricharan R <r.sricharan@ti.com>
Subject: RE: [PATCH 2/5] omap4: board-4430sdp: Initialise the serial pads
Date: Fri, 25 Feb 2011 18:51:51 +0530
Message-ID: <8a4561d18c18f6bbfa9668733c70c9f8@mail.gmail.com>
References: <1296191298-17545-1-git-send-email-r.sricharan@ti.com>
 <1296191298-17545-3-git-send-email-r.sricharan@ti.com> <20110223184940.GW15225@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:45576 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755636Ab1BYNV5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Feb 2011 08:21:57 -0500
Received: by mail-vw0-f43.google.com with SMTP id 18so1747959vws.16
        for <linux-omap@vger.kernel.org>; Fri, 25 Feb 2011 05:21:56 -0800 (PST)
In-Reply-To: <20110223184940.GW15225@atomide.com>
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
>Subject: Re: [PATCH 2/5] omap4: board-4430sdp: Initialise the serial pads
>
>* sricharan <r.sricharan@ti.com> [110127 21:04]:
>> Use the mux framework to initialise the serial pads.
>>
>> Signed-off-by: sricharan <r.sricharan@ti.com>
>> ---
>>  arch/arm/mach-omap2/board-4430sdp.c |   73
>++++++++++++++++++++++++++++++++++-
>>  1 files changed, 72 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-
>omap2/board-4430sdp.c
>> index 1cb208b..d77f099 100644
>> --- a/arch/arm/mach-omap2/board-4430sdp.c
>> +++ b/arch/arm/mach-omap2/board-4430sdp.c
>> @@ -537,8 +537,79 @@ static void __init omap_sfh7741prox_init(void)
>>  static struct omap_board_mux board_mux[] __initdata = {
>>  	{ .reg_offset = OMAP_MUX_TERMINATOR },
>>  };
>> +
>> +static struct omap_device_pad serial2_pads[] __initdata = {
>> +	{ .name   = "uart2_cts.uart2_cts",
>> +	  .enable = OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0,
>> +	  .flags  = OMAP_DEVICE_PAD_REMUX_IDLE,
>> +	  .idle   = OMAP_MUX_MODE7,
>> +	},
>
>Is there need to dynamically remux uart2_cts? If so, please
>describe the reason in the patch description and comments.
>
>Note that if there's need for dynamic remuxing, this should
>be updated for just OMAP_DEVICE_PAD_REMUX to work with the
>patch I posted to replace patch 1/5.
>
Actually there was not a need for remixing here. I added
This for testing purpose.i will remove this and send a updated
Patch.
>Regards,
>
>Tony
