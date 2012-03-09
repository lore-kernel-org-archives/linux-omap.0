From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: Fix compile error when FB_OMAP2 is not set
Date: Fri, 09 Mar 2012 09:55:00 +0200
Message-ID: <1331279700.1927.1.camel@deskari>
References: <20120308204328.GW12083@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-UCS4x/5XgcMjnsNvK57p"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:57396 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753074Ab2CIHzG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Mar 2012 02:55:06 -0500
Received: by lagw12 with SMTP id w12so1947998lag.34
        for <linux-omap@vger.kernel.org>; Thu, 08 Mar 2012 23:55:03 -0800 (PST)
In-Reply-To: <20120308204328.GW12083@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--=-UCS4x/5XgcMjnsNvK57p
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-03-08 at 12:43 -0800, Tony Lindgren wrote:
> Otherwise we will get:
>=20
> arch/arm/plat-omap/fb.c:101: error: expected =E2=80=98)=E2=80=99 before =
=E2=80=98*=E2=80=99 token
>=20
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Thanks. It seems I need to improve my testing practices to include
non-FB builds also...

 Tomi


--=-UCS4x/5XgcMjnsNvK57p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPWbdQAAoJEPo9qoy8lh71oQkQALJP42ctO3GIoHaVSntjra0M
JUc++TrYLDiRfhZj2WP16Pk5xBVBujlrUbxc/GRjaaYX9ZGACgTRe5kQ5ehav3g4
JxyM5i53sYdnkTWtbtIZARpD/S8Lw6THx7ygGF1m1g6pHY5664L8gHyXOJ03jiLr
BBqMNNw56NaOD483K/g8xKNZhIKQH3JbNNvhOJ5GVGcs/6nwntQhfTxuBQRRhxg3
s1uUrDiy6dT6C0l8mm09wxn6HNgeXTuFTajaoyyVrs3TsmS8Co3/uxBEUISuQrVC
x5PpXhvWOh/y8lkZIkBczlbqc82bueSufwq4vndvNtrjK7oihF8iNNRVTzqyYdQ7
u6lRXK4OLaggoh6ZUsV9y4cSgRzNvrMNW7xttXN4NgSoWibcQw7FgaCr4xcYFsI6
NhyOJf0FiZqO6O7frk8C8JRE3nVzHvmra+ihDalfl7up5rMQOkr1lW78oaM9NCGV
r6+climKfhDKQLehONjjipsO44SeByQG6Uc4hdrsxw4mXawyfBHUGUjzkII+8DQI
SHAIAxv86wfUaJ9XzjJm4oOhOhue9LcyP9jdbFFux7bXqcdlD9jCWQcsW7nscolr
CrmL6VJ/RBejLdRWnhZHl9r4ZTXllz7h5x4MEhZxZBY67cDt0Y1oIxyt5g5+7dkQ
GnoEUjpD0D4oPvscxWTU
=f4k9
-----END PGP SIGNATURE-----

--=-UCS4x/5XgcMjnsNvK57p--

