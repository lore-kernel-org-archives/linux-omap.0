From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 01/15] drivers: phy: add generic PHY framework
Date: Tue, 20 Aug 2013 07:26:32 -0500
Message-ID: <20130820122632.GS26587@radagast>
References: <20130720220006.GA7977@kroah.com> <520A2100.6000709@ti.com>
 <520AB0F0.8010106@gmail.com> <2128883.KpgODjXPJQ@flatron>
 <520B9C9E.8010002@ti.com> <5211ACE9.3040302@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6784016741301035164=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <5211ACE9.3040302@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-doc@vger.kernel.org, tony@atomide.com, Tomasz Figa <t.figa@samsung.com>, nsekhar@ti.com, Tomasz Figa <tomasz.figa@gmail.com>, s.nawrocki@samsung.com, kgene.kim@samsung.com, swarren@nvidia.com, jg1.han@samsung.com, Alan Stern <stern@rowland.harvard.edu>, grant.likely@linaro.org, linux-media@vger.kernel.org, george.cherian@ti.com, arnd@arndb.de, devicetree-discuss@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balajitk@ti.com, Greg KH <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, kyungmin.park@samsung.com, akpm@linux-foundation.org
List-Id: linux-omap@vger.kernel.org

--===============6784016741301035164==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MET8MpPxp2u2c48q"
Content-Disposition: inline

--MET8MpPxp2u2c48q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 19, 2013 at 10:58:09AM +0530, Kishon Vijay Abraham I wrote:
> >> So maybe let's stop solving an already solved problem and just state t=
hat=20
> >> you need to explicitly assign device ID to use this framework?
> >=20
> > Felipe,
> > Can we have it the way I had in my v10 patch series till we find a bett=
er way?
> > I think this *non-dt* stuff shouldn't be blocking as most of the users =
are dt only?

I don't have a lot of things against it, but preventing driver authors
to use PLATFORM_DEVID_AUTO just to use the framework is likely going to
piss some people off.

Perhaps we can start with this approach and fix things later ? At least
it ungates all the PHY drivers which are depending on this framework
(quite a few already). If everybody agrees with this approach, I'd be ok
with it too.

cheers

--=20
balbi

--MET8MpPxp2u2c48q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSE2B4AAoJEIaOsuA1yqREd3gP+wRMRCFi5PMZScsqh3zwf+14
Cq/VFvWySbx+P+bh4TS9scGnTq+AaFlrrWjiYaPSWKy7teJcvSj+Y8+o+W3VVkeX
9yzuhSbHnJzBjxqpyEzb1hqtfkiCTQc8HcH/YkIj/yoszIrr3HHz+NgTmXjpcum3
szWpw9gPRo9AT9caOhaDU91bSc8PdZc9mBzPgw7WUfJrf008SfUmhKiOpzvNfht2
nN/mp250zfFDZHHu5fRMWhfUH6+uVYEYM+P8IZMwA0Dvne0RYEuE7Pps8a0M9/dx
E/RS7I7TDphIC/CtuNkaUFyHXZGg4CVSXJF42iAI0vFy9jIvoXtzgrVcxXPgGV7P
FX0KHzGK/0k91zH/zRmVUgqXX5l7OrjzrFeh5UAYlkbhM98PoruwBmwAnDQ1z9Xy
VWKS6N1qUOA/D3zL1HqQpQ6scXYSXmcNju4oVU6aLgxvnMK/8uLX9FwhrOeZhzdN
HHJ7Va7l2VqYug3eq8uAvBaD/VeDnCdQem/tjQfew9P2J29pcrmVzqPRYxAylduZ
hKs/bL5X5/Pzlj4Ox6dGYk/UKfN5ZgphUDd9TW9dagMGX/WGELPi86xsAgwXHu7R
FPf4PeQbfkld1qj1KU+PWCFhspFVMqn/p2kb8NV/HPR/f42I82NUuGNjAFoYxbnf
yQuryiSSHIxte8/C3LK/
=iA/Q
-----END PGP SIGNATURE-----

--MET8MpPxp2u2c48q--


--===============6784016741301035164==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6784016741301035164==--
