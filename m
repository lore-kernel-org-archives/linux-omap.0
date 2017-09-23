From: Pavel Machek <pavel@ucw.cz>
Subject: [PATCH] omap_ssi_core: fix kilo to be "k" not "K"
Date: Sat, 23 Sep 2017 21:08:38 +0200
Message-ID: <20170923190838.GA16966@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com
Cc: Andrew Morton <akpm@osdl.org>
List-Id: linux-omap@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Kilo should be "k" not "K", fix it it comments and messages.

Signed-off-by: Pavel Machek <pavel@ucw.cz>

index 88e48b3..41a09f5 100644
--- a/drivers/hsi/controllers/omap_ssi_core.c
+++ b/drivers/hsi/controllers/omap_ssi_core.c
@@ -334,7 +334,7 @@ static int ssi_clk_event(struct notifier_block *nb, uns=
igned long event,
 	case POST_RATE_CHANGE:
 		dev_dbg(&ssi->device, "post rate change (%lu -> %lu)\n",
 			clk_data->old_rate, clk_data->new_rate);
-		omap_ssi->fck_rate =3D DIV_ROUND_CLOSEST(clk_data->new_rate, 1000); /* K=
Hz */
+		omap_ssi->fck_rate =3D DIV_ROUND_CLOSEST(clk_data->new_rate, 1000); /* k=
Hz */
=20
 		for (i =3D 0; i < ssi->num_ports; i++) {
 			omap_port =3D omap_ssi->port[i];
@@ -467,9 +467,9 @@ static int ssi_hw_init(struct hsi_controller *ssi)
 	}
 	/* Resetting GDD */
 	writel_relaxed(SSI_SWRESET, omap_ssi->gdd + SSI_GDD_GRST_REG);
-	/* Get FCK rate in KHz */
+	/* Get FCK rate in kHz */
 	omap_ssi->fck_rate =3D DIV_ROUND_CLOSEST(ssi_get_clk_rate(ssi), 1000);
-	dev_dbg(&ssi->device, "SSI fck rate %lu KHz\n", omap_ssi->fck_rate);
+	dev_dbg(&ssi->device, "SSI fck rate %lu kHz\n", omap_ssi->fck_rate);
=20
 	writel_relaxed(SSI_CLK_AUTOGATING_ON, omap_ssi->sys + SSI_GDD_GCR_REG);
 	omap_ssi->gdd_gcr =3D SSI_CLK_AUTOGATING_ON;

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlnGsTYACgkQMOfwapXb+vL/IwCgs+9NE1bSXk0RxCJJ4cg+pZXA
Q4gAnigEqqjfXfV3FWLjs+WIZEjWdAcf
=vOCP
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
