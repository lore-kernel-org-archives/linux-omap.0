From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v3 0/6] OMAP: McSPI: Hwmod adaptation + runtime conversion
Date: Mon, 17 Jan 2011 08:47:20 -0700
Message-ID: <AANLkTinOg3aPQrX+rp=UOf4UcMw2CVA=6COgfGpRkVm0@mail.gmail.com>
References: <32036.10.24.255.18.1295274181.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:59893 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752040Ab1AQPrl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Jan 2011 10:47:41 -0500
Received: by iyj18 with SMTP id 18so4744805iyj.19
        for <linux-omap@vger.kernel.org>; Mon, 17 Jan 2011 07:47:40 -0800 (PST)
In-Reply-To: <32036.10.24.255.18.1295274181.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, spi-devel-general <spi-devel-general@lists.sourceforge.net>, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>

On Mon, Jan 17, 2011 at 7:23 AM, Govindraj.R <govindraj.raja@ti.com> wr=
ote:
> Changes invloves:
> ----------------
> 1) Addition of hwmod data for omap2/3/4.
> 2) McSPI driver hwmod adaptation with cleanup of base address
> =A0 macros and using omap-device API's.
> 3) Runtime Conversion of McSPI driver.
>
> Changes from v2:
> ---------------
> 1) Fixing minor comments and adding ack from Grant Likely.
> =A0 =A0 =A0 =A0https://patchwork.kernel.org/patch/371321/
> =A0 =A0 =A0 =A0https://patchwork.kernel.org/patch/371331/

Hi Govindraj,

My comment still stands that it looks like a lot of duplicate data is
being generated, which makes this patch set larger than it appears to
need to be, but those files aren't in a directory that I maintain so
it's not my call.  :-)

Tony, I'm okay with your merging this series through your tree.

g.

>
> Changes from v1:
> ---------------
> 1) Fixing patch 5/5 comments for hwmod+runtime
> =A0Split the patch 5/5 to hwmod adaptation
> =A0and then runtime conversion
> =A0http://www.mail-archive.com/linux-omap@vger.kernel.org/msg33387.ht=
ml
>
> Testing Updates:
> ----------------
> Was tested using data transfer test module available at:
> http://dev.omapzoom.org/?p=3Dricho/device_driver_test.git;a=3Dblob;f=3D=
mcspi/test_code/
> utils/mcspi_modules/omap_mcspi_datatest.c;
> h=3De42ec10c5c844abdde6a7175a268b379fbbdb655;
> hb=3D5d9a755d50e58de861c5e8991f2f607bc49b5dc3
> This test basically involves MISO <--> MOSI lines looped and data tra=
nsfer test
> done using the above test module.
> System wide suspend and ret/off counts observation, ensured that no b=
ehavioral
> difference with and without this patch series.
>
> Charulatha V (1):
> =A0OMAP: devices: Modify McSPI device to adapt to hwmod framework
>
> Govindraj.R (5):
> =A0OMAP2420: hwmod data: Add McSPI
> =A0OMAP2430: hwmod data: Add McSPI
> =A0OMAP3: hwmod data: Add McSPI
> =A0OMAP4: hwmod data: Add McSPI
> =A0OMAP: runtime: McSPI driver runtime conversion
>
> =A0arch/arm/mach-omap2/devices.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0187 =
++++---------------
> =A0arch/arm/mach-omap2/omap_hwmod_2420_data.c | =A0156 ++++++++++++++=
++
> =A0arch/arm/mach-omap2/omap_hwmod_2430_data.c | =A0219 ++++++++++++++=
++++++++
> =A0arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | =A0280 ++++++++++++++=
++++++++++++++
> =A0arch/arm/mach-omap2/omap_hwmod_44xx_data.c | =A0266 ++++++++++++++=
++++++++++++
> =A0arch/arm/plat-omap/include/plat/mcspi.h =A0 =A0| =A0 11 +
> =A0drivers/spi/omap2_mcspi.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
224 +++++++---------------
> =A07 files changed, 1043 insertions(+), 300 deletions(-)
>
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
