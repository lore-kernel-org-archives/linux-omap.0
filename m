From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH 0/7 v2] OMAP: McSPI: Hwmod adaptation + runtime conversion
Date: Thu, 16 Dec 2010 17:03:13 +0530
Message-ID: <AANLkTikxcnUO5DbAm1oVrPO-1arF-6e8+aQV=7qAtYNR@mail.gmail.com>
References: <33183.10.24.255.18.1291212072.squirrel@dbdmail.itg.ti.com> <87d3p3kobt.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:50578 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755220Ab0LPLde convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Dec 2010 06:33:34 -0500
Received: by qyj19 with SMTP id 19so217430qyj.19
        for <linux-omap@vger.kernel.org>; Thu, 16 Dec 2010 03:33:33 -0800 (PST)
In-Reply-To: <87d3p3kobt.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, spi-devel-general <spi-devel-general@lists.sourceforge.net>, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>, Benoit Cousson <b-cousson@ti.com>, "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>, "Basak, Partha" <p-basak2@ti.com>

Hi Kevin,

On Wed, Dec 15, 2010 at 9:42 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> "Govindraj.R" <govindraj.raja@ti.com> writes:
>
>> Changes invloves:
>> ----------------
>> 1) Addition of hwmod data for omap2/3/4.
>> 1) McSPI driver hwmod adaptation with cleanup of base address
>> =A0 =A0macros and using omap-device API's.
>> 2) Runtime Conversion of McSPI driver
>>
>> Changes from v1:
>> ---------------
>> 1) Fixing patch 5/5 comments for hwmod+runtime
>> =A0 =A0Split the patch 5/5 to hwmod adaptation
>> =A0 =A0and then runtime conversion
>> =A0 =A0http://www.mail-archive.com/linux-omap@vger.kernel.org/msg333=
87.html
>>
>> Testing Updates:
>> ----------------
>> Was tested using data transfer test module available at:
>> http://dev.omapzoom.org/?p=3Dricho/device_driver_test.git;a=3Dblob;f=
=3Dmcspi/test_code/
>> utils/mcspi_modules/omap_mcspi_datatest.c;
>> h=3De42ec10c5c844abdde6a7175a268b379fbbdb655;
>> hb=3D5d9a755d50e58de861c5e8991f2f607bc49b5dc3
>
> Can you summarize what this test does?
>
> On what platforms was this tested?
>
> How was it tested for OMAP1 and OMAP2?


Using the above mentioned test module we had done some
data transfer tests.
Platforms used where :
1) OMAP2430 SDP.
2) OMAP3 (ZOOM boards zoom2/3).
3) OMAP4430 SDP [ Here even basic Ethernet functionality was checked
which is over SPI interface]
We boot tested on 2420/n800.

Coming to omap1,

This driver[omap2_mcspi.c] is applicable only from omap2_plus
for omap1 omap_uwire.c is the spi driver file.

Looking into the driver/spi/Kconfig and Makefile:

<KCONFIG SNIP>

config SPI_OMAP_UWIRE
        tristate "OMAP1 MicroWire"
        depends on ARCH_OMAP1

config SPI_OMAP24XX
        tristate "McSPI driver for OMAP"
        depends on ARCH_OMAP2PLUS

<MAKEFILE SNIP>

obj-$(CONFIG_SPI_OMAP_UWIRE)            +=3D omap_uwire.o
obj-$(CONFIG_SPI_OMAP24XX)              +=3D omap2_mcspi.o

---
Thanks,
Govindraj.R

>
> Kevin
>
>> System wide suspend and ret/off counts observation,
>> ensured that no behavioral difference with and without
>> this patch series.
>>
>> Benoit Cousson (1):
>> =A0 OMAP4: hwmod data: Add McSPI
>>
>> Charulatha V (5):
>> =A0 OMAP2420: hwmod data: Add McSPI
>> =A0 OMAP2430: hwmod data: Add McSPI
>> =A0 OMAP3: hwmod data: Add McSPI
>> =A0 OMAP3: clocks: Update clock domain name for mcspi fck
>> =A0 OMAP: devices: Modify McSPI device to adapt to hwmod framework
>>
>> Govindraj.R (1):
>> =A0 OMAP: runtime: McSPI driver runtime conversion
>>
>> =A0arch/arm/mach-omap2/clock3xxx_data.c =A0 =A0 =A0 | =A0 =A04 +
>> =A0arch/arm/mach-omap2/devices.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0189=
 ++++---------------
>> =A0arch/arm/mach-omap2/omap_hwmod_2420_data.c | =A0156 +++++++++++++=
+++
>> =A0arch/arm/mach-omap2/omap_hwmod_2430_data.c | =A0219 +++++++++++++=
+++++++++
>> =A0arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | =A0280 +++++++++++++=
+++++++++++++++
>> =A0arch/arm/mach-omap2/omap_hwmod_44xx_data.c | =A0267 +++++++++++++=
+++++++++++++
>> =A0arch/arm/plat-omap/include/plat/mcspi.h =A0 =A0| =A0 11 +
>> =A0drivers/spi/omap2_mcspi.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
225 +++++++---------------
>> =A08 files changed, 1051 insertions(+), 300 deletions(-)
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
