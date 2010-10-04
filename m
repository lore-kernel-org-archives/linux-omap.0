From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCH] nand: omap2: Missing arg to gpmc_prefetch_reset()
Date: Mon, 04 Oct 2010 10:39:05 +0300
Message-ID: <1286177945.11684.77.camel@localhost>
References: <1285364702-13922-1-git-send-email-loic.minier@linaro.org>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38767 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753174Ab0JDHlw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Oct 2010 03:41:52 -0400
Received: by fxm14 with SMTP id 14so1535121fxm.19
        for <linux-omap@vger.kernel.org>; Mon, 04 Oct 2010 00:41:51 -0700 (PDT)
In-Reply-To: <1285364702-13922-1-git-send-email-loic.minier@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?ISO-8859-1?Q?Lo=EFc?= Minier <loic.minier@linaro.org>
Cc: linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Sukumar Ghorai <s-ghorai@ti.com>

On Fri, 2010-09-24 at 23:45 +0200, Lo=C3=AFc Minier wrote:
> Fix missing cs arg to gpmc_prefetch_reset() when
> CONFIG_MTD_NAND_OMAP_PREFETCH_DMA=3Dy which caused a build failure si=
nce
> 948d38e799f0ab87cf8ed9113fcdaaee61acf321:
> drivers/mtd/nand/omap2.c: In function 'omap_nand_dma_transfer':
> drivers/mtd/nand/omap2.c:416: error: too few arguments to function 'g=
pmc_prefetch_reset'
>=20
> Signed-off-by: Lo=C3=AFc Minier <loic.minier@linaro.org>
> ---
>  drivers/mtd/nand/omap2.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

=46YI, a similar patch is already in Linus' tree, so I'm dropping it fr=
om
my tree:

commit f12f662f29d5801e598c6bb4a71e54b2de218f72
Author: Daniel J Blueman <daniel.blueman@gmail.com>
Date:   Wed Sep 29 21:01:55 2010 +0100

    fix OMAP2 MTD build failure
   =20
    Fix build failure from recent interface change and merge.
   =20
    Tested on OMAP3430.
   =20
    Signed-off-by: Daniel J Blueman <daniel.blueman@gmail.com>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
