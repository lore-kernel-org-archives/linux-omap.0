From: Roger Quadros <rogerq@ti.com>
Subject: Re: [RFC PATCH 1/5] drivers : introduce device_path api
Date: Mon, 10 Dec 2012 11:48:51 +0200
Message-ID: <50C5B003.9060904@ti.com>
References: <CACVXFVNkp0+WmTyG2+YMjTvzCRi3sQZKmG6sG8diqZZj-hwg6g@mail.gmail.com> <Pine.LNX.4.44L0.1211271119380.1489-100000@iolanthe.rowland.org> <20121127170223.GB2687@kroah.com> <CABb+yY3TC3z+jRU91KGX+FKLtJ3ZXUp55-wM_KjxiYuVZ+LL+Q@mail.gmail.com> <50BF55B3.1030205@ti.com> <CABb+yY1xVMGFbedq8Wp2Muz13XAxJUKOk_=Z_UCEBkpzrtVz4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47128 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753815Ab2LJJs7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Dec 2012 04:48:59 -0500
In-Reply-To: <CABb+yY1xVMGFbedq8Wp2Muz13XAxJUKOk_=Z_UCEBkpzrtVz4A@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Ming Lei <tom.leiming@gmail.com>, Felipe Balbi <balbi@ti.com>, Andy Green <andy.green@linaro.org>, linux-omap@vger.kernel.org, keshava_mgowda@ti.com, USB list <linux-usb@vger.kernel.org>

On 12/06/2012 04:34 PM, Jassi Brar wrote:
> On Wed, Dec 5, 2012 at 7:39 PM, Roger Quadros <rogerq@ti.com> wrote:
>> Hi Jassi,
>>
>> On 12/01/2012 09:49 AM, Jassi Brar wrote:
>>> On Tue, Nov 27, 2012 at 10:32 PM, Greg KH <gregkh@linuxfoundation.o=
rg> wrote:
>>>> On Tue, Nov 27, 2012 at 11:30:11AM -0500, Alan Stern wrote:
>>>>>
>>>>> We should have a more generic solution in a more central location=
, like
>>>>> the device core.
>>>>>
>>>>> For example, each struct platform_device could have a list of res=
ources
>>>>> to be enabled when the device is bound to a driver and disabled w=
hen
>>>>> the device is unbound.  Such a list could include regulators, clo=
cks,
>>>>> and whatever else people can invent.
>>>>>
>>>>> In this case, when it is created the ehci-omap.0 platform device =
could
>>>>> get an entry pointing to the LAN95xx's regulator.  Then the regul=
ator
>>>>> would automatically be turned on when the platform device is boun=
d to
>>>>> the ehci-omap driver.
>>>>>
>>>>> How does this sound?
>>>>
>>>> That sounds much better, and it might come in handy for other type=
s of
>>>> devices than platform devices, so feel free to put this on the cor=
e
>>>> 'struct device' instead if needed.
>>>>
>>> Isn't enabling/disabling of clocks and regulators what
>>> dev.probe()/remove() of any driver already does?
>>> If we mean only board specific setup/teardown, still it would mean
>>> having the device core to do an extra 'probe' call when the current
>>> probe() is already meant to do whatever it takes to bring the devic=
e
>>> up. To my untrained eyes, it seem like messing with the
>>> probe()/remove()'s semantics.
>>>  IMHO, if we really must implement something like that, may be we
>>> should employ some 'broadcast mechanism' so that anything anywhere =
in
>>> kernel knows which new device has been probed()/removed()
>>> successfully. I haven't thought exactly how because I am not sure e=
ven
>>> that would be the right way to approach PandaBoard's problem.
>>>
>>> Looking at "Figure 15 =E2=80=93 Panda USBB1 Interface Block Diagram=
" of
>>> http://pandaboard.org/sites/default/files/board_reference/pandaboar=
d-es-b/panda-es-b-manual.pdf
>>> gives me visions ...
>>>
>>>  1) OMAP doesn't provide the USB root-hub, but only ULPIPHY. It is
>>> USB3320C chip that employs OMAP's ULPIPHY to provide the root-hub. =
So
>>> we should have a platform device for USB3320C, the probe() of which
>>> should simply
>>
>> Actually the EHCI controller within OMAP provides the root hub with =
3
>> ports but no PHY. One of them is connected to the USB3320 which is j=
ust
>> a ULPI PHY.
>>
>>>    a) Enable REFCLK (FREF_CLK3_OUT)
>>>    b) Reset itself by cycling RESETB (GPIO_62)
>>>    c) Create one "ehci-omap" platform device
>>
>> c) is not appropriate. ehci-omap must be created before usb3320.
>>
>>>  (or in appropriate order if the above isn't)
>>> That way insmod/rmmod'ing the USB3320C driver would power-up/down t=
he
>>> whole subsystem.
>>
>> Yes, this is where we can think of a generic PHY driver to make sure=
 thy
>> PHY has necessary resources enabled. In the Panda case it would be t=
he
>> PHY clock and RESET gpio.
>>
> I wonder if ehci-omap should assume, besides regulator, a clock might
> also be need to setup for the transceiver chip.
> Maybe "usbhs_bdata" in board-omap4panda.c should have
> .reset_gpio_port[0]  =3D GPIO_HUB_NRESET ?
>=20

Just like the regulator, reset_gpio_port has nothing to do with OMAP
EHCI. So we would want to get rid of that too from the OMAP USB driver.

>=20
>> The LAN95xx chip still needs to be powered up and the PHY driver isn=
't
>> the right place for that (though it could be done there as a hack). =
The
>> closest we can get to emulating right USB behavior is to map the
>> SET/CLEAR PORT_FEATURE of the root hub port to the regulator that po=
wers
>> the LAN95xx.
>>
>> This way, we still don't fall in the dynamically probed space, so we
>> could still provide the regulator information to the ehci hub via
>> platform data and handle the regulator in ehci_hub_control
>> (Set/ClearPortFeature). I'm looking at this as a software workaround=
 for
>> all platforms not implementing the EHCI set port power feature
>> correctly. The same could be repeated for other HCDs as well if requ=
ired.
>>
> IMHO it's not a matter of platforms not implementing EHCI set port
> power feature correctly, we should think about onboard devices
> connected to onboard non-root hubs. Setups like LAN9514 on Panda (HSI=
C
> too ?) that don't run on VBUS of USB, would like their local supply t=
o
> be treated as if it came from the parent hub's port  i.e, tie togethe=
r
> the USB's set port power control with their OOB regulated power suppl=
y
> (U9 on PandaBoard).
>=20

On Pandaboards we are still talking about root hub ports.

Do you know any of such platforms which power their USB devices out of
band for _non_ root hub ports?

Assuming they do exist, the only solution is to match platform data for
dynamically probed devices and deal with the regulators in the hub/port
driver. Something like Andy already proposed.

regards,
-roger
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
