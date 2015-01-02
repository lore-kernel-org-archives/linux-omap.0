From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/3] soc: ti: Add wkup_m3_ipc driver
Date: Fri, 2 Jan 2015 14:33:20 -0600
Message-ID: <20150102203320.GF4920@saruman>
References: <1420228817-41310-1-git-send-email-d-gerlach@ti.com>
 <1420228817-41310-3-git-send-email-d-gerlach@ti.com>
 <20150102201643.GE4920@saruman>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ULyIDA2m8JTe+TiX"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150102201643.GE4920@saruman>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--ULyIDA2m8JTe+TiX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 02, 2015 at 02:16:43PM -0600, Felipe Balbi wrote:
> On Fri, Jan 02, 2015 at 02:00:16PM -0600, Dave Gerlach wrote:
> > Introduce a wkup_m3_ipc driver to handle communication between the MPU
> > and Cortex M3 wkup_m3 present on am335x.
> >=20
> > This driver is responsible for actually booting the wkup_m3_rproc and
> > also handling all IPC which is done using the IPC registers in the cont=
rol
> > module, a mailbox, and a separate interrupt back from the wkup_m3. A sm=
all
> > API is exposed for executing specific power commands, which include
> > configuring for low power mode, request a transition to a low power mod=
e,
> > and status info on a previous transition.

another comment is that no user of such API is provided, so it's very
difficult to verify that there's no other way of implementing this.

--=20
balbi

--ULyIDA2m8JTe+TiX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUpwCQAAoJEIaOsuA1yqREvggP/1asB6h3YrByu8+OGhCJyXEc
xTx38v1xEuQ+OKdU2+NXW+/PBOfFe6riiJxYbK2Lk7ylq8Wu9lFFpzqQanGXNWJY
Gec7hCkOMmy0MrNBHDVlMvwzL+O5V/Om4VdtEP/6z0cFRMq3IlmJHPBMkpqTlJ72
8ICsljnEwH2d5xjYJ/JrXApG/8bNQdoGeVR6zt6Wm9lezd1MlVANQPTd/HRYyQFU
Mk8P+ALBZb6oc4CKMKgxNBW85ufr2IQw3Z/I75mPoWl/KjgWa6tSaSH1iuiwlXcl
SL1B/P6IS0FiJZ48HHgIAJWC2fgQSMGDQWEaqU3pn0DZ4ZJOqpYlGSQpSUH0e6oj
cyFXrZL+qOgSmN4FfR3zpoWykgOV09+BHTj+o/7n/QFRjOpvY79juSKr8IpxKe5h
wRsl39m964sCItaYAWzUGL8ITgbclZ14j59CX2OuHKW7xNYvWxYfUz400NWuRzew
SjhwaBB3Ob31KWmhyrfl8w7Krelpve2D/mf5HXebiylUVDEV4f13xcP4pp3/X0iP
i0dNLI5PX5JhUNVPwslGM/w+AXcGDUM4hdFudXWmnSAHwfSXwnDfxVI79ON9qASi
DnuDIE+P14xbPIIpaXyXwejKEwOl6gt07Isla0UFqK1ctm+j5t8LNxbcRXE3EOfE
AHFQoWO3U40MGkvrwMIy
=3hJe
-----END PGP SIGNATURE-----

--ULyIDA2m8JTe+TiX--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
