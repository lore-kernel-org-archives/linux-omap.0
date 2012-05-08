From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 0/6] OMAPDSS: Misc fixes and cleanups
Date: Tue, 08 May 2012 14:58:57 +0300
Message-ID: <1336478337.5761.29.camel@deskari>
References: <1336389696-21636-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-3Qc/bP3ko3H2tlSORj6b"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog130.obsmtp.com ([74.125.149.143]:55742 "EHLO
	na3sys009aog130.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753726Ab2EHL7C (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 07:59:02 -0400
Received: by lagv3 with SMTP id v3so7516884lag.27
        for <linux-omap@vger.kernel.org>; Tue, 08 May 2012 04:58:59 -0700 (PDT)
In-Reply-To: <1336389696-21636-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-3Qc/bP3ko3H2tlSORj6b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-05-07 at 16:51 +0530, Archit Taneja wrote:
> The first patch in this series is a follow up on the previously posted se=
ries
> 'OMAPDSS: APPLY: Treat overlay manager timings as shadow registers'. It i=
s
> required for HDMI and DPI interfaces to work properly, it ensures manager
> timings are applied in the set_timing() ops for these interfaces.
>=20
> The next 3 patches remove some unnecessary usage of omap_dss_device point=
er in
> DISPC and APPLY.
>=20
> The last 2 patches are miscellaneous fixes and are self explanatory.
>=20
> Reference tree containing this series:
>=20
> git://gitorious.org/~boddob/linux-omap-dss2/archit-dss2-clone.git mgr_tim=
ing_and_fixes
>=20
> Tested on OMAP4 SDP.
>=20
> Archit Taneja (6):
>   OMAPDSS: DPI/HDMI: Apply manager timings even if panel is disabled
>   OMAPDSS: APPLY: Remove an unnecessary omap_dss_device pointer
>   OMAPDSS: DISPC: Remove omap_dss_device pointer usage from
>     dispc_mgr_pclk_rate()
>   OMAPDSS: DISPC: Remove usage of dispc_mgr_get_device()
>   OMAPDSS: Fix DSI_FCLK clock source selection
>   OMAPDSS: DISPC: Remove Fake VSYNC support

The first four patches seem to be related (or at least based) to the
set_timings series (and the first patch you already had included in
later version).

Should I take the two last patches and apply them already, as they are
fine and don't depend on anything? You could add the first 4 patches
into the set_timings series.

 Tomi


--=-3Qc/bP3ko3H2tlSORj6b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPqQqBAAoJEPo9qoy8lh71AC0P/i86YAOXOpd1ynOsyLQhWR4E
xGebj0AX5upuF32EUXVLTfiuxp9545wydNUbTC6bZiiCwzQDnbtyfkqV6qd/BmIi
FDbWbE5/ppqMI83xDHBPtB/aubvKZiSyQxX1hO0nMuQyvELSE+u1DQVfCE9IaWZz
aAtNLhfw+D+n7fN3YYf617UZNhtWCpGSQn9A3SSaJ0wIoKT7iAvAdIp37YphDyjH
IUxRVlShvuHduXlPIPamnJIJuVaP6owqhPIYcvEtEXfdv4CTRfADgrIBDntLLyEi
uJB9YVmFUoh6LEoh2Y+qUQGFkmrwAdtwjQ04PYz4Db8tNEImavwfpaL/ZzepuMQQ
9OOEGQLsn4tTcqJYdIR8z5fPD+M4NjgLb9RErBgP1o9HKwEmsk/o1tKr+KsZCcXX
+2Pi4GOj2P9VeNYTDKt9GWtD2kmpzZEi7/dyo9HdikyddUZgiHP2BLHknJLKm1NM
gvJ+8gTxRirgvgENA6Vgr8o/PHpaEsK8EOk6GZ84uMgsH6QRJ36deZrQ0E+ffUiA
vR1beBhXNcARK1Ny91HV0J+7DXeKh6uRt/fkSzFfwJKgr70BT7j4UNuwQoCJsPUK
8XDZQY9Ba/kluHvQDCjAGFUBN+wLJLAC+f0ueFDtyfbJfEdsDURPZgBxcZRvDMR7
tqwoCFCMU+M+iO+OrghT
=KQU0
-----END PGP SIGNATURE-----

--=-3Qc/bP3ko3H2tlSORj6b--

