From: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Subject: Re: [PATCH] omap: usbhs: Fixed the crash during rmmod of ehci and ohci
Date: Mon, 9 May 2011 15:58:53 +0530
Message-ID: <BANLkTi=F5g50mxw6VBv7-di7hH_eDEZ=GA@mail.gmail.com>
References: <1304932203-31223-1-git-send-email-keshava_mgowda@ti.com>
	<20110509093645.GG1254@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:42914 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751431Ab1EIK24 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 9 May 2011 06:28:56 -0400
In-Reply-To: <20110509093645.GG1254@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, gadiyar@ti.com, p-bask2@ti.com

On Mon, May 9, 2011 at 3:06 PM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Mon, May 09, 2011 at 02:40:03PM +0530, Keshava Munegowda wrote:
>> From: Keshava Munegowda <Keshava_mgowda@ti.com>
>>
>> the disabling of clocks and freeing GPIO are changed
>> to fix the occurence of the crash of rmmod of ehci and ohci
>> drivers
>>
>> Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
>
> NAK
>
>> ---
>> =A0drivers/mfd/omap-usb-host.c | =A0 24 ++++++++++++++++--------
>> =A01 files changed, 16 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host=
=2Ec
>> index 3ab9ffa..cda0797 100644
>> --- a/drivers/mfd/omap-usb-host.c
>> +++ b/drivers/mfd/omap-usb-host.c
>> @@ -939,6 +939,7 @@ static void usbhs_disable(struct device *dev)
>> =A0 =A0 =A0 struct usbhs_hcd_omap =A0 =A0 =A0 =A0 =A0 *omap =3D dev_=
get_drvdata(dev);
>> =A0 =A0 =A0 struct usbhs_omap_platform_data *pdata =3D &omap->platda=
ta;
>> =A0 =A0 =A0 unsigned long =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 flags =
=3D 0;
>> + =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0halt =3D=
 0;
>
> you shouldn't need this.
>
>> @@ -994,24 +995,31 @@ static void usbhs_disable(struct device *dev)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dev, "operation =
timed out\n");
>> =A0 =A0 =A0 }
>>
>> - =A0 =A0 if (pdata->ehci_data->phy_reset) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (gpio_is_valid(pdata->ehci_data->reset_=
gpio_port[0]))
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_free(pdata->ehci_data=
->reset_gpio_port[0]);
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (gpio_is_valid(pdata->ehci_data->reset_=
gpio_port[1]))
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_free(pdata->ehci_data=
->reset_gpio_port[1]);
>> + =A0 =A0 if (is_omap_usbhs_rev2(omap)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (is_ehci_tll_mode(pdata->port_mode[0]))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_enable(omap->usbtll_p1=
_fck);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (is_ehci_tll_mode(pdata->port_mode[1]))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_enable(omap->usbtll_p2=
_fck);
>> + =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(omap->utmi_p2_fck);
>> + =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(omap->utmi_p1_fck);
>> =A0 =A0 =A0 }
>>
>> - =A0 =A0 clk_disable(omap->utmi_p2_fck);
>> - =A0 =A0 clk_disable(omap->utmi_p1_fck);
>> =A0 =A0 =A0 clk_disable(omap->usbtll_ick);
>> =A0 =A0 =A0 clk_disable(omap->usbtll_fck);
>> =A0 =A0 =A0 clk_disable(omap->usbhost_fs_fck);
>> =A0 =A0 =A0 clk_disable(omap->usbhost_hs_fck);
>> =A0 =A0 =A0 clk_disable(omap->usbhost_ick);
>> + =A0 =A0 halt =3D 1;
>
> at least from this diff, you're always reaching that part of the code
> rendering this halt flag useless.

I you see only the patch ; its looks like variable halt is not needed;

If the code; it will be set only when the clocks are disabled;
Then after restoring irq, you will free the gpio based on this value.

The complete usbhs_disable code is follows:
static void usbhs_disable(struct device *dev)
{
	struct usbhs_hcd_omap		*omap =3D dev_get_drvdata(dev);
	struct usbhs_omap_platform_data	*pdata =3D &omap->platdata;
	unsigned long			flags =3D 0;
	unsigned int			halt =3D 0;
	unsigned long			timeout;

	dev_dbg(dev, "stopping TI HSUSB Controller\n");

	spin_lock_irqsave(&omap->lock, flags);

	if (omap->count =3D=3D 0)
		goto end_disble;

	omap->count--;

	if (omap->count !=3D 0)
		goto end_disble;

	/* Reset OMAP modules for insmod/rmmod to work */
	usbhs_write(omap->uhh_base, OMAP_UHH_SYSCONFIG,
			is_omap_usbhs_rev2(omap) ?
			OMAP4_UHH_SYSCONFIG_SOFTRESET :
			OMAP_UHH_SYSCONFIG_SOFTRESET);

	timeout =3D jiffies + msecs_to_jiffies(100);
	while (!(usbhs_read(omap->uhh_base, OMAP_UHH_SYSSTATUS)
				& (1 << 0))) {
		cpu_relax();

		if (time_after(jiffies, timeout))
			dev_dbg(dev, "operation timed out\n");
	}

	while (!(usbhs_read(omap->uhh_base, OMAP_UHH_SYSSTATUS)
				& (1 << 1))) {
		cpu_relax();

		if (time_after(jiffies, timeout))
			dev_dbg(dev, "operation timed out\n");
	}

	while (!(usbhs_read(omap->uhh_base, OMAP_UHH_SYSSTATUS)
				& (1 << 2))) {
		cpu_relax();

		if (time_after(jiffies, timeout))
			dev_dbg(dev, "operation timed out\n");
	}

	usbhs_write(omap->tll_base, OMAP_USBTLL_SYSCONFIG, (1 << 1));

	while (!(usbhs_read(omap->tll_base, OMAP_USBTLL_SYSSTATUS)
				& (1 << 0))) {
		cpu_relax();

		if (time_after(jiffies, timeout))
			dev_dbg(dev, "operation timed out\n");
	}

	if (is_omap_usbhs_rev2(omap)) {
		if (is_ehci_tll_mode(pdata->port_mode[0]))
			clk_enable(omap->usbtll_p1_fck);
		if (is_ehci_tll_mode(pdata->port_mode[1]))
			clk_enable(omap->usbtll_p2_fck);
		clk_disable(omap->utmi_p2_fck);
		clk_disable(omap->utmi_p1_fck);
	}

	clk_disable(omap->usbtll_ick);
	clk_disable(omap->usbtll_fck);
	clk_disable(omap->usbhost_fs_fck);
	clk_disable(omap->usbhost_hs_fck);
	clk_disable(omap->usbhost_ick);
	halt =3D 1;

end_disble:
	spin_unlock_irqrestore(&omap->lock, flags);
	if (halt && pdata->ehci_data->phy_reset) {
		if (gpio_is_valid(pdata->ehci_data->reset_gpio_port[0]))
			gpio_free(pdata->ehci_data->reset_gpio_port[0]);

		if (gpio_is_valid(pdata->ehci_data->reset_gpio_port[1]))
			gpio_free(pdata->ehci_data->reset_gpio_port[1]);
	}
}




>
> --
> balbi
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
