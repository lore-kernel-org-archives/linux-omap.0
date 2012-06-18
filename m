From: Sunil Matange <smatange@ti.com>
Subject: RE: [PATCH v3] ARM: OMAP3: USB: Fix the EHCI ULPI PHY reset fix issues.
Date: Mon, 18 Jun 2012 18:30:05 +0530
Message-ID: <358d9bc4c1dc38c326256727e21daa1c@mail.gmail.com>
References: <1339691061-12778-1-git-send-email-Russ.Dill@ti.com><393884FF03A1CE4A86A02FC97D0954E73E91B6EC@DBDE01.ent.ti.com>
 <CAP05o4Lna51bZHKSNLy9zK49dAf1k1UY_sSXRwPGYcgKtPmzkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:53048 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751042Ab2FRNQo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Jun 2012 09:16:44 -0400
Received: by vbal1 with SMTP id l1so3700686vba.37
        for <linux-omap@vger.kernel.org>; Mon, 18 Jun 2012 06:16:41 -0700 (PDT)
In-Reply-To: <CAP05o4Lna51bZHKSNLy9zK49dAf1k1UY_sSXRwPGYcgKtPmzkQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Keshava Munegowda <keshava_mgowda@ti.com>, Samuel Ortiz <sameo@linux.intel.com>
Cc: Russ Dill <russ.dill@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Partha Basak <parthab@india.ti.com>, Igor Grinberg <grinberg@compulab.co.il>, Sapna Setty <s-sapna1@ti.com>, Russ Dill <Russ.Dill@gmail.com>, Mantesh Sarashetti <mantesh@ti.com>, Nishant Kamat <nskamat@ti.com>, Linux USB Devel <linux-usb@vger.kernel.org>

Thanks Keshava.

Regards
Sunil Matange


-----Original Message-----
=46rom: Munegowda, Keshava [mailto:keshava_mgowda@ti.com]
Sent: Monday, June 18, 2012 1:59 PM
To: Samuel Ortiz
Cc: Dill, Russ; linux-omap@vger.kernel.org;
linux-arm-kernel@lists.infradead.org; Balbi, Felipe; Partha Basak; Igor
Grinberg; Setty, Sapna; Russ Dill; Mantesh Sarashetti; Sunil Matange;
Nishant Kamat; Linux USB Devel
Subject: Re: [PATCH v3] ARM: OMAP3: USB: Fix the EHCI ULPI PHY reset fi=
x
issues.

