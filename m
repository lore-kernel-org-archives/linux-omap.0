From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 0/3] OMAP/pinmux: remove misuse of IRQF_NO_SUSPEND flag
Date: Mon, 15 Feb 2016 10:01:34 +0000
Message-ID: <56C1A1FE.3080403@arm.com>
References: <1454351299-27440-1-git-send-email-sudeep.holla@arm.com>
 <CACRpkdYzJ9Hy0sH6gK6RzpLE6juS4WfPjbt7nh43vR9YTuGZWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CACRpkdYzJ9Hy0sH6gK6RzpLE6juS4WfPjbt7nh43vR9YTuGZWA@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Linus,

On 13/02/16 14:42, Linus Walleij wrote:
> On Mon, Feb 1, 2016 at 7:28 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
>>    pinctrl: single: Use a separate lockdep class
>>    pinctrl: single: remove misuse of IRQF_NO_SUSPEND flag
>>    ARM: OMAP2+: remove misuse of IRQF_NO_SUSPEND flag
>>
>>   arch/arm/mach-omap2/mux.c        |  4 ++--
>>   arch/arm/mach-omap2/pm34xx.c     |  9 ++++-----
>>   arch/arm/mach-omap2/prm_common.c |  1 +
>>   drivers/pinctrl/pinctrl-single.c | 15 ++++++++++++---
>
> Are these patches orthogonal so I can merge the pinctrl patch independently
> of the OMAP patches if Tony ACKs this?
>

Thanks for the follow up.
IIUC they are dependent and remember Tony/Grygorii wanted them to be
merged together(at-least for bisectibility)

> If not: should it be merged by me or through ARM SoC/Tony?
>

I think so.

> Anyways waiting for maintainer feedback, but the above is good to know.
>

Grygorii was still not sure if this works and he couldn't give it a
test. He was traveling and may need more time to get back on this.

-- 
Regards,
Sudeep
