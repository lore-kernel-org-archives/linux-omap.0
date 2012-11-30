From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCHv2] OMAP: board-files: fix i2c_bus for tfp410
Date: Fri, 30 Nov 2012 11:30:58 +0200
Message-ID: <50B87CD2.8010107@ti.com>
References: <1353068553-26897-1-git-send-email-tomi.valkeinen@ti.com> <1353573596-5550-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig752D792B71C1698BB19C5E21"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33940 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932158Ab2K3JbE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Nov 2012 04:31:04 -0500
In-Reply-To: <1353573596-5550-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Thomas Weber <thomas@tomweber.eu>, stable@vger.kernel.org

--------------enig752D792B71C1698BB19C5E21
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Tony,

On 2012-11-22 10:39, Tomi Valkeinen wrote:
> The i2c handling in tfp410 driver, which handles converting parallel RG=
B
> to DVI, was changed in 958f2717b84e88bf833d996997fda8f73276f2af
> (OMAPDSS: TFP410: pdata rewrite). The patch changed what value the
> driver considers as invalid/undefined.  Before the patch, 0 was the
> invalid value, but as 0 is a valid bus number, the patch changed this t=
o
> -1.
>=20
> However, the fact was missed that many board files do not define the bu=
s
> number at all, thus it's left to 0. This causes the driver to fail to
> get the i2c bus, exiting from the driver's probe with an error, meaning=

> that the DVI output does not work for those boards.
>=20
> This patch fixes the issue by changing the i2c_bus number field in the
> driver's platform data from u16 to int, and setting the bus number to -=
1
> in the board files for the boards that did not define the bus. The
> exception is devkit8000, for which the bus is set to 1, which is the
> correct bus for that board.
>=20
> The bug exists in v3.5+ kernels.
>=20
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Reported-by: Thomas Weber <thomas@tomweber.eu>
> Cc: Thomas Weber <thomas@tomweber.eu>
> Cc: <stable@vger.kernel.org> # v3.5+
> ---
>  arch/arm/mach-omap2/board-3430sdp.c      |    1 +
>  arch/arm/mach-omap2/board-am3517evm.c    |    1 +
>  arch/arm/mach-omap2/board-cm-t35.c       |    1 +
>  arch/arm/mach-omap2/board-devkit8000.c   |    1 +
>  arch/arm/mach-omap2/board-omap3evm.c     |    1 +
>  arch/arm/mach-omap2/board-omap3stalker.c |    1 +
>  include/video/omap-panel-tfp410.h        |    2 +-
>  7 files changed, 7 insertions(+), 1 deletion(-)

Did this make it into your v3.8 branch?

 Tomi



--------------enig752D792B71C1698BB19C5E21
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJQuHzSAAoJEPo9qoy8lh71FqoQAJl8G2igqej7sxkCDxeyqG5E
NjHjTa/W/Y7j6bet5cBhpPVV26IJJ/4IH26zWCwscXg2J/lNJPsAs3hgXc6HEYcT
gNJyDQ/Du/Ht4vZPvS46AWF3YCcOjLJHih0hgwPMIIQcpzXicvWVYvsMb6ctG3QZ
oCXWAlsqGT5AAJgtBLA9r5Xwt78MgQCnMNtQLD7H8r6f5VXpll91ylm1J5cHVRSJ
Ls5w8bCIh28LbTUid/vm0flOGDhUAOMK+lyiNPZpE2KHx/CvtLrQJwhHns/FkNIG
OzsVkFQW/qkMAZtcT4TPnKOjRPH5WjScKUtUtETEUu+sAEW8HXaekz/QD7rhUlDM
KYGXAQHZA/dbM2c6zKNxJnbck17xyMwIuOqA/xhsk+LOVP6IvTTE+80XefZ0Azi1
Z/QzI0GgVJkTpUE+zkxcx3WUSNx3STMKy25wLUGeV3wQbgt4osm5qbIDkjkYOZih
YwRlKBrR45IuCrmhrUiG9Fq1s8njXkEzU61m0VyaJGRGHc/GIuzLYdDChKSdhUEZ
83oQDdZ+4kn2KR4k/gv/MisjIRZQPxDnSvo7ugrx8IFfgLkviPvcWyGJsU5NmbtG
embvvQfJr+Ezm2R+vm/8sqUkihpPZoW2ImiI/+x3Z3CkdrwNugJ80WCTB/GXL7cg
kuJhuwmYgxHTnADLfq1Q
=3p7p
-----END PGP SIGNATURE-----

--------------enig752D792B71C1698BB19C5E21--
