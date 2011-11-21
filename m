From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [GIT PULL] ARM: OMAP: hwmod fix for 3.2-rc3
Date: Mon, 21 Nov 2011 09:58:44 +0100
Message-ID: <4ECA12C4.5070708@ti.com>
References: <4EC3DE7D.9050609@ti.com> <20111118233756.GR31337@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58051 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754456Ab1KUI6z (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Nov 2011 03:58:55 -0500
In-Reply-To: <20111118233756.GR31337@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 11/19/2011 12:37 AM, Tony Lindgren wrote:
> * Cousson, Benoit<b-cousson@ti.com>  [111116 07:27]:
>> Hi Tony,
>>
>> That bug is becoming annoying, and a bunch of folks are hitting that issue during DT dev for 3.3, so it will be cool to fix that ASAP.
>
> OK pulling it in. BTW, next time, please try to base branches on some
> recent tag like v3.2 or v3.2-rc2. Of course, that is assuming there's
> no dependency to some recent fix :)

Oops, sorry, I thought the latest HEAD would be better than rc2.
Next time, I'll stick to the latest tag.

Thanks,
Benoit

>
> Regards,
>
> Tony
>
>> It might already be in Paul's queue for 3.2-rc3.
>>
>> Thanks,
>> Benoit
>>
>>
>> The following changes since commit 6aaf05f472c97ebceff47d9eef464574f1a55727:
>>    Linus Torvalds (1):
>>          Merge branch 'for-linus' of git://git390.marist.edu/pub/scm/linux-2.6
>>
>> are available in the git repository at:
>>
>>    git://gitorious.org/omap-pm/linux.git for_3.2-rc/hwmod-fixes
>>
>> sricharan (1):
>>        ARM: OMAP: hwmod: Fix the addr space, irq, dma count APIs
>>
>>   arch/arm/mach-omap2/omap_hwmod.c |    6 +++---
>>   1 files changed, 3 insertions(+), 3 deletions(-)

