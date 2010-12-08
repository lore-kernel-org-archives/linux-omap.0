From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH 0/7 v2] OMAP: McSPI: Hwmod adaptation + runtime conversion
Date: Wed, 8 Dec 2010 14:49:26 +0530
Message-ID: <AANLkTimPAogh+foA3V+LShmw858UAcU7rN_2SryrabEj@mail.gmail.com>
References: <33183.10.24.255.18.1291212072.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:48738 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751698Ab0LHJTs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Dec 2010 04:19:48 -0500
Received: by wwa36 with SMTP id 36so933436wwa.1
        for <linux-omap@vger.kernel.org>; Wed, 08 Dec 2010 01:19:47 -0800 (PST)
In-Reply-To: <33183.10.24.255.18.1291212072.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, spi-devel-general <spi-devel-general@lists.sourceforge.net>, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>, Cousson@dbdmail.itg.ti.com, "Govindraj.R" <govindraj.raja@ti.com>

On Wed, Dec 1, 2010 at 7:31 PM, Govindraj.R <govindraj.raja@ti.com> wro=
te:
> Changes invloves:
> ----------------
> 1) Addition of hwmod data for omap2/3/4.
> 1) McSPI driver hwmod adaptation with cleanup of base address
> =A0 macros and using omap-device API's.
> 2) Runtime Conversion of McSPI driver


Any comments or feedback on this patch series?

If no comments I hope patch series can be merged
through LO tree with a ack from Grant on
patch 6/6 and patch 7/7.

Benoit,
I may need you comments or ack on patch 1/[1-4]

Patch 1/5 will be posted out separately as per Paul's
comments:
http://ns3.spinics.net/lists/linux-omap/msg41219.html

--
Thanks,
Govindraj.R

>
> Changes from v1:
> ---------------
> 1) Fixing patch 5/5 comments for hwmod+runtime
> =A0 Split the patch 5/5 to hwmod adaptation
> =A0 and then runtime conversion
> =A0 http://www.mail-archive.com/linux-omap@vger.kernel.org/msg33387.h=
tml
>
> Testing Updates:
> ----------------
> Was tested using data transfer test module available at:
> http://dev.omapzoom.org/?p=3Dricho/device_driver_test.git;a=3Dblob;f=3D=
mcspi/test_code/
> utils/mcspi_modules/omap_mcspi_datatest.c;
> h=3De42ec10c5c844abdde6a7175a268b379fbbdb655;
> hb=3D5d9a755d50e58de861c5e8991f2f607bc49b5dc3
>
> System wide suspend and ret/off counts observation,
> ensured that no behavioral difference with and without
> this patch series.
>
> Benoit Cousson (1):
> =A0OMAP4: hwmod data: Add McSPI
>
> Charulatha V (5):
> =A0OMAP2420: hwmod data: Add McSPI
> =A0OMAP2430: hwmod data: Add McSPI
> =A0OMAP3: hwmod data: Add McSPI
> =A0OMAP3: clocks: Update clock domain name for mcspi fck
> =A0OMAP: devices: Modify McSPI device to adapt to hwmod framework
>
> Govindraj.R (1):
> =A0OMAP: runtime: McSPI driver runtime conversion
>
> =A0arch/arm/mach-omap2/clock3xxx_data.c =A0 =A0 =A0 | =A0 =A04 +
> =A0arch/arm/mach-omap2/devices.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0189 =
++++---------------
> =A0arch/arm/mach-omap2/omap_hwmod_2420_data.c | =A0156 ++++++++++++++=
++
> =A0arch/arm/mach-omap2/omap_hwmod_2430_data.c | =A0219 ++++++++++++++=
++++++++
> =A0arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | =A0280 ++++++++++++++=
++++++++++++++
> =A0arch/arm/mach-omap2/omap_hwmod_44xx_data.c | =A0267 ++++++++++++++=
++++++++++++
> =A0arch/arm/plat-omap/include/plat/mcspi.h =A0 =A0| =A0 11 +
> =A0drivers/spi/omap2_mcspi.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
225 +++++++---------------
> =A08 files changed, 1051 insertions(+), 300 deletions(-)
>
>
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
