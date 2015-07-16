From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] V4 regmap: Use reg_sequence for
 multi_reg_write / register_patch
Date: Thu, 16 Jul 2015 21:48:08 +0100
Message-ID: <20150716204808.GB1602@sirena.org.uk>
References: <1436885152-19850-1-git-send-email-nariman@opensource.wolfsonmicro.com>
 <20150716125254.GE4039@sirena.org.uk>
 <20150716154525.GB21939@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5666094292535647320=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20150716154525.GB21939@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nariman Poushin <nariman@opensource.wolfsonmicro.com>
Cc: oder_chiou@realtek.com, brian.austin@cirrus.com, laurent.pinchart+renesas@ideasonboard.com, sameo@linux.intel.com, support.opensource@diasemi.com, airlied@linux.ie, gregkh@linuxfoundation.org, dmitry.torokhov@gmail.com, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, lgirdwood@gmail.com, peter.ujfalusi@ti.com, tony@atomide.com, lars@metafoo.de, Paul.Handrigan@cirrus.com, patches@opensource.wolfsonmicro.com, bardliao@realtek.com, linux-omap@vger.kernel.org, lee.jones@linaro.org, linux-kernel@vger.kernel.org, dmurphy@ti.com
List-Id: linux-omap@vger.kernel.org


--===============5666094292535647320==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2B/JsCI69OhZNC5r"
Content-Disposition: inline


--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 16, 2015 at 04:45:25PM +0100, Nariman Poushin wrote:

> I will resend with a cover letter explaining the change from the previous
> patch set if that is the right thing to do.

No, that's fine.  If you want to fix something like that just reply to
the cover letter with the extra information.

--2B/JsCI69OhZNC5r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVqBiFAAoJECTWi3JdVIfQU0cH/2zBhOlDz6e+jY+7Y58/61Mz
Mh23ZVckNJIFWn7xGyznVv0Slw4/iGUhL4FL8B/lOiv8pR3mUT3BNqhCpRk5DzDB
VMQY3fvpHqg6uO1vHrQUeiKQxlZP8Psm455a2lHQ5Xzr/vsabpF/y45g29OsJ1AU
yvjTPV2kcyw7YIuBN7mYE9hVa7LQAMyXCP+vGUJKhjehxDDEtihtVWvJz8Bxwpzy
JneaBE3fkhbGPhvgy+oRKDUgp3J1y/kgKiJ21hizvS0W1UssbC/e7I3QAKMvrxPq
ircmztggAw3hAO2HOMajK9aUDH+g36Hs66N3Z0rg74dfJtYLq07b5OoYIar/+0w=
=OG+G
-----END PGP SIGNATURE-----

--2B/JsCI69OhZNC5r--

--===============5666094292535647320==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5666094292535647320==--
