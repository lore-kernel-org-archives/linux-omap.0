From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] usb: musb_dsps: fix the exit routine for debugfs
Date: Wed, 23 Apr 2014 10:55:29 -0500
Message-ID: <20140423155529.GL9593@saruman.home>
References: <1398267583-19159-1-git-send-email-ogayot@baylibre.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="V3eawNQxI9TAjvgi"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1398267583-19159-1-git-send-email-ogayot-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Olivier Gayot <ogayot-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--V3eawNQxI9TAjvgi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2014 at 05:39:43PM +0200, Olivier Gayot wrote:
> The following commit introduced the debugfs :
>=20
> 40f099e32c2a06bad7d75683421e30fcc74924cd
> Author: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Date:   Fri Jan 17 10:22:35 2014 +0100
>=20
>     usb: musb: dsps, debugfs files
>=20
> Unfortunately, a forgotten call to a cleanup function prevents the
> probing of musb in case of deferred probe.
>=20
> Because musb_init_controller() often retries and creates a new debugfs
> directory each time it is called, we need to remove that directory in cas=
e the
> initialization fails. Otherwise, the debugfs_create_dir() fails at
> subsequent calls because the directory already exists.
>=20
> Fixed by calling debugfs_remove_recursive() in the exit function.
>=20
> Signed-off-by: Olivier Gayot <ogayot-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> Cc: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> ---
>  drivers/usb/musb/musb_dsps.c |    2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
> index 3372ded..c3de0a5 100644
> --- a/drivers/usb/musb/musb_dsps.c
> +++ b/drivers/usb/musb/musb_dsps.c
> @@ -471,6 +471,8 @@ static int dsps_musb_exit(struct musb *musb)
> =20
>  	del_timer_sync(&glue->timer);
> =20
> +	debugfs_remove_recursive(glue->dbgfs_root);
> +
>  	usb_phy_shutdown(musb->xceiv);
>  	return 0;

First of all this commit is wrong, second of all I already have the
proper commit:

commit 0fca91b8a446d4a38b8f3d4772c4a8665ebcd7b2
Author: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date:   Wed Apr 2 11:46:51 2014 +0200

    usb: musb: dsps: move debugfs_remove_recursive()
   =20
    When the platform initialization fails due to missing resources, it will
    return -EPROBE_DEFER after dsps_musb_init() has been called.
   =20
    dsps_musb_init() calls dsps_musb_dbg_init() to allocate the debugfs
    nodes. At a later point in time, the probe will be retried, and
    dsps_musb_dbg_init() will be called again. debugfs_create_dir() will
    fail this time, as the node already exists, and so the entire device
    probe will fail with -ENOMEM.
   =20
    Fix this by moving debugfs_remove_recursive() from dsps_remove() to the
    plaform's exit function, so it will be cleanly torn down when the probe
    fails. It also feels more natural this way, as .exit is the counterpart
    to .init.
   =20
    Signed-off-by: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
    Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index 3372ded..e2fd263 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -470,8 +470,9 @@ static int dsps_musb_exit(struct musb *musb)
 	struct dsps_glue *glue =3D dev_get_drvdata(dev->parent);
=20
 	del_timer_sync(&glue->timer);
-
 	usb_phy_shutdown(musb->xceiv);
+	debugfs_remove_recursive(glue->dbgfs_root);
+
 	return 0;
 }
=20
@@ -708,8 +709,6 @@ static int dsps_remove(struct platform_device *pdev)
 	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
=20
-	debugfs_remove_recursive(glue->dbgfs_root);
-
 	return 0;
 }
=20

a pull request has already been sent to Greg, should be in v3.15-rc3

--=20
balbi

--V3eawNQxI9TAjvgi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTV+JxAAoJEIaOsuA1yqREKskQAKnK///J8vJlhfCvnfacInRf
cgfNeL1s3Hv3kAB+4XMOI4R+MjUfTby6bFtf2nu8yxpv3mPNywfBGfOYCksKjtBA
a3JDfsVtYAyE9sPyxMwcuze6r3ARC6edPw1og2A0add4pNlcnk2LYSshEgtmF+R2
SP8RBYPbrNwW6Fm7VG/oBZ3hbARCujhh+zPPjbU3P0aWgrUnGYq+vO/pPEefWFtF
GgkJpWCFRkTygOUaP+V+igM1GldD7BnEf9AfzGzKS4gTLdwevUBtem9oxijZKqYJ
tqCm1gFRJkjtTOBPw3aEyPEafpuw8eSqtSeI3uuHidPUcga++nKLIiNE/JkzZi/T
4nEgcJHZByF/ID3DmVos2OLHp0IRkU4mD4BHlMQvFgiEEyaPdxipMYjomunqqWHX
5R2Lo6QCudexAqsy69fvogDyALqIwmEQ8fm6pbhGHdxYvr+GrEfMlK0fqnfcdAm8
2KzCxKVWFnFyY/2+1VFGu/+NevfrgmeV8AWYtGrRi8UPVHTDqnqCr+Uxj3cZfwWX
LbT4pR5sfqxmEqlYau+E4MejOhsGW8JFSfs1d2QXDngwjJLSJtWzazGptDTx5OIO
KgtlQSZrljHpeaRc/0nqImBumflcWD9rcKkRDfREFAYj0DpjOCGGYAXArWS9zfYo
JuSBHm+KULI5iVGLr8dO
=YzE2
-----END PGP SIGNATURE-----

--V3eawNQxI9TAjvgi--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
