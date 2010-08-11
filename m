From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@nokia.com>
Subject: Re: [PATCH] OMAP:DSS:Add support for Additional color modes
 supported by OMAP4
Date: Wed, 11 Aug 2010 19:37:55 +0300
Message-ID: <20100811163755.GB13922@nokia.com>
References: <1280987665-25639-1-git-send-email-mythripk@ti.com>
 <FF55437E1F14DA4BAEB721A458B6701706BE125722@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mgw-sa02.nokia.com ([147.243.1.48]:46237 "EHLO
	mgw-sa02.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753318Ab0HKQiV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Aug 2010 12:38:21 -0400
Content-Disposition: inline
In-Reply-To: <FF55437E1F14DA4BAEB721A458B6701706BE125722@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext K, Mythri P" <mythripk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Valkeinen Tomi (Nokia-MS/Helsinki)" <Tomi.Valkeinen@nokia.com>

On Wed, Aug 11, 2010 at 11:22:44AM +0200, ext K, Mythri P wrote:
>=20
> Hi Tomi,
> Can you please comment on the below patch . This is to add new color =
modes supported by OMAP4.
>=20
> Thanks and regards,
> Mythri.
> -----Original Message-----
> From: K, Mythri P=20
> Sent: Thursday, August 05, 2010 11:24 AM
> To: linux-omap@vger.kernel.org
> Cc: tomi.valkeinen@nokia.com; Semwal, Sumit; K, Mythri P
> Subject: [PATCH] OMAP:DSS:Add support for Additional color modes supp=
orted by OMAP4
>=20
> From: Sumit semwal <sumit.semwal@ti.com>
>=20
> This patch adds support for new color modes that are supported by the=
 video/graphics pipeline of OMAP4
>=20
> Signed-off-by: Mythri P K <mythripk@ti.com>
> ---
>  arch/arm/plat-omap/include/plat/display.h |   16 ++++++++-
>  drivers/video/omap2/dss/dispc.c           |   53 +++++++++++++++++++=
+++-------
>  drivers/video/omap2/dss/overlay.c         |    6 ++-
>  3 files changed, 59 insertions(+), 16 deletions(-)
>=20
> diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/pla=
t-omap/include/plat/display.h
> index 7a6eedd..ebf1020 100644
> --- a/arch/arm/plat-omap/include/plat/display.h
> +++ b/arch/arm/plat-omap/include/plat/display.h
> @@ -89,6 +89,12 @@ enum omap_color_mode {
>  	OMAP_DSS_COLOR_ARGB32	=3D 1 << 11, /* ARGB32 */
>  	OMAP_DSS_COLOR_RGBA32	=3D 1 << 12, /* RGBA32 */
>  	OMAP_DSS_COLOR_RGBX32	=3D 1 << 13, /* RGBx32 */
> +	OMAP_DSS_COLOR_NV12	=3D 1 << 14, /* NV12 format: YUV 4:2:0 */
> +	OMAP_DSS_COLOR_RGBA12	=3D 1 << 15, /* RGBA12 - 4444 */
> +	OMAP_DSS_COLOR_XRGB12	=3D 1 << 16, /* xRGB12, 16-bit container */

Isn't this the same as RGB12U?

--=20
Ville Syrj=E4l=E4
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
