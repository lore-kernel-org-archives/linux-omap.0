From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH] OMAP FB code to set DISPC_TIMING_{H,V} doesn't match TRM
Date: Mon, 21 Jun 2010 16:34:33 +0300
Message-ID: <AANLkTinaUy_aPsEZIUUFFSgUdn1RmyAOKRPOop9AfSqL@mail.gmail.com>
References: <20100616214340.GA27198@gibbs.hungrycats.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f198.google.com ([209.85.211.198]:44452 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757612Ab0FUNee convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Jun 2010 09:34:34 -0400
Received: by ywh36 with SMTP id 36so2301896ywh.4
        for <linux-omap@vger.kernel.org>; Mon, 21 Jun 2010 06:34:34 -0700 (PDT)
In-Reply-To: <20100616214340.GA27198@gibbs.hungrycats.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Zygo Blaxell <vger-linux-omap-esightcorp@mailtoo.hungrycats.org>
Cc: linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@nokia.com>

(CC Tomi)

On Thu, Jun 17, 2010 at 12:43 AM, Zygo Blaxell
<vger-linux-omap-esightcorp@mailtoo.hungrycats.org> wrote:
> The TRM and the OMAP FB driver have different ideas about the widths
> of various bit fields in the DISPC_TIMING_{H,V} registers. =A0This pa=
tch
> is based on what the TRM (TI document SPRUF98G) says.
>
> Note: =A0this patch changes the meanings of the vertical timing value=
s
> by one scan line. =A0It still works with my display, but it might bre=
ak
> things for other people.

Why? The TRM doesn't say VFP, VBP have to be programmed with value -1.

>
> ---
>
> diff --git a/drivers/video/omap/dispc.c b/drivers/video/omap/dispc.c
> index c7c6455..e58574b 100644
> --- a/drivers/video/omap/dispc.c
> +++ b/drivers/video/omap/dispc.c
> @@ -795,17 +795,17 @@ static void set_lcd_timings(void)
> =A0 =A0 =A0 =A0unsigned long fck;
>
> =A0 =A0 =A0 =A0l =3D dispc_read_reg(DISPC_TIMING_H);
> - =A0 =A0 =A0 l &=3D ~(FLD_MASK(0, 6) | FLD_MASK(8, 8) | FLD_MASK(20,=
 8));
> - =A0 =A0 =A0 l |=3D ( max(1, (min(64, =A0panel->hsw))) - 1 ) << 0;
> - =A0 =A0 =A0 l |=3D ( max(1, (min(256, panel->hfp))) - 1 ) << 8;
> - =A0 =A0 =A0 l |=3D ( max(1, (min(256, panel->hbp))) - 1 ) << 20;
> + =A0 =A0 =A0 l &=3D ~(FLD_MASK(0, 8) | FLD_MASK(8, 12) | FLD_MASK(20=
, 12));
> + =A0 =A0 =A0 l |=3D ( max(1, (min(256, panel->hsw))) - 1 ) << 0;
> + =A0 =A0 =A0 l |=3D ( max(1, (min(4096, panel->hfp))) - 1 ) << 8;
> + =A0 =A0 =A0 l |=3D ( max(1, (min(4096, panel->hbp))) - 1 ) << 20;
> =A0 =A0 =A0 =A0dispc_write_reg(DISPC_TIMING_H, l);
>
> =A0 =A0 =A0 =A0l =3D dispc_read_reg(DISPC_TIMING_V);
> - =A0 =A0 =A0 l &=3D ~(FLD_MASK(0, 6) | FLD_MASK(8, 8) | FLD_MASK(20,=
 8));
> - =A0 =A0 =A0 l |=3D ( max(1, (min(64, =A0panel->vsw))) - 1 ) << 0;
> - =A0 =A0 =A0 l |=3D ( max(0, (min(255, panel->vfp))) - 0 ) << 8;
> - =A0 =A0 =A0 l |=3D ( max(0, (min(255, panel->vbp))) - 0 ) << 20;
> + =A0 =A0 =A0 l &=3D ~(FLD_MASK(0, 8) | FLD_MASK(8, 12) | FLD_MASK(20=
, 12));
> + =A0 =A0 =A0 l |=3D ( max(1, (min(256, panel->vsw))) - 1 ) << 0;
> + =A0 =A0 =A0 l |=3D ( max(1, (min(4096, panel->vfp))) - 1 ) << 8;
> + =A0 =A0 =A0 l |=3D ( max(1, (min(4096, panel->vbp))) - 1 ) << 20;
> =A0 =A0 =A0 =A0dispc_write_reg(DISPC_TIMING_V, l);
>
> =A0 =A0 =A0 =A0l =3D dispc_read_reg(DISPC_POL_FREQ);
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
