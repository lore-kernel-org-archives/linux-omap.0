From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@nokia.com>
Subject: Re: [PATCH] OMAP: DSS2: OMAPFB: Fix null pointer check
Date: Fri, 12 Nov 2010 14:07:06 +0200
Message-ID: <20101112120705.GF27763@nokia.com>
References: <1289562435-8056-1-git-send-email-samreen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:22400 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751853Ab0KLMHU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 12 Nov 2010 07:07:20 -0500
Content-Disposition: inline
In-Reply-To: <1289562435-8056-1-git-send-email-samreen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Samreen <samreen@ti.com>
Cc: "Valkeinen Tomi (Nokia-MS/Helsinki)" <Tomi.Valkeinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

On Fri, Nov 12, 2010 at 12:47:15PM +0100, ext Samreen wrote:
> A null pointer check added.
>=20
> Signed-off-by: Samreen <samreen@ti.com>
> ---
>  drivers/video/omap2/omapfb/omapfb-main.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video=
/omap2/omapfb/omapfb-main.c
> index 6a704f1..55bed89 100644
> --- a/drivers/video/omap2/omapfb/omapfb-main.c
> +++ b/drivers/video/omap2/omapfb/omapfb-main.c
> @@ -2133,6 +2133,8 @@ static int omapfb_parse_def_modes(struct omapfb=
2_device *fbdev)
>  	int r =3D 0;
> =20
>  	str =3D kmalloc(strlen(def_mode) + 1, GFP_KERNEL);
> +	if (str =3D=3D NULL)
> +		return -EINVAL;
>  	strcpy(str, def_mode);

While you're at it you could change the code to use kstrdup().

--=20
Ville Syrj=E4l=E4
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
