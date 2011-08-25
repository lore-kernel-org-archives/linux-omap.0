From: "Munegowda, Keshava" <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 5/5 v7] mfd: omap: usb: Runtime PM support
Date: Thu, 25 Aug 2011 12:08:29 +0530
Message-ID: <CAP05o4JLUBAsxYeDpxB4=ceoVAEGEzZHyWsSdJ-VwXMLnRO4dQ@mail.gmail.com>
References: <1314196260-9578-1-git-send-email-keshava_mgowda@ti.com>
	<1314196260-9578-2-git-send-email-keshava_mgowda@ti.com>
	<1314196260-9578-3-git-send-email-keshava_mgowda@ti.com>
	<1314196260-9578-4-git-send-email-keshava_mgowda@ti.com>
	<1314196260-9578-5-git-send-email-keshava_mgowda@ti.com>
	<1314196260-9578-6-git-send-email-keshava_mgowda@ti.com>
	<4E55ECC8.2030204@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4E55ECC8.2030204-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, gadiyar-l0cyMroinI0@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, johnstul-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org, vishwanath.bs-l0cyMroinI0@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, Aug 25, 2011 at 12:03 PM, Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org> wr=
ote:
> Hi Keshav,
> Some minor comments
>
> On Wednesday 24 August 2011 08:01 PM, Keshava Munegowda wrote:
>>
>> From: Keshava Munegowda<Keshava_mgowda-l0cyMroinI0@public.gmane.org>
>>
>> The usbhs core driver does not enable/disable the interface and
>> functional clocks; These clocks are handled by hwmod and runtime pm,
>> hence instead of the clock enable/disable, the runtime pm APIS are
>> used. however,the port clocks are handled by the usbhs core.
>>
>> Signed-off-by: Keshava Munegowda<keshava_mgowda-l0cyMroinI0@public.gmane.org>
>> ---
>> =A0arch/arm/plat-omap/include/plat/usb.h | =A0 =A03 -
>> =A0drivers/mfd/omap-usb-host.c =A0 =A0 =A0 =A0 =A0 | =A0731
>> +++++++++++++--------------------
>> =A0drivers/usb/host/ehci-omap.c =A0 =A0 =A0 =A0 =A0| =A0 17 +-
>> =A0drivers/usb/host/ohci-omap3.c =A0 =A0 =A0 =A0 | =A0 18 +-
>> =A04 files changed, 295 insertions(+), 474 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/include/plat/usb.h
>> b/arch/arm/plat-omap/include/plat/usb.h
>> index 17d3c93..2b66dc2 100644
>> --- a/arch/arm/plat-omap/include/plat/usb.h
>> +++ b/arch/arm/plat-omap/include/plat/usb.h
>> @@ -100,9 +100,6 @@ extern void usb_musb_init(struct omap_musb_board=
_data
>> *board_data);
>>
>> =A0extern void usbhs_init(const struct usbhs_omap_board_data *pdata)=
;
>>
>> -extern int omap_usbhs_enable(struct device *dev);
>> -extern void omap_usbhs_disable(struct device *dev);
>> -
>> =A0extern int omap4430_phy_power(struct device *dev, int ID, int on)=
;
>> =A0extern int omap4430_phy_set_clk(struct device *dev, int on);
>> =A0extern int omap4430_phy_init(struct device *dev);
>> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host=
=2Ec
>> index 9c2da29..e6f3b01 100644
>> --- a/drivers/mfd/omap-usb-host.c
>> +++ b/drivers/mfd/omap-usb-host.c
>> @@ -26,6 +26,7 @@
>> =A0#include<linux/spinlock.h>
>> =A0#include<linux/gpio.h>
>> =A0#include<plat/usb.h>
>> +#include<linux/pm_runtime.h>
>>
>> =A0#define USBHS_DRIVER_NAME =A0 =A0 "usbhs_omap"
>> =A0#define OMAP_EHCI_DEVICE =A0 =A0 =A0"ehci-omap"
>> @@ -146,9 +147,6 @@
>>
>>
>> =A0struct usbhs_hcd_omap {
>> - =A0 =A0 =A0 struct clk =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
*usbhost_ick;
>> - =A0 =A0 =A0 struct clk =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
*usbhost_hs_fck;
>> - =A0 =A0 =A0 struct clk =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
*usbhost_fs_fck;
>> =A0 =A0 =A0 =A0struct clk =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
*xclk60mhsp1_ck;
>> =A0 =A0 =A0 =A0struct clk =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
*xclk60mhsp2_ck;
>> =A0 =A0 =A0 =A0struct clk =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
*utmi_p1_fck;
>> @@ -158,8 +156,6 @@ struct usbhs_hcd_omap {
>> =A0 =A0 =A0 =A0struct clk =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
*usbhost_p2_fck;
>> =A0 =A0 =A0 =A0struct clk =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
*usbtll_p2_fck;
>> =A0 =A0 =A0 =A0struct clk =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
*init_60m_fclk;
>> - =A0 =A0 =A0 struct clk =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
*usbtll_fck;
>> - =A0 =A0 =A0 struct clk =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
*usbtll_ick;
>>
>> =A0 =A0 =A0 =A0void __iomem =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*=
uhh_base;
>> =A0 =A0 =A0 =A0void __iomem =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*=
tll_base;
>> @@ -168,7 +164,6 @@ struct usbhs_hcd_omap {
>>
>> =A0 =A0 =A0 =A0u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 usbhs_rev;
>> =A0 =A0 =A0 =A0spinlock_t =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
lock;
>> - =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 count;
>> =A0};
>>
>> =A0/*---------------------------------------------------------------=
----------*/
>>
>> @@ -318,269 +313,6 @@ err_end:
>> =A0 =A0 =A0 =A0return ret;
>> =A0}
>>
>> -/**
>> - * usbhs_omap_probe - initialize TI-based HCDs
>> - *
>> - * Allocates basic resources for this USB host controller.
>> - */
>> -static int __devinit usbhs_omap_probe(struct platform_device *pdev)
>> -{
>> - =A0 =A0 =A0 struct device =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *dev=
 =3D&pdev->dev;
>> - =A0 =A0 =A0 struct usbhs_omap_platform_data *pdata =3D dev->platfo=
rm_data;
>> - =A0 =A0 =A0 struct usbhs_hcd_omap =A0 =A0 =A0 =A0 =A0 *omap;
>> - =A0 =A0 =A0 struct resource =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *res;
>> - =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 ret =3D 0;
>> - =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 i;
>> -
>> - =A0 =A0 =A0 if (!pdata) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "Missing platform data\n"=
);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto end_probe;
>> - =A0 =A0 =A0 }
>> -
>> - =A0 =A0 =A0 omap =3D kzalloc(sizeof(*omap), GFP_KERNEL);
>> - =A0 =A0 =A0 if (!omap) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "Memory allocation failed=
\n");
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto end_probe;
>> - =A0 =A0 =A0 }
>> -
>> - =A0 =A0 =A0 spin_lock_init(&omap->lock);
>> -
>> - =A0 =A0 =A0 for (i =3D 0; i< =A0OMAP3_HS_USB_PORTS; i++)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap->platdata.port_mode[i] =3D pdata-=
>port_mode[i];
>> -
>> - =A0 =A0 =A0 omap->platdata.ehci_data =3D pdata->ehci_data;
>> - =A0 =A0 =A0 omap->platdata.ohci_data =3D pdata->ohci_data;
>> -
>> - =A0 =A0 =A0 omap->usbhost_ick =3D clk_get(dev, "usbhost_ick");
>> - =A0 =A0 =A0 if (IS_ERR(omap->usbhost_ick)) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D =A0PTR_ERR(omap->usbhost_ick);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "usbhost_ick failed error=
:%d\n", ret);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_end;
>> - =A0 =A0 =A0 }
>> -
>> - =A0 =A0 =A0 omap->usbhost_hs_fck =3D clk_get(dev, "hs_fck");
>> - =A0 =A0 =A0 if (IS_ERR(omap->usbhost_hs_fck)) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(omap->usbhost_hs_fck);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "usbhost_hs_fck failed er=
ror:%d\n", ret);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_usbhost_ick;
>> - =A0 =A0 =A0 }
>> -
>> - =A0 =A0 =A0 omap->usbhost_fs_fck =3D clk_get(dev, "fs_fck");
>> - =A0 =A0 =A0 if (IS_ERR(omap->usbhost_fs_fck)) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(omap->usbhost_fs_fck);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "usbhost_fs_fck failed er=
ror:%d\n", ret);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_usbhost_hs_fck;
>> - =A0 =A0 =A0 }
>> -
>> - =A0 =A0 =A0 omap->usbtll_fck =3D clk_get(dev, "usbtll_fck");
>> - =A0 =A0 =A0 if (IS_ERR(omap->usbtll_fck)) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(omap->usbtll_fck);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "usbtll_fck failed error:=
%d\n", ret);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_usbhost_fs_fck;
>> - =A0 =A0 =A0 }
>> -
>> - =A0 =A0 =A0 omap->usbtll_ick =3D clk_get(dev, "usbtll_ick");
>> - =A0 =A0 =A0 if (IS_ERR(omap->usbtll_ick)) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(omap->usbtll_ick);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "usbtll_ick failed error:=
%d\n", ret);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_usbtll_fck;
>> - =A0 =A0 =A0 }
>> -
>> - =A0 =A0 =A0 omap->utmi_p1_fck =3D clk_get(dev, "utmi_p1_gfclk");
>> - =A0 =A0 =A0 if (IS_ERR(omap->utmi_p1_fck)) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(omap->utmi_p1_fck);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "utmi_p1_gfclk failed err=
or:%d\n", ret);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_usbtll_ick;
>> - =A0 =A0 =A0 }
>> -
>> - =A0 =A0 =A0 omap->xclk60mhsp1_ck =3D clk_get(dev, "xclk60mhsp1_ck"=
);
>> - =A0 =A0 =A0 if (IS_ERR(omap->xclk60mhsp1_ck)) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(omap->xclk60mhsp1_ck);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "xclk60mhsp1_ck failed er=
ror:%d\n", ret);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_utmi_p1_fck;
>> - =A0 =A0 =A0 }
>> -
>> - =A0 =A0 =A0 omap->utmi_p2_fck =3D clk_get(dev, "utmi_p2_gfclk");
>> - =A0 =A0 =A0 if (IS_ERR(omap->utmi_p2_fck)) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(omap->utmi_p2_fck);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "utmi_p2_gfclk failed err=
or:%d\n", ret);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_xclk60mhsp1_ck;
>> - =A0 =A0 =A0 }
>> -
>> - =A0 =A0 =A0 omap->xclk60mhsp2_ck =3D clk_get(dev, "xclk60mhsp2_ck"=
);
>> - =A0 =A0 =A0 if (IS_ERR(omap->xclk60mhsp2_ck)) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(omap->xclk60mhsp2_ck);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "xclk60mhsp2_ck failed er=
ror:%d\n", ret);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_utmi_p2_fck;
>> - =A0 =A0 =A0 }
>> -
>> - =A0 =A0 =A0 omap->usbhost_p1_fck =3D clk_get(dev, "usb_host_hs_utm=
i_p1_clk");
>> - =A0 =A0 =A0 if (IS_ERR(omap->usbhost_p1_fck)) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(omap->usbhost_p1_fck);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "usbhost_p1_fck failed er=
ror:%d\n", ret);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_xclk60mhsp2_ck;
>> - =A0 =A0 =A0 }
>> -
>> - =A0 =A0 =A0 omap->usbtll_p1_fck =3D clk_get(dev, "usb_tll_hs_usb_c=
h0_clk");
>> - =A0 =A0 =A0 if (IS_ERR(omap->usbtll_p1_fck)) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(omap->usbtll_p1_fck);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "usbtll_p1_fck failed err=
or:%d\n", ret);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_usbhost_p1_fck;
>> - =A0 =A0 =A0 }
>> -
>> - =A0 =A0 =A0 omap->usbhost_p2_fck =3D clk_get(dev, "usb_host_hs_utm=
i_p2_clk");
>> - =A0 =A0 =A0 if (IS_ERR(omap->usbhost_p2_fck)) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(omap->usbhost_p2_fck);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "usbhost_p2_fck failed er=
ror:%d\n", ret);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_usbtll_p1_fck;
>> - =A0 =A0 =A0 }
>> -
>> - =A0 =A0 =A0 omap->usbtll_p2_fck =3D clk_get(dev, "usb_tll_hs_usb_c=
h1_clk");
>> - =A0 =A0 =A0 if (IS_ERR(omap->usbtll_p2_fck)) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(omap->usbtll_p2_fck);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "usbtll_p2_fck failed err=
or:%d\n", ret);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_usbhost_p2_fck;
>> - =A0 =A0 =A0 }
>> -
>> - =A0 =A0 =A0 omap->init_60m_fclk =3D clk_get(dev, "init_60m_fclk");
>> - =A0 =A0 =A0 if (IS_ERR(omap->init_60m_fclk)) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(omap->init_60m_fclk);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "init_60m_fclk failed err=
or:%d\n", ret);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_usbtll_p2_fck;
>> - =A0 =A0 =A0 }
>> -
>> - =A0 =A0 =A0 res =3D platform_get_resource_byname(pdev, IORESOURCE_=
MEM, "uhh");
>> - =A0 =A0 =A0 if (!res) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "UHH EHCI get resource fa=
iled\n");
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODEV;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_init_60m_fclk;
>> - =A0 =A0 =A0 }
>> -
>> - =A0 =A0 =A0 omap->uhh_base =3D ioremap(res->start, resource_size(r=
es));
>> - =A0 =A0 =A0 if (!omap->uhh_base) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "UHH ioremap failed\n");
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_init_60m_fclk;
>> - =A0 =A0 =A0 }
>> -
>> - =A0 =A0 =A0 res =3D platform_get_resource_byname(pdev, IORESOURCE_=
MEM, "tll");
>> - =A0 =A0 =A0 if (!res) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "UHH EHCI get resource fa=
iled\n");
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODEV;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_tll;
>> - =A0 =A0 =A0 }
>> -
>> - =A0 =A0 =A0 omap->tll_base =3D ioremap(res->start, resource_size(r=
es));
>> - =A0 =A0 =A0 if (!omap->tll_base) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "TLL ioremap failed\n");
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_tll;
>> - =A0 =A0 =A0 }
>> -
>> - =A0 =A0 =A0 platform_set_drvdata(pdev, omap);
>> -
>> - =A0 =A0 =A0 ret =3D omap_usbhs_alloc_children(pdev);
>> - =A0 =A0 =A0 if (ret) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "omap_usbhs_alloc_childre=
n failed\n");
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_alloc;
>> - =A0 =A0 =A0 }
>> -
>> - =A0 =A0 =A0 goto end_probe;
>> -
>> -err_alloc:
>> - =A0 =A0 =A0 iounmap(omap->tll_base);
>> -
>> -err_tll:
>> - =A0 =A0 =A0 iounmap(omap->uhh_base);
>> -
>> -err_init_60m_fclk:
>> - =A0 =A0 =A0 clk_put(omap->init_60m_fclk);
>> -
>> -err_usbtll_p2_fck:
>> - =A0 =A0 =A0 clk_put(omap->usbtll_p2_fck);
>> -
>> -err_usbhost_p2_fck:
>> - =A0 =A0 =A0 clk_put(omap->usbhost_p2_fck);
>> -
>> -err_usbtll_p1_fck:
>> - =A0 =A0 =A0 clk_put(omap->usbtll_p1_fck);
>> -
>> -err_usbhost_p1_fck:
>> - =A0 =A0 =A0 clk_put(omap->usbhost_p1_fck);
>> -
>> -err_xclk60mhsp2_ck:
>> - =A0 =A0 =A0 clk_put(omap->xclk60mhsp2_ck);
>> -
>> -err_utmi_p2_fck:
>> - =A0 =A0 =A0 clk_put(omap->utmi_p2_fck);
>> -
>> -err_xclk60mhsp1_ck:
>> - =A0 =A0 =A0 clk_put(omap->xclk60mhsp1_ck);
>> -
>> -err_utmi_p1_fck:
>> - =A0 =A0 =A0 clk_put(omap->utmi_p1_fck);
>> -
>> -err_usbtll_ick:
>> - =A0 =A0 =A0 clk_put(omap->usbtll_ick);
>> -
>> -err_usbtll_fck:
>> - =A0 =A0 =A0 clk_put(omap->usbtll_fck);
>> -
>> -err_usbhost_fs_fck:
>> - =A0 =A0 =A0 clk_put(omap->usbhost_fs_fck);
>> -
>> -err_usbhost_hs_fck:
>> - =A0 =A0 =A0 clk_put(omap->usbhost_hs_fck);
>> -
>> -err_usbhost_ick:
>> - =A0 =A0 =A0 clk_put(omap->usbhost_ick);
>> -
>> -err_end:
>> - =A0 =A0 =A0 kfree(omap);
>> -
>> -end_probe:
>> - =A0 =A0 =A0 return ret;
>> -}
>> -
>> -/**
>> - * usbhs_omap_remove - shutdown processing for UHH& =A0TLL HCDs
>> - * @pdev: USB Host Controller being removed
>> - *
>> - * Reverses the effect of usbhs_omap_probe().
>> - */
>> -static int __devexit usbhs_omap_remove(struct platform_device *pdev=
)
>> -{
>> - =A0 =A0 =A0 struct usbhs_hcd_omap *omap =3D platform_get_drvdata(p=
dev);
>> -
>> - =A0 =A0 =A0 if (omap->count !=3D 0) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Either EHCI or OHCI i=
s still using usbhs
>> core\n");
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
>> - =A0 =A0 =A0 }
>> -
>> - =A0 =A0 =A0 iounmap(omap->tll_base);
>> - =A0 =A0 =A0 iounmap(omap->uhh_base);
>> - =A0 =A0 =A0 clk_put(omap->init_60m_fclk);
>> - =A0 =A0 =A0 clk_put(omap->usbtll_p2_fck);
>> - =A0 =A0 =A0 clk_put(omap->usbhost_p2_fck);
>> - =A0 =A0 =A0 clk_put(omap->usbtll_p1_fck);
>> - =A0 =A0 =A0 clk_put(omap->usbhost_p1_fck);
>> - =A0 =A0 =A0 clk_put(omap->xclk60mhsp2_ck);
>> - =A0 =A0 =A0 clk_put(omap->utmi_p2_fck);
>> - =A0 =A0 =A0 clk_put(omap->xclk60mhsp1_ck);
>> - =A0 =A0 =A0 clk_put(omap->utmi_p1_fck);
>> - =A0 =A0 =A0 clk_put(omap->usbtll_ick);
>> - =A0 =A0 =A0 clk_put(omap->usbtll_fck);
>> - =A0 =A0 =A0 clk_put(omap->usbhost_fs_fck);
>> - =A0 =A0 =A0 clk_put(omap->usbhost_hs_fck);
>> - =A0 =A0 =A0 clk_put(omap->usbhost_ick);
>> - =A0 =A0 =A0 kfree(omap);
>> -
>> - =A0 =A0 =A0 return 0;
>> -}
>> -
>> =A0static bool is_ohci_port(enum usbhs_omap_port_mode pmode)
>> =A0{
>> =A0 =A0 =A0 =A0switch (pmode) {
>> @@ -687,30 +419,79 @@ static void usbhs_omap_tll_init(struct device =
*dev,
>> u8 tll_channel_count)
>> =A0 =A0 =A0 =A0}
>> =A0}
>>
>> -static int usbhs_enable(struct device *dev)
>> +static int usbhs_runtime_resume(struct device *dev)
>> =A0{
>> =A0 =A0 =A0 =A0struct usbhs_hcd_omap =A0 =A0 =A0 =A0 =A0 *omap =3D d=
ev_get_drvdata(dev);
>> =A0 =A0 =A0 =A0struct usbhs_omap_platform_data *pdata =3D&omap->plat=
data;
>> - =A0 =A0 =A0 unsigned long =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 flag=
s =3D 0;
>> - =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 ret =3D 0;
>> - =A0 =A0 =A0 unsigned long =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 time=
out;
>> - =A0 =A0 =A0 unsigned =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
reg;
>> + =A0 =A0 =A0 unsigned long =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 flag=
s;
>> +
>> + =A0 =A0 =A0 dev_dbg(dev, "usbhs_runtime_resume\n");
>> +
>> + =A0 =A0 =A0 if (!pdata) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dev, "missing platform_data\n"=
);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return =A0-ENODEV;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 spin_lock_irqsave(&omap->lock, flags);
>> +
>> + =A0 =A0 =A0 if (is_ehci_tll_mode(pdata->port_mode[0])) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_enable(omap->usbhost_p1_fck);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_enable(omap->usbtll_p1_fck);
>> + =A0 =A0 =A0 }
>> + =A0 =A0 =A0 if (is_ehci_tll_mode(pdata->port_mode[1])) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_enable(omap->usbhost_p2_fck);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_enable(omap->usbtll_p2_fck);
>> + =A0 =A0 =A0 }
>> + =A0 =A0 =A0 clk_enable(omap->utmi_p1_fck);
>> + =A0 =A0 =A0 clk_enable(omap->utmi_p2_fck);
>> +
>> + =A0 =A0 =A0 spin_unlock_irqrestore(&omap->lock, flags);
>> +
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
>> +static int usbhs_runtime_suspend(struct device *dev)
>> +{
>> + =A0 =A0 =A0 struct usbhs_hcd_omap =A0 =A0 =A0 =A0 =A0 *omap =3D de=
v_get_drvdata(dev);
>> + =A0 =A0 =A0 struct usbhs_omap_platform_data *pdata =3D&omap->platd=
ata;
>> + =A0 =A0 =A0 unsigned long =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 flag=
s;
>> +
>> + =A0 =A0 =A0 dev_dbg(dev, "usbhs_runtime_suspend\n");
>>
>> - =A0 =A0 =A0 dev_dbg(dev, "starting TI HSUSB Controller\n");
>> =A0 =A0 =A0 =A0if (!pdata) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_dbg(dev, "missing platform_data\n=
");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return =A0-ENODEV;
>> =A0 =A0 =A0 =A0}
>>
>> =A0 =A0 =A0 =A0spin_lock_irqsave(&omap->lock, flags);
>> - =A0 =A0 =A0 if (omap->count> =A00)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto end_count;
>>
>> - =A0 =A0 =A0 clk_enable(omap->usbhost_ick);
>> - =A0 =A0 =A0 clk_enable(omap->usbhost_hs_fck);
>> - =A0 =A0 =A0 clk_enable(omap->usbhost_fs_fck);
>> - =A0 =A0 =A0 clk_enable(omap->usbtll_fck);
>> - =A0 =A0 =A0 clk_enable(omap->usbtll_ick);
>> + =A0 =A0 =A0 if (is_ehci_tll_mode(pdata->port_mode[0])) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(omap->usbhost_p1_fck);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(omap->usbtll_p1_fck);
>> + =A0 =A0 =A0 }
>> + =A0 =A0 =A0 if (is_ehci_tll_mode(pdata->port_mode[1])) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(omap->usbhost_p2_fck);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(omap->usbtll_p2_fck);
>> + =A0 =A0 =A0 }
>> + =A0 =A0 =A0 clk_disable(omap->utmi_p2_fck);
>> + =A0 =A0 =A0 clk_disable(omap->utmi_p1_fck);
>> +
>> + =A0 =A0 =A0 spin_unlock_irqrestore(&omap->lock, flags);
>> +
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
>> +static void omap_usbhs_init(struct device *dev)
>
> Since it is called only at init the it could be placed in init sectio=
n.
>>
>> +{
>> + =A0 =A0 =A0 struct usbhs_hcd_omap =A0 =A0 =A0 =A0 =A0 *omap =3D de=
v_get_drvdata(dev);
>> + =A0 =A0 =A0 struct usbhs_omap_platform_data *pdata =3D&omap->platd=
ata;
>> + =A0 =A0 =A0 unsigned long =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 flag=
s;
>> + =A0 =A0 =A0 unsigned =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
reg;
>> +
>> + =A0 =A0 =A0 dev_dbg(dev, "starting TI HSUSB Controller\n");
>> +
>> + =A0 =A0 =A0 pm_runtime_get_sync(dev);
>> + =A0 =A0 =A0 spin_lock_irqsave(&omap->lock, flags);
>>
>> =A0 =A0 =A0 =A0if (pdata->ehci_data->phy_reset) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (gpio_is_valid(pdata->ehci_data->r=
eset_gpio_port[0])) {
>> @@ -734,50 +515,6 @@ static int usbhs_enable(struct device *dev)
>> =A0 =A0 =A0 =A0omap->usbhs_rev =3D usbhs_read(omap->uhh_base, OMAP_U=
HH_REVISION);
>> =A0 =A0 =A0 =A0dev_dbg(dev, "OMAP UHH_REVISION 0x%x\n", omap->usbhs_=
rev);
>>
>> - =A0 =A0 =A0 /* perform TLL soft reset, and wait until reset is com=
plete */
>> - =A0 =A0 =A0 usbhs_write(omap->tll_base, OMAP_USBTLL_SYSCONFIG,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_USBTLL_SYSCONFIG_=
SOFTRESET);
>> -
>> - =A0 =A0 =A0 /* Wait for TLL reset to complete */
>> - =A0 =A0 =A0 timeout =3D jiffies + msecs_to_jiffies(1000);
>> - =A0 =A0 =A0 while (!(usbhs_read(omap->tll_base, OMAP_USBTLL_SYSSTA=
TUS)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 & =A0OMAP_USBTLL_SYSST=
ATUS_RESETDONE)) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpu_relax();
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (time_after(jiffies, timeout)) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dev, "operatio=
n timed out\n");
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_tll;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> - =A0 =A0 =A0 }
>> -
>> - =A0 =A0 =A0 dev_dbg(dev, "TLL RESET DONE\n");
>> -
>> - =A0 =A0 =A0 /* (1<<3) =3D no idle mode only for initial debugging =
*/
>> - =A0 =A0 =A0 usbhs_write(omap->tll_base, OMAP_USBTLL_SYSCONFIG,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_USBTLL_SYSCONFIG_=
ENAWAKEUP |
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_USBTLL_SYSCONFIG_=
SIDLEMODE |
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_USBTLL_SYSCONFIG_=
AUTOIDLE);
>> -
>> - =A0 =A0 =A0 /* Put UHH in NoIdle/NoStandby mode */
>> - =A0 =A0 =A0 reg =3D usbhs_read(omap->uhh_base, OMAP_UHH_SYSCONFIG)=
;
>> - =A0 =A0 =A0 if (is_omap_usbhs_rev1(omap)) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D (OMAP_UHH_SYSCONFIG_ENAWAKEUP
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | OMAP=
_UHH_SYSCONFIG_SIDLEMODE
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | OMAP=
_UHH_SYSCONFIG_CACTIVITY
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | OMAP=
_UHH_SYSCONFIG_MIDLEMODE);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg&=3D ~OMAP_UHH_SYSCONFIG_AUTOIDLE;
>> -
>> -
>> - =A0 =A0 =A0 } else if (is_omap_usbhs_rev2(omap)) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg&=3D ~OMAP4_UHH_SYSCONFIG_IDLEMODE_=
CLEAR;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D OMAP4_UHH_SYSCONFIG_NOIDLE;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg&=3D ~OMAP4_UHH_SYSCONFIG_STDBYMODE=
_CLEAR;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D OMAP4_UHH_SYSCONFIG_NOSTDBY;
>> - =A0 =A0 =A0 }
>> -
>> - =A0 =A0 =A0 usbhs_write(omap->uhh_base, OMAP_UHH_SYSCONFIG, reg);
>> -
>> =A0 =A0 =A0 =A0reg =3D usbhs_read(omap->uhh_base, OMAP_UHH_HOSTCONFI=
G);
>> =A0 =A0 =A0 =A0/* setup ULPI bypass and burst configurations */
>> =A0 =A0 =A0 =A0reg |=3D (OMAP_UHH_HOSTCONFIG_INCR4_BURST_EN
>> @@ -823,49 +560,6 @@ static int usbhs_enable(struct device *dev)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg&=3D ~OMAP4_P1_MODE_CLEAR;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg&=3D ~OMAP4_P2_MODE_CLEAR;
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (is_ehci_phy_mode(pdata->port_mode[=
0])) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D clk_set_parent=
(omap->utmi_p1_fck,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 omap->xclk60mhsp1_ck);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret !=3D 0) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_er=
r(dev, "xclk60mhsp1_ck set parent"
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "faile=
d error:%d\n", ret);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto e=
rr_tll;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (is_ehci_tll_mode(pdata->por=
t_mode[0])) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D clk_set_parent=
(omap->utmi_p1_fck,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 omap->init_60m_fclk);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret !=3D 0) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_er=
r(dev, "init_60m_fclk set parent"
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "faile=
d error:%d\n", ret);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto e=
rr_tll;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_enable(omap->usbho=
st_p1_fck);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_enable(omap->usbtl=
l_p1_fck);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (is_ehci_phy_mode(pdata->port_mode[=
1])) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D clk_set_parent=
(omap->utmi_p2_fck,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 omap->xclk60mhsp2_ck);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret !=3D 0) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_er=
r(dev, "xclk60mhsp1_ck set parent"
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 "failed error:%d\n", ret);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto e=
rr_tll;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (is_ehci_tll_mode(pdata->por=
t_mode[1])) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D clk_set_parent=
(omap->utmi_p2_fck,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 omap->init_60m_fclk);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret !=3D 0) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_er=
r(dev, "init_60m_fclk set parent"
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "faile=
d error:%d\n", ret);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto e=
rr_tll;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_enable(omap->usbho=
st_p2_fck);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_enable(omap->usbtl=
l_p2_fck);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_enable(omap->utmi_p1_fck);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_enable(omap->utmi_p2_fck);
>> -
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (is_ehci_tll_mode(pdata->port_mode=
[0]) ||
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(is_ohci_port(pdata->=
port_mode[0])))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg |=3D OMAP4_P1_MOD=
E_TLL;
>> @@ -911,12 +605,15 @@ static int usbhs_enable(struct device *dev)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(pdat=
a->ehci_data->reset_gpio_port[1], 1);
>> =A0 =A0 =A0 =A0}
>>
>> -end_count:
>> - =A0 =A0 =A0 omap->count++;
>> =A0 =A0 =A0 =A0spin_unlock_irqrestore(&omap->lock, flags);
>> - =A0 =A0 =A0 return 0;
>> + =A0 =A0 =A0 pm_runtime_put_sync(dev);
>> +}
>> +
>> +static void omap_usbhs_deinit(struct device *dev)
>> +{
>> + =A0 =A0 =A0 struct usbhs_hcd_omap =A0 =A0 =A0 =A0 =A0 *omap =3D de=
v_get_drvdata(dev);
>> + =A0 =A0 =A0 struct usbhs_omap_platform_data *pdata =3D&omap->platd=
ata;
>>
>> -err_tll:
>> =A0 =A0 =A0 =A0if (pdata->ehci_data->phy_reset) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (gpio_is_valid(pdata->ehci_data->r=
eset_gpio_port[0]))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gpio_free(pdata->ehci=
_data->reset_gpio_port[0]);
>> @@ -924,123 +621,257 @@ err_tll:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (gpio_is_valid(pdata->ehci_data->r=
eset_gpio_port[1]))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gpio_free(pdata->ehci=
_data->reset_gpio_port[1]);
>> =A0 =A0 =A0 =A0}
>> -
>> - =A0 =A0 =A0 clk_disable(omap->usbtll_ick);
>> - =A0 =A0 =A0 clk_disable(omap->usbtll_fck);
>> - =A0 =A0 =A0 clk_disable(omap->usbhost_fs_fck);
>> - =A0 =A0 =A0 clk_disable(omap->usbhost_hs_fck);
>> - =A0 =A0 =A0 clk_disable(omap->usbhost_ick);
>> - =A0 =A0 =A0 spin_unlock_irqrestore(&omap->lock, flags);
>> - =A0 =A0 =A0 return ret;
>> =A0}
>>
>> -static void usbhs_disable(struct device *dev)
>> +
>> +/**
>> + * usbhs_omap_probe - initialize TI-based HCDs
>> + *
>> + * Allocates basic resources for this USB host controller.
>> + */
>> +static int __devinit usbhs_omap_probe(struct platform_device *pdev)
>> =A0{
>> - =A0 =A0 =A0 struct usbhs_hcd_omap =A0 =A0 =A0 =A0 =A0 *omap =3D de=
v_get_drvdata(dev);
>> - =A0 =A0 =A0 struct usbhs_omap_platform_data *pdata =3D&omap->platd=
ata;
>> - =A0 =A0 =A0 unsigned long =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 flag=
s =3D 0;
>> - =A0 =A0 =A0 unsigned long =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 time=
out;
>> + =A0 =A0 =A0 struct device =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *dev=
 =3D&pdev->dev;
>> + =A0 =A0 =A0 struct usbhs_omap_platform_data *pdata =3D dev->platfo=
rm_data;
>> + =A0 =A0 =A0 struct usbhs_hcd_omap =A0 =A0 =A0 =A0 =A0 *omap;
>> + =A0 =A0 =A0 struct resource =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *res;
>> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 ret =3D 0;
>> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 i;
>>
>> - =A0 =A0 =A0 dev_dbg(dev, "stopping TI HSUSB Controller\n");
>> + =A0 =A0 =A0 if (!pdata) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "Missing platform data\n"=
);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto end_probe;
>> + =A0 =A0 =A0 }
>>
>> - =A0 =A0 =A0 spin_lock_irqsave(&omap->lock, flags);
>> + =A0 =A0 =A0 omap =3D kzalloc(sizeof(*omap), GFP_KERNEL);
>> + =A0 =A0 =A0 if (!omap) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "Memory allocation failed=
\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto end_probe;
>> + =A0 =A0 =A0 }
>>
>> - =A0 =A0 =A0 if (omap->count =3D=3D 0)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto end_disble;
>> + =A0 =A0 =A0 spin_lock_init(&omap->lock);
>>
>> - =A0 =A0 =A0 omap->count--;
>> + =A0 =A0 =A0 for (i =3D 0; i< =A0OMAP3_HS_USB_PORTS; i++)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap->platdata.port_mode[i] =3D pdata-=
>port_mode[i];
>>
>> - =A0 =A0 =A0 if (omap->count !=3D 0)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto end_disble;
>> + =A0 =A0 =A0 omap->platdata.ehci_data =3D pdata->ehci_data;
>> + =A0 =A0 =A0 omap->platdata.ohci_data =3D pdata->ohci_data;
>>
>> - =A0 =A0 =A0 /* Reset OMAP modules for insmod/rmmod to work */
>> - =A0 =A0 =A0 usbhs_write(omap->uhh_base, OMAP_UHH_SYSCONFIG,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 is_omap_usbhs_rev2(oma=
p) ?
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_UHH_SYSCONFIG_SO=
=46TRESET :
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_UHH_SYSCONFIG_SOF=
TRESET);
>> + =A0 =A0 =A0 pm_runtime_enable(dev);
>>
>> - =A0 =A0 =A0 timeout =3D jiffies + msecs_to_jiffies(100);
>> - =A0 =A0 =A0 while (!(usbhs_read(omap->uhh_base, OMAP_UHH_SYSSTATUS=
)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 & =A0(=
1<< =A00))) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpu_relax();
>> + =A0 =A0 =A0 omap->utmi_p1_fck =3D clk_get(dev, "utmi_p1_gfclk");
>> + =A0 =A0 =A0 if (IS_ERR(omap->utmi_p1_fck)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(omap->utmi_p1_fck);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "utmi_p1_gfclk failed err=
or:%d\n", ret);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_end;
>> + =A0 =A0 =A0 }
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (time_after(jiffies, timeout))
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dev, "operatio=
n timed out\n");
>> + =A0 =A0 =A0 omap->xclk60mhsp1_ck =3D clk_get(dev, "xclk60mhsp1_ck"=
);
>> + =A0 =A0 =A0 if (IS_ERR(omap->xclk60mhsp1_ck)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(omap->xclk60mhsp1_ck);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "xclk60mhsp1_ck failed er=
ror:%d\n", ret);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_utmi_p1_fck;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 omap->utmi_p2_fck =3D clk_get(dev, "utmi_p2_gfclk");
>> + =A0 =A0 =A0 if (IS_ERR(omap->utmi_p2_fck)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(omap->utmi_p2_fck);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "utmi_p2_gfclk failed err=
or:%d\n", ret);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_xclk60mhsp1_ck;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 omap->xclk60mhsp2_ck =3D clk_get(dev, "xclk60mhsp2_ck"=
);
>> + =A0 =A0 =A0 if (IS_ERR(omap->xclk60mhsp2_ck)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(omap->xclk60mhsp2_ck);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "xclk60mhsp2_ck failed er=
ror:%d\n", ret);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_utmi_p2_fck;
>> =A0 =A0 =A0 =A0}
>>
>> - =A0 =A0 =A0 while (!(usbhs_read(omap->uhh_base, OMAP_UHH_SYSSTATUS=
)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 & =A0(=
1<< =A01))) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpu_relax();
>> + =A0 =A0 =A0 omap->usbhost_p1_fck =3D clk_get(dev, "usb_host_hs_utm=
i_p1_clk");
>> + =A0 =A0 =A0 if (IS_ERR(omap->usbhost_p1_fck)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(omap->usbhost_p1_fck);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "usbhost_p1_fck failed er=
ror:%d\n", ret);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_xclk60mhsp2_ck;
>> + =A0 =A0 =A0 }
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (time_after(jiffies, timeout))
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dev, "operatio=
n timed out\n");
>> + =A0 =A0 =A0 omap->usbtll_p1_fck =3D clk_get(dev, "usb_tll_hs_usb_c=
h0_clk");
>> + =A0 =A0 =A0 if (IS_ERR(omap->usbtll_p1_fck)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(omap->usbtll_p1_fck);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "usbtll_p1_fck failed err=
or:%d\n", ret);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_usbhost_p1_fck;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 omap->usbhost_p2_fck =3D clk_get(dev, "usb_host_hs_utm=
i_p2_clk");
>> + =A0 =A0 =A0 if (IS_ERR(omap->usbhost_p2_fck)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(omap->usbhost_p2_fck);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "usbhost_p2_fck failed er=
ror:%d\n", ret);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_usbtll_p1_fck;
>> =A0 =A0 =A0 =A0}
>>
>> - =A0 =A0 =A0 while (!(usbhs_read(omap->uhh_base, OMAP_UHH_SYSSTATUS=
)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 & =A0(=
1<< =A02))) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpu_relax();
>> + =A0 =A0 =A0 omap->usbtll_p2_fck =3D clk_get(dev, "usb_tll_hs_usb_c=
h1_clk");
>> + =A0 =A0 =A0 if (IS_ERR(omap->usbtll_p2_fck)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(omap->usbtll_p2_fck);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "usbtll_p2_fck failed err=
or:%d\n", ret);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_usbhost_p2_fck;
>> + =A0 =A0 =A0 }
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (time_after(jiffies, timeout))
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dev, "operatio=
n timed out\n");
>> + =A0 =A0 =A0 omap->init_60m_fclk =3D clk_get(dev, "init_60m_fclk");
>> + =A0 =A0 =A0 if (IS_ERR(omap->init_60m_fclk)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(omap->init_60m_fclk);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "init_60m_fclk failed err=
or:%d\n", ret);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_usbtll_p2_fck;
>> =A0 =A0 =A0 =A0}
>>
>> - =A0 =A0 =A0 usbhs_write(omap->tll_base, OMAP_USBTLL_SYSCONFIG, (1<=
< =A01));
>> + =A0 =A0 =A0 if (is_ehci_phy_mode(pdata->port_mode[0])) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* for OMAP3 , the clk set paretn fail=
s */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D clk_set_parent(omap->utmi_p1_f=
ck,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 omap->xclk60mhsp1_ck);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret !=3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "xclk60mh=
sp1_ck set parent"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "faile=
d error:%d\n", ret);
>> + =A0 =A0 =A0 } else if (is_ehci_tll_mode(pdata->port_mode[0])) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D clk_set_parent(omap->utmi_p1_f=
ck,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 omap->init_60m_fclk);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret !=3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "init_60m=
_fclk set parent"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "faile=
d error:%d\n", ret);
>> + =A0 =A0 =A0 }
>>
>> - =A0 =A0 =A0 while (!(usbhs_read(omap->tll_base, OMAP_USBTLL_SYSSTA=
TUS)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 & =A0(=
1<< =A00))) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpu_relax();
>> + =A0 =A0 =A0 if (is_ehci_phy_mode(pdata->port_mode[1])) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D clk_set_parent(omap->utmi_p2_f=
ck,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 omap->xclk60mhsp2_ck);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret !=3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "xclk60mh=
sp2_ck set parent"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 "failed error:%d\n", ret);
>> + =A0 =A0 =A0 } else if (is_ehci_tll_mode(pdata->port_mode[1])) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D clk_set_parent(omap->utmi_p2_f=
ck,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 omap->init_60m_fclk);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret !=3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "init_60m=
_fclk set parent"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "faile=
d error:%d\n", ret);
>> + =A0 =A0 =A0 }
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (time_after(jiffies, timeout))
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dev, "operatio=
n timed out\n");
>> + =A0 =A0 =A0 res =3D platform_get_resource_byname(pdev, IORESOURCE_=
MEM, "uhh");
>> + =A0 =A0 =A0 if (!res) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "UHH EHCI get resource fa=
iled\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODEV;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_init_60m_fclk;
>> =A0 =A0 =A0 =A0}
>>
>> - =A0 =A0 =A0 if (is_omap_usbhs_rev2(omap)) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (is_ehci_tll_mode(pdata->port_mode[=
0]))
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(omap->usbt=
ll_p1_fck);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (is_ehci_tll_mode(pdata->port_mode[=
1]))
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(omap->usbt=
ll_p2_fck);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(omap->utmi_p2_fck);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(omap->utmi_p1_fck);
>> + =A0 =A0 =A0 omap->uhh_base =3D ioremap(res->start, resource_size(r=
es));
>> + =A0 =A0 =A0 if (!omap->uhh_base) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "UHH ioremap failed\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_init_60m_fclk;
>> =A0 =A0 =A0 =A0}
>>
>> - =A0 =A0 =A0 clk_disable(omap->usbtll_ick);
>> - =A0 =A0 =A0 clk_disable(omap->usbtll_fck);
>> - =A0 =A0 =A0 clk_disable(omap->usbhost_fs_fck);
>> - =A0 =A0 =A0 clk_disable(omap->usbhost_hs_fck);
>> - =A0 =A0 =A0 clk_disable(omap->usbhost_ick);
>> + =A0 =A0 =A0 res =3D platform_get_resource_byname(pdev, IORESOURCE_=
MEM, "tll");
>> + =A0 =A0 =A0 if (!res) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "UHH EHCI get resource fa=
iled\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODEV;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_tll;
>> + =A0 =A0 =A0 }
>>
>> - =A0 =A0 =A0 /* The gpio_free migh sleep; so unlock the spinlock */
>> - =A0 =A0 =A0 spin_unlock_irqrestore(&omap->lock, flags);
>> + =A0 =A0 =A0 omap->tll_base =3D ioremap(res->start, resource_size(r=
es));
>> + =A0 =A0 =A0 if (!omap->tll_base) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "TLL ioremap failed\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_tll;
>> + =A0 =A0 =A0 }
>>
>> - =A0 =A0 =A0 if (pdata->ehci_data->phy_reset) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (gpio_is_valid(pdata->ehci_data->re=
set_gpio_port[0]))
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_free(pdata->ehci_=
data->reset_gpio_port[0]);
>> + =A0 =A0 =A0 platform_set_drvdata(pdev, omap);
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (gpio_is_valid(pdata->ehci_data->re=
set_gpio_port[1]))
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_free(pdata->ehci_=
data->reset_gpio_port[1]);
>> + =A0 =A0 =A0 ret =3D omap_usbhs_alloc_children(pdev);
>> + =A0 =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "omap_usbhs_alloc_childre=
n failed\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_alloc;
>> =A0 =A0 =A0 =A0}
>> - =A0 =A0 =A0 return;
>>
>> -end_disble:
>> - =A0 =A0 =A0 spin_unlock_irqrestore(&omap->lock, flags);
>> -}
>> + =A0 =A0 =A0 omap_usbhs_init(dev);
>>
>> -int omap_usbhs_enable(struct device *dev)
>> -{
>> - =A0 =A0 =A0 return =A0usbhs_enable(dev->parent);
>> + =A0 =A0 =A0 goto end_probe;
>> +
>> +err_alloc:
>> + =A0 =A0 =A0 iounmap(omap->tll_base);
>> +
>> +err_tll:
>> + =A0 =A0 =A0 iounmap(omap->uhh_base);
>> +
>> +err_init_60m_fclk:
>> + =A0 =A0 =A0 clk_put(omap->init_60m_fclk);
>> +
>> +err_usbtll_p2_fck:
>> + =A0 =A0 =A0 clk_put(omap->usbtll_p2_fck);
>> +
>> +err_usbhost_p2_fck:
>> + =A0 =A0 =A0 clk_put(omap->usbhost_p2_fck);
>> +
>> +err_usbtll_p1_fck:
>> + =A0 =A0 =A0 clk_put(omap->usbtll_p1_fck);
>> +
>> +err_usbhost_p1_fck:
>> + =A0 =A0 =A0 clk_put(omap->usbhost_p1_fck);
>> +
>> +err_xclk60mhsp2_ck:
>> + =A0 =A0 =A0 clk_put(omap->xclk60mhsp2_ck);
>> +
>> +err_utmi_p2_fck:
>> + =A0 =A0 =A0 clk_put(omap->utmi_p2_fck);
>> +
>> +err_xclk60mhsp1_ck:
>> + =A0 =A0 =A0 clk_put(omap->xclk60mhsp1_ck);
>> +
>> +err_utmi_p1_fck:
>> + =A0 =A0 =A0 clk_put(omap->utmi_p1_fck);
>> +
>> +err_end:
>> + =A0 =A0 =A0 pm_runtime_disable(dev);
>> + =A0 =A0 =A0 kfree(omap);
>> +
>> +end_probe:
>> + =A0 =A0 =A0 return ret;
>> =A0}
>> -EXPORT_SYMBOL_GPL(omap_usbhs_enable);
>>
>> -void omap_usbhs_disable(struct device *dev)
>> +/**
>> + * usbhs_omap_remove - shutdown processing for UHH& =A0TLL HCDs
>> + * @pdev: USB Host Controller being removed
>> + *
>> + * Reverses the effect of usbhs_omap_probe().
>> + */
>> +static int __devexit usbhs_omap_remove(struct platform_device *pdev=
)
>> =A0{
>> - =A0 =A0 =A0 usbhs_disable(dev->parent);
>> + =A0 =A0 =A0 struct usbhs_hcd_omap *omap =3D platform_get_drvdata(p=
dev);
>> +
>> + =A0 =A0 =A0 omap_usbhs_deinit(&pdev->dev);
>> + =A0 =A0 =A0 iounmap(omap->tll_base);
>> + =A0 =A0 =A0 iounmap(omap->uhh_base);
>> + =A0 =A0 =A0 clk_put(omap->init_60m_fclk);
>> + =A0 =A0 =A0 clk_put(omap->usbtll_p2_fck);
>> + =A0 =A0 =A0 clk_put(omap->usbhost_p2_fck);
>> + =A0 =A0 =A0 clk_put(omap->usbtll_p1_fck);
>> + =A0 =A0 =A0 clk_put(omap->usbhost_p1_fck);
>> + =A0 =A0 =A0 clk_put(omap->xclk60mhsp2_ck);
>> + =A0 =A0 =A0 clk_put(omap->utmi_p2_fck);
>> + =A0 =A0 =A0 clk_put(omap->xclk60mhsp1_ck);
>> + =A0 =A0 =A0 clk_put(omap->utmi_p1_fck);
>> + =A0 =A0 =A0 pm_runtime_disable(&pdev->dev);
>> + =A0 =A0 =A0 kfree(omap);
>> +
>> + =A0 =A0 =A0 return 0;
>> =A0}
>> -EXPORT_SYMBOL_GPL(omap_usbhs_disable);
>> +
>> +static const struct dev_pm_ops usbhsomap_dev_pm_ops =3D {
>> + =A0 =A0 =A0 .runtime_suspend =A0 =A0 =A0 =A0=3D usbhs_runtime_susp=
end,
>> + =A0 =A0 =A0 .runtime_resume =A0 =A0 =A0 =A0 =3D usbhs_runtime_resu=
me,
>> +};
>
> Could these be placed under a PM flag.

