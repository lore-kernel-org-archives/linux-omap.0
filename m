From: jung songtan <jungsongtan@gmail.com>
Subject: Re: [PATCH 1/2] OMAP: update mach/usb.h to allow ehci driver to build
Date: Wed, 11 Nov 2009 16:35:13 +0800
Message-ID: <c27069990911110035pac38e04mb6e915eae7f0607d@mail.gmail.com>
References: <1257536759-15242-1-git-send-email-gadiyar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f192.google.com ([209.85.212.192]:35514 "EHLO
	mail-vw0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750792AbZKKIfI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Nov 2009 03:35:08 -0500
Received: by vws30 with SMTP id 30so254938vws.33
        for <linux-omap@vger.kernel.org>; Wed, 11 Nov 2009 00:35:14 -0800 (PST)
In-Reply-To: <1257536759-15242-1-git-send-email-gadiyar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anand Gadiyar <gadiyar@ti.com>
Cc: linux-omap@vger.kernel.org

Hi expert,

Do you have experience about the Power supply about OMAP3530?
It seems the power supply is not very good, some time I need add
powered hub to recognize some usb devices on MHCI host.
Can you give me any clue? where I should go the check with?

Thanks,
Jung T K


2009/11/7 Anand Gadiyar <gadiyar@ti.com>:
> OMAP: update mach/usb.h to allow ehci driver to build
>
> Add missing declarations to allow the recently introduced
> ehci-omap driver to build on OMAP3
>
> Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
> Cc: Felipe Balbi <felipe.balbi@nokia.com>
> Cc: Tony Lindgren <tony@atomide.com>
> ---
> Tony says he's okay with this patch going through the linux-usb list.
>
> This patch and the next one are required to build this driver.
>
> I've based these patches on current Linus' tree plus your usb
> patch queue (gregkh-07-usb-2.6.32-rc6.patch).
>
> =A0arch/arm/plat-omap/include/mach/usb.h | =A0 17 +++++++++++++++++
> =A01 file changed, 17 insertions(+)
>
> Index: linux-2.6/arch/arm/plat-omap/include/mach/usb.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/arch/arm/plat-omap/include/mach/usb.h =A0 =A0 =A0 =
=A02009-11-06 04:38:40.000000000 -0800
> +++ linux-2.6/arch/arm/plat-omap/include/mach/usb.h =A0 =A0 2009-11-0=
6 04:38:47.000000000 -0800
> @@ -5,6 +5,21 @@
>
> =A0#include <mach/board.h>
>
> +#define OMAP3_HS_USB_PORTS =A0 =A0 3
> +enum ehci_hcd_omap_mode {
> + =A0 =A0 =A0 EHCI_HCD_OMAP_MODE_UNKNOWN,
> + =A0 =A0 =A0 EHCI_HCD_OMAP_MODE_PHY,
> + =A0 =A0 =A0 EHCI_HCD_OMAP_MODE_TLL,
> +};
> +
> +struct ehci_hcd_omap_platform_data {
> + =A0 =A0 =A0 enum ehci_hcd_omap_mode =A0 =A0 =A0 =A0 port_mode[OMAP3=
_HS_USB_PORTS];
> + =A0 =A0 =A0 unsigned =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
phy_reset:1;
> +
> + =A0 =A0 =A0 /* have to be valid if phy_reset is true and portx is i=
n phy mode */
> + =A0 =A0 =A0 int =A0 =A0 reset_gpio_port[OMAP3_HS_USB_PORTS];
> +};
> +
> =A0/*----------------------------------------------------------------=
---------*/
>
> =A0#define OMAP1_OTG_BASE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0xfffb0400
> @@ -29,6 +44,8 @@
>
> =A0extern void usb_musb_init(void);
>
> +extern void usb_ehci_init(struct ehci_hcd_omap_platform_data *pdata)=
;
> +
> =A0#endif
>
> =A0void omap_usb_init(struct omap_usb_config *pdata);
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
