From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [RFC 2/3] misc: Add w2sg0004 (gps receiver) power control driver
Date: Tue, 6 Jun 2017 20:50:28 +0200
Message-ID: <0A8889BB-8238-42C9-9F35-879F0677B403@goldelico.com>
References: <cover.1495363443.git.hns@goldelico.com> <24579fa76fbf454526fddabe0b20070e46d488ba.1495363443.git.hns@goldelico.com> <20170530230903.jrg6ui5xiqfhqyfg@rob-hp-laptop>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170530230903.jrg6ui5xiqfhqyfg@rob-hp-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Thierry Reding <treding@nvidia.com>, Jonathan Cameron <jic23@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com
List-Id: linux-omap@vger.kernel.org


> Am 31.05.2017 um 01:09 schrieb Rob Herring <robh@kernel.org>:
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
<neilb@suse.de>
>> but simplified and adapted to use the new serdev API introduced in =
4.11.
>>=20
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> ---
>> .../devicetree/bindings/misc/wi2wi,w2sg0004.txt    |  20 +
>> .../devicetree/bindings/vendor-prefixes.txt        |   1 +
>=20
> Please split binding patches.

Yes, will do.

We thought that it gives better understanding if kept together with the =
code in a single patch for this RFC.

>=20
>> drivers/misc/Kconfig                               |  16 +
>> drivers/misc/Makefile                              |   1 +
>> drivers/misc/w2sg0004.c                            | 646 =
+++++++++++++++++++++
>> include/linux/w2sg0004.h                           |  27 +
>> 6 files changed, 711 insertions(+)
>> create mode 100644 =
Documentation/devicetree/bindings/misc/wi2wi,w2sg0004.txt
>> create mode 100644 drivers/misc/w2sg0004.c
>> create mode 100644 include/linux/w2sg0004.h
>>=20
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
>=20
> Reformat to one per line.

Ok.

>=20
>> +- on-off-gpio:	the GPIO that controls the module's on-off =
toggle input
>=20
> Does enable-gpios or powerdown-gpios work as those are semi-standard=20=

> names. Also, need to state the active state.

Ok.

>=20
>> +
>> +Optional properties:
>> +- lna-suppy:	an (optional) LNA regulator that is enabled =
together with the GPS receiver
>=20
> typo

tnx :)

>=20
>> +
>> +Example:
>> +
>> +&uart2 {
>> +	gps: w2sg0004 {
>=20
> w2sg0004: gps {
>=20
> The node name should be generic. The label can be whatever you like.

Ok. That comes from thoughtless copying very old stuff (I think we =
started with trying to get this chip DT based around 3.14 kernels...)

>=20
>> +		compatible =3D "wi2wi,w2sg0004";
>> +		lna-supply =3D <&vsim>;   /* LNA regulator */
>> +		on-off-gpios =3D <&gpio5 17 GPIO_ACTIVE_HIGH>;    /* =
GPIO_145: trigger for turning on/off w2sg0004 */
>> +        };
>> +};
>> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt =
b/Documentation/devicetree/bindings/vendor-prefixes.txt
>> index c03d20140366..c56b3181b266 100644
>> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
>> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
>> @@ -345,6 +345,7 @@ voipac	Voipac Technologies s.r.o.
>> wd	Western Digital Corp.
>> wetek	WeTek Electronics, limited.
>> wexler	Wexler
>> +wi2wi	Wi2Wi, Inc.
>> winbond Winbond Electronics corp.
>> winstar	Winstar Display Corp.
>> wlf	Wolfson Microelectronics
