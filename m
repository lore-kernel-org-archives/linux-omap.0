From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: [PATCH] ARM: OMAP: add RTC support to beagleboard
Date: Mon, 12 May 2008 23:54:07 +0200
Message-ID: <60F706BA-C3F1-4683-8CCE-E6E4AC8CD6D2@student.utwente.nl>
References: <6996A016-47DB-45BF-8F78-8AD0051C4695@student.utwente.nl> <fb249edb0805080955h5222acdcy1fe8f3d83f251d43@mail.gmail.com> <E0DD11B5-7C21-4B77-A980-BFB116BC1A96@student.utwente.nl> <E454E413-ED07-497F-811C-5BDAE97B468A@student.utwente.nl> <20080509215404.GF5976@atomide.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp2.utsp.utwente.nl ([130.89.2.9]:36374 "EHLO smtp.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753513AbYELVzl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 May 2008 17:55:41 -0400
In-Reply-To: <20080509215404.GF5976@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Beagle Board <beagleboard@googlegroups.com>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Op 9 mei 2008, om 23:54 heeft Tony Lindgren het volgende geschreven:
> * Koen Kooi <k.kooi@student.utwente.nl> [080509 07:56]:
>>
>> Op 8 mei 2008, om 19:04 heeft Koen Kooi het volgende geschreven:
>>> -----BEGIN PGP SIGNED MESSAGE-----
>>> Hash: SHA1
>>>
>>>
>>> Op 8 mei 2008, om 18:55 heeft andrzej zaborowski het volgende
>>> geschreven:
>>>> Something must be missing here, omap3_beagle_devices is not being
>>>> referenced.
>>>>
>>>> The missing line probably looks something like
>>>> platform_add_devices(omap3_beagle_devices,
>>>> ARRAY_SIZE(omap3_beagle_devices));
>>>
>>> You're 100% right :) I forgot --amend, so the patch missed my second
>>> commit
>>>
>>>> You can also add the #ifdef around omap3_beagle_twl4030rtc_device  
>>>> to
>>>> avoid a compiler warning, or drop it in both places.
>>>
>>> The idea is that a next patch (rudimentary lcd support) will add
>>> device in there as well. I can move the ifdef for this patch if you
>>> want.
>>>
>>> thanks for the review,
>>>
>>> Koen
>>>
>>> Updated patch:
>>
>> With the current patch I get this in the bootlog:
>>
>> usb0: RNDIS ready
>> mice: PS/2 mouse device common for all mice
>> twl4030_rtc twl4030_rtc: rtc core: registered twl4030_rtc as rtc0
>> OMAP Watchdog Timer Rev 0x31: initial timeout 60 sec
>> [..]
>> twl4030_rtc twl4030_rtc: setting system clock to 2000-01-01 00:02:15
>> UTC (946684935)
>>
>> So it works :)
>
> Pushing today.

It still doesn't show up in git after the rc2 merge, did something go  
wrong?

regards,

Koen



>
>
> Tony
>
>>
>> regards,
>>
>> Koen
>>
>>
>>>
>>>
>>> This patch adds RTC support to the omap3 based beagleboard
>>>
>>> Signed-off-by: Koen Kooi <koen@openembedded.org>
>>> - ---
>>> arch/arm/mach-omap2/board-omap3beagle.c |   12 ++++++++++++
>>> 1 files changed, 12 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/ 
>>> mach-
>>> omap2/board-omap3beagle.c
>>> index 626f004..0c0cbfc 100644
>>> - --- a/arch/arm/mach-omap2/board-omap3beagle.c
>>> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
>>> @@ -58,13 +58,25 @@ static struct omap_mmc_config
>>> omap3beagle_mmc_config __initdata = {
>>> 	},
>>> };
>>>
>>> +static struct platform_device omap3_beagle_twl4030rtc_device = {
>>> +	.name           = "twl4030_rtc",
>>> +	.id             = -1,
>>> +};
>>> +
>>> static struct omap_board_config_kernel omap3_beagle_config[]
>>> __initdata = {
>>> 	{ OMAP_TAG_UART,	&omap3_beagle_uart_config },
>>> 	{ OMAP_TAG_MMC,		&omap3beagle_mmc_config },
>>> };
>>>
>>> +static struct platform_device *omap3_beagle_devices[] __initdata  
>>> = {
>>> +#ifdef CONFIG_RTC_DRV_TWL4030
>>> +	&omap3_beagle_twl4030rtc_device,
>>> +#endif
>>> +};
>>> +
>>> static void __init omap3_beagle_init(void)
>>> {
>>> +	platform_add_devices(omap3_beagle_devices,
>>> ARRAY_SIZE(omap3_beagle_devices));
>>> 	omap_board_config = omap3_beagle_config;
>>> 	omap_board_config_size = ARRAY_SIZE(omap3_beagle_config);
>>> 	omap_serial_init();
>>> - --
>>> 1.5.4.3
>>>
>>>
>>> -----BEGIN PGP SIGNATURE-----
>>> Version: GnuPG v1.4.5 (Darwin)
>>>
>>> iD8DBQFIIzK8MkyGM64RGpERAgE7AJ9meokVhJ/V/iR3PfwNbf0ZeR0aDACcDP2/
>>> 2kdpcssXcbftzzC5o6D2mLU=
>>> =dk6K
>>> -----END PGP SIGNATURE-----
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-
>>> omap" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux- 
>> omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFIKLyDMkyGM64RGpERAt8CAJ4neeAxn9BooooblxlIJC4YVAB8xwCfX5WP
5onXr5l0Vm8IGwqtBWK4iEk=
=TpiD
-----END PGP SIGNATURE-----
