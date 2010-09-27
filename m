From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [RFC 4/5] OMAP4: mux: Select CBL package for SDP4430 with ES1
Date: Mon, 27 Sep 2010 09:24:52 +0200
Message-ID: <4CA046C4.6080304@ti.com>
References: <1285319748-28976-1-git-send-email-b-cousson@ti.com> <1285319748-28976-5-git-send-email-b-cousson@ti.com> <4245be19dc809c4c1d16a4c29eed1142@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33004 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755180Ab0I0HY7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Sep 2010 03:24:59 -0400
In-Reply-To: <4245be19dc809c4c1d16a4c29eed1142@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anand Gadiyar <gadiyar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>

On 9/25/2010 1:14 AM, Anand Gadiyar wrote:
> Benoit Cousson wrote:
>
>> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
>> Cc: Tony Lindgren<tony@atomide.com>
>> Cc: Paul Walmsley<paul@pwsan.com>
>> Cc: Kevin Hilman<khilman@deeprootsystems.com>
>> ---
>>   arch/arm/mach-omap2/Kconfig         |    1 +
>>   arch/arm/mach-omap2/board-4430sdp.c |   12 ++++++++++++
>>   2 files changed, 13 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
>> index 6aede64..4a8f897 100644
>> --- a/arch/arm/mach-omap2/Kconfig
>> +++ b/arch/arm/mach-omap2/Kconfig
>> @@ -240,6 +240,7 @@ config MACH_OMAP_4430SDP
>>   	bool "OMAP 4430 SDP board"
>>   	default y
>>   	depends on ARCH_OMAP4
>> +	select OMAP_PACKAGE_CBL
>>
>>   config MACH_OMAP4_PANDA
>>   	bool "OMAP4 Panda Board"
>> diff --git a/arch/arm/mach-omap2/board-4430sdp.c
> b/arch/arm/mach-omap2/board-4430sdp.c
>> index 9447644..d087712 100644
>> --- a/arch/arm/mach-omap2/board-4430sdp.c
>> +++ b/arch/arm/mach-omap2/board-4430sdp.c
>> @@ -35,6 +35,8 @@
>>   #include<plat/timer-gp.h>
>>   #include<plat/usb.h>
>>   #include<plat/mmc.h>
>> +
>> +#include "mux.h"
>>   #include "hsmmc.h"
>>
>>   #define ETH_KS8851_IRQ			34
>> @@ -426,10 +428,20 @@ static int __init omap4_i2c_init(void)
>>   	omap_register_i2c_bus(4, 400, NULL, 0);
>>   	return 0;
>>   }
>> +
>> +#ifdef CONFIG_OMAP_MUX
>> +static struct omap_board_mux board_mux[] __initdata = {
>> +	{ .reg_offset = OMAP_MUX_TERMINATOR },
>> +};
>> +#else
>> +#define board_mux	NULL
>> +#endif
>> +
>>   static void __init omap_4430sdp_init(void)
>>   {
>>   	int status;
>>
>> +	omap4_mux_init(board_mux, OMAP_PACKAGE_CBL);
>>   	omap4_i2c_init();
>>   	platform_add_devices(sdp4430_devices,
> ARRAY_SIZE(sdp4430_devices));
>>   	omap_serial_init();
>
>
> Panda uses the same package I believe - I'll double check and update
> that board file. I'll test this series tomorrow on both boards.

Probably, please note that there is a new CBS package for ES2.0.

I've just generated the data, I'll send you that ASAP, since I do not 
have ES2 board to check that anyway :-(

Thanks,
Benoit
