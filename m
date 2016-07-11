From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v8 4/9] pwm: pwm-tiecap: Update dt binding document to
 use proper unit address
Date: Mon, 11 Jul 2016 12:33:45 +0200
Message-ID: <20160711103345.GB5503@ulmo.ba.sec>
References: <1462291015-1919-1-git-send-email-fcooper@ti.com>
 <1462291015-1919-5-git-send-email-fcooper@ti.com>
 <20160711095623.GI5823@ulmo.ba.sec>
 <20160711100629.GJ5823@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EuxKj2iCbKjpUGkD"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160711100629.GJ5823@ulmo.ba.sec>
Sender: linux-kernel-owner@vger.kernel.org
To: Franklin S Cooper Jr <fcooper@ti.com>
Cc: robh+dt@kernel.org, tony@atomide.com, linux@arm.linux.org.uk, paul@pwsan.com, t-kristo@ti.com, mturquette@baylibre.com, sboyd@codeaurora.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, vigneshr@ti.com, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org


--EuxKj2iCbKjpUGkD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 11, 2016 at 12:06:29PM +0200, Thierry Reding wrote:
> On Mon, Jul 11, 2016 at 11:56:23AM +0200, Thierry Reding wrote:
> > On Tue, May 03, 2016 at 10:56:50AM -0500, Franklin S Cooper Jr wrote:
> > > Replace unit address from 0 to the proper physical address. Also insu=
re
> > > that the unit address matches the reg property address.
> > >=20
> > > Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> > > ---
> > >  Documentation/devicetree/bindings/pwm/pwm-tiecap.txt | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> >=20
> > I applied this long ago but never let you know: Applied, thanks.
>=20
> Actually I didn't. And it seems the reason is that it doesn't apply
> cleanly. For some reason my tree doesn't have an entry for the ecap
> example on am437x. Am I missing a patch? Can you resend whatever is
> not in linux-next yet?

Oh, nevermind my blabbering, it took me too long to realize that this is
the series that Tony had picked up for the most part, and I hadn't
properly marked it done in patchwork.

I'll go get some coffee now.

Thierry

--EuxKj2iCbKjpUGkD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXg3YJAAoJEN0jrNd/PrOhzdwP/iZmYhqh/Q7NjSWzUse3NL/x
K6W5441H1aNOs9T9gE8iTWd3d+wVimySETpZTCg7rFH0BdDrRUx5ZhKbtWOlcem4
L6DpCjhEsPu9ObVw8vBUGaqVkh+GVueV1p6sRlb8F2FdDZtlhBj+mn89xtxDpFKQ
/fp4rykEsh5PhalxBg//9Zbk3at4ouVev7jUNfB3Qxl5U0kxiPmkQ/sETNp2sjoX
TxqbA23rD0B0YDAsk5iYUognAOLUcOXVqeyaw46r2/j/w35a8wzW/BLlfS0ePl9J
Nn2o6xxWm4yEG/5F7+souAa0/65DTERe1nE5OW1UplpVsFFzBHCiH9hjgX2eiRHW
BTCcibLN5y/w9r+tJadsE1ppN5SxdmBsFDwTdRj1/FscGJmc6nb59bHTf6HxVRHW
fLlgCDu44WEJ1LkrAqrq/PEiI0Il/hpO90IEHGJgF1Jbyc7eJfIluSJBsT2D94C5
faQtqO8ZC/rI01LF9pB3IfB9keb43H7c8u+T5t9gHG6QWY1smN9KNUyEJQ4HU8yz
zfMqp7RlQdfFcnJWGLv60wv1pArOUwIYLgIfiMXgo47evWFrwM51QezWQ+iwgntA
IPG+o1CeU/PeUub0Cir53su4Rb9J+oJGTMM5kiLicMf5envlFyBY/mfDq9vezBDn
09ar2DQzX2bP1KfWORs5
=Mx4R
-----END PGP SIGNATURE-----

--EuxKj2iCbKjpUGkD--
