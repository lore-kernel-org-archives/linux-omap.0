From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [Q] SW-ECC to HW-ECC (OMAP3)
Date: Fri, 5 Aug 2011 12:33:40 +0300
Message-ID: <CANOLnON=d_eF8dvNV8K16QbKq04-dd-sv=fx+yC8VAzw=Typqg@mail.gmail.com>
References: <CAACX+R3Gve=V4+AV17WONEkXpb9NwrLbUr7E2Ym6Qu-2URyiTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f170.google.com ([209.85.210.170]:46620 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751631Ab1HEJdl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Aug 2011 05:33:41 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so3343117iye.1
        for <linux-omap@vger.kernel.org>; Fri, 05 Aug 2011 02:33:40 -0700 (PDT)
In-Reply-To: <CAACX+R3Gve=V4+AV17WONEkXpb9NwrLbUr7E2Ym6Qu-2URyiTA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arno Steffen <arno.steffen@googlemail.com>
Cc: linux-omap@vger.kernel.org

On Thu, Aug 4, 2011 at 1:55 PM, Arno Steffen
<arno.steffen@googlemail.com> wrote:
> While migrating from .33 to .37 kernel I found, that HW-ECC is used b=
y default.
> I found that this is set in omap2.c:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0pdata->ecc_opt =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0=3D OMAP_ECC_HAMMING_CODE_HW;
> Unfortunatly setting it back to
> =C2=A0 =C2=A0 =C2=A0 =C2=A0pdata->ecc_opt =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0=3D OMAP_ECC_HAMMING_CODE_DEFAULT;
> doesn't prevent me from getting messages like:
>
> uncorrectable error :
> uncorrectable error :
> mtd->read(0xd18 bytes from 0x7eae8) returned ECC error
>
> So what else has to be set? I couldn't found it.

swecc on .37 is broken (I'm not even sure hwecc works as I use swecc),
you need at least 2.6.39.1 to use that. It is possible to patch .37
but I don't have list of needed parches, but maybe could get you that
if you really need it (or look what changed under drivers/mtd between
those versions yourself).

> Other way maybe to keep it at HW-ECC. Is this significant faster than=
 SW-ECC?
> But howto get nandwrite (mtd-utils) or fw_setenv (uboot) to handle HW=
-ECC?
> Do I have to use just the --noecc option?
>
> When using the fw_setenv command I get CRC errors in environment with=
 next boot.

Never tried hwecc so can't help you here.


--=20
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
