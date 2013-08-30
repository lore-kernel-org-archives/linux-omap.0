From: Vaibhav Bedia <vaibhav.bedia@gmail.com>
Subject: Re: [PATCHv3 8/9] ARM: OMAP2+: AM33XX: Basic suspend resume support
Date: Fri, 30 Aug 2013 13:29:13 -0400
Message-ID: <CANacCWzRcyU1wA07X8Q4bCfUOQe-gXSSM0jfMw6uyLiab1r9SQ@mail.gmail.com>
References: <1375811376-49985-1-git-send-email-d-gerlach@ti.com>
	<1375811376-49985-9-git-send-email-d-gerlach@ti.com>
	<CA+Bv8XbK+=pvG+bbvfCtS2Rtg-YoAhuUbWjSro9m4xWjw=Cr8A@mail.gmail.com>
	<52038E88.2050604@ti.com>
	<5203B336.90102@ti.com>
	<5203C211.7040207@ti.com>
	<87iozfga1t.fsf@kernel.org>
	<52040E67.4050402@ti.com>
	<87pptndbtj.fsf@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:50946 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755102Ab3H3R3P (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Aug 2013 13:29:15 -0400
Received: by mail-la0-f41.google.com with SMTP id ec20so1808930lab.28
        for <linux-omap@vger.kernel.org>; Fri, 30 Aug 2013 10:29:13 -0700 (PDT)
In-Reply-To: <87pptndbtj.fsf@kernel.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Nishanth Menon <nm@ti.com>, Paul Walmsley <paul@pwsan.com>, Dave Gerlach <d-gerlach@ti.com>, Russ Dill <russ.dill@gmail.com>, Vaibhav Bedia <vaibhav.bedia@ti.com>, Tony Lingren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Benoit Cousson <benoit.cousson@linaro.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>

(picking up an old thread, again)

On Thu, Aug 8, 2013 at 7:04 PM, Kevin Hilman <khilman@linaro.org> wrote:
>
> I disagree here.  I'm a firmware minimalist, and hiding bugs like this
> in the firmware is wrong when Linux is otherwise managing these devices.
> It also imposes criteria on the firmware of future SoCs that doesn't
> belong there either.  IMO, the only stuff the firmware should do is what
> Linux *cannot* do.
>
> Remember, this only needs to happen when there isn't a driver for these
> devices.  Should we communicate to the firmware that the OS has no
> driver, so please enable the hack?  I think not.
>

Agreed on not hiding the bugs in the firmware. Moreover, M3 can't access
the IPs in PER domain which is where the bad modules are, so the h/w
doesn't support such hackery (+1 for the h/w after all the -1's that it gets ;)

[...]

>>> That being said, IMO, the kernel (specifically omap_device) should
>>> handle this, and it should be rather easy to do in the omap_device layer
>>> and keep the SoC suspend/resume core code simple and ignorant of these
>>> "quirks."
>>>
>>> AFAICT, there's no reason these quirks need to be dealt with immediatly
>>> on suspend.  A slight delay should be fine, as long as it's before the
>>> next suspend/idle attempt, right?
>>>
>>> Given that, what we need to do (and by we, I mean you) is to flag all
>>> broken IP blocks, and let omap_device handle them in a suspend/resume
>>> notifier (c.f. register_pm_notifier() and PM_POST_SUSPEND.)
>>
>> yes - that is the alternate that comes to mind.
>
> In the earlier reviews of this series (many months ago now), I
> complained about the presence of this device specific handling in the
> core MPU PM code.  I'm somewhat troubled by the fact that nobody explored
> alternatives that so easily come to mind.
>

My bad. I was thinking along those lines [1] but after the suggestion on
using the driver bound status i just went with that suggestion in the dumbest
possible manner.

Regards,
Vaibhav

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2012-November/129676.html
