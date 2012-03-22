From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH RFC] usb: musb: omap: fix the error check for
 pm_runtime_get_sync
Date: Thu, 22 Mar 2012 14:55:51 +0200
Message-ID: <20120322125550.GG32368@arwen.pp.htv.fi>
References: <1332400686-27674-1-git-send-email-shubhrajyoti@ti.com>
 <4F6B1E2D.8020802@mvista.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JKvC8Wn6JllzUPdT"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4F6B1E2D.8020802-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Cc: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--JKvC8Wn6JllzUPdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 22, 2012 at 04:42:21PM +0400, Sergei Shtylyov wrote:
> Hello.
>=20
> On 22-03-2012 11:18, Shubhrajyoti D wrote:
>=20
> >pm_runtime_get_sync returns a signed integer.In case of errors
> >it returns a negative value.This patch fixes the error check
> >by making it signed instead of unsigned thus preventing register
> >access if get_sync_fails. Also passes the error cause to the
> >debug message.
>=20
> >Cc:  Kishon Vijay Abraham I<kishon-l0cyMroinI0@public.gmane.org>
> >Signed-off-by: Shubhrajyoti D<shubhrajyoti-l0cyMroinI0@public.gmane.org>
> >---
> >Compile tested only
>=20
>    You haven't run it thru scripts/checkpatch.pl either, I guess?
>=20
> >  drivers/usb/musb/omap2430.c |    5 +++--
> >  1 files changed, 3 insertions(+), 2 deletions(-)
>=20
> >diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
> >index 2ae0bb3..e5dd18f 100644
> >--- a/drivers/usb/musb/omap2430.c
> >+++ b/drivers/usb/musb/omap2430.c
> [...]
> >@@ -301,7 +302,7 @@ static int omap2430_musb_init(struct musb *musb)
> >
> >  	status =3D pm_runtime_get_sync(dev);
> >  	if (status<  0) {
> >-		dev_err(dev, "pm_runtime_get_sync FAILED");
> >+		dev_err(dev, "pm_runtime_get_sync FAILED %d \n",status);
>=20
>    If I don't mistake, scripts/checkpatch.pl should warn about
> unneeded spaces before '\n'. And also about missing spaces after
> commas.

I fixed in my branch, thanks

--=20
balbi

--JKvC8Wn6JllzUPdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPayFWAAoJEIaOsuA1yqREWTMP/1hUHD6RnDJmV5sOWUo1m0mE
1O0PLYKUx0OWhQPRrcruVwyADttvO8iez5UoAOvDMNId+yoN4haWy1jon/4IWcoE
9b3h5HXpa24LYkDs3rHdwygVwnLXLlgQ35zeOY3M2so7mFC9PmeawQNRlYPUXChK
Xn4d67qT0eGQkEkOR9hZHUDU8wwxpq7kWLhBlNHv06u4vC8WF+liOaOSFm+x8UWH
0aAXPfmYTCXTJnk8E+rZa2xXRctLxBl1XnNC3nsXgmCbkKxuE8IJsHffxMYUfIK5
Dlnjpvkvu916rmNCimcs7gdMce6VI+a/FTtdYpK9NXjl4JlJnVd+ONZOFvtwnK+F
f4Wt3/trYJ7aI1fovdMfLFmwG+77ZiQc0CiJYfVmqHNkY0Tf5/nGe5FcXlIgu0lv
oonHQSljKZFR21hmi0BzIW/u7SF8pV09S///rwNDjHZkzS75uQyyhKuOoztP/Wz4
Q9QSDBwHpB974MuWNSHLEATYytcRo62jxZn1CS3UiNyV8OS32khWfNpPXRBCTADz
Zx/+v7IhrOeLukWSASSjWRqfWEzFY1KLUf/VyKrq4sVNJAtjFZuSWZ/SFh4KKP28
Bzy9XBk4MSD/0m1kZg5KASlxY4WxgBQuGeuPPNBAfcftz47d8QOYDJtJjw6/gJXn
68fPpydmtLowfLUYDljC
=+yW7
-----END PGP SIGNATURE-----

--JKvC8Wn6JllzUPdT--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
