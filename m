From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 0/9] OMAPDSS: minor fixes & cleanups
Date: Mon, 22 Oct 2012 09:54:35 +0300
Message-ID: <5084EDAB.4070402@ti.com>
References: <1350472835-28727-1-git-send-email-tomi.valkeinen@ti.com> <5084DE3D.1050502@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC2608E308EE6D8067870C02A"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44547 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751952Ab2JVGyi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Oct 2012 02:54:38 -0400
In-Reply-To: <5084DE3D.1050502@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

--------------enigC2608E308EE6D8067870C02A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-10-22 08:48, Archit Taneja wrote:
> On Wednesday 17 October 2012 04:50 PM, Tomi Valkeinen wrote:
>> Hi,
>>
>> This series contains minor cleanups and fixes for omapdss.
>=20
> This series looks fine to me. I have a related cleanup patch which you
> may consider adding to the series.
>=20
> Thanks,
> Archit
>=20
> From: Archit Taneja <archit@ti.com>
> Date: Thu, 18 Oct 2012 16:51:57 +0530
> Subject: [PATCH] OMAPDSS: Remove acb and acbi fields from omap_dss_devi=
ce
>=20
> acbi and acb fields were meant for passive matrix panels which omapdss
> doesn't
> support any longer. Remove these fields from omap_dss_device struct.
>=20
> Signed-off-by: Archit Taneja <archit@ti.com>
> ---
>  include/video/omapdss.h |    4 ----
>  1 file changed, 4 deletions(-)
>=20
> diff --git a/include/video/omapdss.h b/include/video/omapdss.h
> index 88c8294..f39e6aa 100644
> --- a/include/video/omapdss.h
> +++ b/include/video/omapdss.h
> @@ -621,10 +621,6 @@ struct omap_dss_device {
>      struct {
>          struct omap_video_timings timings;
>=20
> -        int acbi;    /* ac-bias pin transitions per interrupt */
> -        /* Unit: line clocks */
> -        int acb;    /* ac-bias pin frequency */
> -
>          enum omap_dss_dsi_pixel_format dsi_pix_fmt;
>          enum omap_dss_dsi_mode dsi_mode;
>          struct omap_dss_dsi_videomode_timings dsi_vm_timings;

Thanks, applied to omapdss tree.

 Tomi



--------------enigC2608E308EE6D8067870C02A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQIcBAEBAgAGBQJQhO2rAAoJEPo9qoy8lh71rLAP+wdMqUjpizezLM3vnfoql7Xz
WNZcZYPQ8qzSBLzQvGD4j0jXzmuDfE9YNTAMMYR099zkqBw3gxuFvr2tNxy8TUrF
TpVEeE7ssg+Wl35q/MK51cFdR6HAMp+tFtsBuPUgNdFhGRt1IyFDQzMBuM7us3pP
GbmpAE8ZkOhnsxlfHplCVUhmeedqScP/VUvJihWY52ahzEGsSC1wu+LEnWx+PTET
USjtXOI0G3KtyzXsmoLEUO/c2rg9za7xzmigC9mqKG6fLA/pfWbY8EWBVtuGaSwl
FTB4tQaPe56Vt1a9vlVQP2fqg/9NBEBW2LfJrHV6CkmYvJumrSkSLy4N67R2D8wz
MZKaoW3ZBd/5gBf7dwz7KAu9QLALe/sGiVbreb6Ie3T0p9ni782qfdQYtpXYC759
XZN4C6lhNsqi9Y5GkzN5aVAGNQJ3KXHzTomKl0mSKzCNtcwKsxKw8QrRLDDVbNFF
NGmyJOOq4D8exXgJJNLCau+eK2s7B+g2qyfR0BfGYhMa00tWMe14k70YSe2WMfgX
m+t+4G4mckl5l1azUWlrywmGF78hdvCu2JyAOstGUo/2du6q/IfXo0kYc6NgWNZc
EVGH//wC6mL+9qPCMqKmkCaME6EgmEFXU2MiQ43zSte/EbryXjQfG0Wi4camRB8/
S184RPguREhyQ5I7zLl7
=bKGx
-----END PGP SIGNATURE-----

--------------enigC2608E308EE6D8067870C02A--
