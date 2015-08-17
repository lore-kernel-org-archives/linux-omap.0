From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFC v3 2/7] ASoC: hdmi: Remove obsolete
	dummy HDMI codec
Date: Mon, 17 Aug 2015 11:46:50 -0700
Message-ID: <20150817184650.GX10748@sirena.org.uk>
References: <cover.1439542916.git.jsarha@ti.com>
 <360a38c83ae2a24620da85b8496b745326d995de.1439542916.git.jsarha@ti.com>
 <20150814161033.GT10748@sirena.org.uk> <55D18677.3050805@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6533137771017260714=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <55D18677.3050805@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jyri Sarha <jsarha@ti.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, peter.ujfalusi@ti.com, moinejf@free.fr, airlied@linux.ie, dri-devel@lists.freedesktop.org, liam.r.girdwood@linux.intel.com, tony@atomide.com, tomi.valkeinen@ti.com, bcousson@baylibre.com, rmk+kernel@arm.linux.org.uk, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--===============6533137771017260714==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YXsbNr0GD8juqqEr"
Content-Disposition: inline


--YXsbNr0GD8juqqEr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 17, 2015 at 10:00:07AM +0300, Jyri Sarha wrote:
> On 08/14/15 19:10, Mark Brown wrote:

> Don't you mean "omap-hdmi-audio", that is implemented in
> sound/soc/omap/omap-hdmi-audio.c ?

> That driver is bit different. It implements ASoC card and uses generic dummy
> codec. The "hdmi-audio-codec" has not been used for OMAP HDMI audio for
> several releases already.

Possibly, yes, or I was on an old tree by mistake.  It's definitely not
used now like you say.

--YXsbNr0GD8juqqEr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV0iwZAAoJECTWi3JdVIfQzyoH/3SUXYWr+Le59p7deArzuYhR
vp+ODOeYAn7N1WiBg5/vLbr6Kqyuo6ggmHYd2v+2/A4XL/BfWnD/qDCI1PnblYVn
XRmuqzgN1OKBpHiiD7ZEAoTNyMkbEobfvsR6+ra/Xnx5nTGmHRj+hrDIc8K7P1A6
eTJh9uNNe9o8GQqDmB7fd+97MQ6xEvd7aJgrYD6zNRWFi83EItJPWWtsvGyb+HgC
DZTJWojXqBsuI/r9r7PkQtBdJ7BuVEGqbI25NLmwuKXgbY5Dl7GKAXoQKPQ56j/A
JqrFmy3EmustPXyLWAY7G6AFVp9qLwwLm1K5gFAYZo437OzVTYGHlQJNmB/+iPk=
=2qex
-----END PGP SIGNATURE-----

--YXsbNr0GD8juqqEr--

--===============6533137771017260714==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6533137771017260714==--
