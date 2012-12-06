From: Jassi Brar <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH 1/5] drivers : introduce device_path api
Date: Thu, 6 Dec 2012 20:04:03 +0530
Message-ID: <CABb+yY1xVMGFbedq8Wp2Muz13XAxJUKOk_=Z_UCEBkpzrtVz4A@mail.gmail.com>
References: <CACVXFVNkp0+WmTyG2+YMjTvzCRi3sQZKmG6sG8diqZZj-hwg6g@mail.gmail.com>
	<Pine.LNX.4.44L0.1211271119380.1489-100000@iolanthe.rowland.org>
	<20121127170223.GB2687@kroah.com>
	<CABb+yY3TC3z+jRU91KGX+FKLtJ3ZXUp55-wM_KjxiYuVZ+LL+Q@mail.gmail.com>
	<50BF55B3.1030205@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <50BF55B3.1030205-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Ming Lei <tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Andy Green <andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, keshava_mgowda-l0cyMroinI0@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Dec 5, 2012 at 7:39 PM, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> wrote:
> Hi Jassi,
>
> On 12/01/2012 09:49 AM, Jassi Brar wrote:
>> On Tue, Nov 27, 2012 at 10:32 PM, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG8Xa4x6EXUF0@public.gmane.org=
g> wrote:
>>> On Tue, Nov 27, 2012 at 11:30:11AM -0500, Alan Stern wrote:
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
>>> That sounds much better, and it might come in handy for other types=
 of
>>> devices than platform devices, so feel free to put this on the core
>>> 'struct device' instead if needed.
>>>
>> Isn't enabling/disabling of clocks and regulators what
>> dev.probe()/remove() of any driver already does?
>> If we mean only board specific setup/teardown, still it would mean
>> having the device core to do an extra 'probe' call when the current
>> probe() is already meant to do whatever it takes to bring the device
>> up. To my untrained eyes, it seem like messing with the
>> probe()/remove()'s semantics.
>>  IMHO, if we really must implement something like that, may be we
>> should employ some 'broadcast mechanism' so that anything anywhere i=
n
>> kernel knows which new device has been probed()/removed()
>> successfully. I haven't thought exactly how because I am not sure ev=
en
>> that would be the right way to approach PandaBoard's problem.
>>
>> Looking at "Figure 15 =E2=80=93 Panda USBB1 Interface Block Diagram"=
 of
>> http://pandaboard.org/sites/default/files/board_reference/pandaboard=
-es-b/panda-es-b-manual.pdf
>> gives me visions ...
>>
>>  1) OMAP doesn't provide the USB root-hub, but only ULPIPHY. It is
>> USB3320C chip that employs OMAP's ULPIPHY to provide the root-hub. S=
o
>> we should have a platform device for USB3320C, the probe() of which
>> should simply
>
> Actually the EHCI controller within OMAP provides the root hub with 3
> ports but no PHY. One of them is connected to the USB3320 which is ju=
st
> a ULPI PHY.
>
>>    a) Enable REFCLK (FREF_CLK3_OUT)
>>    b) Reset itself by cycling RESETB (GPIO_62)
>>    c) Create one "ehci-omap" platform device
>
> c) is not appropriate. ehci-omap must be created before usb3320.
>
>>  (or in appropriate order if the above isn't)
>> That way insmod/rmmod'ing the USB3320C driver would power-up/down th=
e
>> whole subsystem.
>
> Yes, this is where we can think of a generic PHY driver to make sure =
thy
> PHY has necessary resources enabled. In the Panda case it would be th=
e
> PHY clock and RESET gpio.
>
I wonder if ehci-omap should assume, besides regulator, a clock might
also be need to setup for the transceiver chip.
Maybe "usbhs_bdata" in board-omap4panda.c should have
=2Ereset_gpio_port[0]  =3D GPIO_HUB_NRESET ?


> The LAN95xx chip still needs to be powered up and the PHY driver isn'=
t
> the right place for that (though it could be done there as a hack). T=
he
> closest we can get to emulating right USB behavior is to map the
> SET/CLEAR PORT_FEATURE of the root hub port to the regulator that pow=
ers
> the LAN95xx.
>
> This way, we still don't fall in the dynamically probed space, so we
> could still provide the regulator information to the ehci hub via
> platform data and handle the regulator in ehci_hub_control
> (Set/ClearPortFeature). I'm looking at this as a software workaround =
for
> all platforms not implementing the EHCI set port power feature
> correctly. The same could be repeated for other HCDs as well if requi=
red.
>
IMHO it's not a matter of platforms not implementing EHCI set port
power feature correctly, we should think about onboard devices
connected to onboard non-root hubs. Setups like LAN9514 on Panda (HSIC
too ?) that don't run on VBUS of USB, would like their local supply to
be treated as if it came from the parent hub's port  i.e, tie together
the USB's set port power control with their OOB regulated power supply
(U9 on PandaBoard).

cheers.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
