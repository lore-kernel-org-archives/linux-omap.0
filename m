From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH 1/2] OMAP: DSS: Add display board file for zoom boards
Date: Wed, 20 Jan 2010 15:34:52 +0200
Message-ID: <6ed0b2681001200534h34c8fe03jf07d9fa765e07924@mail.gmail.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E94026B2DC23C@dbde02.ent.ti.com>
	 <19F8576C6E063C45BE387C64729E7394044A47239C@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:9941 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753082Ab0ATNey convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Jan 2010 08:34:54 -0500
Received: by fg-out-1718.google.com with SMTP id 16so897144fgg.1
        for <linux-omap@vger.kernel.org>; Wed, 20 Jan 2010 05:34:52 -0800 (PST)
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044A47239C@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "Y, Kishore" <kishore.y@ti.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, Jan 19, 2010 at 7:52 PM, Hiremath, Vaibhav <hvaibhav@ti.com> wr=
ote:
>
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Y, Kishore
>> Sent: Tuesday, January 19, 2010 6:42 PM
>> To: Tomi Valkeinen
>> Cc: linux-omap@vger.kernel.org
>> Subject: [PATCH 1/2] OMAP: DSS: Add display board file for zoom
>> boards
>>
>> From: Kishore Y <kishore.y@ti.com>
>>
>> board-zoom-display.c added as a common file for display
>> fucntionality
>> on boards zoom2, zoom3 and 3630sdp
>>
>> Signed-off-by: Mukund Mittal <mmittal@ti.com>
>> Signed-off-by: Kishore Y <kishore.y@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 =A03 +
>> =A0arch/arm/mach-omap2/board-zoom-display.c =A0 =A0 =A0| =A0232
>> +++++++++++++++++++++++++
>> =A0arch/arm/mach-omap2/board-zoom-peripherals.c =A0| =A0 36 ++++
>> =A0arch/arm/mach-omap2/include/mach/board-zoom.h | =A0 =A03 +
>> =A04 files changed, 274 insertions(+), 0 deletions(-)
>> =A0create mode 100644 arch/arm/mach-omap2/board-zoom-display.c
>>
>> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-
>> omap2/Makefile
>> index b32678b..3dbe694 100644
>> --- a/arch/arm/mach-omap2/Makefile
>> +++ b/arch/arm/mach-omap2/Makefile
>> @@ -91,14 +91,17 @@ obj-$(CONFIG_MACH_NOKIA_RX51) =A0 =A0 =A0 =A0 =A0=
 =A0 +=3D
>> board-rx51.o \
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0board-rx51-peripherals.o \
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0mmc-twl4030.o
>> =A0obj-$(CONFIG_MACH_OMAP_ZOOM2) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D=
 board-zoom2.o \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0board-zoom-display.o \
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0board-zoom-peripherals.o \
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0mmc-twl4030.o \
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0board-zoom-debugboard.o
>> =A0obj-$(CONFIG_MACH_OMAP_ZOOM3) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D=
 board-zoom3.o \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0board-zoom-display.o \
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0board-zoom-peripherals.o \
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0mmc-twl4030.o \
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0board-zoom-debugboard.o
>> =A0obj-$(CONFIG_MACH_OMAP_3630SDP) =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D b=
oard-3630sdp.o \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0board-zoom-display.o \
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0board-zoom-peripherals.o \
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0mmc-twl4030.o
>> =A0obj-$(CONFIG_MACH_CM_T35) =A0 =A0 =A0 =A0 =A0 =A0+=3D board-cm-t3=
5.o \
>> diff --git a/arch/arm/mach-omap2/board-zoom-display.c
>> b/arch/arm/mach-omap2/board-zoom-display.c
>> new file mode 100644
>> index 0000000..c8f47f4
>> --- /dev/null
>> +++ b/arch/arm/mach-omap2/board-zoom-display.c

<snip>

>> +static int zoom_panel_enable_tv(struct omap_dss_device *dssdev)
>> +{
>> + =A0 =A0 int ret;
>> + =A0 =A0 struct regulator *vdac_reg;
>> +
>> + =A0 =A0 vdac_reg =3D regulator_get(NULL, "vdda_dac");
>> + =A0 =A0 if (IS_ERR(vdac_reg)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_err("Unable to get vdac regulator\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return PTR_ERR(vdac_reg);
>> + =A0 =A0 }
> [Hiremath, Vaibhav] Same here.

Actually you don't need this regulator_get() at all, DSS2 core already
calls it for you. With upcoming DSS2 updates you will not need
regulator_get() vpll2 too, so I guess it can already be removed too.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
