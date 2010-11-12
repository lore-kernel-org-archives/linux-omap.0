From: Belisko Marek <marek.belisko@gmail.com>
Subject: Re: [PATCH] OMAP: DSS2: OMAPFB: Fix null pointer check
Date: Fri, 12 Nov 2010 12:58:19 +0100
Message-ID: <AANLkTik2WToLpQCK7zM+4xwwnbxY_PbRnZF-H40iYhuW@mail.gmail.com>
References: <1289562435-8056-1-git-send-email-samreen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:59692 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751853Ab0KLL6V convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Nov 2010 06:58:21 -0500
In-Reply-To: <1289562435-8056-1-git-send-email-samreen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Samreen <samreen@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Fri, Nov 12, 2010 at 12:47 PM, Samreen <samreen@ti.com> wrote:
> A null pointer check added.
>
> Signed-off-by: Samreen <samreen@ti.com>
> ---
> =C2=A0drivers/video/omap2/omapfb/omapfb-main.c | =C2=A0 =C2=A02 ++
> =C2=A01 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video=
/omap2/omapfb/omapfb-main.c
> index 6a704f1..55bed89 100644
> --- a/drivers/video/omap2/omapfb/omapfb-main.c
> +++ b/drivers/video/omap2/omapfb/omapfb-main.c
> @@ -2133,6 +2133,8 @@ static int omapfb_parse_def_modes(struct omapfb=
2_device *fbdev)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int r =3D 0;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0str =3D kmalloc(strlen(def_mode) + 1, GFP_=
KERNEL);
> + =C2=A0 =C2=A0 =C2=A0 if (str =3D=3D NULL)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
Shouldn't be rerutn _ENNOMEM; instead to get correct error code?
> =C2=A0 =C2=A0 =C2=A0 =C2=A0strcpy(str, def_mode);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0options =3D str;
>
> --
> 1.5.6.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
thank,

marek


--=20
as simple and primitive as possible
-------------------------------------------------
Marek Belisko - OPEN-NANDRA
=46reelance Developer

Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
Tel: +421 915 052 184
skype: marekwhite
icq: 290551086
web: http://open-nandra.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
