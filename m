From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [RFC 0/3] misc: new serdev based drivers for w2sg00x4 GPS module and w2cbw003 wifi/bluetooth
Date: Tue, 23 May 2017 15:49:17 +0200
Message-ID: <889E8F7F-FC0F-490E-B924-D04D9F4D3402@goldelico.com>
References: <cover.1495363443.git.hns@goldelico.com> <CAL_Jsq+fmi2QwE7J8xv47ece1b+jqnOo99NghfjtocnrRvBkPg@mail.gmail.com> <78B1501A-B9AD-4C6E-A481-26F647AA2BCE@goldelico.com> <CAL_JsqJamBBggr9AOQtQWtZOG+FevK1XEU_D=nYL6=hyvjviVw@mail.gmail.com> <0D94BEA0-F98D-48F6-9DDC-99F932AE7834@goldelico.com> <CAL_JsqK5NxL+rHU2enW0Lo+e+HThp-iK3hpW-UxeFREbivRZOw@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqK5NxL+rHU2enW0Lo+e+HThp-iK3hpW-UxeFREbivRZOw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Thierry Reding <treding@nvidia.com>, Jonathan Cameron <jic23@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com, Marcel Holtmann <marcel@holtmann.org>
List-Id: linux-omap@vger.kernel.org

Hi Rob,

> Am 23.05.2017 um 15:10 schrieb Rob Herring <robh+dt@kernel.org>:
>=20
> +Marcel

Good!

>=20
> On Tue, May 23, 2017 at 7:48 AM, H. Nikolaus Schaller =
<hns@goldelico.com> wrote:
>> Hi Rob,
>>=20
>>> Am 23.05.2017 um 14:28 schrieb Rob Herring <robh+dt@kernel.org>:
>>>=20
>>> On Tue, May 23, 2017 at 12:43 AM, H. Nikolaus Schaller
>>> <hns@goldelico.com> wrote:
>>>> Hi Rob,
>>>>=20
>>>>> Am 23.05.2017 um 04:26 schrieb Rob Herring <robh+dt@kernel.org>:
>>>>>=20
>>>>> On Sun, May 21, 2017 at 5:44 AM, H. Nikolaus Schaller =
<hns@goldelico.com> wrote:
>>>>>> Since our proposed API was not acceptable and the new serdev API =
has arrived in 4.11 kernels,
>>>>>> we finally took the challenge to update the w2sg and w2cbw =
drivers to use the serdev API.
>>>>>>=20
>>>>>> The approach is to write a "man in the middle" driver which is on =
one side a serdev client
>>>>>> which directly controls the UART where the device is connected to =
and on the other side
>>>>>> presents a new tty port so that user-space software can talk to =
the chips as if they would
>>>>>> directly talk to the UART of the SoC (e.g. ttyO1). This is =
similar to connecting to a remote
>>>>>> serial device e.g. through USB (ttyACM) or Bluetooth UART =
profiles.
>>>>>>=20
>>>>>> For example gpsd or hciattach expect a /dev/tty they can control =
(flow control, baud rate
>>>>>> etc.).
>>>>>=20
>>>>> I understand from the prior discussion why you want to pass the =
data
>>>>> thru for gps, but why do you need to do that for BT?
>>>>=20
>>>> Because we otherwise can't turn on power when /dev/ttyBT0 is opened =
and turn off when it
>>>> is closed. I.e. it should not be powered unless someone does a =
hciattach /dev/ttyBT0. And it
>>>> should be turned off by a killall hciattach.
>>>=20
>>> Still, you can do power control within BT HCI drivers.
>>=20
>> We do not use any driver for bluetooth. We just start hciattach on =
demand.
>> And afaik there is no plugin mechanism for adding power control to =
hciattach.
>=20
> You don't need hciattach. All userspace has to do for kernel BT
> drivers is "hciconfig hci0 up|down".

Hm. Well:

root@letux:~# hciconfig hci0 up
Can't get device info: No such device
root@letux:~#

I wonder how I can tell hciconfig about the UART port if not by running =
hciattach /dev/ttyBT0?

>=20
>> Or do you have a link to what you think about?
>=20
> Look at the nokia BT or TI (HCI_LL) BT drivers. Those both have f/w
> downloading and some GPIO controls. Given that this module is based on
> Marvell chipset, I'd expect you need to add serdev support to
> hci_mrvl.c.

The w2cb003 has a Marvell WiFi (libertas) but a CSR Bluetooth side.

It has built-in firmware and already talks serial HCI over simple UART =
right
after power-on. This is why our serdev driver has no firmware download.

>=20
>>> You wouldn't be
>>> limited to just open/close, but can handle suspend/resume as well.
>>=20
>> Well, it does not look as if we need more than open/close since =
suspend/resume
>> is already handled by the regulator driver. We just need to keep it =
powered off
>> if there is no user-space client.
>=20
> Okay.
>=20
> Rob

BR,
Nikolaus
