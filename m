From: Bob Liu <lliubbo@gmail.com>
Subject: Re: [PATCH] arm: omap3beagle: init musb default role by Kconfig
Date: Wed, 16 Feb 2011 16:49:34 +0800
Message-ID: <AANLkTikjhkhQzDDVazEr8wP7JHnnonGs8GFytA=QaE6c@mail.gmail.com>
References: <1297760100-7200-1-git-send-email-lliubbo@gmail.com>
	<20110215112350.GM2570@legolas.emea.dhcp.ti.com>
	<AANLkTik-tZKZ-0G1RBXD0rz1O4=wLXtHd2wTD-61dLm0@mail.gmail.com>
	<20110216080506.GC2497@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:48470 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757608Ab1BPItf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Feb 2011 03:49:35 -0500
Received: by wyb28 with SMTP id 28so1083666wyb.19
        for <linux-omap@vger.kernel.org>; Wed, 16 Feb 2011 00:49:34 -0800 (PST)
In-Reply-To: <20110216080506.GC2497@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-omap@vger.kernel.org, archit@ti.com, tony@atomide.com, adrian.hunter@nokia.com

On Wed, Feb 16, 2011 at 4:05 PM, Felipe Balbi <balbi@ti.com> wrote:
> On Wed, Feb 16, 2011 at 10:07:26AM +0800, Bob Liu wrote:
>> On Tue, Feb 15, 2011 at 7:23 PM, Felipe Balbi <balbi@ti.com> wrote:
>> > Hi,
>> >
>> > On Tue, Feb 15, 2011 at 04:55:00PM +0800, Bob Liu wrote:
>> >> Currently musb is initialized to OTG mode by default in musb_boar=
d_data, it's
>> >> better to init it depending on Kconfig.
>> >
>> > what's the problem in always keeping OTG ? that board is wired for=
 OTG
>> > anyway.
>> >
>>
>> Yeah, but it's better if user can make their choices by themselves.
>> Or mask the other choices in Kconfig if keeping OTG.
>> Currently user can select HOST-only mode in Kconfig, but will receiv=
e
>> compiler error.
>> In my opinion, this should be consist.
>
> compile error ?? Would you share that ? All I see is a dev_err() when
> Kconfig doesn't match board-file.
>
>> Another problem is if keeping in OTG mode, my board can't recognize =
usb device.
>> HOST-only mode works fine, I am still debugging on it.
>> But I think it's not related with current topic.
>
> I can be related. Try this:

Yeah, it works. Thanks, sorry for the noise
=2E
BTW: Is the below patch which about musb_core.c will be merged into mai=
nline ?

>
> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_cor=
e.c
> index 54a8bd1..bc29655 100644
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c
> @@ -1949,31 +1949,6 @@ musb_init_controller(struct device *dev, int n=
Irq, void __iomem *ctrl)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto fail0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> - =C2=A0 =C2=A0 =C2=A0 switch (plat->mode) {
> - =C2=A0 =C2=A0 =C2=A0 case MUSB_HOST:
> -#ifdef CONFIG_USB_MUSB_HDRC_HCD
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> -#else
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto bad_config;
> -#endif
> - =C2=A0 =C2=A0 =C2=A0 case MUSB_PERIPHERAL:
> -#ifdef CONFIG_USB_GADGET_MUSB_HDRC
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> -#else
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto bad_config;
> -#endif
> - =C2=A0 =C2=A0 =C2=A0 case MUSB_OTG:
> -#ifdef CONFIG_USB_MUSB_OTG
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> -#else
> -bad_config:
> -#endif
> - =C2=A0 =C2=A0 =C2=A0 default:
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(dev, "inco=
mpatible Kconfig role setting\n");
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 status =3D -EINVAL=
;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto fail0;
> - =C2=A0 =C2=A0 =C2=A0 }
> -
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* allocate */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0musb =3D allocate_instance(dev, plat->conf=
ig, ctrl);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!musb) {
>

--=20
Regards,
--Bob
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
