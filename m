From: Adrian Hunter <ext-adrian.hunter@nokia.com>
Subject: Re: [PATCH 2/2] ARM: OMAP: Fix gpio by switching to generic gpio
 calls
Date: Wed, 07 Jan 2009 15:26:41 +0200
Message-ID: <4964AD91.3000200@nokia.com>
References: <20090107111415.GF27566@atomide.com> <20090107111615.GG27566@atomide.com> <20090107111744.GH27566@atomide.com> <20090107133747.d448222e.jarkko.nikula@nokia.com> <20090107120344.GK27566@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:38313 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751006AbZAGNPa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Jan 2009 08:15:30 -0500
In-Reply-To: <20090107120344.GK27566@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

Tony Lindgren wrote:
> * Jarkko Nikula <jarkko.nikula@nokia.com> [090107 13:38]:
>> On Wed, 7 Jan 2009 13:17:45 +0200
>> "ext Tony Lindgren" <tony@atomide.com> wrote:
>>
>>> From: Jarkko Nikula <jarkko.nikula@nokia.com>
>>> Date: Wed, 7 Jan 2009 12:54:34 +0200
>>> Subject: [PATCH] ARM: OMAP: Fix gpio by switching to generic gpio calls
>>>
>>> Fix compile by removing remaining omap specific gpio
>>> calls. Based on earlier patches by Jarkko Nikula.
>>>
>> Thanks Tony!
>>
>>> diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
>>> index 96ecc17..77a4f14 100644
>>> --- a/drivers/mtd/onenand/omap2.c
>>> +++ b/drivers/mtd/onenand/omap2.c
>>>
>> I think this was already handed over to mtd list by Adrian?
> 
> Oops, sorry. Adrian, do you want me to drop the compile fix for onenand?
> 
> Regards,
> 
> Tony
> 

No, those changes have not been sent to mainline before.
Please go ahead.
