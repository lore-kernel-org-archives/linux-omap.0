From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 5/8] ARM: OMAP2+: Configure voltage controller for cpcap
Date: Sun, 13 Oct 2019 16:46:09 +0200
Message-ID: <20191013144608.GC13278@amd>
References: <20191010001224.41826-1-tony@atomide.com>
 <20191010001224.41826-6-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4403216939243970364=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191010001224.41826-6-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Merlijn Wajer <merlijn@wizzup.org>, linux-omap@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


--===============4403216939243970364==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hYooF8G/hrfVAmum"
Content-Disposition: inline


--hYooF8G/hrfVAmum
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2019-10-09 17:12:21, Tony Lindgren wrote:
> We can configure voltage controller for cpcap with the data available in
> Motorola Mapphone Android Linux kernel. Let's add it so we can have droid4
> behave the same way for voltage controller as other omap4 devices and save
> some power when idle.
>=20
> Note that we're now using high-speed i2c mode, looks like the Motorola
> kernel had a typo using 0x200 instead of 200 for the timings which may
> caused it to not work properly.
>=20
> Also note that in the long run, this should just become dts data for a
> voltage controller device driver. But let's get things working first to
> make it possible to test further changes easily.

3-5: Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--hYooF8G/hrfVAmum
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl2jOLAACgkQMOfwapXb+vIEJACfaOC+s2HMvLdS2v3uYO1Oi2zx
p+AAnih27tb4tyL0MuWGn7s8d7B2QZpb
=iIfp
-----END PGP SIGNATURE-----

--hYooF8G/hrfVAmum--


--===============4403216939243970364==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4403216939243970364==--
