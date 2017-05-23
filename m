From: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: Re: [RFC 0/3] misc: new serdev based drivers for w2sg00x4 GPS module and w2cbw003 wifi/bluetooth
Date: Tue, 23 May 2017 07:43:53 +0200
Message-ID: <78B1501A-B9AD-4C6E-A481-26F647AA2BCE@goldelico.com>
References: <cover.1495363443.git.hns@goldelico.com> <CAL_Jsq+fmi2QwE7J8xv47ece1b+jqnOo99NghfjtocnrRvBkPg@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAL_Jsq+fmi2QwE7J8xv47ece1b+jqnOo99NghfjtocnrRvBkPg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Jarkko Sakkinen <jarkko.sakkinen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Discussions about the Letux Kernel <letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org>, kernel-Jl6IXVxNIMRxAtABVqVhTwC/G2K4zDHf@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Rob,

> Am 23.05.2017 um 04:26 schrieb Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>:
>=20
> On Sun, May 21, 2017 at 5:44 AM, H. Nikolaus Schaller =
<hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org> wrote:
>> Since our proposed API was not acceptable and the new serdev API has =
arrived in 4.11 kernels,
>> we finally took the challenge to update the w2sg and w2cbw drivers to =
use the serdev API.
>>=20
>> The approach is to write a "man in the middle" driver which is on one =
side a serdev client
>> which directly controls the UART where the device is connected to and =
on the other side
>> presents a new tty port so that user-space software can talk to the =
chips as if they would
>> directly talk to the UART of the SoC (e.g. ttyO1). This is similar to =
connecting to a remote
>> serial device e.g. through USB (ttyACM) or Bluetooth UART profiles.
>>=20
>> For example gpsd or hciattach expect a /dev/tty they can control =
(flow control, baud rate
>> etc.).
>=20
> I understand from the prior discussion why you want to pass the data
> thru for gps, but why do you need to do that for BT?

Because we otherwise can't turn on power when /dev/ttyBT0 is opened and =
turn off when it
is closed. I.e. it should not be powered unless someone does a hciattach =
/dev/ttyBT0. And it
should be turned off by a killall hciattach.

Basically we would like to have a power control automatic like it exists =
for many other devices.

Since the BT chip is described as a serdev by DT, we see no other means =
than to pass data
through the serdev driver.

We had looked into the line discipline approach but it makes a lot of =
problems. The first one
is that registering a new system-wide ldesc number is required. Next we =
do not see how to make
a serdev driver (as it seems to be required by the DT) to register a =
different ldesc.

>=20
>> Here is the result of our first hack which is working as a demo on =
GTA04 devices (and the
>> w2cbw driver can also be used to control a GTA04 variant with =
WL1837).
>>=20
>> Since it is just a demo hack, the code is not yet cleaned up, nor =
does it completely pass
>> check-patch, nor follows 100% the coding styles. And certainly has =
some bugs.
>>=20
>> The most significant issue is that calling tty_port_register_device() =
inside of the
>> serdev probe() function makes the serdev probe() function to be =
entered a second
>> time. This does not lead to big problems since we currently have =
minor =3D 0
>> and this makes the second call assume the device is not available.
>>=20
>> But we have no idea why this happens and how it can be prevented.
>=20
> Johan's fixes may help there, but it is intended to be temporary to
> have a separate API for registering tty ports with or without serdev.

Ah, would that mean something like a =
tty_port_register_device_without_serdev()?

Do you have a reference to his fixes?

BR and thanks,
Nikolaus

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
