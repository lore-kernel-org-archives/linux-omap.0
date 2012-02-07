From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 2/7] MFD: twl6040: Convert to i2c driver,
 and separate it from twl core
Date: Tue, 7 Feb 2012 13:29:25 +0000
Message-ID: <20120207132925.GN3332@opensource.wolfsonmicro.com>
References: <1328619678-26080-1-git-send-email-peter.ujfalusi@ti.com>
	<1328619678-26080-3-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5169307797168870310=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1328619678-26080-3-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dtor@mail.ru>, linux-kernel@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


--===============5169307797168870310==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="c2gYorpyS4gG0T74"
Content-Disposition: inline


--c2gYorpyS4gG0T74
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 07, 2012 at 03:01:13PM +0200, Peter Ujfalusi wrote:
> Complete the separation of the twl6040 from the twl core since
> it is a separate chip, not part of the twl6030 PMIC.

Looking good

Reviewed-by: Mark Brown <broonie@opensource.wolfsonicro.com>

and it looks like you'll save a bunch more code if you're able to
convert over to using a regmap cache.  Note that as a first pass you
just need to define which registers are volatile and enable a cache type
- if defaults are omitted then the values will be read back from the
device to start off with.

--c2gYorpyS4gG0T74
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPMSZ+AAoJEBus8iNuMP3df30QAIN5S2+p8EyQfwYgHzuz4N/x
q0c3AOU/aUpOheyLjEUkVOjzJjNiQHY0GXvmHrXnn/whULW16+n5BFq9/DlHPcff
rlWE7K1jrl93Lv/dM5IZS4jsDx0iCKN88tw9PN0one/klDUWJPzB7CBEioQQlEq7
UHKwZtzPk2oHNTAknnsUPMK1hkl9J2fBHDrC+meC1gXyjgdxJy1i03OVbkOntz3P
eBku+7Hf7Wl3r+txV9aRKLIvx891GB+AtVeZboPtjLgQZ9o9FeSEuQSmImGOgLBG
3mvgOa14rRVV6wRf2j+H604r2tTNZ2FZZ7OZOK4esOnU8O1bBsirT9Sz3JpY8t99
gT3BCyzvsrH8IehF5tCA5cWAMT1uLymWN5kMPiBwh4MN+R5MU6DlNbT69KmawM+D
//gYlHal1sYzyINYTmeoSwlZRCGqNizyO4fL1mxMP0aPpKpIorDvnKFaX8A2cNHT
4HkkZV/Qt0Uy78+c+OOAlJ+MsIh+mQ7PfzAnVuJlG2wehecJ0D3OysbCVBd+d2Gt
pu6pzljwKzi+M00BcZPGC5ulrhs0boXczd+av2AOcSQU//rQ/3qSHc8d5LddAMNe
hP1PMe5GHmnD+qhnbFMWlLAX5jQzmHGw0ITsUKPowQ9FNj4aRH/Tw4OStWDg6eiH
fc2xy34kKKS0j3yL9W5z
=1teB
-----END PGP SIGNATURE-----

--c2gYorpyS4gG0T74--

--===============5169307797168870310==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5169307797168870310==--
