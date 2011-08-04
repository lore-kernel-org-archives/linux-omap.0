From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAP: DSS2: DSI: Support non-dcs long read
Date: Thu, 04 Aug 2011 15:06:51 +0300
Message-ID: <1312459611.2143.18.camel@deskari>
References: <1309405483-6876-1-git-send-email-arve@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:49442 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752786Ab1HDMG4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Aug 2011 08:06:56 -0400
Received: by mail-fx0-f48.google.com with SMTP id 7so2062523fxg.7
        for <linux-omap@vger.kernel.org>; Thu, 04 Aug 2011 05:06:55 -0700 (PDT)
In-Reply-To: <1309405483-6876-1-git-send-email-arve@android.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arve =?ISO-8859-1?Q?Hj=F8nnev=E5g?= <arve@android.com>
Cc: linux-omap@vger.kernel.org, Dima Zavin <dima@android.com>

Hi,

On Wed, 2011-06-29 at 20:44 -0700, Arve Hj=C3=B8nnev=C3=A5g wrote:
> Change-Id: I18168c887e1384c07dc033a1ffc57abdacb26073
> Signed-off-by: Arve Hj=C3=B8nnev=C3=A5g <arve@android.com>
> ---
>  drivers/video/omap2/dss/dsi.c |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)

This feels somehow partial... Why do you want to read generic packets i=
f
there are no functions to send generic packets?

And always write a patch description.

 Tomi

>=20
> diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/=
dsi.c
> index c16b933..6975645 100644
> --- a/drivers/video/omap2/dss/dsi.c
> +++ b/drivers/video/omap2/dss/dsi.c
> @@ -206,6 +206,7 @@ struct dsi_reg { u16 idx; };
>  #define DSI_DT_DCS_LONG_WRITE		0x39
> =20
>  #define DSI_DT_RX_ACK_WITH_ERR		0x02
> +#define DSI_DT_RX_LONG_READ		0x1a
>  #define DSI_DT_RX_DCS_LONG_READ		0x1c
>  #define DSI_DT_RX_SHORT_READ_1		0x21
>  #define DSI_DT_RX_SHORT_READ_2		0x22
> @@ -2943,6 +2944,10 @@ static u16 dsi_vc_flush_receive_data(struct pl=
atform_device *dsidev,
>  		} else if (dt =3D=3D DSI_DT_RX_SHORT_READ_2) {
>  			DSSERR("\tDCS short response, 2 byte: %#x\n",
>  					FLD_GET(val, 23, 8));
> +		} else if (dt =3D=3D DSI_DT_RX_LONG_READ) {
> +			DSSERR("\tlong response, len %d\n",
> +					FLD_GET(val, 23, 8));
> +			dsi_vc_flush_long_data(dsidev, channel);
>  		} else if (dt =3D=3D DSI_DT_RX_DCS_LONG_READ) {
>  			DSSERR("\tDCS long response, len %d\n",
>  					FLD_GET(val, 23, 8));
> @@ -3287,7 +3292,7 @@ int dsi_vc_dcs_read(struct omap_dss_device *dss=
dev, int channel, u8 dcs_cmd,
>  		buf[1] =3D (data >> 8) & 0xff;
> =20
>  		return 2;
> -	} else if (dt =3D=3D DSI_DT_RX_DCS_LONG_READ) {
> +	} else if (dt =3D=3D DSI_DT_RX_DCS_LONG_READ || dt =3D=3D DSI_DT_RX=
_LONG_READ) {
>  		int w;
>  		int len =3D FLD_GET(val, 23, 8);
>  		if (dsi->debug_read)


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
