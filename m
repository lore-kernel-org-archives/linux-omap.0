From: Jassi Brar <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH 1/5] drivers : introduce device_path api
Date: Sat, 1 Dec 2012 23:38:27 +0530
Message-ID: <CABb+yY11bc2dwTwf8K6Uj-XvHBc3uSTqiv4K2WC4gCktZk0kBg@mail.gmail.com>
References: <CACVXFVNkp0+WmTyG2+YMjTvzCRi3sQZKmG6sG8diqZZj-hwg6g@mail.gmail.com>
	<Pine.LNX.4.44L0.1211271119380.1489-100000@iolanthe.rowland.org>
	<20121127170223.GB2687@kroah.com>
	<CABb+yY3TC3z+jRU91KGX+FKLtJ3ZXUp55-wM_KjxiYuVZ+LL+Q@mail.gmail.com>
	<50B9C1B0.3080605@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <50B9C1B0.3080605-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Green <andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Ming Lei <tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, keshava_mgowda-l0cyMroinI0@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, rogerq-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Sat, Dec 1, 2012 at 2:07 PM, Andy Green <andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrot=
e:
> On 12/01/2012 03:49 PM, the mail apparently from Jassi Brar included:
>
>> On Tue, Nov 27, 2012 at 10:32 PM, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG8Xa4x6EXUF0@public.gmane.org=
g>
>> wrote:
>>>
>>> On Tue, Nov 27, 2012 at 11:30:11AM -0500, Alan Stern wrote:
>>>>
>>>>
>>>> We should have a more generic solution in a more central location,=
 like
>>>> the device core.
>>>>
>>>> For example, each struct platform_device could have a list of reso=
urces
>>>> to be enabled when the device is bound to a driver and disabled wh=
en
>>>> the device is unbound.  Such a list could include regulators, cloc=
ks,
>>>> and whatever else people can invent.
>>>>
>>>> In this case, when it is created the ehci-omap.0 platform device c=
ould
>>>> get an entry pointing to the LAN95xx's regulator.  Then the regula=
tor
>>>> would automatically be turned on when the platform device is bound=
 to
>>>> the ehci-omap driver.
>>>>
>>>> How does this sound?
>>>
>>>
>>> That sounds much better, and it might come in handy for other types=
 of
>>> devices than platform devices, so feel free to put this on the core
>>> 'struct device' instead if needed.
>>>
>> Isn't enabling/disabling of clocks and regulators what
>> dev.probe()/remove() of any driver already does?
>
>
> The particular issue this tries to address is stuff that is not part =
of the
> generic driver function, but which is tied to the device instance by
> hardware connection choices on the physical platform.  External clock=
s,
> regulators and mux settings needed to make the device instance work o=
n the
> board may all be out of scope for the generic driver, even when the g=
eneric
> driver has a SoC-specific part as in this case.
>
> So no, enabling regulators, clock and mux it has no idea about becaus=
e the
> dependency only exists as a board feature is not the job of probe / r=
emove
> in drivers already.
>
Yeah, I called that "board specific setup/teardown". Which is quite
common in ASoC, where an soc has an I2S controller which itself
doesn't do much without some third party CODEC chip onboard which has
board specific OOB control. The CODEC setup usually involves
occasional PLL configuring besides setting reference clock(s) and
regulator supplies.

>
>> If we mean only board specific setup/teardown, still it would mean
>> having the device core to do an extra 'probe' call when the current
>> probe() is already meant to do whatever it takes to bring the device
>> up. To my untrained eyes, it seem like messing with the
>> probe()/remove()'s semantics.
>
>
> It's in the way of automating and simplifying code that would be repe=
ated in
> each driver probe routine according to what you're suggesting.  In fa=
ct the
> pre-probe activity happens at the start of the actual probe code, and=
 post
> remove at the end of the actual remove, there is no duplicated activi=
ty.
> It's just a helper.
>
I am not calling that code duplication. Just that device core
shouldn't be bothered to first setup board specific stuff and then
platform/soc specific stuff. Esp when both calls would be contiguous.
dev.probe() should simply get things up and running.

