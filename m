From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [RFC 0/3] misc: new serdev based drivers for w2sg00x4 GPS module and w2cbw003 wifi/bluetooth
Date: Tue, 6 Jun 2017 20:50:39 +0200
Message-ID: <5429321F-A126-446B-B679-B98B4366F7A9@goldelico.com>
References: <cover.1495363443.git.hns@goldelico.com> <CAL_Jsq+fmi2QwE7J8xv47ece1b+jqnOo99NghfjtocnrRvBkPg@mail.gmail.com> <78B1501A-B9AD-4C6E-A481-26F647AA2BCE@goldelico.com> <CAL_JsqJamBBggr9AOQtQWtZOG+FevK1XEU_D=nYL6=hyvjviVw@mail.gmail.com> <0D94BEA0-F98D-48F6-9DDC-99F932AE7834@goldelico.com> <CAL_JsqK5NxL+rHU2enW0Lo+e+HThp-iK3hpW-UxeFREbivRZOw@mail.gmail.com> <889E8F7F-FC0F-490E-B924-D04D9F4D3402@goldelico.com> <CAL_JsqLE5ANtLNQ9oQR3djEV8V8RX8Kuw_iK34_-YrpTp6+GiA@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqLE5ANtLNQ9oQR3djEV8V8RX8Kuw_iK34_-YrpTp6+GiA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Thierry Reding <treding@nvidia.com>, Jonathan Cameron <jic23@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com, Marcel Holtmann <marcel@holtmann.org>
List-Id: linux-omap@vger.kernel.org

Hi Rob,
thanks for all the comments.

> Am 25.05.2017 um 14:48 schrieb Rob Herring <robh+dt@kernel.org>:
>=20
> On Tue, May 23, 2017 at 8:49 AM, H. Nikolaus Schaller =
<hns@goldelico.com> wrote:
>> Hi Rob,
>>=20
>>> Am 23.05.2017 um 15:10 schrieb Rob Herring <robh+dt@kernel.org>:
>>>=20
>>> +Marcel
>>=20
>> Good!
>>=20
>> Hm. Well:
>>=20
>> root@letux:~# hciconfig hci0 up
>> Can't get device info: No such device
>> root@letux:~#
>>=20
>> I wonder how I can tell hciconfig about the UART port if not by =
running hciattach /dev/ttyBT0?
>=20
> You don't create a tty device. Instead you call
> hci_uart_register_device from the serdev probe.

I see. That is also brand new API in 4.12.

>=20
>>>> Or do you have a link to what you think about?
>>>=20
>>> Look at the nokia BT or TI (HCI_LL) BT drivers. Those both have f/w
>>> downloading and some GPIO controls. Given that this module is based =
on
>>> Marvell chipset, I'd expect you need to add serdev support to
>>> hci_mrvl.c.
>>=20
>> The w2cb003 has a Marvell WiFi (libertas) but a CSR Bluetooth side.
>>=20
>> It has built-in firmware and already talks serial HCI over simple =
UART right
>> after power-on. This is why our serdev driver has no firmware =
download.
>=20
> Okay, then probably add serdev support to hci_bcsp. In any case,
> hci_uart_register_device just needs to register the correct protocol.

Hm. I have tried to understand the hci_bcsp stuff but I must admit that =
we lack
quick enough understanding of such magic, to be able to add serdev =
support with
reasonable efforts. Is there a good description how hci_bcsp it works?

And I found:

	  BCSP (BlueCore Serial Protocol) is serial protocol for =
communication=20
	  between Bluetooth device and host. This protocol is required =
for non
	  USB Bluetooth devices based on CSR BlueCore chip, including =
PCMCIA and
	  CF cards.

It appears as if the w2cbw003 bluetooth is really based on a BlueCore =
chip
(there are 2 references in =
http://www.wi2wi.com/mgr/docs/W2CBW003_Datasheet_Rev1.8.pdf ).

Therefore it might be possible to use BCSP but that are completely new =
horizons.
But so far we have simply used "hciattach any" mode for years.

We also know that the Gumstix Storm uses the same w2cbw wifi/bluetooth =
combo
(omap3-overo-base.dtsi) but there also appears to be no BCSP support in =
the kernel.

BTW: it looks as if they simply turn on bluetooth as soon as WiFi is =
configured up. So they
could be interested in a more precise power management driver like what =
we propose.

Maybe someone who owns an older Gumstix with the same chip (they were =
phased out in 2015
and replaced by TI modules) can help or jump into this discussion.

Thanks and BR,
Nikolaus=
