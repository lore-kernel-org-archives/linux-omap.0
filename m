From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v4 RESEND 6/7] gpio/omap: fix incorrect update to context.irqenable1
Date: Wed, 21 Mar 2012 07:06:30 -0700
Message-ID: <87y5qurqu1.fsf@ti.com>
References: <1332240799-6748-1-git-send-email-tarun.kanti@ti.com>
	<1332240799-6748-7-git-send-email-tarun.kanti@ti.com>
	<87zkbbywwz.fsf@ti.com>
	<CAC83ZvKRbvVU5Qa1jwud0E6WT-DBU1Z1XEweiXay9x+eLcn0hg@mail.gmail.com>
	<CAC83ZvLgPWO2C6cpRBEsoqFdac1rMyo4OvTXB2_y_mCzaFzJXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:37958 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030839Ab2CUOGh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Mar 2012 10:06:37 -0400
Received: by ghrr18 with SMTP id r18so1118687ghr.0
        for <linux-omap@vger.kernel.org>; Wed, 21 Mar 2012 07:06:31 -0700 (PDT)
In-Reply-To: <CAC83ZvLgPWO2C6cpRBEsoqFdac1rMyo4OvTXB2_y_mCzaFzJXA@mail.gmail.com>
	(Tarun Kanti DebBarma's message of "Wed, 21 Mar 2012 10:31:48 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, b-cousson@ti.com, grant.likely@secretlab.ca, linux-arm-kernel@lists.infradead.org

"DebBarma, Tarun Kanti" <tarun.kanti@ti.com> writes:

> On Wed, Mar 21, 2012 at 8:10 AM, DebBarma, Tarun Kanti
> <tarun.kanti@ti.com> wrote:
>> On Tue, Mar 20, 2012 at 11:31 PM, Kevin Hilman <khilman@ti.com> wrote:
>>> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
>>>
>>>> In _enable_gpio_irqbank() when bank->regs->set_irqenable is valid,
>>>> gpio_mask can be directly set by writing to set_irqenable register
>>>> without overwriting current value. In order to ensure the same is
>>>> stored in context.irqenable1, we must read from regs->irqenable
>>>> instead of overwriting it with gpio_mask.
>>>
>>>> The overwriting makes sense only in the second case where irqenable
>>>> is explicitly read and updated with new gpio_mask before writing it
>>>> back. However, for consistency reading regs->irqenable into the
>>>> bank->context.irqenable1 takes care of both the scenarios.
>>>
>>> ...except that the code doesn't do this anymore.
>> Yes.
>>>
>>> I like the newer version (I hope so, since I suggested it :), but please
>>> update the changlog to describe what the code is actually doing.
>> Sure.
> I have updated the change log here:
> git://gitorious.org/~tarunkanti/omap-sw-develoment/tarunkantis-linux-omap-dev
> for_3.4/gpio_more_fixes

Please also post and updated version of the patch for review.

Kevin
