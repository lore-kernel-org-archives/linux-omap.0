From: =?UTF-8?B?UmFwaGHDq2wgQXNzw6luYXQ=?= <raph@8d.com>
Subject: Re: [PATCH] OMAPDSS: Add timings for ChiMei G121S1-L01/L02 and G121X1-L01
 LCD displays
Date: Wed, 15 Aug 2012 11:26:51 -0400
Message-ID: <502BBFBB.6090303@8d.com>
References: <20120717140140.GC3850@renkinjitsu.usine.8d.com> <1345023063.3494.20.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from roc.holo.8d.com ([64.254.227.115]:49738 "EHLO roc.holo.8d.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754764Ab2HOP04 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Aug 2012 11:26:56 -0400
In-Reply-To: <1345023063.3494.20.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org

Hi,

On 15/08/12 05:31 AM, Tomi Valkeinen wrote:
> Hi,
>=20
> On Tue, 2012-07-17 at 10:01 -0400, Raphael Assenat wrote:
>> Add timings for ChiMei G121S1-L01/L02 and G121X1-L01 LCD displays.
>>
>=20
> This needed to be converted to work with latest kernel. See patch bel=
ow.
> I've applied the patch to my dev branch, mail me if it's not correct.
>=20
>=20
> commit f4e491f283266b53a926eb3c9017505b04786b9b (HEAD, dev)
> Author: Raphael Assenat <raph@8d.com>
> Date:   Tue Jul 17 10:01:40 2012 -0400
>=20
>     OMAPDSS: Add timings for ChiMei G121S1-L01/L02 and G121X1-L01 LCD=
 displays
>    =20
>     Add timings for ChiMei G121S1-L01/L02 and G121X1-L01 LCD displays=
=2E
>    =20
>     Signed-off-by: Raphael Assenat <raph@8d.com>
>     Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>=20
> diff --git a/drivers/video/omap2/displays/panel-generic-dpi.c b/drive=
rs/video/omap2/displays/panel-generic-dpi.c
> index bc5af25..ae862bb 100644
> --- a/drivers/video/omap2/displays/panel-generic-dpi.c
> +++ b/drivers/video/omap2/displays/panel-generic-dpi.c
> @@ -538,6 +538,82 @@ static struct panel_config generic_dpi_panels[] =
=3D {
>  		},
>  		.name			=3D "primeview_pd104slf",
>  	},
> +
> +	/* ChiMei G121S1-L01 */
> +	{
> +		{

=2E..

> +			.vsync_level	=3D OMAPDSS_SIG_ACTIVE_HIGH,
> +			.hsync_level	=3D OMAPDSS_SIG_ACTIVE_HIGH,
> +			.data_pclk_edge	=3D OMAPDSS_DRIVE_SIG_RISING_EDGE,
> +			.de_level	=3D OMAPDSS_SIG_ACTIVE_HIGH,
> +			.sync_pclk_edge	=3D OMAPDSS_DRIVE_SIG_OPPOSITE_EDGES,

Actually those 3 panels only use the DE signal. The hsync/vsync signals
are not used and on our system we mux them out to make sure they are
kept low as recommended in the panel datasheets.

Since vsync/hsync are not used, I think the vsync_level, hsync_level an=
d
sync_pclk_edge entries could be removed. Otherwise the updated patch
works fine as is.

Best regards,
Rapha=C3=ABl Ass=C3=A9nat
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
