From: Ran Shalit <ranshalit@gmail.com>
Subject: Re: ideas about idle loop and power management
Date: Wed, 24 Sep 2014 08:19:05 +0300
Message-ID: <CAJ2oMhJZedB1N+HAx3-Tyv0z9TksTCTQiFxBt5YvO7pcrdEBbQ@mail.gmail.com>
References: <CAJ2oMhKRSo76NEppiR6oqJXeuwrN=Um2azKCNGgP3PbuH_T3PA@mail.gmail.com>
	<20140923203722.GB3122@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:64124 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750767AbaIXFTH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Sep 2014 01:19:07 -0400
Received: by mail-we0-f182.google.com with SMTP id u57so3683538wes.41
        for <linux-omap@vger.kernel.org>; Tue, 23 Sep 2014 22:19:06 -0700 (PDT)
In-Reply-To: <20140923203722.GB3122@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Tue, Sep 23, 2014 at 11:37 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Ran Shalit <ranshalit@gmail.com> [140923 12:24]:
>> Hello,
>>
>> I have a system which is required to have 2 modes operation:
>> 1. idle - in which devices in Soc and on board should be off.
>> 2. active mode
>
> Hmm we do this already with the mainline kernel since v3.16-rc6
> for device tree based systems too. Some devices will still block
> deeper idle states idle like EHCI. I suggest you give v3.17-rc6
> a try on a beagleboard xm (rev c preferrably)using omap2plus_defconfig.
> Or omap 37xx evm. Or on n900. Or overo, but that's still pending
> a .dts fix.
>
>> Moving from idle to active on interrupt, and moving from active to
>> idle when there is inactivity.
>> After reading and re-reading about PM various mechanism, I got to
>> conculsion that the best and easiest way to achive this on omap
>> (omap3530) will be as following:
>> 1. use cpuidle
>> 2. find the exact place in cpuidle mechanism where we enter idle loop,
>> and where we exit idle loop.
>> 3. on entering idle loop: turn off various devices on board, and
>> devices power domain
>
> The devices are autoidle where possible with runtime PM. And then
> the hardware enters deeper idle states when drivers are not
> blocking.
>
> Sounds like you just need to give it a try. I'm using the following
> test script. You may need to also blank the LCD.
>

Hi Tony,

I actually want something different than runtime PM.
I want that the whenever system enters idle loop it will force suspend
of the devices, and not that each device will decide on its own.
Aside from that, from delving into code it seems that tailoring new
device runtime suspend/resume by building registration of runtime_pm
callbacks is much more complex than simply disabling power domain of
all relevant devices whenever entering idle mode.

Thanks,
Ran
