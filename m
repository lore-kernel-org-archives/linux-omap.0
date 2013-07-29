From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/PATCH 2/2] driver: spi: Add quad spi read support
Date: Mon, 29 Jul 2013 12:59:58 +0300
Message-ID: <20130729095958.GI23710@radagast>
References: <1375082550-30544-1-git-send-email-sourav.poddar@ti.com>
 <1375082550-30544-3-git-send-email-sourav.poddar@ti.com>
 <20130729093258.GF23710@radagast>
 <51F6392B.8030809@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fDERRRNgB4on1jOB"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49927 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752331Ab3G2KAW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Jul 2013 06:00:22 -0400
Content-Disposition: inline
In-Reply-To: <51F6392B.8030809@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sourav Poddar <sourav.poddar@ti.com>
Cc: balbi@ti.com, broonie@kernel.org, spi-devel-general@lists.sourceforge.net, grant.likely@linaro.org, linux-omap@vger.kernel.org, rnayak@ti.com

--fDERRRNgB4on1jOB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2013 at 03:13:07PM +0530, Sourav Poddar wrote:
> On Monday 29 July 2013 03:02 PM, Felipe Balbi wrote:
> >On Mon, Jul 29, 2013 at 12:52:30PM +0530, Sourav Poddar wrote:
> >>Since, qspi controller uses quad read.
> >>
> >>Configuring the command register, if the transfer of data needs
> >>dual or quad lines.
> >>
> >>This patch has been done on top of the following patch[1], which is jus=
t the
> >>basic idea of adding dual/quad support in spi framework.
> >>$subject patch will undergo changes with the ongoing discussion in the
> >>community.
> >>
> >>This patch is posted to demonstrate how patch 1 of the series will supp=
ort
> >>quad read.
> >>
> >>[1]: http://comments.gmane.org/gmane.linux.kernel.spi.devel/14047
> >>
> >>Signed-off-by: Sourav Poddar<sourav.poddar@ti.com>
> >>---
> >>  drivers/spi/spi-ti-qspi.c |   16 ++++++++++++++--
> >>  1 files changed, 14 insertions(+), 2 deletions(-)
> >>
> >>diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
> >>index 51fe95f..8a32b1c 100644
> >>--- a/drivers/spi/spi-ti-qspi.c
> >>+++ b/drivers/spi/spi-ti-qspi.c
> >>@@ -86,6 +86,7 @@ struct ti_qspi {
> >>  #define QSPI_3_PIN			(1<<  18)
> >>  #define QSPI_RD_SNGL			(1<<  16)
> >>  #define QSPI_WR_SNGL			(2<<  16)
> >>+#define	QSPI_RD_DUAL			(3<<  16)
> >>  #define QSPI_RD_QUAD			(7<<  16)
> >so RD_QUAD is defined in previous patch but not RD_DUAL ? What gives ?
> >
> I think I will define RD_DUAL in the previous patch...
> >IMHO, just merge this patch with previous and make the entire driver
> >depend on the other patch.
> >
> but I was thinking of keeping rest of the $subject patch seperate, since =
the
> idea of implementing dual/quad read in spi framework is still under
> discussion.
> and this patch will change.
>=20
> So, it would be good if we can get the basic previous patch in, and
> then when the
> other discussion is sorted out, we can get this in?

alright, in that case it makes sense.

--=20
balbi

--fDERRRNgB4on1jOB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR9j0dAAoJEIaOsuA1yqREznMQAJz4eE7HEKPkFZYxYn1ruqTD
L7gan9TKe9gBnTYBVhMZks0OpTklQfVAHZZWXdU5bj1SVy7hHeCJw/yXIOXn7vqg
ivdYk3H1aEIi+QlYoxYw0z1XojTU1wOz/J6gX7RPnd9luRrVK/AKeIlFAvBBbpDl
UdsFGP3bA7EdGs8cSh6tQP8uqPuXiO1FKnOQmXDC7G9Vi2ofYrzBUEhWQTSg9/Za
zkUPCUic/vxIqWo80QpLDq6GKVRQ/B7hrO0SehEr4MLmSaZq9RPmrlF7+aOQ7PFJ
0vsEuNddNAy50S3UjxQso4Ias6pCtk8BA6bJhotuFnEZQvjymDXF6DVWvmgyvXWE
ps/HqJD907OZjqL+cX7dBNMErVQbGveumckBxJNlkEBfpGwZ2mhPt9JRjPsBraUu
NkKAUu3rrF2Lllp0EewPm08s0onsXHAZIyYtcezNuGl6hrx1gKri9KOFBR5V8amH
O3dQ80yAmBrOc2ZkduEfgTxU8snHK0MfkkMyprESO9cyUHhnOd7qDDAMg8uVCzib
8vp9XdAq8d2ctwA7r5eZDTCWSh0A1UUv3dts0nfSZL5At88FApqUQGjaXYvxPt/x
qDEqYJPdM4CwNifed4eXR7pNm9kRKoBwzYXiFJ5B43zeKNRlQB1nacBJ8MmoKM0f
Sf3WsVSmAdVAlWXGuzkc
=mr1V
-----END PGP SIGNATURE-----

--fDERRRNgB4on1jOB--
