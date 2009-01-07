From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] ARM: OMAP: Fix gpio by switching to generic gpio
	calls
Date: Wed, 7 Jan 2009 15:18:15 +0200
Message-ID: <20090107131814.GN27566@atomide.com>
References: <20090107111415.GF27566@atomide.com> <20090107111615.GG27566@atomide.com> <20090107111744.GH27566@atomide.com> <20090107133747.d448222e.jarkko.nikula@nokia.com> <20090107120344.GK27566@atomide.com> <4964AD91.3000200@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:60386 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751003AbZAGNSU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Jan 2009 08:18:20 -0500
Content-Disposition: inline
In-Reply-To: <4964AD91.3000200@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Adrian Hunter <ext-adrian.hunter@nokia.com>
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

* Adrian Hunter <ext-adrian.hunter@nokia.com> [090107 15:15]:
> Tony Lindgren wrote:
>> * Jarkko Nikula <jarkko.nikula@nokia.com> [090107 13:38]:
>>> On Wed, 7 Jan 2009 13:17:45 +0200
>>> "ext Tony Lindgren" <tony@atomide.com> wrote:
>>>
>>>> From: Jarkko Nikula <jarkko.nikula@nokia.com>
>>>> Date: Wed, 7 Jan 2009 12:54:34 +0200
>>>> Subject: [PATCH] ARM: OMAP: Fix gpio by switching to generic gpio calls
>>>>
>>>> Fix compile by removing remaining omap specific gpio
>>>> calls. Based on earlier patches by Jarkko Nikula.
>>>>
>>> Thanks Tony!
>>>
>>>> diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
>>>> index 96ecc17..77a4f14 100644
>>>> --- a/drivers/mtd/onenand/omap2.c
>>>> +++ b/drivers/mtd/onenand/omap2.c
>>>>
>>> I think this was already handed over to mtd list by Adrian?
>>
>> Oops, sorry. Adrian, do you want me to drop the compile fix for onenand?
>>
>> Regards,
>>
>> Tony
>>
>
> No, those changes have not been sent to mainline before.
> Please go ahead.

OK, thanks. Keeping the onenand change so the pull request is still
valid.

Tony
