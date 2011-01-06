From: "Coley, Gerald" <g-coley1@ti.com>
Subject: RE: [PATCH v2] ARM: OMAP: Power on EHCI, serial, camera and DVI on
 beagleboard-xM
Date: Thu, 6 Jan 2011 13:53:21 -0600
Message-ID: <676FD6AA0F002F49B89E70F0C5EFD22C136F720B9A@dlee04.ent.ti.com>
References: <1291725639-86397-1-git-send-email-koen@beagleboard.org>
 <1292769735-54159-1-git-send-email-koen@dominion.thruhere.net>
 <4D2609F6.8090204@ti.com>
 <C29E2E05-1E8C-4A3F-8A64-0C8450049FB8@dominion.thruhere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43064 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751404Ab1AFTx1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Jan 2011 14:53:27 -0500
In-Reply-To: <C29E2E05-1E8C-4A3F-8A64-0C8450049FB8@dominion.thruhere.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <koen@dominion.thruhere.net>, "Menon, Nishanth" <nm@ti.com>
Cc: Koen Kooi <koen.kooi@gmail.com>, l-o Mailing List <linux-omap@vger.kernel.org>

You are correct. On the -xM over current is from the USB HUB driver as there are four ports. So that gets detected by the USB hub device and reported back.


Gerald


-----Original Message-----
From: Koen Kooi [mailto:koen@dominion.thruhere.net]
Sent: Thursday, January 06, 2011 12:33 PM
To: Menon, Nishanth
Cc: Koen Kooi; l-o Mailing List; Coley, Gerald
Subject: Re: [PATCH v2] ARM: OMAP: Power on EHCI, serial, camera and DVI on beagleboard-xM


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
>> +     /* Power on DVI, Serial and PWR led */
>> +    if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM) {
>> +            gpio_request(gpio + 1, "nDVI_PWR_EN");
>> +            gpio_direction_output(gpio + 1, 0);
>> +    }
> earlier in this function, we do:
>       gpio_request(gpio + 1, "EHCI_nOC");
>       gpio_direction_input(gpio + 1);
> here we do
> gpio_request(gpio + 1, "nDVI_PWR_EN");
> gpio_direction_output(gpio + 1, 0);
>
> I am confused. is gpio+1 input or output line? and what level should it be on?

On early revB prototypes it was used to sense USB overcurrent, I'm not sure what the current status is for that pin on revB and revC, but on xM it controls the DVI, serial and led block.

Adding Gerald to CC: to see if he has some pearls of wisdom on this :)

regards,

Koen
