From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] OMAP: Fix build failure on MEMBLOCK_REAL_LIMIT
Date: Mon, 8 Nov 2010 00:44:15 +0200
Message-ID: <AANLkTim+EHnfAQT4HnOROutZ9U=P_PeEidCdOCz8DuRj@mail.gmail.com>
References: <1288629008-29767-1-git-send-email-namhyung@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:51632 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751981Ab0KGWoR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 7 Nov 2010 17:44:17 -0500
Received: by bwz11 with SMTP id 11so4281503bwz.19
        for <linux-omap@vger.kernel.org>; Sun, 07 Nov 2010 14:44:15 -0800 (PST)
In-Reply-To: <1288629008-29767-1-git-send-email-namhyung@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Namhyung Kim <namhyung@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>, linux-omap@vger.kernel.org

On Mon, Nov 1, 2010 at 6:30 PM, Namhyung Kim <namhyung@gmail.com> wrote=
:
> --- a/drivers/video/omap2/vram.c
> +++ b/drivers/video/omap2/vram.c
> @@ -570,7 +570,8 @@ void __init omap_vram_reserve_sdram_memblock(void=
)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0return;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 paddr =3D memblock=
_alloc_base(size, PAGE_SIZE, MEMBLOCK_REAL_LIMIT);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 paddr =3D memblock=
_alloc_base(size, PAGE_SIZE,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 MEMBLOCK_ALLOC_ACCESSIBLE);

This is exactly the same as:
 paddr =3D memblock_alloc(size, PAGE_SIZE);

Let's use that instead.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
