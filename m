From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: [PATCH v2] ARM: OMAP: Power on EHCI, serial, camera and DVI on beagleboard-xM
Date: Thu, 6 Jan 2011 19:33:01 +0100
Message-ID: <C29E2E05-1E8C-4A3F-8A64-0C8450049FB8@dominion.thruhere.net>
References: <1291725639-86397-1-git-send-email-koen@beagleboard.org> <1292769735-54159-1-git-send-email-koen@dominion.thruhere.net> <4D2609F6.8090204@ti.com>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:37858 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751649Ab1AFSfG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Jan 2011 13:35:06 -0500
Received: by wwa36 with SMTP id 36so17692616wwa.1
        for <linux-omap@vger.kernel.org>; Thu, 06 Jan 2011 10:35:01 -0800 (PST)
In-Reply-To: <4D2609F6.8090204@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Koen Kooi <koen.kooi@gmail.com>, l-o Mailing List <linux-omap@vger.kernel.org>, Gerald Coley <g-coley1@ti.com>


Op 6 jan 2011, om 19:29 heeft Nishanth Menon het volgende geschreven:

> Koen,
> Apologies on a late response.
> 
> Koen Kooi had written, on 12/19/2010 08:42 AM, the following:
> [...]
>> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
>> index f1a8ede..4756ac7 100644
>> --- a/arch/arm/mach-omap2/board-omap3beagle.c
>> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
>> @@ -297,13 +297,35 @@ static int beagle_twl_gpio_setup(struct device *dev,
> [..]
>> +
>> +	 /* Power on DVI, Serial and PWR led */
>> +	if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM) {
>> +		gpio_request(gpio + 1, "nDVI_PWR_EN");
>> +		gpio_direction_output(gpio + 1, 0);
>> +	}
> earlier in this function, we do:
> 	gpio_request(gpio + 1, "EHCI_nOC");
>  	gpio_direction_input(gpio + 1);
> here we do
> gpio_request(gpio + 1, "nDVI_PWR_EN");
> gpio_direction_output(gpio + 1, 0);
> 
> I am confused. is gpio+1 input or output line? and what level should it be on?

On early revB prototypes it was used to sense USB overcurrent, I'm not sure what the current status is for that pin on revB and revC, but on xM it controls the DVI, serial and led block.

Adding Gerald to CC: to see if he has some pearls of wisdom on this :)

regards,

Koen