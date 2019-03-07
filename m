From: Peter Rosin <peda@axentia.se>
Subject: Re: [RFC PATCH v2 0/7] i2c: core: introduce atomic transfers
Date: Thu, 7 Mar 2019 00:02:52 +0000
Message-ID: <6d9a1d1e-a6b7-b3ae-f560-4f906934e795@axentia.se>
References: <20190302134735.4393-1-wsa+renesas@sang-engineering.com>
 <71aaab62-2965-8ad8-61b9-02d02694919d@axentia.se>
 <20190304224856.w7egngqynl3hlabp@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190304224856.w7egngqynl3hlabp@ninjato>
Content-Language: en-US
Content-ID: <D04E06487EBA66469285C1477FADF2F5@eurprd02.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Keerthy <j-keerthy@ti.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Stefan Lengfeld <contact@stefanchrist.eu>, Phil Reid <preid@electromag.com.au>, Tero Kristo <t-kristo@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 2019-03-04 23:48, Wolfram Sang wrote:
> Hi Peda,
>=20
>> The way I read this series, you are not giving atomic transfers priority=
. The
>=20
> You are reading correctly. I could have made more clear that the issue
> pointed out by Russell is not handled by this series but discussion
> about it is welcome / needed to decide if we can take this series as is
> or if we need to redesign it. But here we are anyhow :)
>=20
>> only thing that happens is that if an xfer happens in atomic/irq context=
,
>> trylock is used instead of an ordinary (unconditional) lock (this is jus=
t
>> like it is already). If a mux is sitting in between the client device an=
d
>> the root adapter, the trylock operation will percolate to the root. Sure=
,
>> there are more trylock ops that may fail and abort the xfer, but if
>> everything is uncontended, then things should proceed in orderly fashion=
.
>> Also, sure, the mux may need additional resources that are no longer
>> available if the machine is half way down (or worse). But I don't see an=
y
>> fundamental *locking* issue with muxes that is different from the case
>> without a mux.
>=20
> Good, that was my conclusion as well. The series, as is, doesn't change
> the locking behaviour, so that will work exactly as before. Or, it will
> not work in the case described by Russell. Like before.
>=20
>> That said, if you then want to introduce xfers that want to circumvent t=
he
>> locking, then parent-locked muxes are easier since the actual muxing ope=
ration
>> is performed as an unlocked xfer (if one is needed) while the client dev=
ice
>> has grabbed the adapter lock "from the outside". Sure, there is a list o=
f
>> locks going up through the adapter tree to handle, but that can probably=
 be
>> handled in one place. I.e. the locking must have been avoided prior to t=
he
>> actual muxing operation, but the code to do so can be in one place. The
>=20
> That was my gut feeling, too...
>=20
>> mux-locked case is where the trouble is, since the muxing operation is d=
one
>> as a normal xfer and needs to be classified as a special xfer that just =
like
>> the original client xfer also needs to break through any existing locks =
in
>> the adapter tree. And those muxing xfers might come from anywhere, e.g.
>>
>> 	- IO-expander controlling a gpio/pinctrl mux
>> 	- dedicated I2C mux (e.g. the LTC4306)
>> 	- regmap device
>> 	- etc, who knows what muxing options will evolve?
>>
>> So, any scheme that require a white-list will work poorly for mux-locked
>> muxes, unless you can add some new grip/pinctrl/regmap flags to

s/grip/gpio/ of course

>> gpios/pins/registers so that the particular accesses can be white-listed=
.
>> Adding those flags seem rather invasive?
>=20
> ... and sadly, this too. We would need the same kind of flag which I
> described in my first paragraph of the original posting where I wanted
> the flag to detect "unauthorized" uses of late I2C transfers. And this
> is gonna be invasive. And I am not sure it is worth the effort.
>=20
> I wonder what a reasonable effort is? Simply ignore the lock from the
> "current" adapter and hope for the best that there is no mux or at
> least no mux which needs interrupts / a lock attached to it?

Just wanted to add a note that the underlying problem is similar to why
I introduced the mux-locked concept. There is no simple way to identify
*exactly* which xfers that need to be unlocked. Going only by call site
is not enough, since the same call in different context may need to be
muxed (in my case) or irq-less (in this case). If someone comes up with
a solution for that, all muxes can be converted to the parent-locked
scheme and we can get rid of a bunch of complexity. I just don't see how
though, all ideas I have come up with I have immediately discarded as way
too invasive, ugly and/or error prone.

>> But of course, you need to actually do something about the added FIXME i=
n
>> the demux-pinctrl driver... BTW, that driver should forward ->smbus_xfer
>> just like it does for ->master_xfer, no?
>=20
> Yes. The idea of having two seperate SMBus controllers in one SoC which
> would need demuxing is amusing, but still, it exists for I2C and you are
> right.

Right, I didn't actually think all that far... :-)

Cheers,
Peter
