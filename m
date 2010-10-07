From: Vimal Singh <vimal.newwork@gmail.com>
Subject: Re: [PATCH v3] OMAP: NAND: Fix static declaration warning
Date: Thu, 7 Oct 2010 23:05:10 +0530
Message-ID: <AANLkTin-rjxxDpiN9V5CinWr4cCqH1QB=cEH+huEcxYv@mail.gmail.com>
References: <1286315819-5906-1-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:60767 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751309Ab0JGRfb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Oct 2010 13:35:31 -0400
Received: by qyk29 with SMTP id 29so335919qyk.19
        for <linux-omap@vger.kernel.org>; Thu, 07 Oct 2010 10:35:31 -0700 (PDT)
In-Reply-To: <1286315819-5906-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>

On Wed, Oct 6, 2010 at 3:26 AM, G, Manjunath Kondaiah <manjugk@ti.com> =
wrote:
> This patch fixes sparse warning for static declaration of variable "u=
se_dma"
>
> drivers/mtd/nand/omap2.c:114:11: warning: symbol 'use_dma' was not de=
clared. Should it be static?
>
> Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-mtd@lists.infradead.org
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Nishanth Menon <nm@ti.com>
> ---
> Changes since v1:
> =A0- no logical changes, patch seperated from series based Tony's sug=
gestion.
>
> =A0drivers/mtd/nand/omap2.c | =A0 =A04 ++--
> =A01 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
> index 133d515..439e80d 100644
> --- a/drivers/mtd/nand/omap2.c
> +++ b/drivers/mtd/nand/omap2.c
> @@ -111,11 +111,11 @@ static int use_dma =3D 1;
> =A0module_param(use_dma, bool, 0);
> =A0MODULE_PARM_DESC(use_dma, "enable/disable use of DMA");
> =A0#else
> -const int use_dma;
> +static const int use_dma;
> =A0#endif
> =A0#else
> =A0const int use_prefetch;
> -const int use_dma;
> +static const int use_dma;

I did not understand, why did it not pointed same error for 'const int
use_prefetch'?

--=20
Regards,
Vimal Singh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
