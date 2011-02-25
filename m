From: Sricharan R <r.sricharan@ti.com>
Subject: RE: [PATCH 4/5] omap4: board-omap4panda: Initialise the serial pads
Date: Fri, 25 Feb 2011 18:52:08 +0530
Message-ID: <6a9ea1b93fa4e06c10a45c8b3da6259b@mail.gmail.com>
References: <1296191298-17545-1-git-send-email-r.sricharan@ti.com>
 <1296191298-17545-5-git-send-email-r.sricharan@ti.com> <20110223184950.GX15225@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:33437 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755636Ab1BYNWN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Feb 2011 08:22:13 -0500
Received: by mail-vw0-f54.google.com with SMTP id 16so1555650vws.13
        for <linux-omap@vger.kernel.org>; Fri, 25 Feb 2011 05:22:10 -0800 (PST)
In-Reply-To: <20110223184950.GX15225@atomide.com>
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
>Subject: Re: [PATCH 4/5] omap4: board-omap4panda: Initialise the serial
>pads
>
>* sricharan <r.sricharan@ti.com> [110127 21:05]:
>> --- a/arch/arm/mach-omap2/board-omap4panda.c
>> +++ b/arch/arm/mach-omap2/board-omap4panda.c
>> @@ -370,13 +370,83 @@ static int __init omap4_panda_i2c_init(void)
>>  	omap_register_i2c_bus(4, 400, NULL, 0);
>>  	return 0;
>>  }
>> -
>>  #ifdef CONFIG_OMAP_MUX
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
>Here too please check the need for dynamic remuxing and
>update the patch if necessary.
>
Actually there was not a need for remixing here. I added
This for testing purpose.i will remove this and send an updated
Patch.
>Regards,
>
>Tony
