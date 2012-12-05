From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC PATCH 1/5] drivers : introduce device_path api
Date: Wed, 5 Dec 2012 16:09:55 +0200
Message-ID: <50BF55B3.1030205@ti.com>
References: <CACVXFVNkp0+WmTyG2+YMjTvzCRi3sQZKmG6sG8diqZZj-hwg6g@mail.gmail.com> <Pine.LNX.4.44L0.1211271119380.1489-100000@iolanthe.rowland.org> <20121127170223.GB2687@kroah.com> <CABb+yY3TC3z+jRU91KGX+FKLtJ3ZXUp55-wM_KjxiYuVZ+LL+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CABb+yY3TC3z+jRU91KGX+FKLtJ3ZXUp55-wM_KjxiYuVZ+LL+Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jassi Brar <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Ming Lei <tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Andy Green <andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, keshava_mgowda-l0cyMroinI0@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Jassi,

On 12/01/2012 09:49 AM, Jassi Brar wrote:
> On Tue, Nov 27, 2012 at 10:32 PM, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org=
> wrote:
>> On Tue, Nov 27, 2012 at 11:30:11AM -0500, Alan Stern wrote:
>>>
>>> We should have a more generic solution in a more central location, =
like
>>> the device core.
>>>
>>> For example, each struct platform_device could have a list of resou=
rces
>>> to be enabled when the device is bound to a driver and disabled whe=
n
>>> the device is unbound.  Such a list could include regulators, clock=
s,
>>> and whatever else people can invent.
>>>
>>> In this case, when it is created the ehci-omap.0 platform device co=
uld
>>> get an entry pointing to the LAN95xx's regulator.  Then the regulat=
or
>>> would automatically be turned on when the platform device is bound =
to
>>> the ehci-omap driver.
>>>
>>> How does this sound?
>>
>> That sounds much better, and it might come in handy for other types =
of
>> devices than platform devices, so feel free to put this on the core
>> 'struct device' instead if needed.
>>
> Isn't enabling/disabling of clocks and regulators what
> dev.probe()/remove() of any driver already does?
> If we mean only board specific setup/teardown, still it would mean
> having the device core to do an extra 'probe' call when the current
> probe() is already meant to do whatever it takes to bring the device
> up. To my untrained eyes, it seem like messing with the
> probe()/remove()'s semantics.
>  IMHO, if we really must implement something like that, may be we
> should employ some 'broadcast mechanism' so that anything anywhere in
> kernel knows which new device has been probed()/removed()
> successfully. I haven't thought exactly how because I am not sure eve=
n
> that would be the right way to approach PandaBoard's problem.
>=20
> Looking at "Figure 15 =E2=80=93 Panda USBB1 Interface Block Diagram" =
of
> http://pandaboard.org/sites/default/files/board_reference/pandaboard-=
es-b/panda-es-b-manual.pdf
> gives me visions ...
>=20
>  1) OMAP doesn't provide the USB root-hub, but only ULPIPHY. It is
> USB3320C chip that employs OMAP's ULPIPHY to provide the root-hub. So
> we should have a platform device for USB3320C, the probe() of which
> should simply

Actually the EHCI controller within OMAP provides the root hub with 3
ports but no PHY. One of them is connected to the USB3320 which is just
a ULPI PHY.

>    a) Enable REFCLK (FREF_CLK3_OUT)
>    b) Reset itself by cycling RESETB (GPIO_62)
>    c) Create one "ehci-omap" platform device

c) is not appropriate. ehci-omap must be created before usb3320.

>  (or in appropriate order if the above isn't)
> That way insmod/rmmod'ing the USB3320C driver would power-up/down the
> whole subsystem.

Yes, this is where we can think of a generic PHY driver to make sure th=
y
PHY has necessary resources enabled. In the Panda case it would be the
PHY clock and RESET gpio.

The LAN95xx chip still needs to be powered up and the PHY driver isn't
the right place for that (though it could be done there as a hack). The
closest we can get to emulating right USB behavior is to map the
SET/CLEAR PORT_FEATURE of the root hub port to the regulator that power=
s
the LAN95xx.

This way, we still don't fall in the dynamically probed space, so we
could still provide the regulator information to the ehci hub via
platform data and handle the regulator in ehci_hub_control
(Set/ClearPortFeature). I'm looking at this as a software workaround fo=
r
all platforms not implementing the EHCI set port power feature
correctly. The same could be repeated for other HCDs as well if require=
d.

cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
