From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFC PATCH v2 0/7] i2c: core: introduce atomic transfers
Date: Mon, 4 Mar 2019 23:48:56 +0100
Message-ID: <20190304224856.w7egngqynl3hlabp@ninjato>
References: <20190302134735.4393-1-wsa+renesas@sang-engineering.com>
 <71aaab62-2965-8ad8-61b9-02d02694919d@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="i2ufgd73rsxv6a7m"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <71aaab62-2965-8ad8-61b9-02d02694919d@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Keerthy <j-keerthy@ti.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Stefan Lengfeld <contact@stefanchrist.eu>, Phil Reid <preid@electromag.com.au>, Tero Kristo <t-kristo@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org


--i2ufgd73rsxv6a7m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Peda,

> The way I read this series, you are not giving atomic transfers priority.=
 The

You are reading correctly. I could have made more clear that the issue
pointed out by Russell is not handled by this series but discussion
about it is welcome / needed to decide if we can take this series as is
or if we need to redesign it. But here we are anyhow :)

> only thing that happens is that if an xfer happens in atomic/irq context,
> trylock is used instead of an ordinary (unconditional) lock (this is just
> like it is already). If a mux is sitting in between the client device and
> the root adapter, the trylock operation will percolate to the root. Sure,
> there are more trylock ops that may fail and abort the xfer, but if
> everything is uncontended, then things should proceed in orderly fashion.
> Also, sure, the mux may need additional resources that are no longer
> available if the machine is half way down (or worse). But I don't see any
> fundamental *locking* issue with muxes that is different from the case
> without a mux.

Good, that was my conclusion as well. The series, as is, doesn't change
the locking behaviour, so that will work exactly as before. Or, it will
not work in the case described by Russell. Like before.

> That said, if you then want to introduce xfers that want to circumvent the
> locking, then parent-locked muxes are easier since the actual muxing oper=
ation
> is performed as an unlocked xfer (if one is needed) while the client devi=
ce
> has grabbed the adapter lock "from the outside". Sure, there is a list of
> locks going up through the adapter tree to handle, but that can probably =
be
> handled in one place. I.e. the locking must have been avoided prior to the
> actual muxing operation, but the code to do so can be in one place. The

That was my gut feeling, too...

> mux-locked case is where the trouble is, since the muxing operation is do=
ne
> as a normal xfer and needs to be classified as a special xfer that just l=
ike
> the original client xfer also needs to break through any existing locks in
> the adapter tree. And those muxing xfers might come from anywhere, e.g.
>=20
> 	- IO-expander controlling a gpio/pinctrl mux
> 	- dedicated I2C mux (e.g. the LTC4306)
> 	- regmap device
> 	- etc, who knows what muxing options will evolve?
>=20
> So, any scheme that require a white-list will work poorly for mux-locked
> muxes, unless you can add some new grip/pinctrl/regmap flags to
> gpios/pins/registers so that the particular accesses can be white-listed.
> Adding those flags seem rather invasive?

=2E.. and sadly, this too. We would need the same kind of flag which I
described in my first paragraph of the original posting where I wanted
the flag to detect "unauthorized" uses of late I2C transfers. And this
is gonna be invasive. And I am not sure it is worth the effort.

I wonder what a reasonable effort is? Simply ignore the lock from the
"current" adapter and hope for the best that there is no mux or at
least no mux which needs interrupts / a lock attached to it?

> But of course, you need to actually do something about the added FIXME in
> the demux-pinctrl driver... BTW, that driver should forward ->smbus_xfer
> just like it does for ->master_xfer, no?

Yes. The idea of having two seperate SMBus controllers in one SoC which
would need demuxing is amusing, but still, it exists for I2C and you are
right.

Thanks,

   Wolfram


--i2ufgd73rsxv6a7m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlx9q1gACgkQFA3kzBSg
KbYX3BAAjQDCFpbGfGXB8PlBXZzY6XS+1sO3YC6TcePKhtRbKNzfW4QConML5j+g
KlTrgTUx82i4bv7IVtbOw5in2PB/rMiv6FyZ68Ezy5Z2dmCnH9WS9T7+OWIMNDwB
6F4YJZ+1JfsL6G7IlapHMlDuIcXIXJzL4UMzcpQHQXrkoxO6dPOkbRGGvSA9u0/K
Lw+IPnkBa/TROkUrWMzmjqKiAXNw7Ddr8fBPopllklAmD+lL6ZtElrgS95tjHS1X
pGEKNZgZC7AY+7v7kzieLbtDIBQalOaixJbSZ3Ckm+Eo+ejpnWxjqLAnxZ2zjBGS
N4opb/qvklrxCv+/vUTqtWqTQ3XhLnIlY4+tZINJF4BxTTqaWXheREYuHOn7fFN8
fAxeU8p6aYDiszl4djPBBuRha+NDHEY8MySklHh5H8iR495c1vM+aYq4N/dTXlta
J/AVwAbq89Nh/rSlkxcxNbNu/eb2IP/4ZmFCk62+xtklydaH8yOv1jiKl/oCmHVD
PCnd8Sd8siY9s0fyUnaxAeaverSyjdu/kucrVdqs4AYDn57iMqsNB4CmeGjxx6ko
3sAiJQb5mwLONtDW3viQ6zCBrnQ3I+/vxS/7u7q+AXnOzpSy/nid/0zY9eXeJBHh
WFSVTwuhq4IGzGaqUSHGqcfO4FsjL0KgXnP7cSJWzmBURW0JgzE=
=Al+e
-----END PGP SIGNATURE-----

--i2ufgd73rsxv6a7m--
