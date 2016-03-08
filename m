From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH 0/3] OMAP/pinmux: remove misuse of IRQF_NO_SUSPEND flag
Date: Tue, 8 Mar 2016 18:31:59 +0700
Message-ID: <56DEB82F.5050703@ti.com>
References: <1454351299-27440-1-git-send-email-sudeep.holla@arm.com>
 <CACRpkdYzJ9Hy0sH6gK6RzpLE6juS4WfPjbt7nh43vR9YTuGZWA@mail.gmail.com>
 <56C1A1FE.3080403@arm.com> <20160215152751.GT19432@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20160215152751.GT19432@atomide.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Sudeep Holla <sudeep.holla@arm.com>, Tero Kristo <t-kristo@ti.com>, Dave Gerlach <d-gerlach@ti.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 02/15/2016 10:27 PM, Tony Lindgren wrote:
> * Sudeep Holla <sudeep.holla@arm.com> [160215 02:03]:
>> Hi Linus,
>>
>> On 13/02/16 14:42, Linus Walleij wrote:
>>> On Mon, Feb 1, 2016 at 7:28 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>>
>>>>    pinctrl: single: Use a separate lockdep class
>>>>    pinctrl: single: remove misuse of IRQF_NO_SUSPEND flag
>>>>    ARM: OMAP2+: remove misuse of IRQF_NO_SUSPEND flag
>>>>
>>>>   arch/arm/mach-omap2/mux.c        |  4 ++--
>>>>   arch/arm/mach-omap2/pm34xx.c     |  9 ++++-----
>>>>   arch/arm/mach-omap2/prm_common.c |  1 +
>>>>   drivers/pinctrl/pinctrl-single.c | 15 ++++++++++++---
>>>
>>> Are these patches orthogonal so I can merge the pinctrl patch independently
>>> of the OMAP patches if Tony ACKs this?
>>>
>>
>> Thanks for the follow up.
>> IIUC they are dependent and remember Tony/Grygorii wanted them to be
>> merged together(at-least for bisectibility)
> 
> AFAIK this series needs to be kept together to keep things
> working.
> 
>>> If not: should it be merged by me or through ARM SoC/Tony?
>>>
>>
>> I think so.
>>
>>> Anyways waiting for maintainer feedback, but the above is good to know.
>>>
>>
>> Grygorii was still not sure if this works and he couldn't give it a
>> test. He was traveling and may need more time to get back on this.
> 
> He said it does not work so clearly more work is needed.
> 

Yeah. As I mentioned before patches 2/3 will not work.
I've tried to test suspend with diff I posted [1], but I did it only on 
dra7 and am43 where suspend i more simple than on omap3. Also, I worry
that with such approach some irq can be missed (especially edge ones), 
because PRCM irqs will be re-enabled at very late resume stage 
(right before thaw).

Second option, I see, is to rework PRCM to be threaded IRQ, but in this case
all children IRQs will need to be threaded/nested threaded
(including PCS, legacy OMAP mux, OMAP3 _prcm_int_handle_wakeup/_prcm_int_handle_io).

Are there any objection to convert PCS to threaded IRQ, for example? ;)
 

[1] https://patchwork.ozlabs.org/patch/578915/

-- 
regards,
-grygorii
