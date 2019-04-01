From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [BUG/PATCH 1/4] DTS: GTA04: SPI / gpiolib: work around a regression that unhides a broken legacy handler, which makes the gta04 display inoperable
Date: Mon, 1 Apr 2019 18:56:51 +0200
Message-ID: <06C7464E-FAF2-4AA6-9FF4-629E9C97F86A@goldelico.com>
References: <cover.1554026842.git.hns@goldelico.com> <e8d784f7fb06fd3a6a92bc730f919352c4ad4411.1554026842.git.hns@goldelico.com> <20190401164617.GH49658@atomide.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190401164617.GH49658@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, letux-kernel@openphoenux.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,

> Am 01.04.2019 um 18:46 schrieb Tony Lindgren <tony@atomide.com>:
>=20
> Hi,
>=20
> * H. Nikolaus Schaller <hns@goldelico.com> [190331 10:08]:
>> This is an ugly workaround for a regression introduced into v5.1-rc1 =
by
>>=20
>> <c1c04cea13dc234ce9a4504879ddd36ea524d880>
>=20
> You should standardized commit references like this instead:
>=20
> c1c04cea13dc ("gpio: of: Fix logic inversion")
>=20
> Then please also include a proper Fixes tag.
>=20
> You can configure an alias for it to make things easier:
>=20
> git log --abbrev=3D12 --pretty=3Dformat:"%h (\"%s\")"
>=20
>> --- a/arch/arm/boot/dts/omap3-gta04.dtsi
>> +++ b/arch/arm/boot/dts/omap3-gta04.dtsi
>> @@ -114,6 +114,7 @@
>> 		gpio-miso =3D <&gpio1 18 GPIO_ACTIVE_HIGH>;
>> 		gpio-mosi =3D <&gpio1 20 GPIO_ACTIVE_HIGH>;
>> 		cs-gpios =3D <&gpio1 19 GPIO_ACTIVE_HIGH>;
>> +		spi-cs-high;	/* make the legacy handler in gpiolib =
not intervene */
>> 		num-chipselects =3D <1>;
>>=20
>> 		/* lcd panel */
>> @@ -123,6 +124,7 @@
>> 			spi-max-frequency =3D <100000>;
>> 			spi-cpol;
>> 			spi-cpha;
>> +			spi-cs-high;	/* here is where it should be =
but this is ignored by a bug in the gpiolib handler */
>>=20
>> 			backlight=3D <&backlight>;
>> 			label =3D "lcd";
>=20
> So what's the plan with this fix? Add this for v5.2-rc cycle,
> then revert it later? I'd probably go directly for the proper
> fix if possible.

Well, I learned just some minutes ago that a new patch for gpiolib
came through 5.1-rc3 which does fix this.

It seems to check for "cs-gpios" and then disable the legacy handling.

This means that we do not need to patch the DTS at all.

BR and thanks,
Nikolaus
