From: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: Re: [RFC 2/3] misc: Add w2sg0004 (gps receiver) power control driver
Date: Wed, 7 Jun 2017 12:08:17 +0200
Message-ID: <8F1B0629-A5FD-4794-9A50-BA6D18C0C34C@goldelico.com>
References: <cover.1495363443.git.hns@goldelico.com> <24579fa76fbf454526fddabe0b20070e46d488ba.1495363443.git.hns@goldelico.com> <20170607073459.qg4giwqdajtmpy4n@lenoch>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170607073459.qg4giwqdajtmpy4n@lenoch>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Jarkko Sakkinen <jarkko.sakkinen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org, kernel-Jl6IXVxNIMRxAtABVqVhTwC/G2K4zDHf@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Ladislav,

> Am 07.06.2017 um 09:34 schrieb Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>:
>=20
> Dear Nikolaus,
>=20
> On Sun, May 21, 2017 at 12:44:03PM +0200, H. Nikolaus Schaller wrote:
>> Add driver for Wi2Wi W2SG0004/84 GPS module connected through uart.
>>=20
>> Use serdev API hooks to monitor and forward the UART traffic to =
/dev/BTn
>> and turn on/off the module. It also detects if the module is turned =
on (sends data)
>> but should be off, e.g. if it was already turned on during boot or =
power-on-reset.
>>=20
>> Additionally, rfkill block/unblock can be used to control an external =
LNA
>> (and power down the module if not needed).
>>=20
>> The driver concept is based on code developed by NeilBrown =
<neilb-l3A5Bk7waGM@public.gmane.org>
>> but simplified and adapted to use the new serdev API introduced in =
4.11.
> [snip]
>> diff --git =
a/Documentation/devicetree/bindings/misc/wi2wi,w2sg0004.txt =
b/Documentation/devicetree/bindings/misc/wi2wi,w2sg0004.txt
>> new file mode 100644
>> index 000000000000..b7125c7a598c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/misc/wi2wi,w2sg0004.txt
>> @@ -0,0 +1,20 @@
>> +Wi2Wi GPS module connected through UART
>> +
>> +Should be a subnode of the SoC UART it is connected to (serdev).
>> +
>> +Required properties:
>> +- compatible:	wi2wi,w2sg0004 or wi2wi,w2sg0084
>> +- on-off-gpio:	the GPIO that controls the module's on-off =
toggle input
>> +
>> +Optional properties:
>> +- lna-suppy:	an (optional) LNA regulator that is enabled =
together with the GPS receiver
>> +
>> +Example:
>> +
>> +&uart2 {
>> +	gps: w2sg0004 {
>> +		compatible =3D "wi2wi,w2sg0004";
>> +		lna-supply =3D <&vsim>;   /* LNA regulator */
>> +		on-off-gpios =3D <&gpio5 17 GPIO_ACTIVE_HIGH>;    /* =
GPIO_145: trigger for turning on/off w2sg0004 */
>> +        };
>> +};
>=20
> Here it seems is nothing specific to GPS receiver in this driver

Well, most serdev subnodes will look similar to this but still will
need different drivers (timing, pulses, other logic, special functions,
firmware download etc.).

> and
> basically UART connected GSM modules could benefit from such =
functionality
> too - as they need power supply, had reset and ignition pin and often
> status pin. See for example:
> http://simcom.ee/documents/SIM5300E/SIM5300E_Hardware_Design_V1.08.pdf
> page 14 or
> http://www.robotshop.com/media/files/pdf/datasheet-gsm-tc35.pdf
> page 19 for block diagrams.
> So I wonder if you would accept making this driver a bit more generic
> to cover also GSM modems use case.

We also have such a 2G/3G/4G module in the GTA04 and Pyra devices but =
there
we have significantly different power control needs because they are =
connected
through USB and not as UART / serdev.

But you could simply try to use and extend our proposed w2cbw003 =
bluetooth
driver [RFC 3/3] for that purpose.

It already has most of what you need: provides a user-space /dev/tty for =
the
serdev and controls some power-control gpio or regulator.

This w2sg0004 gps chip is very specific for this chip since it has no =
simple
power-enable to be controlled. This also differs too much from GSM =
modules
with ignition. Especially it has no status feedback.

Another aspect is that there are plans to have some gps infrastructure =
in the
kernel. Then, this driver wouldn't be the right solution for gsm.

Therefore it is and should remain a special purpose driver for this type =
of
gps chips.

The common denominator of all these things is the serdev and gpio =
infrastructure.

Feel free to take both drivers as blueprints to propose some new driver
for your chips.

BR,
Nikolaus

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
