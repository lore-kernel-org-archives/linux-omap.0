From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH 1/4] ARM: OMAP3: cm-t35: add regulator supply for ads7846
Date: Tue, 08 Nov 2011 15:21:42 +0200
Message-ID: <4EB92CE6.1000408@compulab.co.il>
References: <1319017160-20391-1-git-send-email-grinberg@compulab.co.il> <1319017160-20391-2-git-send-email-grinberg@compulab.co.il> <20111104233938.GF31337@atomide.com> <20111104235720.GG31337@atomide.com> <4EB68974.5090907@compulab.co.il> <20111107203110.GX31337@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:33763
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752869Ab1KHNVy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Nov 2011 08:21:54 -0500
In-Reply-To: <20111107203110.GX31337@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 11/07/11 22:31, Tony Lindgren wrote:
> * Igor Grinberg <grinberg@compulab.co.il> [111106 04:45]:
>> Hi Tony,
>>
>> On 11/05/11 01:57, Tony Lindgren wrote:
>>> * Tony Lindgren <tony@atomide.com> [111104 16:05]:
>>>> * Igor Grinberg <grinberg@compulab.co.il> [111019 02:05]:
>>>>
>>>> Applying to board branch for v3.3 merge window.
>>>
>>> Hmm, actually I suggest you respin patches 2 and 3 so they apply
>>> on their own to current fixes branch. Then update 1 and 4 to
>>> apply on top of those.
>>>
>>> This way we can apply 2 and 3 during the -rc cycle, and then
>>> queue 1 and 4 for the next merge window.
>>
>> Well, actually all them are fixes, although it cannot be understood
>> from the subject.
>> I will adjust the subjects (and may be the commit messages also)
>> to be more specific and resend.
> 
> Hmm 1 & 4 are "features that never worked" type fixes, so they
> have flame potential. Those have to wait for the next merge window.

Not exactly:

1/4 is a fix that I should have submitted more than a year ago,
just after the ads7846 got support for the regulators:
---------
commit 91143379b01b2020d8878d627ebe9dfb9d6eb4c8
Author: Grazvydas Ignotas <notasas@gmail.com>
Date:   Thu Feb 25 02:04:56 2010 -0800

    Input: ads7846 - add regulator support
    
    The ADS7846/TSC2046 touchscreen controllers can (and usually are)
    connected to various regulators for power, so add regulator support.
    
    Valid regulator will now be required, so boards without complete
    regulator setup should either disable regulator framework or enable
    CONFIG_REGULATOR_DUMMY.
    
    Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
    Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
    Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---------

4/4 is a functionality fix, that also should have been submitted
some time ago. We had this one locally and finally I've sent it out.
With out it, the USB hub sometimes works, but not always.
I've came back to that issue while working on CM-T3730 and
finally sent it.

So now, when I'm sure you have all the information,
what will it be?
If you still think it should be split up - that's fine with me,
I will do the thing and resend.
Otherwise, what about the v2 I've sent?

> 
> Patches 2 & 3 could be justified as fixes during the -rc cycle.

So here we have no doubt. Good.

> 
> Or I can just apply all of them into board branch to wait for the
> next merge window.

That can be an option, if it bothers you too much,
but I prefer to have this already in 3.2.

Thanks

-- 
Regards,
Igor.
