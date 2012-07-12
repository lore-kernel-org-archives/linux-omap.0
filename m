From: Omar Ramirez Luna <omar.luna@linaro.org>
Subject: Re: suspend broken on 3.5-rc1?
Date: Thu, 12 Jul 2012 14:49:08 -0500
Message-ID: <CALLhW=4VkOhYo9vRgqqVfmifx7ynTfURxGH2CQh8ZvD0SBtnmg@mail.gmail.com>
References: <4FD1D570.1010508@ti.com>
	<20120608105611.GO12766@atomide.com>
	<4FD1EF25.3060906@ti.com>
	<1339160732.2091.47.camel@sokoban>
	<4FD1FB47.8040007@ti.com>
	<4FD72FB7.60905@ti.com>
	<CALLhW=5HUJuUbEoz7GXJ3h75iqB_9_bNrofBU45zKQejkKExAQ@mail.gmail.com>
	<87mx36ht3y.fsf@ti.com>
	<CALLhW=7FwtPy0_u863fH7-nSMW4AvxuqHvNeO2CqtF3aJEgh4Q@mail.gmail.com>
	<4FFE6049.7040908@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:51547 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932899Ab2GLTtJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Jul 2012 15:49:09 -0400
Received: by vcbf11 with SMTP id f11so1779950vcb.19
        for <linux-omap@vger.kernel.org>; Thu, 12 Jul 2012 12:49:08 -0700 (PDT)
In-Reply-To: <4FFE6049.7040908@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, t-kristo@ti.com, Tony Lindgren <tony@atomide.com>, loml <linux-omap@vger.kernel.org>

On 12 July 2012 00:27, Rajendra Nayak <rnayak@ti.com> wrote:
> On Thursday 12 July 2012 05:28 AM, Omar Ramirez Luna wrote:
>>
>> I suspect this might be specific to 4460 as Rajendra reported it was
>> working for him on 4430 but not on 4460, I haven't tried 4430 but let
>> me see if I can find one.
>
>
> Yes, this is an issue specific to 4460. The patch 'ARM: OMAP4460:
> Workaround for ROM bug because of CA9 r2pX GIC control register change'
> from Tero's Core retention series [1] fixes it. Unfortunately the patch
> does not apply on it own and has dependencies with other patches in the
> series.
>
> [1] http://comments.gmane.org/gmane.linux.ports.arm.omap/78399

Thanks, it worked! I took the first two patches of the series and at
least I'm able to come back from suspend on Panda 4460.

However, the original series no longer applies on 3.5-rc6 and I
couldn't find a rebased version on Tero's tree, so I just rebased the
first two to 3.5-rc6 in case anybody stomps on this thread and for
test purposes only:

git://github.com/omarrmz/upstream-wip.git
branch: LO-k3.5-rc6-secondary-CPU-resume-hangs

I hope at least 1 and 2 from the original series make it for 3.6.

Regards,

Omar
