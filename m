From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v8 4/9] pwm: pwm-tiecap: Update dt binding document to
 use proper unit address
Date: Mon, 11 Jul 2016 12:06:29 +0200
Message-ID: <20160711100629.GJ5823@ulmo.ba.sec>
References: <1462291015-1919-1-git-send-email-fcooper@ti.com>
 <1462291015-1919-5-git-send-email-fcooper@ti.com>
 <20160711095623.GI5823@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ed/6oDxOLijJh8b0"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160711095623.GI5823@ulmo.ba.sec>
Sender: linux-kernel-owner@vger.kernel.org
To: Franklin S Cooper Jr <fcooper@ti.com>
Cc: robh+dt@kernel.org, tony@atomide.com, linux@arm.linux.org.uk, paul@pwsan.com, t-kristo@ti.com, mturquette@baylibre.com, sboyd@codeaurora.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, vigneshr@ti.com, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org


--ed/6oDxOLijJh8b0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 11, 2016 at 11:56:23AM +0200, Thierry Reding wrote:
> On Tue, May 03, 2016 at 10:56:50AM -0500, Franklin S Cooper Jr wrote:
> > Replace unit address from 0 to the proper physical address. Also insure
> > that the unit address matches the reg property address.
> >=20
> > Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> > ---
> >  Documentation/devicetree/bindings/pwm/pwm-tiecap.txt | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> I applied this long ago but never let you know: Applied, thanks.

Actually I didn't. And it seems the reason is that it doesn't apply
cleanly. For some reason my tree doesn't have an entry for the ecap
example on am437x. Am I missing a patch? Can you resend whatever is
not in linux-next yet?

Thierry

--ed/6oDxOLijJh8b0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXg2+jAAoJEN0jrNd/PrOh5JsP/i0T3/m0XUoP5hAgP9iz4fEz
+dFTXJChc/J0DklRURH1d0UAM6GQU1TpBon9hY4GKU9A00DNNemxo+hyDCix0ETE
H90PtwWoIsD3kbd+sFpbZFqLNTRM3r9oI18He6OAyy0Gvbx6G1aakqF78V14xxfc
w5sLmrJQDHNY6PqoNTks7ZgNxRLm+zQbl2NvbRDXSh1WS+5smj44W1RfkaLCq6jt
ewfEpV4dvFJR6/bX+PiFerDndG98pCeZIQjgLDT2gcabbaPzo8C2pq9kti3kmeXi
ubDLo17vK/DsZCgO3LyyRVUiadHs0z5DgtCbVbg7MVziFKduZZuEzP5X9tzB01zk
ja6v2Bibra2YL93KOc6erNsrzLfPuPtkp3bqraZpcGf3u4TpIl9niLrRNPKeM16+
FOk3oJtn+ROKeOfHBgEPHNsDSWF2aBBCjrahZqWHPJUui7XkSEq3prL88fEJPIPn
4JShghxqXdbtsyNgbFv3wLnAUrobQBFlDGAFIlIotiJKP9m2xR6L6vnxkaL048iX
Bbgnhaz5UzsG+t4XNDQxt2orG7V2NnQLOV6ha67e57NNmYrrrCJFgx8bozIZ1ycv
AAB2iQBt7mOGlzKr+e90hBAKCyT0CXTjeRzeHOgEqRXfkP8qbLs1YAQZL759TrA6
29zFvSmIXuSPc2pdTP2N
=T0aR
-----END PGP SIGNATURE-----

--ed/6oDxOLijJh8b0--
