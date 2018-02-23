From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCHv4 2/4] ASoC: codec: cpcap: new codec
Date: Fri, 23 Feb 2018 09:07:14 +0100
Message-ID: <20180223080714.GC1584@amd>
References: <20180214220741.28306-1-sebastian.reichel@collabora.co.uk>
 <20180214220741.28306-3-sebastian.reichel@collabora.co.uk>
 <20180216113901.GC5886@sirena.org.uk>
 <20180216135113.akicejkodhbjpp2w@earth.universe>
 <20180216142716.GJ5886@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6877952755298681874=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180216142716.GJ5886@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-omap@vger.kernel.org


--===============6877952755298681874==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HG+GLK89HZ1zG0kk"
Content-Disposition: inline


--HG+GLK89HZ1zG0kk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-02-16 14:27:16, Mark Brown wrote:
> On Fri, Feb 16, 2018 at 02:51:13PM +0100, Sebastian Reichel wrote:
> > On Fri, Feb 16, 2018 at 11:39:01AM +0000, Mark Brown wrote:
>=20
> > > We don't have default lines like this for other MFDs...
>=20
> > Is there a reason not to add them? It looks very useful to me:
>=20
> Consistency.  It's a lot easier to apply a single rule to everything
> than it is to have to individually think through and discuss the
> decisions on every individual driver, especially when there will
> inevitably be some cases where there are conflicting requirements from
> different users.  As you said in the rest of your mail hand configuring
> kernels is already a very specialist thing at the best of times.

Yes, so please don't make it any harder than it needs to be. Having to
enable (by hand) more than one option per chip is annoying and error-prone.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--HG+GLK89HZ1zG0kk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqPy7IACgkQMOfwapXb+vKrRACfSPOLbfTzlyi3wGezRGoMK7VH
/XIAnj7ERmB7Ow0NtqtO7NdiHNvCrnwh
=4tK+
-----END PGP SIGNATURE-----

--HG+GLK89HZ1zG0kk--

--===============6877952755298681874==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6877952755298681874==--
