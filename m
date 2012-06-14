From: Russ Dill <Russ.Dill@ti.com>
Subject: Re: [PATCH] ARM: OMAP3: USB: Fix the EHCI ULPI PHY reset fix issues.
Date: Thu, 14 Jun 2012 09:09:52 -0700
Message-ID: <CA+Bv8XbTK+dk6Oqbf4byJwY0O9bhWvPqr1rQojfR=hGxPmZ-uA@mail.gmail.com>
References: <1339673500-5218-1-git-send-email-Russ.Dill@ti.com>
	<4FD9E03E.8030102@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:63379 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754318Ab2FNQJy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Jun 2012 12:09:54 -0400
Received: by lahd3 with SMTP id d3so1376813lah.19
        for <linux-omap@vger.kernel.org>; Thu, 14 Jun 2012 09:09:52 -0700 (PDT)
In-Reply-To: <4FD9E03E.8030102@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Keshava Munegowda <keshava_mgowda@ti.com>, Partha Basak <parthab@india.ti.com>, Samuel Ortiz <sameo@linux.intel.com>, mantesh@ti.com, s-sapna1@ti.com

On Thu, Jun 14, 2012 at 5:59 AM, Igor Grinberg <grinberg@compulab.co.il=
> wrote:
> Hi Russ,
>
> On 06/14/12 14:31, Russ Dill wrote:
>> 'ARM: OMAP3: USB: Fix the EHCI ULPI PHY reset issue' (1fcb57d0) fixe=
s
>> an issue where the ULPI PHYs were not held in reset while initializi=
ng
>> the EHCI controller. However, it also changes behavior in
>> omap-usb-host.c omap_usbhs_init by releasing reset while the
>> configuration in that function was done.
>>
>> This change caused a regression on BB-xM where USB would not functio=
n
>> if 'usb start' had been run from u-boot before booting. A change was
>> made to release reset a little bit earlier which fixed the issue on
>> BB-xM and did not cause any regressions on 3430 sdp, the board for
>> which the fix was originally made.
>>
>> This new fix, 'USB: EHCI: OMAP: Finish ehci omap phy reset cycle
>> before adding hcd.', (3aa2ae74) caused a regression on OMAP5.
>>
>> The original fix to hold the EHCI controller in reset during
>> initialization was correct, however it appears that changing
>> omap_usbhs_init to not hold the PHYs in reset during it's
>> configuration was incorrect. This patch first reverts both fixes, an=
d
>> then changes ehci_hcd_omap_probe in ehci-omap.c to hold the PHYs in
>> reset as the original patch had done. It also is sure to incorporate
>> the _cansleep change that has been made in the meantime.
>>
>> I've tested this on Beagleboard xM, I'd really like to get an ack fr=
om
>> the 3430 sdp and OMAP5 guys before getting this merged.
>>
>> Signed-off-by: Russ Dill <Russ.Dill@gmail.com>
>> ---
>> =C2=A0drivers/mfd/omap-usb-host.c =C2=A0| =C2=A0 45 ++++++++++++++++=
++++++++++++++++++++++++++
>> =C2=A0drivers/usb/host/ehci-omap.c | =C2=A0 18 ++++++++---------
>> =C2=A02 files changed, 53 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host=
=2Ec
>> index 7e96bb2..10984e2 100644
>> --- a/drivers/mfd/omap-usb-host.c
>> +++ b/drivers/mfd/omap-usb-host.c
>> @@ -25,6 +25,7 @@
>> =C2=A0#include <linux/clk.h>
>> =C2=A0#include <linux/dma-mapping.h>
>> =C2=A0#include <linux/spinlock.h>
>> +#include <linux/gpio.h>
>> =C2=A0#include <plat/cpu.h>
>> =C2=A0#include <plat/usb.h>
>> =C2=A0#include <linux/pm_runtime.h>
>> @@ -502,6 +503,19 @@ static void omap_usbhs_init(struct device *dev)
>> =C2=A0 =C2=A0 =C2=A0 pm_runtime_get_sync(dev);
>> =C2=A0 =C2=A0 =C2=A0 spin_lock_irqsave(&omap->lock, flags);
>>
>> + =C2=A0 =C2=A0 if (pdata->ehci_data->phy_reset) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (gpio_is_valid(pdata-=
>ehci_data->reset_gpio_port[0]))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 gpio_request_one(pdata->ehci_data->reset_gpio_port[0],
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GPIOF=
_OUT_INIT_LOW, "USB1 PHY reset");
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (gpio_is_valid(pdata-=
>ehci_data->reset_gpio_port[1]))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 gpio_request_one(pdata->ehci_data->reset_gpio_port[1],
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GPIOF=
_OUT_INIT_LOW, "USB2 PHY reset");
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Hold the PHY in RESET=
 for enough time till DIR is high */
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 udelay(10);
>> + =C2=A0 =C2=A0 }
>
> Hmmm.... I think this hunk should come before the spin_lock_irqsave()=
 call,
