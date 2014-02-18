From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v4 1/2] usb: musb: dsps, debugfs files
Date: Tue, 18 Feb 2014 10:20:54 -0600
Message-ID: <20140218162054.GE9878@saruman.home>
References: <1389950556-6453-1-git-send-email-mpa@pengutronix.de>
 <1389950556-6453-2-git-send-email-mpa@pengutronix.de>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3180067756023476600=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1389950556-6453-2-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Bin Liu <binmlist@gmail.com>, linux-usb@vger.kernel.org, Felipe Balbi <balbi@ti.com>, kernel@pengutronix.de, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============3180067756023476600==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4eRLI4hEmsdu6Npr"
Content-Disposition: inline

--4eRLI4hEmsdu6Npr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2014 at 10:22:35AM +0100, Markus Pargmann wrote:
> debugfs files to show the contents of important dsps registers.
>=20
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  drivers/usb/musb/musb_dsps.c | 54 ++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 54 insertions(+)
>=20
> diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
> index 593d3c9..d0a97d6 100644
> --- a/drivers/usb/musb/musb_dsps.c
> +++ b/drivers/usb/musb/musb_dsps.c
> @@ -46,6 +46,8 @@
>  #include <linux/of_irq.h>
>  #include <linux/usb/of.h>
> =20
> +#include <linux/debugfs.h>
> +
>  #include "musb_core.h"
> =20
>  static const struct of_device_id musb_dsps_of_match[];
> @@ -137,6 +139,26 @@ struct dsps_glue {
>  	unsigned long last_timer;    /* last timer data for each instance */
> =20
>  	struct dsps_context context;
> +	struct debugfs_regset32 regset;
> +	struct dentry *dbgfs_root;
> +};
> +
> +static const struct debugfs_reg32 dsps_musb_regs[] =3D {
> +	{ "revision",		0x00 },
> +	{ "control",		0x14 },
> +	{ "status",		0x18 },
> +	{ "eoi",		0x24 },
> +	{ "intr0_stat",		0x30 },
> +	{ "intr1_stat",		0x34 },
> +	{ "intr0_set",		0x38 },
> +	{ "intr1_set",		0x3c },
> +	{ "txmode",		0x70 },
> +	{ "rxmode",		0x74 },
> +	{ "autoreq",		0xd0 },
> +	{ "srpfixtime",		0xd4 },
> +	{ "tdown",		0xd8 },
> +	{ "phy_utmi",		0xe0 },
> +	{ "mode",		0xe8 },
>  };
> =20
>  static void dsps_musb_try_idle(struct musb *musb, unsigned long timeout)
> @@ -369,6 +391,30 @@ out:
>  	return ret;
>  }
> =20
> +static int dsps_musb_dbg_init(struct musb *musb, struct dsps_glue *glue)
> +{
> +	struct dentry *root;
> +	struct dentry *file;
> +	char buf[128];
> +
> +	sprintf(buf, "%s.dsps", dev_name(musb->controller));
> +	root =3D debugfs_create_dir(buf, NULL);
> +	if (!root)

wrong, you should be using IS_ERR()

--=20
balbi

--4eRLI4hEmsdu6Npr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTA4hmAAoJEIaOsuA1yqREmGIP/A6AuAfssrRmuL0aigz1JJ/0
1lsz25baVACyrNEAPX2MZsU0sc2oZfIwE5r1RAcWOEvwfDBHMgSZbXB2pk0tk1ZE
9GV2cp4zCnirYfRCgjzKUveZlcmG5lWgLucDPncWVNynluL5F98LIL1TmFIQeL0K
XaRJvW59LaicaK+mSkmPdriFFrhjspZ1AOuhS6YCawksfIlReSvPA1uIzMaq6F8r
ywo2DgMtKbs5Y+asVoti3niXkoWd6l7eRnxpRrvodTAxyuP5V6cfpKhbQAa5q7a4
xsd0XZfJQBhEwWoyqRIgZGye0w3kNCx5qMzDTLVRlBSdBKgRInei3ANQ1XXoi8yl
rIvzoOLzdg+Q606n4ruW5XgOjjdN5/SBHWt9OSTPd05JIXPdbDXakuXTucPHLK3P
q/+loMLfaZrK7z3z1t3VhXkL1xJYi6NT5A0ZcfUW32MtwM45Ba/ldpBcT01DKrKK
+Ykv/h1Ezs22ZyTuUNcSccE7XVY0H2x1kjldvygGl7whNQC+4Kp3/FqsLpjWjN/0
Dzyekf6jiW+ar3Og2qXJy3Cn/cOlaFMJVU1+knp0BKkWquKVrA4TGdYtXFJAWLkC
yx2rb4gSfGYQslF6uVuk0JaVC6YFEvVcpZ5hfqBCQFkhD5jsKOGDBr5oaGYIIvfL
fvtuJKuxr2NQXY1X65sc
=fWdH
-----END PGP SIGNATURE-----

--4eRLI4hEmsdu6Npr--


--===============3180067756023476600==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3180067756023476600==--
