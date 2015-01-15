From: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH 1/3] input: tsc2007: Add pre-calibration, flipping and rotation
Date: Thu, 15 Jan 2015 17:14:38 +0100
Message-ID: <8B08216C-13DD-40D8-9BA9-060F1C18A018@goldelico.com>
References: <1412108254-19234-1-git-send-email-marek@goldelico.com> <1412108254-19234-2-git-send-email-marek@goldelico.com> <CAAfyv36bD9ZratOzr7FkeQde8k-K9XjEjH9gkntm9qewD-cH9g@mail.gmail.com> <20150115005938.GB9134@dtor-ws> <0F9A17C1-9B01-4EE9-BE98-266B8FC02B84@goldelico.com> <20150115143855.GD512@earth.universe>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150115143855.GD512@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Belisko Marek <marek.belisko@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-input@vger.kernel.org, Marek Belisko <marek@goldelico.com>, Jonathan Richardson <jonathar@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Yoichi Yuasa <yuasa@linux-mips.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, List
List-Id: linux-omap@vger.kernel.org


Am 15.01.2015 um 15:38 schrieb Sebastian Reichel <sre@kernel.org>:

> Hi,
>=20
> On Thu, Jan 15, 2015 at 08:36:44AM +0100, Dr. H. Nikolaus Schaller wr=
ote:
>>> 1. Perform conversion in input core rather than individual drivers.=
 I
>>> think we should allocate a new bitmaps for some transformations and=
 have
>>> the code do X/Y flip/clip of the coordinates.
>>=20
>> Do you have a suggestion where this should be (I have no clue how
>> the input system works or is structured - we just know how to extend=
 a
>> driver that uses it)?
>>=20
>>> 2. Standardize on bindings. We already have of-touchscreen.c doing
>>> rudimentary parsing, we shoudl look into extending it rather than
>>> creating myriad of driver-specific bindings.
>>=20
>> Ok, looks reasonable.
>=20
> Documentation is in=20
>=20
> Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt

I did look into it now. Unfortunately, it does not fit well into my vie=
w of how bindings
should be. They should describe hardware (as we are told for many other=
 kernel
subsystems).

Pixels and resolutions are IMHO related to the screen it is glued on - =
and that is
quite independent.

So I don=92t see how they do describe the different ways the touch scre=
en can be
wired to a tsc2007 controller.

Please can you add minimum and maximum properties for us?

Then, inverted-x and inverted-y is redundant because it is the same as =
having
an expected higher value from the ADC for the minimum coordinate and a =
lower
for the maximum.

>=20
>>> Also, do we need swap and flip or do we simply need rotation (like =
the
>>> proposed Broadcom iproc driver has)?
>>=20
>> Well, since the DT should describe hardware, there are 3 sets of wir=
es which
>> can have a cross-over: X+ and X-, Y+ and Y-, X and Y.
>>=20
>> So IMHO hardware has no =93rotation=94, just crossover of wires. Rot=
ation is an
>> interpretation of the result of these connections in combination wit=
h some
>> panel the touch is glued to and should therefore not be represented =
in the DT.
>>=20
>> As a result we have proposed a scheme without explicit rotation. We =
specify what
>> coordinates X- and X+ should report at their ends (min, max) because=
 the DT
>> programmer has to specify them anyways. Flipping is a result of defi=
ning these
>> coordinates in an ascending or descending way. Only swapping of the =
X and Y
>> wires can=92t be implicitly defined so it has its own property. So t=
he scheme we
>> have proposed tries to optimize the efforts needed to adapt new boar=
ds and write
>> DTs and focus the DT on hardware description.
>>=20
>> As a bonus we also specify the min and max value to be reported for =
the touch
>> pressure (Z axis) using the same basic principle.
>>=20
>> And it is a pure add-on on top of the existing driver so that it att=
empts not
>> to break existing device trees.
>=20
> from what I can see there are no in-tree-users using any of the
> new properties.
>=20
>> Maybe could you accept it as a first step for this specific driver (=
and let=92s do
>> the big standardization work later on)?
>=20
> That does not work, since you create an ABI.
>=20
> -- Sebastian
