From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] mfd: palmas: Add support for optional wakeup
Date: Mon, 1 Sep 2014 10:32:06 +0100
Message-ID: <20140901093206.GJ7374@lee--X1>
References: <1408457197-30487-1-git-send-email-nm@ti.com>
 <20140829105619.GH24579@lee--X1>
 <54007515.5080506@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54007515.5080506@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Mark Brown <broonie@linaro.org>, Tony Lindgren <tony@atomide.com>, Keerthy <j-keerthy@ti.com>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, 29 Aug 2014, Nishanth Menon wrote:
> On 08/29/2014 05:56 AM, Lee Jones wrote:
> > On Tue, 19 Aug 2014, Nishanth Menon wrote:
> >=20
> >> With the recent pinctrl-single changes, omaps can treat wake-up ev=
ents
> >> from deeper idle states as interrupts.
> >>
> >> Let's add support for the optional second interrupt for wake-up
> >> events. And then SoC can wakeup and handle the event using it's
> >> regular handler.
> >>
> >> Finally, to pass the wake-up interrupt in the dts file,
> >> interrupts-extended property needs to be passed.
> >>
> >> This is similar in approach to commit 2a0b965cfb6e ("serial: omap:=
 Add
> >> support for optional wake-up")
> >>
> >> Signed-off-by: Nishanth Menon <nm@ti.com>
> >> ---
> >>  Documentation/devicetree/bindings/mfd/palmas.txt |   20 ++++++++
> >=20
> > DT Ack please.

Please read Documentation/devicetree/bindings/submittingpatches.txt

> >>  drivers/mfd/palmas.c                             |   59 +++++++++=
+++++++++++++
> >>  include/linux/mfd/palmas.h                       |    2 +
> >>  3 files changed, 81 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/mfd/palmas.txt b/Do=
cumentation/devicetree/bindings/mfd/palmas.txt
> >> index eda8989..2627842 100644
> >> --- a/Documentation/devicetree/bindings/mfd/palmas.txt
> >> +++ b/Documentation/devicetree/bindings/mfd/palmas.txt
> >> @@ -51,3 +51,23 @@ palmas {
> >>  		....
> >>  	};
> >>  }
> >> +
> >> +Example: with interrupts extended
> >> + See Documentation/devicetree/bindings/interrupt-controller/inter=
rupts.txt
> >> + Use pinmux 0x418 as wakeup interrupt and gpio1_0 as interrupt so=
urce
> >> +
> >> +palmas {
> >=20
> > Should this be 'palmas@40 {'?
>=20
> I might have preferred that as well.. I kept the existing style in th=
e
> documentation. Would you like me to change existing doc style too?

Yes please.  Although you can do this subseqently.

[...]

> >> +static irqreturn_t palmas_wake_irq(int irq, void *_palmas)
> >> +{
> >> +	/*
> >> +	 * Return Not handled so that interrupt is disabled.
> >> +	 * Level event ensures that the event is eventually handled
> >> +	 * by the appropriate chip handler already registered
> >> +	 */
> >=20
> > This looks okay to me, but could do with a second opinion from some=
one
> > who is a little more familier with this kind of h/w.
> >=20
> > How does this differ from threading IRQs?
>=20
> I could try with an example:
> consider a GPIO block 7 gpio 4 connected to a pinctrl pin 234 as the
> interrupt source for palmas.
>=20
> When the system is active, the GPIO block 7, gpio 4 happily functions
> as the interrupt source. However, the SoC might not capable of
> achieving SoC wide deepsleep when GPIO block 7 is active, So we have
> to power off GPIO block 7. However on achieving low power, the system
> needs to be capable of waking backup, for this, SoC uses the hardware
> at the pin itself(TI calls it control module, others have other names=
,
> lets for the discussion, call it pinctrl), on going to sleep the
> action of enabling the pinctrl irq - enables the wakeup capability of
> the pin, and disabling it disabled the wakeup capability. when the
> wakeup event does take place, in some cases, it might be a edge event=
,
> where by the time we have recofigured GPIO block, the interrupt event
> is long gone - to support this, pinctrl invokes the driver interrupt
> handler to ensure this functions. in our case(palmas), we are level
> event and can depend on GPIO block to handle it when it is configured=
=2E
>=20
> Basically two interrupt sources when SoC is in deep sleep(1 to exit
> from deepsleep, and other from the module handling the actual event) =
-
> Example: powerbutton press OR palmas RTC wakeup OR Palmas GPIO
> generated wakeup.
>=20
> However, this is not the same as threading IRQ as the wakeup event is
> involved only during suspend path.
>=20
> commit 2a0b965cfb6e ("serial: omap: Add support for optional wake-up"=
)
>=20
> is a good reference from serial port handling perspective.

Thanks for the explanation.  This makes sense now.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
