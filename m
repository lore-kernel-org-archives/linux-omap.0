From: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Subject: Re: [PATCH 1/6] mmc: host: omap_hsmmc: trivial cleanups
Date: Thu, 15 Mar 2012 19:20:22 +0530
Message-ID: <CANrkHUYGDYiCrXp56fwgoXvOin_YPAnyQPhDiFWizZ2X0WM-Sw@mail.gmail.com>
References: <1331716714-31912-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog137.obsmtp.com ([74.125.149.18]:37329 "EHLO
	psmtp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756308Ab2CONu0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Mar 2012 09:50:26 -0400
Received: by mail-lpp01m010-f52.google.com with SMTP id i5so2299341lah.25
        for <linux-omap@vger.kernel.org>; Thu, 15 Mar 2012 06:50:22 -0700 (PDT)
In-Reply-To: <1331716714-31912-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, "Jean Delvare (PC drivers, core)" <khali@linux-fr.org>, "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>, "Wolfram Sang (embedded platforms)" <w.sang@pengutronix.de>, cjb@laptop.org

On Wed, Mar 14, 2012 at 2:48 PM, Felipe Balbi <balbi@ti.com> wrote:
> a bunch of non-functional cleanups to the omap_hsmmc
> driver.
>
> It basically decreases indentation level, drop unneded
> dereferences and drop unneded accesses to the platform_device
> structure.
>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
> =A0drivers/mmc/host/omap_hsmmc.c | =A0147 ++++++++++++++++++++-------=
--------------
> =A01 file changed, 70 insertions(+), 77 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hs=
mmc.c
> index fd0c661..11fef49 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -2104,30 +2104,28 @@ static int omap_hsmmc_remove(struct platform_=
device *pdev)
> =A0 =A0 =A0 =A0struct omap_hsmmc_host *host =3D platform_get_drvdata(=
pdev);
> =A0 =A0 =A0 =A0struct resource *res;
>
> - =A0 =A0 =A0 if (host) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_get_sync(host->dev);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_remove_host(host->mmc);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->use_reg)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_hsmmc_reg_put(host=
);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->pdata->cleanup)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->pdata->cleanup(&p=
dev->dev);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_irq(host->irq, host);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_slot(host).card_detect_irq)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_irq(mmc_slot(host)=
=2Ecard_detect_irq, host);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_put_sync(host->dev);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_disable(host->dev);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_put(host->fclk);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->got_dbclk) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(host->dbclk=
);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_put(host->dbclk);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
Hi,

Checking for host NULL is added in suspend/resume, however it is missin=
g in
=2Eremove, is it intentional ?

> + =A0 =A0 =A0 pm_runtime_get_sync(host->dev);
> + =A0 =A0 =A0 mmc_remove_host(host->mmc);
> + =A0 =A0 =A0 if (host->use_reg)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_hsmmc_reg_put(host);
> + =A0 =A0 =A0 if (host->pdata->cleanup)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->pdata->cleanup(&pdev->dev);
> + =A0 =A0 =A0 free_irq(host->irq, host);
> + =A0 =A0 =A0 if (mmc_slot(host).card_detect_irq)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_irq(mmc_slot(host).card_detect_irq=
, host);
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_free_host(host->mmc);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 iounmap(host->base);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_hsmmc_gpio_free(pdev->dev.platform=
_data);
> + =A0 =A0 =A0 pm_runtime_put_sync(host->dev);
> + =A0 =A0 =A0 pm_runtime_disable(host->dev);
> + =A0 =A0 =A0 clk_put(host->fclk);
> + =A0 =A0 =A0 if (host->got_dbclk) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(host->dbclk);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_put(host->dbclk);
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 mmc_free_host(host->mmc);
> + =A0 =A0 =A0 iounmap(host->base);
> + =A0 =A0 =A0 omap_hsmmc_gpio_free(pdev->dev.platform_data);
> +
> =A0 =A0 =A0 =A0res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0)=
;
> =A0 =A0 =A0 =A0if (res)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0release_mem_region(res->start, resourc=
e_size(res));
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