>
>>   IMHO, if we really must implement something like that, may be we
>> should employ some 'broadcast mechanism' so that anything anywhere i=
n
>> kernel knows which new device has been probed()/removed()
>> successfully. I haven't thought exactly how because I am not sure ev=
en
>> that would be the right way to approach PandaBoard's problem.
>
>
> I think this stuff is a bit more multifacted than you're giving it cr=
edit
> for, and indeed this thread has gone right into this aspect.  Say we =
hooked
> to a device creation notifier, we still must identify the correct dev=
ice, in
> the case the device is on a dynamic bus.  Hence the discussion about =
device
> paths.  Just throwing a notifier at it itself doesn't scratch the pro=
blem.
> The stuff I completed yesterday does solve this dynamic matching issu=
e
> inexpensively.
>
Maybe your try#2 will brainwash me to fall in line :)

>
>> Looking at "Figure 15 =E2=80=93 Panda USBB1 Interface Block Diagram"=
 of
>>
>> http://pandaboard.org/sites/default/files/board_reference/pandaboard=
-es-b/panda-es-b-manual.pdf
>> gives me visions ...
>>
>>   1) OMAP doesn't provide the USB root-hub, but only ULPIPHY. It is
>> USB3320C chip that employs OMAP's ULPIPHY to provide the root-hub. S=
o
>> we should have a platform device for USB3320C, the probe() of which
>> should simply
>>     a) Enable REFCLK (FREF_CLK3_OUT)
>>     b) Reset itself by cycling RESETB (GPIO_62)
>>     c) Create one "ehci-omap" platform device
>>   (or in appropriate order if the above isn't)
>> That way insmod/rmmod'ing the USB3320C driver would power-up/down th=
e
>> whole subsystem.
>
>
> First there's the issue that Panda has the same signal to reset the U=
LPI PHY
> and the SMSC device, and that we must operate that reset after poweri=
ng the
> SMSC device.  The only nice way to do that is to arrange for the rese=
t to
> happen once for both, at a time after the SMSC chip is powered, so we=
 have
> no need to interrupt ULPI operation or touch the reset subsequently, =
until
> next powerup of the ULPI PHY + SMSC.
>
> That is why tying "foreign-to-the-generic-driver" assets to a device
> instantiation can get us out of the hole, even when we want a hub por=
t
> device that is impossible to have as a platform_device to control the=
 power
> and clock for the SMSC device.
>
> With Panda just trying to cleanly deal with ULPI reset in ULPI driver=
 and
> SMSC reset in SMSC driver (how're you going to let that dynamically c=
reated
> smsc device know the gpio again?) are complicated by both getting res=
et by
> the same signal.
>
Well, Panda has exactly one device (SMSC's hub) _hardwired_ to the
root-hub port (USB3320C). So does it really matter if we reset the
SMSC device and the ULPI-PHY gets reset too or vice-versa?

> Second, the choices of Panda about providing a refclock and reset to =
the
> ULPI PHY are not SoC level choices but board level ones.
>
Of course and that's why I said let USB3320C (board specific) get its
clock and reset line and then in probe() populate a device for
ULPI-PHY (SoC specific)

>
>> 2) Just like the user has to manually power-on/off any externally
>> powered hub connected to a PC, maybe we should implement a user
>> controlled 'soft' switch (reacting to UDEV events from ehci-omap?) t=
o
>> emulate LAN9514 power-on/off. I do realize it would be cool to have =
it
>> automatically toggle in kernel when we (de)power the hub but isn't
>> that outside of scope of Linux USB implementation?
>>
>> The above solution isn't most optimal for Panda but it seems a desig=
n
>> more consistent with what we already have. Or so do I think.
>
>
> Not sure why you think that's out of scope for USB when USB allows hu=
bs to
> control port power.
>
I meant there is nothing in USB that switches on external power supply
of a connected device.
LAN9514 is not bus powered and USB subsystem doesn't manage OOB signali=
ng.

regards.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
