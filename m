From: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>
Subject: Re: [RFC PATCH 1/6] usb: musb: omap: Configure OTG_INTERFSEL for
 proper charger detection
Date: Fri, 16 Sep 2011 19:21:41 +0530
Message-ID: <CAAe_U6KaFJGM61=Pkm2q-EBQeEtSAOBuC2jgFRd7DV4xKOjJdg@mail.gmail.com>
References: <1316096403-6013-1-git-send-email-kishon@ti.com>
	<1316096403-6013-2-git-send-email-kishon@ti.com>
	<4E731B6D.2040007@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:41026 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753953Ab1IPNvn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Sep 2011 09:51:43 -0400
In-Reply-To: <4E731B6D.2040007@ru.mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, balbi@ti.com, heikki.krogerus@linux.intel.com, gregkh@suse.de, p-basak2@ti.com, balajitk@ti.com, x0153364@ti.com, m-sonasath@ti.com, vishp@ti.com, hemahk@ti.com

Sergei,

Thanks for your comments.

On Fri, Sep 16, 2011 at 3:18 PM, Sergei Shtylyov <sshtylyov@mvista.com>=
 wrote:
> Hello.
>
> On 15-09-2011 18:19, Kishon Vijay Abraham I wrote:
>
>> Setting OTG_INTERFSEL to UTMI interferes with charger detection resu=
lting
>> in incorrect detection of charger type. Hence OTG_INTERFSEL is confi=
gured
>> to
>> ULPI initially and changed to UTMI only after receiving USB_EVENT_ID=
 or
>> USB_EVENT_VBUS notification.
>
>> Signed-off-by: Kishon Vijay Abraham I<kishon@ti.com>
>> Signed-off-by: Balaji T K<balajitk@ti.com>
>
> =A0 AFAIK, full name is needed here.

is it not the prerogative of the person giving his signed-off by??

>
>> [sandesh.gowda@ti.com: The interface selection has to be done before=
 the
>> PHY
>> is activated and is not allowed to change when the PHY clock is alre=
ady
>> running]
>
> =A0 No signoff from him?

ok. will add his signoff.
>
>> ---
>> =A0drivers/usb/musb/omap2430.c | =A0 50
>> +++++++++++++++++++++++++++++++++++-------
>> =A01 files changed, 41 insertions(+), 9 deletions(-)
>
>> diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430=
=2Ec
>> index fc9377c..724450b 100644
>> --- a/drivers/usb/musb/omap2430.c
>> +++ b/drivers/usb/musb/omap2430.c
>> @@ -228,6 +228,7 @@ static inline void omap2430_low_level_init(struc=
t musb
>> *musb)
>> =A0static int musb_otg_notifications(struct notifier_block *nb,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned long event, void *unused)
>> =A0{
>> + =A0 =A0 =A0 u32 val;
>> =A0 =A0 =A0 =A0struct musb =A0 =A0 *musb =3D container_of(nb, struct=
 musb, nb);
>> =A0 =A0 =A0 =A0struct device *dev =3D musb->controller;
>> =A0 =A0 =A0 =A0struct musb_hdrc_platform_data *pdata =3D dev->platfo=
rm_data;
>> @@ -240,11 +241,32 @@ static int musb_otg_notifications(struct
>> notifier_block *nb,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (is_otg_enabled(musb)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (musb->gadget_driv=
er) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pm_ru=
ntime_get_sync(musb->controller);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 val =3D=
 musb_readl(musb->mregs,
>> OTG_INTERFSEL);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (da=
ta->interface_type =3D=3D
>> +
>> MUSB_INTERFACE_UTMI) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 val&=3D ~ULPI_12PIN;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 val |=3D UTMI_8BIT;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else=
 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 val |=3D ULPI_12PIN;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 musb_w=
ritel(musb->mregs, OTG_INTERFSEL,
>> val);
>> +
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0usb_p=
hy_init(musb->xceiv);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap2=
430_musb_set_vbus(musb, 1);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pm_runtime_get_sync(m=
usb->controller);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 val =3D musb_readl(mus=
b->mregs, OTG_INTERFSEL);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (data->interface_ty=
pe =3D=3D MUSB_INTERFACE_UTMI) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 val&=3D=
 ~ULPI_12PIN;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 val |=3D=
 UTMI_8BIT;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 val |=3D=
 ULPI_12PIN;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 musb_writel(musb->mreg=
s, OTG_INTERFSEL, val);
>> +
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0usb_phy_init(musb->xc=
eiv);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap2430_musb_set_vbu=
s(musb, 1);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>> @@ -255,6 +277,16 @@ static int musb_otg_notifications(struct
>> notifier_block *nb,
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (musb->gadget_driver)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pm_runtime_get_sync(m=
usb->controller);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val =3D musb_readl(musb->mregs, OTG_IN=
TERFSEL);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (data->interface_type =3D=3D MUSB_I=
NTERFACE_UTMI) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 val&=3D ~ULPI_12PIN;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 val |=3D UTMI_8BIT;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 val |=3D ULPI_12PIN;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 musb_writel(musb->mregs, OTG_INTERFSEL=
, val);
>> +
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0usb_phy_init(musb->xceiv);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>
> =A0 Why repeat the same sequence 3 times. Couldn't you factor it out =
into a
> subroutine?

I thought it will be unnecessary to to add a subroutine just for a
single register modification.
Since you have pointed that out, I'll add a subroutine for it.

>
>> @@ -272,6 +304,11 @@ static int musb_otg_notifications(struct
>> notifier_block *nb,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0otg_s=
et_vbus(musb->xceiv->otg, 0);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0usb_phy_shutdown(musb->xceiv);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val =3D musb_readl(musb->mregs, OTG_IN=
TERFSEL);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val |=3D ULPI_12PIN;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 musb_writel(musb->mregs, OTG_INTERFSEL=
, val);
>> +
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>> =A0 =A0 =A0 =A0default:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_dbg(musb->controller, "ID float\n=
");
>> @@ -304,16 +341,11 @@ static int omap2430_musb_init(struct musb *mus=
b)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err1;
>> =A0 =A0 =A0 =A0}
>>
>> + =A0 =A0 =A0 /* Set OTG_INTERFSEL to ULPI for correct charger detec=
tion.
>> + =A0 =A0 =A0 =A0* This should be later set to UTMI.
>> + =A0 =A0 =A0 =A0*/
>> =A0 =A0 =A0 =A0l =3D musb_readl(musb->mregs, OTG_INTERFSEL);
>> -
>> - =A0 =A0 =A0 if (data->interface_type =3D=3D MUSB_INTERFACE_UTMI) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* OMAP4 uses Internal PHY GS70 which =
uses UTMI interface
>> */
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 l&=3D ~ULPI_12PIN; =A0 =A0 =A0 /* Disa=
ble ULPI */
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 l |=3D UTMI_8BIT; =A0 =A0 =A0 =A0 /* E=
nable UTMI =A0*/
>> - =A0 =A0 =A0 } else {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 l |=3D ULPI_12PIN;
>> - =A0 =A0 =A0 }
>> -
>> + =A0 =A0 =A0 l |=3D ULPI_12PIN;
>> =A0 =A0 =A0 =A0musb_writel(musb->mregs, OTG_INTERFSEL, l);
>
> =A0 This also seems to be the same code repeated twice...

Ok. So i'll create a new sub-routine which takes interface type as
argument and set OTG_INTERFSEL to ULPI_12PIN or UTMI_8BIT based on the
interface type.

Regards
Kishon
>
> WBR, Sergei
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
