From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAPDSS: Use only "omapdss_dss" platform device to get
 context lost count
Date: Thu, 29 Nov 2012 12:54:42 +0200
Message-ID: <50B73EF2.4090307@ti.com>
References: <1354102299-4928-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig39107395C13876FE2885F6BB"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54230 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752029Ab2K2Kyr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Nov 2012 05:54:47 -0500
In-Reply-To: <1354102299-4928-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vgerk.kernel.org, t-kristo@ti.com, linux-arm-kernel@lists.infradead.org, rnayak@ti.com

--------------enig39107395C13876FE2885F6BB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-11-28 13:31, Archit Taneja wrote:
> When enabling a hwmod, omap_hwmod refers to the register mentioned in t=
he
> hwmod struct's member 'prcm.omap4.context_offs' to see whether context =
was
> lost or not. It increments the context lost count for the hwmod and the=
n clears
> the register.
>=20
> All the DSS hwmods have the same register(RM_DSS_DSS_CONTEXT) as contex=
t_offs.
> When DSS is enabled, the first hwmod to be enabled is the "dss_core" hw=
mod since
> it's corresponding platform device is the parent platform device("omapd=
ss_dss").
> The dss_core hwmod updates it's context lost count correctly and clears=
 the
> register. When the hwmods corresponding to the children platform device=
s are
> enabled, they see that the register is clear, and don't increment their=
 context
> lost count. Therefore, all the children platform devices never report a=
 loss in
> context.
>=20
> The DISPC driver currently gets the context lost count for DSS power do=
main from
> it's corresponding platform device instance("omapdss_dispc"). The DISPC=
 platform
> device is one of the child devices, and it's corresponding hwmod("dss_d=
ispc")
> doesn't report the context lost count correctly.
>=20
> Modify dss_get_ctx_loss_count() such that it always takes the "omapdss_=
dss"
> platform device as it's input, move the function to dss.c so that it ha=
s access
> to that platform device.
>=20
> Signed-off-by: Archit Taneja <archit@ti.com>
> ---
>  drivers/video/omap2/dss/core.c  |   15 ---------------
>  drivers/video/omap2/dss/dispc.c |    4 ++--
>  drivers/video/omap2/dss/dss.c   |   15 +++++++++++++++
>  drivers/video/omap2/dss/dss.h   |    3 ++-
>  4 files changed, 19 insertions(+), 18 deletions(-)

I think this looks fine. I'll apply to dss master.

 Tomi



--------------enig39107395C13876FE2885F6BB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJQtz7yAAoJEPo9qoy8lh71Su4P/2SnYj6HIdxtKLkb9EweQMHZ
mctJ4cXQ2jqpXbrA+x8hBppvtZd1UgiKF8GZdj4ayMzdQezMer4GY8ay3HkoA5LW
fbGSHt3pHktjyQi8K1ZTHdPml5lXMfW7/WEWC4gp/r3fO8gddkgy4FTKFe9G8AOw
gAcp+rjH+pEFJG+zFKV3dfZwmaFinYVU9hc046VBMG9livwzDQP8MVSEM+s7IYA0
0GwA+ot9XQ22Le4olwAGDo2amNH911xYmiYm7a0iq+8UrgejHuYpQvmbG5JRQnBK
GJYEFZ1vCZgONwnalR/Bf82rC2RDX+sv4lqhzKdJV+WfiO2CIWXwQtUdWir/Gmcs
3ajuCQskT68HjLt3Jt8iEsb41WWMDJ1Et8Q0RSMKBP3itBI99U6y1kobevCHXNRm
85EWNnZx2xO6crfjNG1CG/wMpW9H/sLb4ZdGEwJGtkxzYvBRiBezVDr8rkykfxyA
/HhYSbvEvpSUHvbj4Y/czpvhUBFIqpfL6U+5f5busxeVl/QxV/zNG3gGmEcsu3Fd
DdItlClhNnCrsDcyUe5Z+/vnkjifyOS75zNkX7M9RfZrlpbtbE6Jl4oZhodWaaOV
TPJoXPgHMe0dz5MZRsZ62bFqX7tEZEhvYtM2qmbo+E260QDnTZX/CaMRRNRIxxo3
g4HHvGyl5k1ydZyxqwKq
=ijOV
-----END PGP SIGNATURE-----

--------------enig39107395C13876FE2885F6BB--
