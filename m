From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCHv3 1/6] ALSA: pcm: Export
	soc_dpcm_runtime_update
Date: Thu, 27 Jul 2017 12:01:18 +0200
Message-ID: <20170727100118.32p4fyfnkgnoz7op@earth>
References: <20170725151030.26863-1-sebastian.reichel@collabora.co.uk>
 <20170725151030.26863-2-sebastian.reichel@collabora.co.uk>
 <s5h7eywjzek.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5087870828780515006=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <s5h7eywjzek.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--===============5087870828780515006==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pd7rvp7sextjfran"
Content-Disposition: inline


--pd7rvp7sextjfran
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 25, 2017 at 05:42:59PM +0200, Takashi Iwai wrote:
> On Tue, 25 Jul 2017 17:10:25 +0200,
> Sebastian Reichel wrote:
> > Some codecs may need to use this from loadable modules. Without
> > this patch compilation for this kind of codec will fail with the
> > following error:
> >=20
> > ERROR: "soc_dpcm_runtime_update" [sound/soc/codecs/snd-soc-cpcap.ko]
> > undefined!
> >=20
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
>=20
> If you do export the function, please make its comments prettier, so
> that it appears in kernel documentation properly as an API function.
>=20
> Also, in general, we use snd_ prefix for the exported stuff.
> You'd need to rename it accordingly, too.
>=20
> Last but not least, this is specific to ASoC, so use "ASoC" prefix to
> the subject line.

After fixing this locally I noticed, that I no longer need to call
soc_dpcm_runtime_update at all and it can remain private. So this
patch will be dropped in v4.

-- Sebastian

--pd7rvp7sextjfran
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAll5uekACgkQ2O7X88g7
+po0xg/9GXSUuo4W0Uc1of/gqEZgDoB1EHjS1FN7I8B8kpuhGgFrYKkr6A2v75gu
43OBnV7+8FL+5TCgmH3lf2dA7aRFrp24T0Fqp1jTj4CmstZi2dIh0ywD66xqaqJb
jAJK093CMd+DhSR+9yd8CBVhFLWP4nU5B2qixLtDWveCuBw6F0tfGlxVWn0/i8ut
+qvyRYpygrxbIKY/yDUzZxA9Fjl9iWGeCggx9kaALtu4wiTujOPL2c8/mXawJ5rH
BpdppSagvZR7Rzw+2aVuU52npcaMpOaWPk1Q2f11l1hi2o0df6U2hBjlt0qK6NI0
sbciYxGlxZO064psbrHQQ7x9Tf23G1wb3cAYLmFZt/4CZecSbeFPDRKAnEIWqbqf
+ClCJ5mwg7r6NG37qDQ1lfItpV2Md48a898BLbsaY93yw2AbFE87VciuY9ZVgj3G
YVYljjSr9XfTG/iFxL+ODZJN+1qKR6wj/bxNyycGjIuzuAoVQQQbyRvvSgrbTBB1
T51czp1Ym2NNKNbUjuu6BnKLJ+6Wt4+QYho0ic1V5ZAGnS8wKWBmZX+WEhOuMJ13
1GySLIaI6h2sGpG9FtNxGmnxLTMq71Dv8KkLCMwNBu4DbbcS/hnbNZv1luYOWiUy
u9aUALO7Jhqv7grjr4JbGtFmyTcvs0SlQXBO8HaCUkfFo+EdzI4=
=jM3h
-----END PGP SIGNATURE-----

--pd7rvp7sextjfran--

--===============5087870828780515006==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5087870828780515006==--
