From: Bryan Wu <bryan.wu@canonical.com>
Subject: Re: [PATCH 1/3] OMAP: DSS2: Add generic DPI panel display driver
Date: Thu, 18 Nov 2010 09:00:42 +0800
Message-ID: <AANLkTi=oeScA_Hj0aKEX_ae6xnuhTXFHSbKz=MV_t-6L@mail.gmail.com>
References: <1290000875-11508-1-git-send-email-bryan.wu@canonical.com>
	<1290000875-11508-2-git-send-email-bryan.wu@canonical.com>
	<B85A65D85D7EB246BE421B3FB0FBB5930247387FCD@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:45919 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753516Ab0KRBAo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Nov 2010 20:00:44 -0500
Received: by vws13 with SMTP id 13so1488232vws.19
        for <linux-omap@vger.kernel.org>; Wed, 17 Nov 2010 17:00:43 -0800 (PST)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB5930247387FCD@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Gadiyar, Anand" <gadiyar@ti.com>

On Thu, Nov 18, 2010 at 12:13 AM, Premi, Sanjeev <premi@ti.com> wrote:
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org
>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Bryan Wu
>> Sent: Wednesday, November 17, 2010 7:05 PM
>> To: tomi.valkeinen@nokia.com; linux-omap@vger.kernel.org;
>> linux-arm-kernel@lists.infradead.org; Gadiyar, Anand
>> Subject: [PATCH 1/3] OMAP: DSS2: Add generic DPI panel display drive=
r
>>
>> Generic DPI panel driver includes the driver and 4 similar
>> panel configurations. It
>> will match the panel name which is passed from platform data
>> and setup the
>> right configurations.
>>
>> With generic DPI panel driver, we can remove those 4
>> duplicated panel display
>> drivers. In the future, it is simple for us just add new
>> panel configuration
>> date in panel-generic-dpi.c to support new display panel.
>>
>> Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
>> ---
>> =A0.../arm/plat-omap/include/plat/panel-generic-dpi.h | =A0 37 ++
>> =A0drivers/video/omap2/displays/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
| =A0 =A08 +
>> =A0drivers/video/omap2/displays/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 =A01 +
>> =A0drivers/video/omap2/displays/panel-generic-dpi.c =A0 | =A0355
>> ++++++++++++++++++++
>> =A04 files changed, 401 insertions(+), 0 deletions(-)
>> =A0create mode 100644
>> arch/arm/plat-omap/include/plat/panel-generic-dpi.h
>> =A0create mode 100644 drivers/video/omap2/displays/panel-generic-dpi=
=2Ec
>>
>> diff --git
>> a/arch/arm/plat-omap/include/plat/panel-generic-dpi.h
>> b/arch/arm/plat-omap/include/plat/panel-generic-dpi.h
>> new file mode 100644
>> index 0000000..7906197
>> --- /dev/null
>> +++ b/arch/arm/plat-omap/include/plat/panel-generic-dpi.h
>> @@ -0,0 +1,37 @@
>> +/*
>> + * Header for generic DPI panel driver
>> + *
>> + * Copyright (C) 2010 Canonical Ltd.
>> + * Author: Bryan Wu <bryan.wu@canonical.com>
>> + *
>> + * This program is free software; you can redistribute it
>> and/or modify it
>> + * under the terms of the GNU General Public License version
>> 2 as published by
>> + * the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be
>> useful, but WITHOUT
>> + * ANY WARRANTY; without even the implied warranty of
>> MERCHANTABILITY or
>> + * FITNESS FOR A PARTICULAR PURPOSE. =A0See the GNU General
>> Public License for
>> + * more details.
>> + *
>> + * You should have received a copy of the GNU General Public
>> License along with
>> + * this program. =A0If not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#ifndef __ARCH_ARM_PLAT_OMAP_PANEL_GENERIC_DPI_H
>> +#define __ARCH_ARM_PLAT_OMAP_PANEL_GENERIC_DPI_H
>> +
>> +#include "display.h"
>> +
>> +/**
>> + * struct panel_generic_dpi_data - panel driver configuration data
>> + * @name: panel name
>> + * @platform_enable: platform specific panel enable function
>> + * @platform_disable: platform specific panel disable function
>> + */
>> +struct panel_generic_dpi_data {
>> + =A0 =A0 const char *name;
>> + =A0 =A0 int (*platform_enable)(struct omap_dss_device *dssdev);
>> + =A0 =A0 void (*platform_disable)(struct omap_dss_device *dssdev);
>> +};
>> +
>> +#endif /* __ARCH_ARM_PLAT_OMAP_PANEL_GENERIC_DPI_H */
>> diff --git a/drivers/video/omap2/displays/Kconfig
>> b/drivers/video/omap2/displays/Kconfig
>> index 12327bb..cb3e339 100644
>> --- a/drivers/video/omap2/displays/Kconfig
>> +++ b/drivers/video/omap2/displays/Kconfig
>> @@ -1,6 +1,14 @@
>> =A0menu "OMAP2/3 Display Device Drivers"
>> =A0 =A0 =A0 =A0 =A0depends on OMAP2_DSS
>>
>> +config PANEL_GENERIC_DPI
>> + =A0 =A0 =A0 =A0tristate "Generic DPI Panel"
>> + =A0 =A0 =A0 =A0help
>> + =A0 =A0 =A0 Generic DPI panel driver.
>> + =A0 =A0 =A0 Supports DVI output for Beagle and OMAP3 SDP.
>> + =A0 =A0 =A0 Supports LCD Panel used in TI SDP3430 and EVM boards,
>> + =A0 =A0 =A0 OMAP3517 EVM boards and CM-T35.
>> +
>> =A0config PANEL_GENERIC
>> =A0 =A0 =A0 =A0 =A0tristate "Generic Panel"
>> =A0 =A0 =A0 =A0 =A0help
>> diff --git a/drivers/video/omap2/displays/Makefile
>> b/drivers/video/omap2/displays/Makefile
>> index aa38609..022058c 100644
>> --- a/drivers/video/omap2/displays/Makefile
>> +++ b/drivers/video/omap2/displays/Makefile
>> @@ -1,3 +1,4 @@
>> +obj-$(CONFIG_PANEL_GENERIC_DPI) +=3D panel-generic-dpi.o
>> =A0obj-$(CONFIG_PANEL_GENERIC) +=3D panel-generic.o
>> =A0obj-$(CONFIG_PANEL_SHARP_LS037V7DW01) +=3D panel-sharp-ls037v7dw0=
1.o
>> =A0obj-$(CONFIG_PANEL_SHARP_LQ043T1DG01) +=3D panel-sharp-lq043t1dg0=
1.o
>> diff --git a/drivers/video/omap2/displays/panel-generic-dpi.c
>> b/drivers/video/omap2/displays/panel-generic-dpi.c
>> new file mode 100644
>> index 0000000..6702cf6
>> --- /dev/null
>> +++ b/drivers/video/omap2/displays/panel-generic-dpi.c
>> @@ -0,0 +1,355 @@
>> +/*
>> + * Generic DPI Panels support
>> + *
>> + * Copyright (C) 2010 Canonical Ltd.
>> + * Author: Bryan Wu <bryan.wu@canonical.com>
>> + *
>> + * Copyright (C) 2008 Nokia Corporation
>> + * Author: Tomi Valkeinen <tomi.valkeinen@nokia.com>
>> + *
>
> [sp] Shouldn't all authors (from the files being coalesced) be
> =A0 =A0 listed here.
>

No problem, I will provide an incremental patch for Tomi.

-Bryan

> =A0 =A0 I see this missing from PATCH3/3 in your series:
>
> [quote]
> - * LCD panel driver for Sharp LQ043T1DG01
> - *
> - * Copyright (C) 2009 Texas Instruments Inc
> - * Author: Vaibhav Hiremath <hvaibhav@ti.com>
> - *
> [/quote]
>
>
> [snip]...[snip]
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