> as it might sleep with I2C GPIO extenders...
>
>> +
>> =C2=A0 =C2=A0 =C2=A0 omap->usbhs_rev =3D usbhs_read(omap->uhh_base, =
OMAP_UHH_REVISION);
>> =C2=A0 =C2=A0 =C2=A0 dev_dbg(dev, "OMAP UHH_REVISION 0x%x\n", omap->=
usbhs_rev);
>>
>> @@ -580,10 +594,39 @@ static void omap_usbhs_init(struct device *dev=
)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 usbhs_omap_tll_init(dev, OMAP_TLL_CHANNEL_COUNT);
>> =C2=A0 =C2=A0 =C2=A0 }
>>
>> + =C2=A0 =C2=A0 if (pdata->ehci_data->phy_reset) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Hold the PHY in RESET=
 for enough time till
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* PHY is settled a=
nd ready
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 udelay(10);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (gpio_is_valid(pdata-=
>ehci_data->reset_gpio_port[0]))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 gpio_set_value_cansleep
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (pdata->ehci_data->reset_gpio_port[0], =
1);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (gpio_is_valid(pdata-=
>ehci_data->reset_gpio_port[1]))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 gpio_set_value_cansleep
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (pdata->ehci_data->reset_gpio_port[1], =
1);
>> + =C2=A0 =C2=A0 }
>
> Same here, after the the spin_unlock_irqrestore() call?

That's embarrassing, thanks, I'll resend.

