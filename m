From: Bryan Wu <bryan.wu@canonical.com>
Subject: Re: [PATCH 1/3] Backlight: driver for Sharp LS037V7DW01 panel on OMAP machine
Date: Wed, 1 Dec 2010 22:21:24 +0800
Message-ID: <AANLkTimjoDJoG2GLjPamhROAHLBx77=a=DP+K2a7uPYe@mail.gmail.com>
References: <1291118860-10325-1-git-send-email-bryan.wu@canonical.com>
	<1291118860-10325-2-git-send-email-bryan.wu@canonical.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB0322C02493@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:48701 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754862Ab0LAOVZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Dec 2010 09:21:25 -0500
Received: by qyk11 with SMTP id 11so2656572qyk.19
        for <linux-omap@vger.kernel.org>; Wed, 01 Dec 2010 06:21:24 -0800 (PST)
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB0322C02493@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Janorkar, Mayuresh" <mayur@ti.com>
Cc: "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Gadiyar, Anand" <gadiyar@ti.com>, "rpurdie@rpsys.net" <rpurdie@rpsys.net>

On Tue, Nov 30, 2010 at 9:09 PM, Janorkar, Mayuresh <mayur@ti.com> wrot=
e:
>
>
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Bryan Wu
>> Sent: Tuesday, November 30, 2010 5:38 PM
>> To: tomi.valkeinen@nokia.com; linux-omap@vger.kernel.org; linux-arm-
>> kernel@lists.infradead.org; Gadiyar, Anand; rpurdie@rpsys.net
>> Subject: [PATCH 1/3] Backlight: driver for Sharp LS037V7DW01 panel o=
n OMAP
>> machine
>>
>> This driver is split from drivers/video/backlight/sharp_ls037v7dw01.=
c
>>
>> Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
>> ---
>> =A0drivers/video/backlight/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 | =A0 10 =
++
>> =A0drivers/video/backlight/Makefile =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0=
1 +
>> =A0drivers/video/backlight/sharp_ls037v7dw01.c | =A0144
>> +++++++++++++++++++++++++++
>> =A03 files changed, 155 insertions(+), 0 deletions(-)
>> =A0create mode 100644 drivers/video/backlight/sharp_ls037v7dw01.c
>>
>> diff --git a/drivers/video/backlight/Kconfig
>> b/drivers/video/backlight/Kconfig
>> index e54a337..46b2415 100644
>> --- a/drivers/video/backlight/Kconfig
>> +++ b/drivers/video/backlight/Kconfig
>> @@ -307,6 +307,16 @@ config BACKLIGHT_PCF50633
>> =A0 =A0 =A0 =A0 If you have a backlight driven by a NXP PCF50633 MFD=
, say Y here
>> to
>> =A0 =A0 =A0 =A0 enable its driver.
>>
>> +config BACKLIGHT_SHARP_LS037V7DW01
>> + =A0 =A0 tristate "Backlight driver for SHARP LS037V7DW01 Panel"
>> + =A0 =A0 depends on PANEL_GENERIC_DPI
>> + =A0 =A0 help
>> + =A0 =A0 =A0 If you are using Sharp LS037V7DW01 LCD panel, say Y he=
re to enable
>> this driver.
>> +
>> + =A0 =A0 =A0 To compile this driver as a module, choose M here: the=
 module will
>> + =A0 =A0 =A0 be called sharp_ls037v7dw01.
>> +
>> +
> [Mayuresh]: Please do not introduce extra new lines.

No problem, I will remove this for next try.

