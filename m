From: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6 04/10] usb: dwc3: omap: fix up error path on probe()
Date: Mon, 11 Apr 2016 15:20:50 +0300
Message-ID: <87bn5gnxp9.fsf@intel.com>
References: <1460374506-9779-1-git-send-email-rogerq@ti.com> <1460374506-9779-5-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1460374506-9779-5-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> writes:
> From: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>
> Even if pm_runtime_get*() fails, we *MUST* call
> pm_runtime_put_sync() before disabling PM.
>
> While at it, remove superfluous dwc3_omap_disable_irqs()
> in error path.
>
> Signed-off-by: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> [nsekhar-l0cyMroinI0@public.gmane.org: patch description updates]
> Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>

this fix is unrelated to DRD/OTG work, right ? Care to rebase only this
patch on v4.6-rc3 so I can apply it during current -rc ?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXC5ajAAoJEIaOsuA1yqREVzQP/AvPHVxgtfpioKt0qIEECgk5
ZmZWsrF7ElNfncTGS026PNdt5/3r7Cjz6ktcMVB1CRxMj9lOQFLRjh+vX6dJmd6h
0hAXjVR9mg1Vaq5GH9hrfjT+50e9KdQyeZjtYew5UQ4ro/1g1GXwP8xWzakO5f6D
JsNyPneJlR+zcW7wmaUuLbemh2uWrS6ByuV/ETAv59InZgRgHqdBPYPU2rt+Qzlo
R0f6RSfaEk5u5wpsCMEiTbsagAPZbN33qzI2SERSxFxkBrNUeo/qSW9IcmP3+khK
VzuPOf2nJMk5hV0Onqj+tPbAt05NSd9JG9/JTs76iKoKefpk7hAbjiTlyXL9yDl8
S3bs/EB3meufpP8zWMRYGKlUPGfl1Hehc+S5a99M9LhF5Ln5FeVREWIO5ic41TNL
iaqgOfcQ/m+eClIwdWHUDira2HQYo/xBMmXUgDhH7lvA/6YQ4e13gpodbm0Nq8Yw
cF+vxhUJERK5EtJoZVNyUCH1iIo9IynXkK7g3aWcJbl/rhG7Xv43zmPlGrY7P+6G
pkluULkE4looXxjymjwVAEVyZQo7OosZ6l1appjzhkOYRrN8Jva52MMPMpnTXaov
WA/OhEvcYnhpqSq/iMY1o+wp16gFlk71wWfZaTj/DWG/UbA33mFklqZm+wv2GxLK
zegPOMyJJKWwcQvKpQjZ
=j2Ll
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
