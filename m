From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2] usb: musb: fix pm_runtime mismatch
Date: Tue, 20 Dec 2011 13:38:25 +0200
Message-ID: <20111220113823.GJ31842@legolas.emea.dhcp.ti.com>
References: <1324324914-14584-1-git-send-email-felipe.contreras@nokia.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9aCKuHbn5v2q3RVc"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1324324914-14584-1-git-send-email-felipe.contreras-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Contreras <felipe.contreras-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, Jarkko Nikula <jarkko.nikula-FVTvWyuFUl3QT0dZR+AlfA@public.gmane.org>, Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--9aCKuHbn5v2q3RVc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 19, 2011 at 10:01:54PM +0200, Felipe Contreras wrote:
> From: Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>=20
> In musb_init_controller() there's a pm_runtime_put(), but there's no
> pm_runtime_get(), which creates a mismatch that causes the driver to
> sleep when it shouldn't.
>=20
> This was introduced in 7acc619[1], but it wasn't triggered in my setup
> until 18a2689[2] was merged to Linus' branch at point df0914[3]. IOW;
> when PM is working as it was supposed to.
>=20
> However, it seems most of the time this is used in a way that keeps the
> counter above 0, so nobody noticed. Also, it seems to depend on the
> configuration used in versions before 3.1, but not later (or in it).
>=20
> I found the problem by loading isp1704_charger before any usb gadgets:
> http://article.gmane.org/gmane.linux.kernel/1226122
>=20
> All versions after 2.6.39 are affected.
>=20
> [1] usb: musb: Idle path retention and offmode support for OMAP3
> [2] OMAP2+: musb: hwmod adaptation for musb registration
> [3] Merge branch 'omap-for-linus' of git://git.kernel.org/pub/scm/linux/k=
ernel/git/tmlind/linux-omap-2.6
>=20
> Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

applied, thanks

--=20
balbi

--9aCKuHbn5v2q3RVc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJO8HOvAAoJEIaOsuA1yqRERB4P/08Mx+ZByh3INWPzHPztXiLM
3FSz3inIRYde+VZqB0DUDp50JxpgT1hvvpl1kuxHBXHv9glfsUX9G2cdHXXSl9VM
KlOwcb/7dFo6Xq18PK5+ff5Vwy5eIXSxRg4DnK/iWpHVo/KT2S4zeEpma3dwxlmI
I39ANSwvJUGwhQA6uoEEtJsG4TJFOPf5fYvyw9FCOnV2M8m+tKh5kcJBEnYB/yhG
FQo6ZMFitvqXD7xAjpa633KvHFoTqhG8jAyMo7iV7owcs5VA2hhmwB8P+cowbT5K
8qIOhE3z7dT20DYRdIB1Bf9v/zgEc8jr53Po5PJ4Dl04aOOfGXr3QTZRBOULPTWt
Wjc5uEHLxg58rJyJ73SQMsAS0643iRaE1CVanirT80PQOV05y1VNKMvuKzjzVMyN
VpfnAxkyxpBj93C7/A3SUpm5PQ93BKIukmO0SoZFSFQJIJ/1off2ZjmfMyDCdpRo
PmAWe+8NV+k3LnNw+8f1jK2Jk6iMer7Sw8XmZIRaB9c/zp2PIupF+S3MNN2F5EbH
eUU4xgSpPj39xh/BJMf7a04MMZf4w/K01KtH8a6ufdBHlcY98bdCxqKUuKuyDF3K
Ih6o9lZxZ5UCZWAWGeYT/B/rg/Ovogo3/7UVv+YyhXG7gzD016UrX3jr7UwLadVg
FRSN89jmHYKWW8JEhAF9
=X3Ra
-----END PGP SIGNATURE-----

--9aCKuHbn5v2q3RVc--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
