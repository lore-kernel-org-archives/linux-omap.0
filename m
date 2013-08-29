From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCHv3 0/9] ARM: OMAP2+: AM33XX: Add suspend-resume support
Date: Thu, 29 Aug 2013 15:20:27 -0700
Message-ID: <87mwo0rvf8.fsf@linaro.org>
References: <1375811376-49985-1-git-send-email-d-gerlach@ti.com>
	<5211E3F6.6090108@ti.com> <52125A39.3010008@ti.com>
	<87vc2qyjao.fsf@linaro.org> <521FBD6B.3020208@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f51.google.com ([209.85.160.51]:65072 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751968Ab3H2WUb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Aug 2013 18:20:31 -0400
Received: by mail-pb0-f51.google.com with SMTP id jt11so1025139pbb.38
        for <linux-omap@vger.kernel.org>; Thu, 29 Aug 2013 15:20:30 -0700 (PDT)
In-Reply-To: <521FBD6B.3020208@ti.com> (Dave Gerlach's message of "Thu, 29 Aug
	2013 16:30:19 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: Gururaja Hebbar <gururaja.hebbar@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>

Dave Gerlach <d-gerlach@ti.com> writes:

[...]

>>>
>>> The working repo for this version of the patch series can be found here:
>>>
>>> git://github.com/dgerlach/linux-pm.git am335x-3.11rc4-suspend-resume
>>
>> I tried this branch on my beaglebone black, and it's not fully resuming.
>> Suspend seems to be working (power draw goes from ~1W to ~130mW) and
>> pressing a key on the UART seems to be waking up the SoC (power draw
>> goes to ~600mW) but I don't ever get the console back.
>>
>> Is there a specific version of the firmware I should be using?
>>
>> Kevin
>>
>
> Kevin, I agree there does seem to be some issues with Beaglebone
> black. I can confirm it works on BeagleBone White and the large am335
> EVM, I am working on pinpointing the issue on beaglebone black, seems
> that support isn't quite there yet.

OK, I tried the above branch on my BB white, using prebuilt firmware
from the next3 branch of the am33x-cm3 repo and it's suspending/resuming
fine.  Thanks for the pointer.

FYI, measuring at the 5V supply, it goes from ~1.6W at idle down to
~700mW in suspend.  The black goes from ~1W down to an impressive 130mW
but of course, it doesn't wake up so maybe it's not that impressive. ;)

Kevin