>> =A0endif # BACKLIGHT_CLASS_DEVICE
>>
>> =A0endif # BACKLIGHT_LCD_SUPPORT
>> diff --git a/drivers/video/backlight/Makefile
>> b/drivers/video/backlight/Makefile
>> index 44c0f81..c756f49 100644
>> --- a/drivers/video/backlight/Makefile
>> +++ b/drivers/video/backlight/Makefile
>> @@ -35,4 +35,5 @@ obj-$(CONFIG_BACKLIGHT_ADP5520) =A0 =A0 +=3D adp55=
20_bl.o
>> =A0obj-$(CONFIG_BACKLIGHT_ADP8860) =A0 =A0 =A0+=3D adp8860_bl.o
>> =A0obj-$(CONFIG_BACKLIGHT_88PM860X) +=3D 88pm860x_bl.o
>> =A0obj-$(CONFIG_BACKLIGHT_PCF50633) =A0 =A0 +=3D pcf50633-backlight.=
o
>> +obj-$(CONFIG_BACKLIGHT_SHARP_LS037V7DW01) =A0 =A0+=3D sharp_ls037v7=
dw01.o
>>
>> diff --git a/drivers/video/backlight/sharp_ls037v7dw01.c
>> b/drivers/video/backlight/sharp_ls037v7dw01.c
>> new file mode 100644
>> index 0000000..e90595e
>> --- /dev/null
>> +++ b/drivers/video/backlight/sharp_ls037v7dw01.c
>> @@ -0,0 +1,144 @@
>> +/*
>> + * Backlight driver for Sharp LS037V7DW01
>> + *
>> + * Copyright (C) 2010 Canonical Ltd.
>> + * Author: Bryan Wu <bryan.wu@canonical.com>
>> + *
>> + * Copyright (C) 2008 Nokia Corporation
>> + * Author: Tomi Valkeinen <tomi.valkeinen@nokia.com>
>> + *
>> + * This program is free software; you can redistribute it and/or mo=
dify
>> it
>> + * under the terms of the GNU General Public License version 2 as
>> published by
>> + * the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful, =
but
>> WITHOUT
>> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILI=
TY or
>> + * FITNESS FOR A PARTICULAR PURPOSE. =A0See the GNU General Public =
License
>> for
>> + * more details.
>> + *
>> + * You should have received a copy of the GNU General Public Licens=
e
>> along with
>> + * this program. =A0If not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/device.h>
>> +#include <linux/backlight.h>
>> +#include <linux/fb.h>
>> +#include <linux/err.h>
>> +
>> +/* This OMAP platform header file is required by this driver */
>> +#include <plat/display.h>
>> +
>> +static int sharp_ls_bl_update_status(struct backlight_device *bl)
>> +{
>> + =A0 =A0 struct omap_dss_device *dssdev =3D bl_get_data(bl);
>> + =A0 =A0 int level;
>> +
>> + =A0 =A0 if (!dssdev->set_backlight)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 if (bl->props.fb_blank =3D=3D FB_BLANK_UNBLANK &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bl->props.power =3D=3D FB_=
BLANK_UNBLANK)
>> + =A0 =A0 =A0 =A0 =A0 =A0 level =3D bl->props.brightness;
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 level =3D 0;
>> +
>> + =A0 =A0 return dssdev->set_backlight(dssdev, level);
>> +}
>> +
>> +static int sharp_ls_bl_get_brightness(struct backlight_device *bl)
>> +{
>> + =A0 =A0 if (bl->props.fb_blank =3D=3D FB_BLANK_UNBLANK &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bl->props.power =3D=3D FB_=
BLANK_UNBLANK)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return bl->props.brightness;
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static const struct backlight_ops sharp_ls_bl_ops =3D {
>> + =A0 =A0 .get_brightness =3D sharp_ls_bl_get_brightness,
>> + =A0 =A0 .update_status =A0=3D sharp_ls_bl_update_status,
>> +};
>> +
>> +static int __devinit sharp_ls_bl_probe(struct platform_device *pdev=
)
>> +{
>> + =A0 =A0 struct backlight_properties props;
>> + =A0 =A0 struct backlight_device *bl;
>> + =A0 =A0 struct omap_dss_device *dssdev =3D pdev->dev.platform_data=
;
>> +
>> + =A0 =A0 if (!dssdev)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 memset(&props, 0, sizeof(struct backlight_properties));
>> + =A0 =A0 props.max_brightness =3D dssdev->max_backlight_level;
>> +
>> + =A0 =A0 bl =3D backlight_device_register("sharp-ls-bl", &dssdev->d=
ev, dssdev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &sharp_ls_bl_ops, &props);
>> + =A0 =A0 if (IS_ERR(bl))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return PTR_ERR(bl);
>> +
>> + =A0 =A0 bl->props.fb_blank =3D FB_BLANK_UNBLANK;
>> + =A0 =A0 bl->props.power =3D FB_BLANK_UNBLANK;
>> + =A0 =A0 bl->props.brightness =3D dssdev->max_backlight_level;
>> + =A0 =A0 backlight_update_status(bl);
>> +
>> + =A0 =A0 platform_set_drvdata(pdev, bl);
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int __devexit sharp_ls_bl_remove(struct platform_device *pde=
v)
>> +{
>> + =A0 =A0 struct backlight_device *bl =3D platform_get_drvdata(pdev)=
;
>> +
>> + =A0 =A0 bl->props.power =3D FB_BLANK_POWERDOWN;
>> + =A0 =A0 backlight_update_status(bl);
>> + =A0 =A0 backlight_device_unregister(bl);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +#ifdef CONFIG_PM
>> +static int sharp_ls_bl_suspend(struct platform_device *dev, pm_mess=
age_t
>> state)
>> +{
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int sharp_ls_bl_resume(struct platform_device *dev)
>> +{
>> + =A0 =A0 struct backlight_device *bl =3D platform_get_drvdata(dev);
>> +
>> + =A0 =A0 backlight_update_status(bl);
>> + =A0 =A0 return 0;
>> +}
>> +#else
>> +#define sharp_ls_bl_suspend =A0NULL
>> +#define sharp_ls_bl_resume =A0 NULL
>> +#endif
>> +
>> +static struct platform_driver sharp_ls_bl_driver =3D {
>> + =A0 =A0 .driver =A0 =A0 =A0 =A0 =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "sharp-ls-bl",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0=3D THIS_MODULE,
>> + =A0 =A0 },
>> + =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D sharp_ls_bl_probe,
>> + =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D __devexit_p(sharp_ls_bl_remove=
),
>> + =A0 =A0 .suspend =A0 =A0 =A0 =A0=3D sharp_ls_bl_suspend,
>> + =A0 =A0 .resume =A0 =A0 =A0 =A0 =3D sharp_ls_bl_resume,
>> +};
>> +
>> +static int __init sharp_ls_bl_init(void)
>> +{
>> + =A0 =A0 return platform_driver_register(&sharp_ls_bl_driver);
>> +}
>> +module_init(sharp_ls_bl_init);
>> +
>> +static void __exit sharp_ls_bl_exit(void)
>> +{
>> + =A0 =A0 platform_driver_unregister(&sharp_ls_bl_driver);
>> +}
>> +module_exit(sharp_ls_bl_exit);
>> +
>> +MODULE_DESCRIPTION("Sharp LS037V7DW01 Backlight Driver");
>> +MODULE_AUTHOR("Bryan Wu <bryan.wu@canonical.com>");
>> +MODULE_LICENSE("GPL");
>> +MODULE_ALIAS("platform:sharp-ls-bl");
>> --
>> 1.7.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
Bryan Wu <bryan.wu@canonical.com>
Kernel Developer =A0 =A0+86.138-1617-6545 Mobile
Ubuntu Kernel Team
Canonical Ltd. =A0 =A0 =A0www.canonical.com
Ubuntu - Linux for human beings | www.ubuntu.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
