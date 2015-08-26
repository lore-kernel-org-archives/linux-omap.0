From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: Re: CONFIG_DEBUG_SHIRQ and PM
Date: Wed, 26 Aug 2015 16:53:27 -0300
Message-ID: <CAAEAJfAPVgxhRnfYJYzebFJDRJ4Ooam6n+0B5HJ-+uLJ0exTLA@mail.gmail.com>
References: <20150825195830.GH27534@saruman.tx.rr.com>
	<CAAEAJfCY1BRuoQCWfD2pCq36E54vDB5Coy2S7rz3RfL2BVLGaw@mail.gmail.com>
	<20150826193820.GT14625@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150826193820.GT14625@saruman.tx.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Ingo Molnar <mingo@elte.hu>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 26 August 2015 at 16:38, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Wed, Aug 26, 2015 at 04:29:52PM -0300, Ezequiel Garcia wrote:
>> Felipe,
>>
>> On 25 August 2015 at 16:58, Felipe Balbi <balbi@ti.com> wrote:
>> > Hi Ingo,
>> >
>> > I'm facing an issue with CONFIG_DEBUG_SHIRQ and pm_runtime when us=
ing
>> > devm_request_*irq().
>> >
>>
>> I may be jumping on the gun here, but I believe here's your problem.
>> Using devm_request_irq with shared IRQs is not a good idea.
>>
>> Or at least, it forces you to handle interrupts after your device
>> is _completely_ removed (e.g. your IRQ cookie could be bogus).
>>
>> AFAICS, the CONFIG_DEBUG_SHIRQ option is just triggering a couple
>> spurious interrupts, that are expected to happen anyway.
>>
>> Your IRQ is shared, and so you may get any IRQ at any time,
>> coming from another device (not yours).
>>
>> So, if I'm right, my suggestion is simple: use request_irq/free_irq
>> and free your IRQ before you disable your clocks, remove your device=
,
>> etc.
>
> yeah, that's just a workaround though. Specially with IRQ flags comin=
g
> from DT, driver might have no knowledge that its IRQ is shared to sta=
rt
> with.
>

Really? Is there any way the DT can set the IRQF_SHARED flag?
The caller of devm_request_irq / request_irq needs to pass the irqflags=
,
so I'd say the driver is perfectly aware of the IRQ being shared or not=
=2E

Maybe you can clarify what I'm missing here.

> Besides, removing devm_* is just a workaround to the real problem. It
> seems, to me at least, that drivers shouldn't be calling
> pm_runtime_put_sync(); pm_runtime_disable() from their ->remove(),
> rather the bus driver should be responsible for doing so; much
> usb_bus_type and pci_bus_type do. Of course, this has the side effect=
 of
> requiring buses to make sure that by the time ->probe() is called, th=
at
> device's clocks are stable and running and the device is active.
>
> However, that's not done today for the platform_bus_type and, frankly=
,
> that would be somewhat of a complex problem to solve, considering tha=
t
> different SoCs integrate IPs the way they want.
>
> Personally, I think removing devm_* is but a workaround to the real
> thing we're dealing with.
>

I don't see any problems here: if your interrupt is shared, then you mu=
st
be prepared to handle it any time, coming from any sources (not only
your device). And CONFIG_DEBUG_SHIRQ does exactly that, in order to
make sure all the drivers passing IRQF_SHARED comply with that rule.

So you either avoid using devm_request_irq, or you prepare your handler
accordingly to be ready to handle an interrupt _any time_.

--=20
Ezequiel Garc=C3=ADa, VanguardiaSur
www.vanguardiasur.com.ar