>> +
>> =C2=A0 =C2=A0 =C2=A0 spin_unlock_irqrestore(&omap->lock, flags);
>> =C2=A0 =C2=A0 =C2=A0 pm_runtime_put_sync(dev);
>> =C2=A0}
>>
>> +static void omap_usbhs_deinit(struct device *dev)
>> +{
>> + =C2=A0 =C2=A0 struct usbhs_hcd_omap =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 *omap =3D dev_get_drvdata(dev);
>> + =C2=A0 =C2=A0 struct usbhs_omap_platform_data *pdata =3D &omap->pl=
atdata;
>> +
>> + =C2=A0 =C2=A0 if (pdata->ehci_data->phy_reset) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (gpio_is_valid(pdata-=
>ehci_data->reset_gpio_port[0]))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 gpio_free(pdata->ehci_data->reset_gpio_port[0]);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (gpio_is_valid(pdata-=
>ehci_data->reset_gpio_port[1]))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 gpio_free(pdata->ehci_data->reset_gpio_port[1]);
>> + =C2=A0 =C2=A0 }
>> +}
>> +
>>
>> =C2=A0/**
>> =C2=A0 * usbhs_omap_probe - initialize TI-based HCDs
>> @@ -767,6 +810,7 @@ static int __devinit usbhs_omap_probe(struct pla=
tform_device *pdev)
>> =C2=A0 =C2=A0 =C2=A0 goto end_probe;
>>
>> =C2=A0err_alloc:
>> + =C2=A0 =C2=A0 omap_usbhs_deinit(&pdev->dev);
>> =C2=A0 =C2=A0 =C2=A0 iounmap(omap->tll_base);
>>
>> =C2=A0err_tll:
>> @@ -818,6 +862,7 @@ static int __devexit usbhs_omap_remove(struct pl=
atform_device *pdev)
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 struct usbhs_hcd_omap *omap =3D platform_get_dr=
vdata(pdev);
>>
>> + =C2=A0 =C2=A0 omap_usbhs_deinit(&pdev->dev);
>> =C2=A0 =C2=A0 =C2=A0 iounmap(omap->tll_base);
>> =C2=A0 =C2=A0 =C2=A0 iounmap(omap->uhh_base);
>> =C2=A0 =C2=A0 =C2=A0 clk_put(omap->init_60m_fclk);
>> diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-om=
ap.c
>> index a44294d..d0815b6 100644
>> --- a/drivers/usb/host/ehci-omap.c
>> +++ b/drivers/usb/host/ehci-omap.c
>> @@ -192,14 +192,13 @@ static int ehci_hcd_omap_probe(struct platform=
_device *pdev)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> =C2=A0 =C2=A0 =C2=A0 }
>>
>> + =C2=A0 =C2=A0 /* Hold PHYs in reset while initializing EHCI contro=
ller */
>> =C2=A0 =C2=A0 =C2=A0 if (pdata->phy_reset) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (gpio_is_valid(p=
data->reset_gpio_port[0]))
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 gpio_request_one(pdata->reset_gpio_port[0],
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GPIOF=
_OUT_INIT_LOW, "USB1 PHY reset");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 gpio_set_value_cansleep(pdata->reset_gpio_port[0], 0);
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (gpio_is_valid(p=
data->reset_gpio_port[1]))
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 gpio_request_one(pdata->reset_gpio_port[1],
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GPIOF=
_OUT_INIT_LOW, "USB2 PHY reset");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 gpio_set_value_cansleep(pdata->reset_gpio_port[1], 0);
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Hold the PHY in =
RESET for enough time till DIR is high */
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 udelay(10);
>> @@ -241,6 +240,11 @@ static int ehci_hcd_omap_probe(struct platform_=
device *pdev)
>> =C2=A0 =C2=A0 =C2=A0 omap_ehci->hcs_params =3D readl(&omap_ehci->cap=
s->hcs_params);
>>
>> =C2=A0 =C2=A0 =C2=A0 ehci_reset(omap_ehci);
>> + =C2=A0 =C2=A0 ret =3D usb_add_hcd(hcd, irq, IRQF_SHARED);
>> + =C2=A0 =C2=A0 if (ret) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(dev, "failed to =
add hcd with err %d\n", ret);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_add_hcd;
>> + =C2=A0 =C2=A0 }
>>
>> =C2=A0 =C2=A0 =C2=A0 if (pdata->phy_reset) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Hold the PHY in =
RESET for enough time till
>> @@ -255,12 +259,6 @@ static int ehci_hcd_omap_probe(struct platform_=
device *pdev)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 gpio_set_value_cansleep(pdata->reset_gpio_port[1], 1);
>> =C2=A0 =C2=A0 =C2=A0 }
>>
>> - =C2=A0 =C2=A0 ret =3D usb_add_hcd(hcd, irq, IRQF_SHARED);
>> - =C2=A0 =C2=A0 if (ret) {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(dev, "failed to =
add hcd with err %d\n", ret);
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_add_hcd;
>> - =C2=A0 =C2=A0 }
>> -
>> =C2=A0 =C2=A0 =C2=A0 /* root ports should always stay powered */
>> =C2=A0 =C2=A0 =C2=A0 ehci_port_power(omap_ehci, 1);
>>
>
> --
> Regards,
> Igor.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
