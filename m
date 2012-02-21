From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 3/3] OMAPDSS: DSS: Add runtime_pm protection around
 wait_for_vsync.
Date: Tue, 21 Feb 2012 18:08:18 +0200
Message-ID: <1329840498.2090.36.camel@deskari>
References: <1329833192-16529-1-git-send-email-archit@ti.com>
	 <1329833192-16529-4-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-IEzyDC6qwHFbxrNxAKRn"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:37129 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751719Ab2BUQIW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Feb 2012 11:08:22 -0500
Received: by mail-lpp01m010-f41.google.com with SMTP id f4so10342082lam.14
        for <linux-omap@vger.kernel.org>; Tue, 21 Feb 2012 08:08:20 -0800 (PST)
In-Reply-To: <1329833192-16529-4-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: lajos@ti.com, linux-omap@vger.kernel.org


--=-IEzyDC6qwHFbxrNxAKRn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-02-21 at 19:36 +0530, Archit Taneja wrote:
> From: Lajos Molnar <lajos@ti.com>
>=20
> If DSS is suspended during a wait_for_vsync operation, it may loose its c=
lock.
> Request runtime_pm around wait_for_vsync.
>=20
> Signed-off-by: Lajos Molnar <lajos@ti.com>
> Signed-off-by: Archit Taneja <archit@ti.com>
> ---
>  drivers/video/omap2/dss/dispc.c |   16 +++++++++++-----
>  1 files changed, 11 insertions(+), 5 deletions(-)

This only handles omap_dispc_wait_for_irq_interruptible_timeout(),
there's also omap_dispc_wait_for_irq_timeout().

However, I think it'd be better to do the runtime_get/put in the caller,
instead of in these dispc's wait funcs. While it doesn't really matter
with dss_mgr_wait_for_vsync(), for dss_mgr/ovl_wait_for_go() it makes
much more sense to get/put there just once, instead of every time the
omap_dispc_wait_* is called.

 Tomi


--=-IEzyDC6qwHFbxrNxAKRn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPQ8FyAAoJEPo9qoy8lh7155YQAJqTbSeaIP1uGsyT5GONY2Zh
LGuBekRArQcAolNq74eM/5DmjkZ+e/dhza6SyUfKvxbdboYvrmu9V3BbAQE8isj0
DbFe7tmHEFs9YuCW7j0h5HS5q+CZD6tohz0V+5rZScz43Hte71HdVsfBHYqTDkzQ
sZ1cbNSUz5ftuD0BZEkIAwwfsewnJ4hjjJaS6R0x/O/Ey357KzixjBoAX5UZ55Qw
ddRb9N/1TPB4611cbKrU5v0VCyhRDQmN8YGjtEdP9+L41cizrqKgEqi/odq8dNC8
SM7IB/gIFI/8Q9QZzC1Aq4JEK6zx3n4KDiztlvom/E/f+6EsxwVNHtGjZFWtmbmF
rXpcaWWfzGP9eIxw2cXnEFA5YMD8wnx7df2Il/maQn6ifEiZsBEHdEMhbrutQPkJ
kjr+wwq9nJGJ3W11+w8UzHeK3oNZBGDGB3IvT28ZIa01kHSGjDQxw9ZdcK1KpYUv
KDzTaX+GGEoaNWIxJSYNqXwZ1FwQu7vNthdEDp7SE1Gjgv0mX165bRkYliAwZgYG
oCFRd2TMYD7MgxPsDNygAKqo0cF0rNnvBdtHHxr5sRtxB+8KjnVtygnFf6GjzM0F
DuL5pumBZtLlHqvVgWh/J0K0Eyg5i2mzxLymDe1oMcexdXNd1fWSoy4uZnljRoZu
xTBg340oepJQeDsm/T2R
=Eyl0
-----END PGP SIGNATURE-----

--=-IEzyDC6qwHFbxrNxAKRn--

