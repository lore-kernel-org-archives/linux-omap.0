From: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH 1/3] input: tsc2007: Add pre-calibration, flipping and rotation
Date: Thu, 15 Jan 2015 08:36:44 +0100
Message-ID: <0F9A17C1-9B01-4EE9-BE98-266B8FC02B84@goldelico.com>
References: <1412108254-19234-1-git-send-email-marek@goldelico.com> <1412108254-19234-2-git-send-email-marek@goldelico.com> <CAAfyv36bD9ZratOzr7FkeQde8k-K9XjEjH9gkntm9qewD-cH9g@mail.gmail.com> <20150115005938.GB9134@dtor-ws>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20150115005938.GB9134@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Belisko Marek <marek.belisko@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-input@vger.kernel.org, Marek Belisko <marek@goldelico.com>, Jonathan Richardson <jonathar@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Yoichi Yuasa <yuasa@linux-mips.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, List for communicating with real GTA04 owners <gta04-owne>
List-Id: linux-omap@vger.kernel.org

Hi,

Am 15.01.2015 um 01:59 schrieb Dmitry Torokhov <dmitry.torokhov@gmail.c=
om>:

> On Sat, Jan 10, 2015 at 03:15:39PM +0100, Belisko Marek wrote:
>> Ping for input maintainer. DT changes was acked. Thanks.
>>=20
>> On Tue, Sep 30, 2014 at 10:17 PM, Marek Belisko <marek@goldelico.com=
> wrote:
>>> This patch adds new parameters that allow to address typical hardwa=
re
>>> design differences: touch screens may be wired or oriented differen=
tly
>>> (portrait or landscape). And usually the active area of the touch i=
s a
>>> little larger than the active area of the LCD. This results in the =
touch
>>> coordinates that have some significant deviation from LCD coordinat=
es.
>>> Usually this is addressed in user space by a calibration tool (e.g.=
 tslib
>>> or xinput-calibrator) but some systems don't have these tools or re=
quire
>>> that the screen is already roughly calibrated (e.g. Replicant) to o=
perate
>>> the device until a better calibration can be done. And, some system=
s
>>> react very strangely if the touch event stream reports coordinates
>>> outside of the active area.
>>>=20
>>> This makes it necessry to be able to configure:
>>> 1. swapping x and y wires (coordinate values)
>>> 2. flipping of x (left - right) or y (top - bottom) or even both
>>> 3. define an active area so that an uncalibrated screen already
>>> roughly matches the LCD to be useful.
>>> 4. clip reported coordinates to the active area.
>>>=20
>>> If none of the new parameters is defined (in DT) or set in a board =
file,
>>> the driver behaves the same as without this patch.
>>>=20
>>> Author (1&2): H. Nikolaus Schaller <hns@goldelico.com>
>>> Author (3&4): Paul Kocialkowski <contact@paulk.fr>
>>>=20
>>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>=20
> OK, I was hesitant of adding these as normally we have tslib to perfo=
rm
> the conversion, but maybe it is time to allow it in the kernel and
> standardize users.

Well, tslib isn=92t a good replacement for this problem any more and
pre-initializing tslib makes some deep hardware dependency visible
in user space (each board needs a different tslib config and pointercal
default - and on some user spaces tslib is broken with Xorg).

But the issue to be solved is more hardware related, i.e. if the Y- and=
 Y+
pins of the controller are connected in a swapped way to the resistor
ends of the panel.

Hence in a DT based system, this must IMHO be described by the DT
and can not be left to some user-space functions any more.

> However, this seems like a general issue and we
> should:
>=20
> 1. Perform conversion in input core rather than individual drivers. I
> think we should allocate a new bitmaps for some transformations and h=
ave
> the code do X/Y flip/clip of the coordinates.

Do you have a suggestion where this should be (I have no clue how
the input system works or is structured - we just know how to extend a
driver that uses it)?

>=20
> 2. Standardize on bindings. We already have of-touchscreen.c doing
> rudimentary parsing, we shoudl look into extending it rather than
> creating myriad of driver-specific bindings.

Ok, looks reasonable.

>=20
> Also, do we need swap and flip or do we simply need rotation (like th=
e
> proposed Broadcom iproc driver has)?

Well, since the DT should describe hardware, there are 3 sets of wires =
which
can have a cross-over: X+ and X-, Y+ and Y-, X and Y.

So IMHO hardware has no =93rotation=94, just crossover of wires. Rotati=
on is an
interpretation of the result of these connections in combination with s=
ome
panel the touch is glued to and should therefore not be represented in =
the DT.

As a result we have proposed a scheme without explicit rotation. We spe=
cify what
coordinates X- and X+ should report at their ends (min, max) because th=
e DT
programmer has to specify them anyways. Flipping is a result of definin=
g these
coordinates in an ascending or descending way. Only swapping of the X a=
nd Y
wires can=92t be implicitly defined so it has its own property. So the =
scheme we
have proposed tries to optimize the efforts needed to adapt new boards =
and write
DTs and focus the DT on hardware description.

As a bonus we also specify the min and max value to be reported for the=
 touch
pressure (Z axis) using the same basic principle.

And it is a pure add-on on top of the existing driver so that it attemp=
ts not
to break existing device trees.

Maybe could you accept it as a first step for this specific driver (and=
 let=92s do
the big standardization work later on)?

=97 hns


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