On Fri, Jun 15, 2012 at 12:36 AM, Sarashetti, Mantesh <mantesh@ti.com>
wrote:
> 'Acked-by: mantesh@ti.com'
> 'Tested-by: mantesh@ti.com'
>
> Regards,
> Mantesh
> -----Original Message-----
> From: Russ Dill [mailto:russ.dill@gmail.com] On Behalf Of Dill, Russ
> Sent: Thursday, June 14, 2012 11:24 AM
> To: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Cc: Balbi, Felipe; Munegowda, Keshava; Partha Basak; Igor Grinberg;
Samuel Ortiz; Sarashetti, Mantesh; Setty, Sapna; Russ Dill
> Subject: [PATCH v3] ARM: OMAP3: USB: Fix the EHCI ULPI PHY reset fix
issues.
>
> From: Russ Dill <Russ.Dill@gmail.com>
>
> 'ARM: OMAP3: USB: Fix the EHCI ULPI PHY reset issue' (1fcb57d0) fixes
> an issue where the ULPI PHYs were not held in reset while initializin=
g
> the EHCI controller. However, it also changes behavior in
> omap-usb-host.c omap_usbhs_init by releasing reset while the
> configuration in that function was done.
>
> This change caused a regression on BB-xM where USB would not function
> if 'usb start' had been run from u-boot before booting. A change was
> made to release reset a little bit earlier which fixed the issue on
> BB-xM and did not cause any regressions on 3430 sdp, the board for
> which the fix was originally made.
>
> This new fix, 'USB: EHCI: OMAP: Finish ehci omap phy reset cycle
> before adding hcd.', (3aa2ae74) caused a regression on OMAP5.
>
> The original fix to hold the EHCI controller in reset during
> initialization was correct, however it appears that changing
> omap_usbhs_init to not hold the PHYs in reset during it's
> configuration was incorrect. This patch first reverts both fixes, and
> then changes ehci_hcd_omap_probe in ehci-omap.c to hold the PHYs in
> reset as the original patch had done. It also is sure to incorporate
> the _cansleep change that has been made in the meantime.
>
> I've tested this on Beagleboard xM, I'd really like to get an ack fro=
m
> the 3430 sdp and OMAP5 guys before getting this merged.
>
> v3 - Brown paper bag its too early in the morning actually run
> =A0 =A0 git commit amend fix
> v2 - Put cansleep gpiolib call outside of spinlock
>
> Signed-off-by: Russ Dill <Russ.Dill@gmail.com>
> ---
> =A0drivers/mfd/omap-usb-host.c =A0| =A0 48
+++++++++++++++++++++++++++++++++++++++++-
> =A0drivers/usb/host/ehci-omap.c | =A0 18 +++++++---------
> =A02 files changed, 55 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.=
c
> index 7e96bb2..41088ec 100644
> --- a/drivers/mfd/omap-usb-host.c
> +++ b/drivers/mfd/omap-usb-host.c
> @@ -25,6 +25,7 @@
> =A0#include <linux/clk.h>
> =A0#include <linux/dma-mapping.h>
> =A0#include <linux/spinlock.h>
> +#include <linux/gpio.h>
> =A0#include <plat/cpu.h>
> =A0#include <plat/usb.h>
> =A0#include <linux/pm_runtime.h>
> @@ -500,8 +501,21 @@ static void omap_usbhs_init(struct device *dev)
> =A0 =A0 =A0 =A0dev_dbg(dev, "starting TI HSUSB Controller\n");
>
> =A0 =A0 =A0 =A0pm_runtime_get_sync(dev);
> - =A0 =A0 =A0 spin_lock_irqsave(&omap->lock, flags);
>
> + =A0 =A0 =A0 if (pdata->ehci_data->phy_reset) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (gpio_is_valid(pdata->ehci_data->res=
et_gpio_port[0]))
> +
gpio_request_one(pdata->ehci_data->reset_gpio_port[0],
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0GPIOF_OUT_INIT_LOW, "USB1 PHY
reset");
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (gpio_is_valid(pdata->ehci_data->res=
et_gpio_port[1]))
> +
gpio_request_one(pdata->ehci_data->reset_gpio_port[1],
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0GPIOF_OUT_INIT_LOW, "USB2 PHY
reset");
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Hold the PHY in RESET for enough tim=
e till DIR is
high */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(10);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 spin_lock_irqsave(&omap->lock, flags);
> =A0 =A0 =A0 =A0omap->usbhs_rev =3D usbhs_read(omap->uhh_base, OMAP_UH=
H_REVISION);
> =A0 =A0 =A0 =A0dev_dbg(dev, "OMAP UHH_REVISION 0x%x\n", omap->usbhs_r=
ev);
>
> @@ -581,9 +595,39 @@ static void omap_usbhs_init(struct device *dev)
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0spin_unlock_irqrestore(&omap->lock, flags);
> +
> + =A0 =A0 =A0 if (pdata->ehci_data->phy_reset) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Hold the PHY in RESET for enough tim=
e till
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* PHY is settled and ready
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(10);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (gpio_is_valid(pdata->ehci_data->res=
et_gpio_port[0]))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_set_value_cansleep
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (pdata-=
>ehci_data->reset_gpio_port[0],
1);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (gpio_is_valid(pdata->ehci_data->res=
et_gpio_port[1]))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_set_value_cansleep
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (pdata-=
>ehci_data->reset_gpio_port[1],
1);
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0pm_runtime_put_sync(dev);
> =A0}
>
> +static void omap_usbhs_deinit(struct device *dev)
> +{
> + =A0 =A0 =A0 struct usbhs_hcd_omap =A0 =A0 =A0 =A0 =A0 *omap =3D dev=
_get_drvdata(dev);
> + =A0 =A0 =A0 struct usbhs_omap_platform_data *pdata =3D &omap->platd=
ata;
> +
> + =A0 =A0 =A0 if (pdata->ehci_data->phy_reset) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (gpio_is_valid(pdata->ehci_data->res=
et_gpio_port[0]))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_free(pdata->ehci_d=
ata->reset_gpio_port[0]);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (gpio_is_valid(pdata->ehci_data->res=
et_gpio_port[1]))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_free(pdata->ehci_d=
ata->reset_gpio_port[1]);
> + =A0 =A0 =A0 }
> +}
> +
>
> =A0/**
> =A0* usbhs_omap_probe - initialize TI-based HCDs
> @@ -767,6 +811,7 @@ static int __devinit usbhs_omap_probe(struct
platform_device *pdev)
> =A0 =A0 =A0 =A0goto end_probe;
>
> =A0err_alloc:
> + =A0 =A0 =A0 omap_usbhs_deinit(&pdev->dev);
> =A0 =A0 =A0 =A0iounmap(omap->tll_base);
>
> =A0err_tll:
> @@ -818,6 +863,7 @@ static int __devexit usbhs_omap_remove(struct
platform_device *pdev)
> =A0{
> =A0 =A0 =A0 =A0struct usbhs_hcd_omap *omap =3D platform_get_drvdata(p=
dev);
>
> + =A0 =A0 =A0 omap_usbhs_deinit(&pdev->dev);
> =A0 =A0 =A0 =A0iounmap(omap->tll_base);
> =A0 =A0 =A0 =A0iounmap(omap->uhh_base);
> =A0 =A0 =A0 =A0clk_put(omap->init_60m_fclk);
> diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-oma=
p.c
> index a44294d..d0815b6 100644
> --- a/drivers/usb/host/ehci-omap.c
> +++ b/drivers/usb/host/ehci-omap.c
> @@ -192,14 +192,13 @@ static int ehci_hcd_omap_probe(struct
platform_device *pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 /* Hold PHYs in reset while initializing EHCI controlle=
r */
> =A0 =A0 =A0 =A0if (pdata->phy_reset) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (gpio_is_valid(pdata->reset_gpio_po=
rt[0]))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_request_one(pdata-=
>reset_gpio_port[0],
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0GPIOF_OUT_INIT_LOW, "USB1 PHY
reset");
> +
gpio_set_value_cansleep(pdata->reset_gpio_port[0], 0);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (gpio_is_valid(pdata->reset_gpio_po=
rt[1]))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_request_one(pdata-=
>reset_gpio_port[1],
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0GPIOF_OUT_INIT_LOW, "USB2 PHY
reset");
> +
gpio_set_value_cansleep(pdata->reset_gpio_port[1], 0);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Hold the PHY in RESET for enough ti=
me till DIR is high
*/
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0udelay(10);
> @@ -241,6 +240,11 @@ static int ehci_hcd_omap_probe(struct
platform_device *pdev)
> =A0 =A0 =A0 =A0omap_ehci->hcs_params =3D readl(&omap_ehci->caps->hcs_=
params);
>
> =A0 =A0 =A0 =A0ehci_reset(omap_ehci);
> + =A0 =A0 =A0 ret =3D usb_add_hcd(hcd, irq, IRQF_SHARED);
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "failed to add hcd with er=
r %d\n", ret);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_add_hcd;
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0if (pdata->phy_reset) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Hold the PHY in RESET for enough ti=
me till
> @@ -255,12 +259,6 @@ static int ehci_hcd_omap_probe(struct
platform_device *pdev)
>
=A0gpio_set_value_cansleep(pdata->reset_gpio_port[1], 1);
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 ret =3D usb_add_hcd(hcd, irq, IRQF_SHARED);
> - =A0 =A0 =A0 if (ret) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "failed to add hcd with er=
r %d\n", ret);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_add_hcd;
> - =A0 =A0 =A0 }
> -
> =A0 =A0 =A0 =A0/* root ports should always stay powered */
> =A0 =A0 =A0 =A0ehci_port_power(omap_ehci, 1);
>
> --
> 1.7.10.4
>

Hi Samuel

I have validated this patch v3 in omap3 beagle XM .

Acked-by: Keshava Munegowda <keshava_mgowda@ti.com>
Tested-by: Keshava Munegowda <keshava_mgowda@ti.com>

regards
keshava
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
