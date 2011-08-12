From: Michael Jones <michael.jones@matrix-vision.de>
Subject: Re: [PATCH] OMAP: DSS2: DSI: fix warning unused variable 'dsidev'
Date: Fri, 12 Aug 2011 09:45:25 +0200
Message-ID: <4E44DA15.7080103@matrix-vision.de>
References: <1312556561-27179-1-git-send-email-michael.jones@matrix-vision.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail2.matrix-vision.com ([85.214.244.251]:43103 "EHLO
	mail2.matrix-vision.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752671Ab1HLHp3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Aug 2011 03:45:29 -0400
In-Reply-To: <1312556561-27179-1-git-send-email-michael.jones@matrix-vision.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Archit Taneja <archit@ti.com>

Hi all,

On 08/05/2011 05:02 PM, Michael Jones wrote:
>=20
>   CC      drivers/video/omap2/dss/dsi.o
> drivers/video/omap2/dss/dsi.c: In function =E2=80=98omap_dsi_prepare_=
update=E2=80=99:
> drivers/video/omap2/dss/dsi.c:3936: warning: unused variable =E2=80=98=
dsidev=E2=80=99
>=20
> Signed-off-by: Michael Jones <michael.jones@matrix-vision.de>
> ---
>  drivers/video/omap2/dss/dsi.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/=
dsi.c
> index 345757c..3ae0fd8 100644
> --- a/drivers/video/omap2/dss/dsi.c
> +++ b/drivers/video/omap2/dss/dsi.c
> @@ -3933,7 +3933,9 @@ int omap_dsi_prepare_update(struct omap_dss_dev=
ice *dssdev,
>  				    u16 *x, u16 *y, u16 *w, u16 *h,
>  				    bool enlarge_update_area)
>  {
> +#ifdef DEBUG
>  	struct platform_device *dsidev =3D dsi_get_dsidev_from_dssdev(dssde=
v);
> +#endif
>  	u16 dw, dh;
> =20
>  	dssdev->driver->get_resolution(dssdev, &dw, &dh);

Upon a second look, this seems to fix a problem that doesn't exist and
create one that didn't. Having reverted this patch, I don't get the
warning I originally saw, and using the patch, I get a compiler error.
Please disregard this submission and excuse the noise.

-Michael

MATRIX VISION GmbH, Talstrasse 16, DE-71570 Oppenweiler
Registergericht: Amtsgericht Stuttgart, HRB 271090
Geschaeftsfuehrer: Gerhard Thullner, Werner Armingeon, Uwe Furtner, Erh=
ard Meier
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
