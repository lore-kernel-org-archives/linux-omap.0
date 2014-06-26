From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v3 0/7] OMAPDSS: Support multiple DPI instances
Date: Thu, 26 Jun 2014 15:28:50 +0300
Message-ID: <53AC1202.5050901@ti.com>
References: <1401096492-1405-1-git-send-email-archit@ti.com> <1401864063-19196-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="PmqUKt4C4LTlMJCxFXq1o2ILlpMWPItlN"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:32905 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752271AbaFZM2x (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Jun 2014 08:28:53 -0400
In-Reply-To: <1401864063-19196-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org

--PmqUKt4C4LTlMJCxFXq1o2ILlpMWPItlN
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 04/06/14 09:40, Archit Taneja wrote:
> DSS on DRA7x has 3 DPI outputs. In order to get them to work. We need t=
o make
> the DPI driver support multiple DPI instances. We also need to tweak th=
e
> DT parsing done to match an encoder/connector/panel driver to find the
> corresponding omapdss output. This series tries to achieve the above 2 =
tasks.
>=20
> Changes in v3:
>=20
> - Make indexes in port lists not depend on DPI and SDI CONFIGs.
> - Cleaner code in dss_init_ports/uninit_ports.
> - Split up the patch which creates multi DPI instances.
> - Switch to a simpler way of extracting DPI driver data from dssdev.
> - Change some of the dss-of fucntions, such that
>   omapdss_of_find_source_for_first_ep is simplified.
>=20
> Archit Taneja (7):
>   OMAPDSS: DPI: Use DPI driver data
>   OMAPDSS: DPI: Allocate driver data
>   OMAPDSS: DPI: Store dpi_data pointer in the DT port's data
>   OMAPDSS: DSS: init dss ports cleanly
>   OMAPDSS: DT: Get source endpoint by matching reg-id
>   OMAPDSS: DPI: Add support for multiple instances
>   omapdss: DSS: add reg-id param to dpi_select_source
>=20
>  .../fbdev/omap2/displays-new/encoder-tfp410.c      |   1 +
>  .../fbdev/omap2/displays-new/encoder-tpd12s015.c   |   1 +
>  drivers/video/fbdev/omap2/dss/dpi.c                | 259 +++++++++++++=
+-------
>  drivers/video/fbdev/omap2/dss/dss-of.c             |  58 +++--
>  drivers/video/fbdev/omap2/dss/dss.c                | 108 +++++++--
>  drivers/video/fbdev/omap2/dss/dss.h                |  34 ++-
>  drivers/video/fbdev/omap2/dss/output.c             |  19 +-
>  drivers/video/fbdev/omap2/dss/sdi.c                |   2 +-
>  include/video/omapdss.h                            |   5 +-
>  9 files changed, 354 insertions(+), 133 deletions(-)

Other than the couple minor comments I had, the series looks good.

 Tomi




--PmqUKt4C4LTlMJCxFXq1o2ILlpMWPItlN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTrBICAAoJEPo9qoy8lh718PcP/1SBee+MRTfEu0ccT3Bnr/WQ
q/enD2Ps8uLhhH1Hiz9RVbuGbDlfbqL9I16lFQQwYPboyRQ9DoRdc7JYYax+gSY/
j0TtCUcovYbtLA54OdpLp0WZHeVQO8LOSckV/P4XPd1/Z7qB0x6qZlvM99jFls7h
fUyJjn5EdcL+4N74HVqG0Ce8w0qahOkyCCW9hwEKyi4lWOqHdOywAUeznzgULDcE
Ewp2tlCJW80l7XHARuM++dz+KbY743Yo2YNIUngkl+NDEKkO8kDKidBwXtuCx3aZ
KpRIEIj2+anreyc0M3eagWuWLG3aUgXw3MYbppc/REa+4STM1xVLlLS5fLyZv1l3
OardvUfr2n+naWEIW4KUY8bcOI1rsPK0EMkiLBxtq3+SgfOqlIvJHE+OEefom/B+
wg7rjszwJbFCCJCSBz5doZ5tOzUneLU+A1Foh5iFwfqE9f6nR2/KoQMcKzseuebX
tGMjQLuUt9dtXRnzKqeJhjQe6KPq40W1h0XokyP8MrynlnNFj6IcV3qbN+IwUpE+
HkREILSvxeq/Wt3qiz6IJjoYPO8TJE0IQ75N9TmsYWf214LspAmMgSx/IpqZVY04
ZpR4rf5o7mswhdaG+oShi4JasNWlJAHAERxlT4CxM7XbE19vSTnqvBLl/Y+5znU/
7Mi7o4fhR5n48EE2RBbj
=EdQh
-----END PGP SIGNATURE-----

--PmqUKt4C4LTlMJCxFXq1o2ILlpMWPItlN--
