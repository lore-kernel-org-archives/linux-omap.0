From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 2.6.26-omap-git] beagle LED fixes
Date: Tue, 5 Aug 2008 11:24:09 +0300
Message-ID: <20080805082407.GA7193@atomide.com>
References: <200808042356.16674.david-b@pacbell.net> <EAD57A58-81F7-45A9-95CB-69FC5068885F@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:51579 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754693AbYHEIYM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Aug 2008 04:24:12 -0400
Content-Disposition: inline
In-Reply-To: <EAD57A58-81F7-45A9-95CB-69FC5068885F@student.utwente.nl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: David Brownell <david-b@pacbell.net>, linux-omap@vger.kernel.org

* Koen Kooi <k.kooi@student.utwente.nl> [080805 11:14]:
>
> Op 5 aug 2008, om 08:56 heeft David Brownell het volgende geschreven:
>
>> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
>>
>> Update and fix Beagle LED declarations:  gpios for USR0 and USR1
>> were swapped, and their names don't match docs or silksreen.
>
> I just heard that from TI and wanted to fix that today :) I didn't  
> notice it because revA board have the leds shorted together so they both 
> light up at the same time.

Pushing today.

Tony

>
>> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
>
> Acked-by: Koen Kooi <koen@openembedded.org>
>
>>
>> ---
>> arch/arm/mach-omap2/board-omap3beagle.c |    9 +++++----
>> 1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> --- a/arch/arm/mach-omap2/board-omap3beagle.c	2008-08-04  
>> 22:08:16.000000000 -0700
>> +++ b/arch/arm/mach-omap2/board-omap3beagle.c	2008-08-04  
>> 22:08:36.000000000 -0700
>>
>> @@ -75,14 +76,14 @@ static struct omap_lcd_config omap3_beag
>>
>> struct gpio_led gpio_leds[] = {
>> 	{
>> -		.name			= "beagleboard::led0",
>> +		.name			= "beagleboard::usr0",
>> 		.default_trigger	= "none",
>> -		.gpio			= 149,
>> +		.gpio			= 150,
>> 	},
>> 	{
>> -		.name			= "beagleboard::led1",
>> +		.name			= "beagleboard::usr1",
>> 		.default_trigger	= "none",
>> -		.gpio			= 150,
>> +		.gpio			= 149,
>> 	},
>> };
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" 
>> in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>


