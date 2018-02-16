From: Pavel Machek <pavel@ucw.cz>
Subject: Nokia N900 camera in v4.16-rc1: ready for testing?
Date: Fri, 16 Feb 2018 23:30:41 +0100
Message-ID: <20180216223041.GA16010@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>
List-Id: linux-omap@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Camera should work on N900, with v4.16-rc1. Autofocus should work;
flash is in the queue.

This patch is needed for non-square image. Patched v4l-utils is very
much recommened for taking photos.

Sakari: any ideas about this one? This is the bug I showed you in
Prague...

Best regards,
								Pavel

commit b685b7b98fc50149779416b33d234e4f9ff6ad0e
Author: Pavel <pavel@ucw.cz>
Date:   Mon Feb 13 21:26:51 2017 +0100

    omap3isp: fix VP2SDR bit so capture (not preview) works
   =20
    This is neccessary for capture (not preview) to work properly on
    N900. Why is unknown.

diff --git a/drivers/media/platform/omap3isp/ispccdc.c b/drivers/media/plat=
form/omap3isp/ispccdc.c
index b66276a..6435857 100644
--- a/drivers/media/platform/omap3isp/ispccdc.c
+++ b/drivers/media/platform/omap3isp/ispccdc.c
@@ -1182,7 +1182,8 @@ static void ccdc_configure(struct isp_ccdc_device *cc=
dc)
 	/* Use the raw, unprocessed data when writing to memory. The H3A and
 	 * histogram modules are still fed with lens shading corrected data.
 	 */
-	syn_mode &=3D ~ISPCCDC_SYN_MODE_VP2SDR;
+//	syn_mode &=3D ~ISPCCDC_SYN_MODE_VP2SDR;
+	syn_mode |=3D ISPCCDC_SYN_MODE_VP2SDR;
=20
 	if (ccdc->output & CCDC_OUTPUT_MEMORY)
 		syn_mode |=3D ISPCCDC_SYN_MODE_WEN;
@@ -1249,6 +1250,8 @@ static void ccdc_configure(struct isp_ccdc_device *cc=
dc)
 			<< ISPCCDC_VERT_LINES_NLV_SHIFT,
 		       OMAP3_ISP_IOMEM_CCDC, ISPCCDC_VERT_LINES);
=20
+	printk("configuring for %d(%d)x%d\n", crop->width, ccdc->video_out.bpl_va=
lue, crop->height);
+
 	ccdc_config_outlineoffset(ccdc, ccdc->video_out.bpl_value,
 				  format->field);
=20

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqHW5EACgkQMOfwapXb+vJJzQCgwy/hd+62RIMPOnb+XMUGUHgR
eeAAn2I8D4cVonrWZZU79Xf+G/xEUlbG
=Msrx
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