No, you should not, these functions enable the port clocks for omap4 us=
bhs
so, it should be default.


>
>>
>> =A0static struct platform_driver usbhs_omap_driver =3D {
>> =A0 =A0 =A0 =A0.driver =3D {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =3D (char *=
)usbhs_driver_name,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.owner =A0 =A0 =A0 =A0 =A0=3D THIS_MO=
DULE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pm =A0 =A0 =A0 =A0 =A0 =A0 =3D&usbhso=
map_dev_pm_ops,
>> =A0 =A0 =A0 =A0},
>> =A0 =A0 =A0 =A0.remove =A0 =A0 =A0 =A0 =3D __exit_p(usbhs_omap_remov=
e),
>> =A0};
>> diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-om=
ap.c
>> index 4524032..82cd3ea 100644
>> --- a/drivers/usb/host/ehci-omap.c
>> +++ b/drivers/usb/host/ehci-omap.c
>> @@ -41,6 +41,7 @@
>> =A0#include<linux/usb/ulpi.h>
>> =A0#include<plat/usb.h>
>> =A0#include<linux/regulator/consumer.h>
>> +#include<linux/pm_runtime.h>
>>
>> =A0/* EHCI Register Set */
>> =A0#define EHCI_INSNREG04 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0xA0)
>> @@ -190,11 +191,8 @@ static int ehci_hcd_omap_probe(struct platform_=
device
>> *pdev)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>> =A0 =A0 =A0 =A0}
>>
>> - =A0 =A0 =A0 ret =3D omap_usbhs_enable(dev);
>> - =A0 =A0 =A0 if (ret) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "failed to start usbhs wi=
th err %d\n", ret);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_enable;
>> - =A0 =A0 =A0 }
>> + =A0 =A0 =A0 pm_runtime_enable(dev);
>> + =A0 =A0 =A0 pm_runtime_get_sync(dev);
>>
>> =A0 =A0 =A0 =A0/*
>> =A0 =A0 =A0 =A0 * An undocumented "feature" in the OMAP3 EHCI contro=
ller,
>> @@ -240,11 +238,8 @@ static int ehci_hcd_omap_probe(struct platform_=
device
>> *pdev)
>> =A0 =A0 =A0 =A0return 0;
>>
>> =A0err_add_hcd:
>> - =A0 =A0 =A0 omap_usbhs_disable(dev);
>> -
>> -err_enable:
>> =A0 =A0 =A0 =A0disable_put_regulator(pdata);
>> - =A0 =A0 =A0 usb_put_hcd(hcd);
>> + =A0 =A0 =A0 pm_runtime_put_sync(dev);
>>
>> =A0err_io:
>> =A0 =A0 =A0 =A0iounmap(regs);
>> @@ -266,10 +261,12 @@ static int ehci_hcd_omap_remove(struct
>> platform_device *pdev)
>> =A0 =A0 =A0 =A0struct usb_hcd *hcd =A0 =A0 =3D dev_get_drvdata(dev);
>>
>> =A0 =A0 =A0 =A0usb_remove_hcd(hcd);
>> - =A0 =A0 =A0 omap_usbhs_disable(dev);
>> =A0 =A0 =A0 =A0disable_put_regulator(dev->platform_data);
>> =A0 =A0 =A0 =A0iounmap(hcd->regs);
>> =A0 =A0 =A0 =A0usb_put_hcd(hcd);
>> + =A0 =A0 =A0 pm_runtime_put_sync(dev);
>> + =A0 =A0 =A0 pm_runtime_disable(dev);
>> +
>> =A0 =A0 =A0 =A0return 0;
>> =A0}
>>
>> diff --git a/drivers/usb/host/ohci-omap3.c b/drivers/usb/host/ohci-o=
map3.c
>> index 6048f2f..6cfedaf 100644
>> --- a/drivers/usb/host/ohci-omap3.c
>> +++ b/drivers/usb/host/ohci-omap3.c
>> @@ -31,6 +31,7 @@
>>
>> =A0#include<linux/platform_device.h>
>> =A0#include<plat/usb.h>
>> +#include<linux/pm_runtime.h>
>>
>>
>> =A0/*---------------------------------------------------------------=
----------*/
>>
>> @@ -134,7 +135,7 @@ static int __devinit ohci_hcd_omap3_probe(struct
>> platform_device *pdev)
>> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq;
>>
>> =A0 =A0 =A0 =A0if (usb_disabled())
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_end;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>>
>> =A0 =A0 =A0 =A0if (!dev->parent) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(dev, "Missing parent device\n=
");
>> @@ -172,11 +173,8 @@ static int __devinit ohci_hcd_omap3_probe(struc=
t
>> platform_device *pdev)
>> =A0 =A0 =A0 =A0hcd->rsrc_len =3D resource_size(res);
>> =A0 =A0 =A0 =A0hcd->regs =3D =A0regs;
>>
>> - =A0 =A0 =A0 ret =3D omap_usbhs_enable(dev);
>> - =A0 =A0 =A0 if (ret) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dev, "failed to start ohci\n")=
;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_end;
>> - =A0 =A0 =A0 }
>> + =A0 =A0 =A0 pm_runtime_enable(dev);
>> + =A0 =A0 =A0 pm_runtime_get_sync(dev);
>>
>> =A0 =A0 =A0 =A0ohci_hcd_init(hcd_to_ohci(hcd));
>>
>> @@ -189,9 +187,7 @@ static int __devinit ohci_hcd_omap3_probe(struct
>> platform_device *pdev)
>> =A0 =A0 =A0 =A0return 0;
>>
>> =A0err_add_hcd:
>> - =A0 =A0 =A0 omap_usbhs_disable(dev);
>> -
>> -err_end:
>> + =A0 =A0 =A0 pm_runtime_put_sync(dev);
>> =A0 =A0 =A0 =A0usb_put_hcd(hcd);
>>
>> =A0err_io:
>> @@ -220,9 +216,9 @@ static int __devexit ohci_hcd_omap3_remove(struc=
t
>> platform_device *pdev)
>>
>> =A0 =A0 =A0 =A0iounmap(hcd->regs);
>> =A0 =A0 =A0 =A0usb_remove_hcd(hcd);
>> - =A0 =A0 =A0 omap_usbhs_disable(dev);
>> + =A0 =A0 =A0 pm_runtime_put_sync(dev);
>> + =A0 =A0 =A0 pm_runtime_disable(dev);
>> =A0 =A0 =A0 =A0usb_put_hcd(hcd);
>> -
>> =A0 =A0 =A0 =A0return 0;
>> =A0}
>>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
