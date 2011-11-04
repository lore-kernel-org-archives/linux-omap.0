From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v3 2/4] regulator: adapt fixed regulator driver to dt
Date: Fri, 4 Nov 2011 15:09:32 -0700
Message-ID: <CAOesGMh-fpUSMvOGkq_b4DVzFUby6pnMmKDXQ=sFJpn+g4FzOw@mail.gmail.com>
References: <1319702185-16108-1-git-send-email-rnayak@ti.com>
	<1319702185-16108-3-git-send-email-rnayak@ti.com>
	<20111104203422.GB3918@quad.lixom.net>
	<20111104210151.GA2541@opensource.wolfsonmicro.com>
	<20111104211824.GA5608@quad.lixom.net>
	<20111104212538.GA8266@opensource.wolfsonmicro.com>
	<CAOesGMh2_C+yx=_5PjqoKxZmAMvx-puRjq45s+G2kz2EaEEtqw@mail.gmail.com>
	<20111104215733.GD8266@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111104215733.GD8266@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Rajendra Nayak <rnayak@ti.com>, grant.likely@secretlab.ca, patches@linaro.org, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Fri, Nov 4, 2011 at 2:57 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Fri, Nov 04, 2011 at 02:47:05PM -0700, Olof Johansson wrote:
>> On Fri, Nov 4, 2011 at 2:25 PM, Mark Brown
>
>> > I don't see how you can usefully do that, the task of plumbing a
>> > regulator into a board is largely orthogonal to the specific featu=
re set
>> > of a given regulator. =A0The specific bindings for a fixed voltage
>> > regulator would be useful or unhelpful for most regultors controll=
ed via
>> > I2C.
>
>> I meant more that the fixed regulators should reuse as much as
>> possible from the generic regulator bindings, instead of completely
>> forking them.
>
> That appears to be what's going on? =A0The fixed voltage regulator
> includes by reference the core regulator binding, all of the properti=
es
> it defines with the possible exception of the supply name are not
> covered in the core binding.

The fixed-regulator binding makes no reference to the generic binding,
and the example includes no properties that are defined in that one.
So I definitely did not make that conclusion based on what I saw.

>> Then, depending on how they are controlled, there will be more
>> specific bindings. So the case of a gpio-controlled fixed regulator
>> would have a binding where the format of the properties to find the
>> gpio, etc, would be described. But things like voltage (without a
>> range, obviously) would be using the same bindings as the other
>> regulators.
>
> The only overlap I'm seeing is the voltage?
>
> The intended semantic for the voltage is rather different. =A0The cor=
e
> binding for the voltage specifies the range of voltages it is possibl=
e
> to set a regulator to on a given board and is used to give permission=
 to
> the system to reconfigure the regulator. =A0The binding here tells th=
e
> system what voltage a fixed voltage regulator is running at. =A0We co=
uld
> have the fixed voltage regulator read the same binding - though there=
's
> some risk of mild confusion it shouldn't be too bad.

Yeah, voltage is the obvious one where fixed would have a max and min
that is the same when you have a fixed regulator.

But even things like allowing (optional) attributes such as
startup-delay on non-fixed regulators could make sense. Keep in mind
that the device tree should focus on describing the hardware, not just
what the linux driver needs from it. So maybe instead of
startup-delay, specifying ramp-up speed instead of time needed until
power is good could be the way to go there.


-Olof
