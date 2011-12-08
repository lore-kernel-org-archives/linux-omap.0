From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2] staging: tidspbridge: request dmtimer clocks on init
Date: Thu, 8 Dec 2011 21:50:34 +0200
Message-ID: <CAMP44s0DGZVD34u=5DaFPGHwVaQ5O2s+U0W2w8MnNMUbr6Jong@mail.gmail.com>
References: <1321654734-11882-1-git-send-email-omar.ramirez@ti.com>
	<CAMP44s0OvrrWnYJzowkMUT7-jHKYS=LZUty=e1d9gM=OZT-0Ow@mail.gmail.com>
	<CAB-zwWiNkD=jinUgvdd6w8-2BCYTB+TiPBJij+LgY13gO=NQoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:43282 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750829Ab1LHTug (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Dec 2011 14:50:36 -0500
Received: by bkbzv3 with SMTP id zv3so2017763bkb.19
        for <linux-omap@vger.kernel.org>; Thu, 08 Dec 2011 11:50:35 -0800 (PST)
In-Reply-To: <CAB-zwWiNkD=jinUgvdd6w8-2BCYTB+TiPBJij+LgY13gO=NQoQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, devel@driverdev.osuosl.org, linux-omap@vger.kernel.org

On Thu, Dec 8, 2011 at 9:10 PM, Ramirez Luna, Omar <omar.ramirez@ti.com> wrote:
> On Wed, Dec 7, 2011 at 4:11 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> On Sat, Nov 19, 2011 at 12:18 AM, Omar Ramirez Luna <omar.ramirez@ti.com> wrote:
>>> Given that dm timer framework doesn't support request of clocks
>>> by soft | hard irqs because some recent changes, tidspbridge needs
>>> to request its clocks on init and enable/disable them on demand.
>>>
>>> This was first seen on 3.2-rc1.
>>>
>>> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
>>
>> This looks similar similar to this one:
>> http://article.gmane.org/gmane.linux.ports.arm.omap/61816
>>
>> Are you sure this is what we want instead of that one?
>
> I believe your patch only takes care of gpt5 and gpt6, but not of the
> other 2 that could be requested by the dsp, let's say gpt8 for avsync.

I'm not really sure about that... Judging from the code, the only
timers needed used to be initialized on bridge_brd_start based on the
symbols of the baseimage. If you say that's not enough, then I guess
that's fine (not really surprising that the old code missed that).

> As for this patch, dm timer framework should support request on soft
> or hard irq[1], but it can't because the underlying functions to use
> clk_get->clk_get_sys which holds a mutex.
>
> I believe your error was seen because of patches not in mainline, but
> the concept between the patches is similar indeed, however mine:

Yes, it's basically the same, the only difference is that I'm
initializing only the clocks that are supposed to be needed by the
baseimage.

> - Handles the other gpt that can be requested by the dsp.

And I guess which clocks are going to be used is not discoverable somehow...

> - Uses start/stop according to future plans of making enable/disable static.

Yeah, but that's easy to change s/enable/start/ s/disable/stop/

> - Might be temporal if *dm_timer_request* functions are fixed and
> there is an overall feeling that we can revert to use
> request+start/stop+free on request.

At which point we would end up with something similar to my patch :)

Anyway, I guess there's not much problem in requesting extra clocks
that we would not use.

Cheers.

-- 
Felipe Contreras
