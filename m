From: Kim Kyuwon <chammoru@gmail.com>
Subject: Re: [PATCH] Fix the size of twl4030 script
Date: Thu, 7 May 2009 10:35:49 +0900
Message-ID: <4d34a0a70905061835u4b6aaaabnb0819584e4d6ed8f@mail.gmail.com>
References: <4d34a0a70904092130r215f0eb3p6a45c4950c92e5c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f125.google.com ([209.85.221.125]:39610 "EHLO
	mail-qy0-f125.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753893AbZEGBgK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 May 2009 21:36:10 -0400
Received: by qyk31 with SMTP id 31so849906qyk.33
        for <linux-omap@vger.kernel.org>; Wed, 06 May 2009 18:36:10 -0700 (PDT)
In-Reply-To: <4d34a0a70904092130r215f0eb3p6a45c4950c92e5c0@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: OMAP <linux-omap@vger.kernel.org>

Hi All,

I sent this patch about 1 month ago.
Can anybody check I'm sending correct patch?

Thanks you!
Kyuwon.

2009/4/10 Kim Kyuwon <chammoru@gmail.com>:
> The array size of wrst_seq is ARRAY_SIZE(wrst_seq)
>
> Signed-off-by: Kim Kyuwon <q1.kim@samsung.com>
> ---
>  arch/arm/mach-omap2/board-3430sdp.c |    2 +-
>  arch/arm/mach-omap2/board-ldp.c     |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-3430sdp.c
> b/arch/arm/mach-omap2/board-3430sdp.c
> index 03acac7..38550e2 100644
> --- a/arch/arm/mach-omap2/board-3430sdp.c
> +++ b/arch/arm/mach-omap2/board-3430sdp.c
> @@ -473,7 +473,7 @@ static struct twl4030_ins wrst_seq[] __initdata =3D=
 {
>  };
>  static struct twl4030_script wrst_script __initdata =3D {
>        .script =3D wrst_seq,
> -       .size   =3D ARRAY_SIZE(wakeup_seq),
> +       .size   =3D ARRAY_SIZE(wrst_seq),
>        .flags  =3D TRITON_WRST_SCRIPT,
>  };
>
> diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/bo=
ard-ldp.c
> index 804fd8e..da814d7 100644
> --- a/arch/arm/mach-omap2/board-ldp.c
> +++ b/arch/arm/mach-omap2/board-ldp.c
> @@ -450,7 +450,7 @@ static struct twl4030_ins wrst_seq[] __initdata =3D=
 {
>
>  static struct twl4030_script wrst_script __initdata =3D {
>        .script =3D wrst_seq,
> -       .size   =3D ARRAY_SIZE(wakeup_seq),
> +       .size   =3D ARRAY_SIZE(wrst_seq),
>        .flags  =3D TRITON_WRST_SCRIPT,
>  };
>
> --
> 1.5.2.5
>
> --
> Kyuwon (=B1=D4=BF=F8)
>

--=20
Kyuwon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
