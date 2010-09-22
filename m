From: Bryan Wu <bryan.wu@canonical.com>
Subject: Re: [PATCH 3/4] omap4: pandaboard: Adding card detect support for MMC1
Date: Wed, 22 Sep 2010 15:28:44 +0800
Message-ID: <AANLkTi=Us2g=+E50MRPXHuOnNYa2aV3tmxZj3sGS-kQ8@mail.gmail.com>
References: <1285104244-32274-1-git-send-email-x0132446@ti.com>
	<1285104244-32274-4-git-send-email-x0132446@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:42032 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752038Ab0IVH2p convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Sep 2010 03:28:45 -0400
Received: by qyk36 with SMTP id 36so4887788qyk.19
        for <linux-omap@vger.kernel.org>; Wed, 22 Sep 2010 00:28:45 -0700 (PDT)
In-Reply-To: <1285104244-32274-4-git-send-email-x0132446@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Anders <x0132446@ti.com>
Cc: jayabharath@ti.com, gadiyar@ti.com, vpasam@ti.com, tony@atomide.com, linux-omap@vger.kernel.org

On Wed, Sep 22, 2010 at 5:24 AM, David Anders <x0132446@ti.com> wrote:
> Adding card detect callback function and card detect configuration
> function for MMC1 Controller.
>
> Signed-off-by: David Anders <x0132446@ti.com>
> Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
> ---
>
> patch depends on https://patchwork.kernel.org/patch/189952/
>
> =A0arch/arm/mach-omap2/board-omap4panda.c | =A0 =A07 ++++++-
> =A01 files changed, 6 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-o=
map2/board-omap4panda.c
> index 697c0bd..94e819c 100644
> --- a/arch/arm/mach-omap2/board-omap4panda.c
> +++ b/arch/arm/mach-omap2/board-omap4panda.c
> @@ -77,9 +77,14 @@ static int omap4_twl6030_hsmmc_late_init(struct de=
vice *dev)
> =A0 =A0 =A0 =A0struct omap_mmc_platform_data *pdata =3D dev->platform=
_data;
>
> =A0 =A0 =A0 =A0/* Setting MMC1 Card detect Irq */
> - =A0 =A0 =A0 if (pdev->id =3D=3D 0)
> + =A0 =A0 =A0 if (pdev->id =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D twl6030_mmc_card_detect_config(=
);

It looks like we need this function from twl6030 driver, otherwise we
will get this compiling error:

----
In file included from arch/arm/mach-omap2/board-omap4panda.c:38:
arch/arm/plat-omap/include/plat/usb.h:109: warning: return type
defaults to 'int'
arch/arm/mach-omap2/board-omap4panda.c: In function
'omap4_twl6030_hsmmc_late_init':
arch/arm/mach-omap2/board-omap4panda.c:81: error: implicit declaration
of function 'twl6030_mmc_card_detect_config'
arch/arm/mach-omap2/board-omap4panda.c:86: error:
'twl6030_mmc_card_detect' undeclared (first use in this function)
arch/arm/mach-omap2/board-omap4panda.c:86: error: (Each undeclared
identifier is reported only once
arch/arm/mach-omap2/board-omap4panda.c:86: error: for each function it
appears in.)
arch/arm/mach-omap2/board-omap4panda.c: In function 'omap4_panda_init':
arch/arm/mach-omap2/board-omap4panda.c:285: warning: unused variable 's=
tatus'
----

Thanks,
-Bryan


> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("Failed configur=
ing MMC1 card detect\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pdata->slots[0].card_detect_irq =3D TW=
L6030_IRQ_BASE +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0MMCDETECT_INTR_OFFSET;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->slots[0].card_detect =3D twl6030=
_mmc_card_detect;
> + =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0return ret;
> =A0}
>
> --
> 1.7.0.4
>
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
