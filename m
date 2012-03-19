From: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Subject: Re: [PATCH RESEND] ARM: OMAP3: USB: Fix the EHCI ULPI PHY reset issue
Date: Mon, 19 Mar 2012 20:13:25 +0530
Message-ID: <CAP05o4KyWYuvKyz7XRqKOhmRhQLjwvibRoG55wgF1+W-KA4hfg@mail.gmail.com>
References: <1332139367-1302-1-git-send-email-keshava_mgowda@ti.com>
	<CAMrsUdKnL+kSRQXi=X0d1S2fZM5sGpmYqzKnp0TPpjCKVujuaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:42947 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752766Ab2CSOn0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Mar 2012 10:43:26 -0400
Received: by mail-gx0-f172.google.com with SMTP id i1so5326828ggm.3
        for <linux-omap@vger.kernel.org>; Mon, 19 Mar 2012 07:43:25 -0700 (PDT)
In-Reply-To: <CAMrsUdKnL+kSRQXi=X0d1S2fZM5sGpmYqzKnp0TPpjCKVujuaw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Raja, Govindraj" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, balbi@ti.com, sameo@linux.intel.com, parthab@india.ti.com

On Mon, Mar 19, 2012 at 7:04 PM, Raja, Govindraj <govindraj.raja@ti.com=
> wrote:
> On Mon, Mar 19, 2012 at 12:12 PM, Keshava Munegowda
> <keshava_mgowda@ti.com> wrote:
>> From: Keshava Munegowda <Keshava_mgowda@ti.com>
>>
>> It is observed that the echi ports of 3430 sdp board
>> are not working due to the random timing of programming
>> the associated GPIOs of the ULPI PHYs of the EHCI for reset.
>> If the PHYs are reset at during usbhs core driver, host ports will
>> not work because EHCI driver is loaded after the resetting PHYs.
>> The PHYs should be in reset state while initializing the EHCI
>> controller.
>> The code which does the GPIO pins associated with the PHYs
>> are programmed to reset is moved from the USB host core driver
>> to EHCI driver.
>
> I tested on beagle xm where gpio nreset is requested from
> board file.
> (Basic enumertaion after gpio nreset seems to work fine,
> Hub and smsc lan chip get detected afetr boot up)
>
>>
>> Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
>> Reviewed-by: Partha Basak <parthab@india.ti.com>
>
> Tested-by: Govindraj.R <govindraj.raja@ti.com>
>
>> ---
>> =A0drivers/mfd/omap-usb-host.c =A0| =A0 44 -------------------------=
-----------------
>> =A0drivers/usb/host/ehci-omap.c | =A0 39 +++++++++++++++++++++++++++=
++++++++-
>> =A02 files changed, 37 insertions(+), 46 deletions(-)
>>
>> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host=
=2Ec
>> index 68ac2c5..9927129 100644
>> --- a/drivers/mfd/omap-usb-host.c
>> +++ b/drivers/mfd/omap-usb-host.c
>> @@ -25,7 +25,6 @@
>> =A0#include <linux/clk.h>
>> =A0#include <linux/dma-mapping.h>
>> =A0#include <linux/spinlock.h>
>> -#include <linux/gpio.h>
>> =A0#include <plat/usb.h>
>> =A0#include <linux/pm_runtime.h>
>>
>> @@ -502,19 +501,6 @@ static void omap_usbhs_init(struct device *dev)
>> =A0 =A0 =A0 =A0pm_runtime_get_sync(dev);
>> =A0 =A0 =A0 =A0spin_lock_irqsave(&omap->lock, flags);
>>
>> - =A0 =A0 =A0 if (pdata->ehci_data->phy_reset) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (gpio_is_valid(pdata->ehci_data->re=
set_gpio_port[0]))
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_request_one(pdata=
->ehci_data->reset_gpio_port[0],
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0GPIOF_OUT_INIT_LOW, "USB1 PHY reset");
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (gpio_is_valid(pdata->ehci_data->re=
set_gpio_port[1]))
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_request_one(pdata=
->ehci_data->reset_gpio_port[1],
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0GPIOF_OUT_INIT_LOW, "USB2 PHY reset");
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Hold the PHY in RESET for enough ti=
me till DIR is high */
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(10);
>> - =A0 =A0 =A0 }
>> -
>> =A0 =A0 =A0 =A0omap->usbhs_rev =3D usbhs_read(omap->uhh_base, OMAP_U=
HH_REVISION);
>> =A0 =A0 =A0 =A0dev_dbg(dev, "OMAP UHH_REVISION 0x%x\n", omap->usbhs_=
rev);
>>
>> @@ -593,39 +579,10 @@ static void omap_usbhs_init(struct device *dev=
)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0usbhs_omap_tll_init(d=
ev, OMAP_TLL_CHANNEL_COUNT);
>> =A0 =A0 =A0 =A0}
>>
>> - =A0 =A0 =A0 if (pdata->ehci_data->phy_reset) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Hold the PHY in RESET for enough ti=
me till
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* PHY is settled and ready
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(10);
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (gpio_is_valid(pdata->ehci_data->re=
set_gpio_port[0]))
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_set_value
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (pdata=
->ehci_data->reset_gpio_port[0], 1);
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (gpio_is_valid(pdata->ehci_data->re=
set_gpio_port[1]))
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_set_value
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (pdata=
->ehci_data->reset_gpio_port[1], 1);
>> - =A0 =A0 =A0 }
>> -
>> =A0 =A0 =A0 =A0spin_unlock_irqrestore(&omap->lock, flags);
>> =A0 =A0 =A0 =A0pm_runtime_put_sync(dev);
>> =A0}
>>
>> -static void omap_usbhs_deinit(struct device *dev)
>> -{
>> - =A0 =A0 =A0 struct usbhs_hcd_omap =A0 =A0 =A0 =A0 =A0 *omap =3D de=
v_get_drvdata(dev);
>> - =A0 =A0 =A0 struct usbhs_omap_platform_data *pdata =3D &omap->plat=
data;
>> -
>> - =A0 =A0 =A0 if (pdata->ehci_data->phy_reset) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (gpio_is_valid(pdata->ehci_data->re=
set_gpio_port[0]))
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_free(pdata->ehci_=
data->reset_gpio_port[0]);
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (gpio_is_valid(pdata->ehci_data->re=
set_gpio_port[1]))
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_free(pdata->ehci_=
data->reset_gpio_port[1]);
>> - =A0 =A0 =A0 }
>> -}
>> -
>>
>> =A0/**
>> =A0* usbhs_omap_probe - initialize TI-based HCDs
>> @@ -861,7 +818,6 @@ static int __devexit usbhs_omap_remove(struct pl=
atform_device *pdev)
>> =A0{
>> =A0 =A0 =A0 =A0struct usbhs_hcd_omap *omap =3D platform_get_drvdata(=
pdev);
>>
>> - =A0 =A0 =A0 omap_usbhs_deinit(&pdev->dev);
>> =A0 =A0 =A0 =A0iounmap(omap->tll_base);
>> =A0 =A0 =A0 =A0iounmap(omap->uhh_base);
>> =A0 =A0 =A0 =A0clk_put(omap->init_60m_fclk);
>> diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-om=
ap.c
>> index bba9850..5c78f9e 100644
>> --- a/drivers/usb/host/ehci-omap.c
>> +++ b/drivers/usb/host/ehci-omap.c
>> @@ -42,6 +42,7 @@
>> =A0#include <plat/usb.h>
>> =A0#include <linux/regulator/consumer.h>
>> =A0#include <linux/pm_runtime.h>
>> +#include <linux/gpio.h>
>>
>> =A0/* EHCI Register Set */
>> =A0#define EHCI_INSNREG04 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 (0xA0)
>> @@ -191,6 +192,19 @@ static int ehci_hcd_omap_probe(struct platform_=
device *pdev)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>> =A0 =A0 =A0 =A0}
>>
>> + =A0 =A0 =A0 if (pdata->phy_reset) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (gpio_is_valid(pdata->reset_gpio_po=
rt[0]))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_request_one(pdata=
->reset_gpio_port[0],
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0GPIOF_OUT_INIT_LOW, "USB1 PHY reset");
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (gpio_is_valid(pdata->reset_gpio_po=
rt[1]))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_request_one(pdata=
->reset_gpio_port[1],
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0GPIOF_OUT_INIT_LOW, "USB2 PHY reset");
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Hold the PHY in RESET for enough ti=
me till DIR is high */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(10);
>> + =A0 =A0 =A0 }
>> +
>> =A0 =A0 =A0 =A0pm_runtime_enable(dev);
>> =A0 =A0 =A0 =A0pm_runtime_get_sync(dev);
>>
>> @@ -237,6 +251,19 @@ static int ehci_hcd_omap_probe(struct platform_=
device *pdev)
>> =A0 =A0 =A0 =A0/* root ports should always stay powered */
>> =A0 =A0 =A0 =A0ehci_port_power(omap_ehci, 1);
>>
>> + =A0 =A0 =A0 if (pdata->phy_reset) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Hold the PHY in RESET for enough ti=
me till
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* PHY is settled and ready
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(10);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (gpio_is_valid(pdata->reset_gpio_po=
rt[0]))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_set_value(pdata->=
reset_gpio_port[0], 1);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (gpio_is_valid(pdata->reset_gpio_po=
rt[1]))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_set_value(pdata->=
reset_gpio_port[1], 1);
>> + =A0 =A0 =A0 }
>> +
>> =A0 =A0 =A0 =A0return 0;
>>
>> =A0err_add_hcd:
>> @@ -259,8 +286,9 @@ err_io:
>> =A0*/
>> =A0static int ehci_hcd_omap_remove(struct platform_device *pdev)
>> =A0{
>> - =A0 =A0 =A0 struct device *dev =A0 =A0 =A0=3D &pdev->dev;
>> - =A0 =A0 =A0 struct usb_hcd *hcd =A0 =A0 =3D dev_get_drvdata(dev);
>> + =A0 =A0 =A0 struct device *dev =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0=3D &pdev->dev;
>> + =A0 =A0 =A0 struct usb_hcd *hcd =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =3D dev_get_drvdata(dev);
>> + =A0 =A0 =A0 struct ehci_hcd_omap_platform_data *pdata =A0 =A0 =A0 =
=3D dev->platform_data;
>>
>> =A0 =A0 =A0 =A0usb_remove_hcd(hcd);
>> =A0 =A0 =A0 =A0disable_put_regulator(dev->platform_data);
>> @@ -269,6 +297,13 @@ static int ehci_hcd_omap_remove(struct platform=
_device *pdev)
>> =A0 =A0 =A0 =A0pm_runtime_put_sync(dev);
>> =A0 =A0 =A0 =A0pm_runtime_disable(dev);
>>
>> + =A0 =A0 =A0 if (pdata->phy_reset) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (gpio_is_valid(pdata->reset_gpio_po=
rt[0]))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_free(pdata->reset=
_gpio_port[0]);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (gpio_is_valid(pdata->reset_gpio_po=
rt[1]))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_free(pdata->reset=
_gpio_port[1]);
>> + =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0return 0;
>> =A0}
>>
>> --
>> 1.6.0.4
>>

thanks govind

regards
keshava
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
