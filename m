From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCH] nand: omap2: Missing arg to gpmc_prefetch_reset()
Date: Sun, 26 Sep 2010 15:18:23 +0300
Message-ID: <1285503503.13050.19.camel@brekeke>
References: <1285364702-13922-1-git-send-email-loic.minier@linaro.org>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:39152 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757554Ab0IZMS2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 26 Sep 2010 08:18:28 -0400
Received: by bwz11 with SMTP id 11so2779940bwz.19
        for <linux-omap@vger.kernel.org>; Sun, 26 Sep 2010 05:18:27 -0700 (PDT)
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

Looks like a regression which should be merged to 2.6.36.
I've taken this patch to l2-mtd-2.6.git, will ping dwmw2 about the need
to merge this to 2.6.36.

--=20
Best Regards,
Artem Bityutskiy (=D0=91=D0=B8=D1=82=D1=8E=D1=86=D0=BA=D0=B8=D0=B9 =D0=90=
=D1=80=D1=82=D1=91=D0=BC)

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
