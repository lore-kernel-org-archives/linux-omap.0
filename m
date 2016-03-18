From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH 14/15] dt-bindings: arm-gic: Drop 'clock-names' from
 binding document
Date: Fri, 18 Mar 2016 14:47:28 +0200
Message-ID: <56EBF8E0.8020700@ti.com>
References: <1458224359-32665-1-git-send-email-jonathanh@nvidia.com>
 <1458224359-32665-15-git-send-email-jonathanh@nvidia.com>
 <CAMuHMdV0QiWR0bML44zhAx+MStmQhQWKd=b_TMKnEdu_hw_ReA@mail.gmail.com>
 <56EBD4E5.1060002@nvidia.com>
 <CAMuHMdWXqS9cru74Ckr47gFVTf2MkmjZUtMt4MeXW_1V7x+KHw@mail.gmail.com>
 <56EBDEFA.30102@nvidia.com>
 <CAMuHMdUkGiX6YWzbRVJaJ4BNskE8PUXq-7Zob40f=CEZyjtJiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdUkGiX6YWzbRVJaJ4BNskE8PUXq-7Zob40f=CEZyjtJiA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>, Jon Hunter <jonathanh@nvidia.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Kevin Hilman <khilman@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Linus Walleij <linus.walleij@linaro.org>, linux-tegra@vger.kernel.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 03/18/2016 02:05 PM, Geert Uytterhoeven wrote:
> Hi Jon,
> 
> On Fri, Mar 18, 2016 at 11:56 AM, Jon Hunter <jonathanh@nvidia.com> wrote:
>> On 18/03/16 10:52, Geert Uytterhoeven wrote:
>>> On Fri, Mar 18, 2016 at 11:13 AM, Jon Hunter <jonathanh@nvidia.com> wrote:
>>>> On 18/03/16 09:13, Geert Uytterhoeven wrote:
>>>>> On Thu, Mar 17, 2016 at 3:19 PM, Jon Hunter <jonathanh@nvidia.com> wrote:
>>>>>> Commit afbbd2338176 ("irqchip/gic: Document optional Clock and Power
>>>>>> Domain properties") documented optional clock and power-dmoain properties
>>>>>> for the ARM GIC. Currently, there are no users of these and for the
>>>>>> Tegra210 Audio GIC (based upon the GIC-400) there are two clocks, a
>>>>>> functional clock and interface clock, that need to be enabled.
>>>>>
>>>>> The reason that there are no users for this is twofold:
>>>>>    1. The GIC driver doesn't have Runtime PM support yet,
>>>>>    2. There was no clean way to prevent the GIC's clock from being disabled.
>>>>> Due to this, adding the clocks to the DTSes would mean that they will be
>>>>> disabled during boot up as unused clocks, leading to a system lock-up.
>>>>>
>>>>> I had hoped your series would fix part 1. I gave it a try on r8a7791/koelsch,
>>>>> but unfortunately it seems the platform driver only supports non-root
>>>>> controllers, while the r8a7791 GIC is the primary one...
>>>>
>>>> Can you try making the following change ...
>>>
>>> Thanks! I gave it a try, but no difference.
>>
>> I assume you added the appropriate compatible flag? Any more details you
> 
> Doh... bad assumption... Silly me.
> 
>> can share about why it is not working? Is it not registered early enough?
> 
> With
> 
> +       { .compatible = "arm,gic-400", },
> 
> the kernel no longer crashes due to accessing the GIC registers while the
> GIC module clock is disabled.
> 
> However, the system doesn't boot completely, and time outs on SPI transfers
> make me believe interrupts are not working.
> Both with and without "the following change".
> 

Is my assumption correct that you are trying to enable RPM for primary GIC controller?


If yes it may help to take a look on clocksource drivers which use early_platform_device/driver
sh_cmt.c sh_mtu2.c sh_tmu.c

The primary interrupt controller is initialized very early init_IRQ->irqchip_init->of_irq_init()
(IRQCHIP_DECLARE) and, at least as i can see from st_xxx code, the same case is valid for 
clocksource devices and it was solved using early_platform_device/drive staff.


-- 
regards,
-grygorii
