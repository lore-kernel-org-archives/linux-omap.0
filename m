From: Bryan Wu <bryan.wu@canonical.com>
Subject: Re: [PATCH 1/3] OMAP: DSS2: Add generic DPI panel display driver
Date: Wed, 17 Nov 2010 21:38:44 +0800
Message-ID: <AANLkTi=yQwo0AATr=X2oNAvsU1Y3+RSEu8oUOLym6-u9@mail.gmail.com>
References: <1289960640-8782-1-git-send-email-bryan.wu@canonical.com>
	<1289960640-8782-2-git-send-email-bryan.wu@canonical.com>
	<1289997841.26444.21.camel@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:41282 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932433Ab0KQNiq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Nov 2010 08:38:46 -0500
Received: by qyk12 with SMTP id 12so6382868qyk.19
        for <linux-omap@vger.kernel.org>; Wed, 17 Nov 2010 05:38:45 -0800 (PST)
In-Reply-To: <1289997841.26444.21.camel@tubuntu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, gadiyar@ti.com

On Wed, Nov 17, 2010 at 8:44 PM, Tomi Valkeinen
<tomi.valkeinen@nokia.com> wrote:
> On Wed, 2010-11-17 at 10:23 +0800, ext Bryan Wu wrote:
>> Generic DPI panel driver includes the driver and 4 similar panel con=
figurations. It
>> will match the panel name which is passed from platform data and set=
up the
>> right configurations.
>>
>> With generic DPI panel driver, we can remove those 4 duplicated pane=
l display
>> drivers. In the future, it is simple for us just add new panel confi=
guration
>> date in panel-generic-dpi.c to support new display panel.
>>
>> Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
>> ---
>> =A0.../arm/plat-omap/include/plat/panel-generic-dpi.h | =A0 37 ++
>> =A0drivers/video/omap2/displays/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
| =A0 =A08 +
>> =A0drivers/video/omap2/displays/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 =A01 +
>> =A0drivers/video/omap2/displays/panel-generic-dpi.c =A0 | =A0348 +++=
+++++++++++++++++
>> =A04 files changed, 394 insertions(+), 0 deletions(-)
>> =A0create mode 100644 arch/arm/plat-omap/include/plat/panel-generic-=
dpi.h
>> =A0create mode 100644 drivers/video/omap2/displays/panel-generic-dpi=
=2Ec
>>
>
[snip]

>> +
>> +static void generic_dpi_panel_remove(struct omap_dss_device *dssdev=
)
>> +{
>> +}
>
> You need to free the drv_data here.
>
> Perhaps this will be the last fix =3D).
>

My bad, I just sent out the 8th version for review. Moreover, I think
in panel-taal.c it also misses call dev_set_drvdata(&dssdev->dev,
NULL); after we kfree(td) in taal_remove().

Thanks,
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
