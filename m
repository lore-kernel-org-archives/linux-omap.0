From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: Spurious ECC errors with mtd_subpagetest (OMAP3, NAND)
Date: Fri, 2 Mar 2012 19:17:40 +0200
Message-ID: <CANOLnOM6X=29r7_aMs=z4eiDtw0kvWZ-jSeds_NO0KdZ3E8Ouw@mail.gmail.com>
References: <4F50F2AB.10209@flatfrog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:47940 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757161Ab2CBRRl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Mar 2012 12:17:41 -0500
Received: by iagz16 with SMTP id z16so2536754iag.19
        for <linux-omap@vger.kernel.org>; Fri, 02 Mar 2012 09:17:40 -0800 (PST)
In-Reply-To: <4F50F2AB.10209@flatfrog.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Orjan Friberg <of@flatfrog.com>
Cc: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hello,

On Fri, Mar 2, 2012 at 6:17 PM, Orjan Friberg <of@flatfrog.com> wrote:
> When running the mtd_subpagetest I'm seeing more or less spurious ECC
> corrections. =C2=A0I.e., one round may show 4 corrections and the nex=
t will show
> 7, only some of which are the same as the previous 4.
>
> Are the ECC errors expected to be that volatile and frequent?
>
>
> I've seen various discussions regarding the OMAP sub page support, as=
 well
> as problems with the GPMC prefetch engine. =C2=A0Disabling both made =
no
> difference regarding this. =C2=A0I've also tried two different sets o=
f NAND
> timings (relaxed and optimized), with no difference.
>
> I'm using a Micron NAND that requires 4-bit ECC correction but I'm ru=
nning
> with only 1-bit (software) ECC. =C2=A0This is on an old kernel, 2.6.3=
2.

IIRC NAND in mainline was broken for very long time on OMAP3, I think
it was only fixed in 2.6.39.1.

--=20
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
