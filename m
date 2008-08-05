From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/4] OMAP: MENELAUS: Improvements on menelaus
Date: Tue, 5 Aug 2008 16:45:05 +0300
Message-ID: <20080805134502.GK7193@atomide.com>
References: <488F48E3.2060504@indt.org.br> <20080729183717.GB7275@frodo> <fb249edb0807291157v40f4c0e0vf0e35b1beb39cd3b@mail.gmail.com> <13B9B4C6EF24D648824FF11BE89671620361D432D8@dlee02.ent.ti.com> <5A47E75E594F054BAF48C5E4FC4B92AB02567D91E5@dbde02.ent.ti.com> <20080805085752.GE7193@atomide.com> <20080805093544.GU30539@gandalf.research.nokia.com> <20080805094204.GM7193@atomide.com> <489857E1.1010305@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:53714 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758178AbYHENpT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Aug 2008 09:45:19 -0400
Content-Disposition: inline
In-Reply-To: <489857E1.1010305@indt.org.br>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Carlos Aguiar <carlos.aguiar@indt.org.br>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, "Gadiyar, Anand" <gadiyar@ti.com>, andrzej zaborowski <balrogg@gmail.com>, "me@felipebalbi.com" <me@felipebalbi.com>, "Woodruff, Richard" <r-woodruff2@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Carlos Aguiar <carlos.aguiar@indt.org.br> [080805 16:40]:
> ext Tony Lindgren wrote:
>> * Felipe Balbi <felipe.balbi@nokia.com> [080805 12:35]:
>>   
>>> On Tue, Aug 05, 2008 at 11:57:53AM +0300, Tony Lindgren wrote:
>>>     
>>>> Yeah, let's rename it as it's not in mainline yet. I'll apply this
>>>> series, then the next set of patches can take care of the renaming.
>>>>       
>>> It it in mainline actually, check your drivers/i2c/chips and it was
>>> added by you :-p
>>>
>>> commit 0c4a59fed41bdd4c30ce0999a87f30a812f29ee2
>>> Author: Tony Lindgren <tony@atomide.com>
>>> Date:   Tue Jul 17 04:06:09 2007 -0700
>>>
>>>     OMAP: add TI TWL92330/Menelaus Power Management chip driver
>>>         Add Texas Instruments TWL92330/Menelaus Power Management chip 
>>> driver.  This
>>>     includes voltage regulators, Dual slot memory card tranceivers and
>>>     real-time clock(RTC).
>>>         The support for RTC is integrated with this driver only; it 
>>> is not separate
>>>     module.  Passes 'rtctest' on OMAP H4 EVM, other than lack of "periodic"
>>>     (1/N second) IRQs.  System wakeup alarms (from suspend-to-RAM) work too.
>>>         The battery keeps the RTC active over power off, so once you 
>>> set clock
>>>     (rdate/ntpdate/etc, then "hwclock -w") then RTC_HCTOSYS at boot time will
>>>     behave as expected.
>>>         Cc: "Jean Delvare" <khali@linux-fr.org>
>>>     Cc: "Tony Lindgren" <tony@atomide.com>
>>>     Cc: "David Brownell" <david-b@pacbell.net>
>>>     Signed-off-by: Trilok Soni <soni.trilok@gmail.com>
>>>     Acked-by: Alessandro Zummo <alessandro.zummo@towertech.it>
>>>     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>>>     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
>>>
>>> Maybe someone sent that patch for you ?
>>>     
>>
>> Oops :) I guess I'm over a year behind current developments after my
>> vacation!
>>
>> Anyways, sounds like people want to rename it. Carlos, can you
>> send your patches to the i2c list for integration?
>>
>> Tony
>>
>>   
> Hi Tony and folks,
>
> So, I'm going to preparing and send a new series by today to i2c list  
> for integration so that such series:
>
> - Align the code from l-o tree to mainline tree.
> - Apply the series of four patches I just sent to l-o.
> - And than a last one to rename files to twl92230, as folks agreeded.

Sounds good to me!

Tony
