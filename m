From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH 2/2] arm: omap: gpmc-smsc911x: minor style fixes
Date: Tue, 26 Apr 2011 08:45:07 -0500
Message-ID: <BANLkTikw73F1RBmJC=+Z2msA3Wr7gG3AGQ@mail.gmail.com>
References: <1303397412-24813-1-git-send-email-grinberg@compulab.co.il> <1303397412-24813-2-git-send-email-grinberg@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:34455 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755789Ab1DZNqq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Apr 2011 09:46:46 -0400
Received: by mail-wy0-f176.google.com with SMTP id 40so665640wyb.21
        for <linux-omap@vger.kernel.org>; Tue, 26 Apr 2011 06:46:22 -0700 (PDT)
In-Reply-To: <1303397412-24813-2-git-send-email-grinberg@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Tony Lindgren <tony@atomide.com>, Mike Rapoport <mike@compulab.co.il>, Tim Nordell <tim.nordell@logicpd.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Apr 21, 2011 at 09:50, Igor Grinberg <grinberg@compulab.co.il> =
wrote:
> replace "printk(KERN_ERR" by "pr_err("
> and fix needlessly multi-lined #ifdef
>
> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
> ---
> =A0arch/arm/mach-omap2/gpmc-smsc911x.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =
14 +++++++-------
> =A0arch/arm/plat-omap/include/plat/gpmc-smsc911x.h | =A0 =A03 +--
> =A02 files changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/gpmc-smsc911x.c b/arch/arm/mach-omap=
2/gpmc-smsc911x.c
> index d30293a..b45efff 100644
> --- a/arch/arm/mach-omap2/gpmc-smsc911x.c
> +++ b/arch/arm/mach-omap2/gpmc-smsc911x.c

minor suggestion: wont using pr_fmt help to reduce the need to add %s,
__func__ for pr_err through out the file?

Regards,
Nishanth Menon



> @@ -55,7 +55,7 @@ void __init gpmc_smsc911x_init(struct omap_smsc911x=
_platform_data *board_data)
> =A0 =A0 =A0 =A0gpmc_cfg =3D board_data;
>
> =A0 =A0 =A0 =A0if (gpmc_cs_request(gpmc_cfg->cs, SZ_16M, &cs_mem_base=
) < 0) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Failed to request GPMC=
 mem for smsc911x\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: Failed to request GPMC mem =
region\n", __func__);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0}
>
> @@ -63,8 +63,8 @@ void __init gpmc_smsc911x_init(struct omap_smsc911x=
_platform_data *board_data)
> =A0 =A0 =A0 =A0gpmc_smsc911x_resources[0].end =3D cs_mem_base + 0xff;
>
> =A0 =A0 =A0 =A0if (gpio_request(gpmc_cfg->gpio_irq, "smsc911x irq") <=
 0) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Failed to request GPIO=
%d for smsc911x IRQ\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpmc_cf=
g->gpio_irq);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: Failed to request IRQ GPIO%=
d\n", __func__,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gpmc_cfg->gpio_irq);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto free1;
> =A0 =A0 =A0 =A0}
>
> @@ -74,8 +74,8 @@ void __init gpmc_smsc911x_init(struct omap_smsc911x=
_platform_data *board_data)
> =A0 =A0 =A0 =A0if (gpio_is_valid(gpmc_cfg->gpio_reset)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D gpio_request(gpmc_cfg->gpio_re=
set, "smsc911x reset");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ret) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Failed=
 to request GPIO%d for smsc911x reset\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 gpmc_cfg->gpio_reset);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: Failed to r=
equest reset GPIO%d\n", __func__,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gpmc_cfg=
->gpio_reset);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto free2;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> @@ -92,7 +92,7 @@ void __init gpmc_smsc911x_init(struct omap_smsc911x=
_platform_data *board_data)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpmc_smsc911x_resources, ARRAY_SIZE(g=
pmc_smsc911x_resources),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &gpmc_smsc911x_config, sizeof(gpmc_sm=
sc911x_config));
> =A0 =A0 =A0 =A0if (!pdev) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Unable to register sms=
c911x device\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: Unable to register platform=
 device\n", __func__);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gpio_free(gpmc_cfg->gpio_reset);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto free2;
> =A0 =A0 =A0 =A0}
> @@ -104,5 +104,5 @@ free2:
> =A0free1:
> =A0 =A0 =A0 =A0gpmc_cs_free(gpmc_cfg->cs);
>
> - =A0 =A0 =A0 printk(KERN_ERR "Could not initialize smsc911x\n");
> + =A0 =A0 =A0 pr_err("Could not initialize smsc911x\n");
> =A0}
> diff --git a/arch/arm/plat-omap/include/plat/gpmc-smsc911x.h b/arch/a=
rm/plat-omap/include/plat/gpmc-smsc911x.h
> index d3f1579..ea6c9c8 100644
> --- a/arch/arm/plat-omap/include/plat/gpmc-smsc911x.h
> +++ b/arch/arm/plat-omap/include/plat/gpmc-smsc911x.h
> @@ -21,8 +21,7 @@ struct omap_smsc911x_platform_data {
> =A0 =A0 =A0 =A0u32 =A0 =A0 flags;
> =A0};
>
> -#if defined(CONFIG_SMSC911X) || \
> - =A0 =A0 =A0 defined(CONFIG_SMSC911X_MODULE)
> +#if defined(CONFIG_SMSC911X) || defined(CONFIG_SMSC911X_MODULE)
>
> =A0extern void gpmc_smsc911x_init(struct omap_smsc911x_platform_data =
*d);
>
> --
> 1.7.3.4
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
