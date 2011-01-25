From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH v5 0/6] OMAP: McSPI: Hwmod adaptation + runtime conversion
Date: Tue, 25 Jan 2011 15:34:33 +0530
Message-ID: <AANLkTimdBJe64bYyBZnuOPhshyik4Z90zpsSSXJPosPs@mail.gmail.com>
References: <1295614547-1920-1-git-send-email-govindraj.raja@ti.com> <87lj2a5462.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:61851 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751829Ab1AYKE5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Jan 2011 05:04:57 -0500
Received: by gxk9 with SMTP id 9so1631953gxk.19
        for <linux-omap@vger.kernel.org>; Tue, 25 Jan 2011 02:04:56 -0800 (PST)
In-Reply-To: <87lj2a5462.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, spi-devel-general@lists.sourceforge.net, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Charulatha V <charu@ti.com>

On Tue, Jan 25, 2011 at 3:56 AM, Kevin Hilman <khilman@ti.com> wrote:
> Hi Govindraj,
>
> "Govindraj.R" <govindraj.raja@ti.com> writes:
>
>> Changes invloves:
>> ----------------
>> 1) Addition of hwmod data for omap2/3/4.
>> 2) McSPI driver hwmod adaptation with cleanup of base address
>> =A0 =A0macros and using omap-device API's.
>> 3) Runtime Conversion of McSPI driver.
>
> I accidentally replied to the v4 series about the refresh, but this o=
ne
> still needs ar refresh.
>
> Specifically, this change from Gregory Clement touches some of the sa=
me
> code as your patch:
>
> commit 42ce7fd6319bed8ecb26d656c476365da46b29e9
> Author: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Date: =A0 Wed Dec 29 11:52:53 2010 +0100
>
> =A0 =A0spi/omap2_mcspi.c: Force CS to be in inactive state after off-=
mode transition
>

Yes correct.

Will rebase and repost in couple of days.

--
Thanks
Govindraj.R


>
> Kevin
>
>>
>> Changes from v4:
>> ---------------
>> 1) 4430 hwmod file alignment based on Benoit's comments.
>> =A0 =A0http://www.spinics.net/lists/arm-kernel/msg111215.html
>> =A0 =A04430 Hwmod file now aligned based on:
>> =A0 =A0http://gitorious.org/omap-pm/linux/blobs/pm-wip/
>> =A0 =A0hwmods-omap4-full/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>>
>> Changes from v3:
>> ---------------
>> 1) Updated proper Author for all patches which was missed
>> =A0 =A0in v2.
>> 2) Modified 4430 hwmod data file so that mcspi data gets
>> =A0 =A0updated in proper alphabetical order.
>> 3) Update omap2/3 hwmod dat files with SYSS_HAS_RESET_STATUS
>> =A0 =A0flag.
>>
>> Changes from v2:
>> ---------------
>> 1) Fixing minor comments and adding ack from Grant Likely.
>> =A0 =A0 =A0 https://patchwork.kernel.org/patch/371321/
>> =A0 =A0 =A0 https://patchwork.kernel.org/patch/371331/
>>
>> Changes from v1:
>> ---------------
>> 1) Fixing patch 5/5 comments for hwmod+runtime
>> =A0 Split the patch 5/5 to hwmod adaptation
>> =A0 and then runtime conversion
>> =A0 http://www.mail-archive.com/linux-omap@vger.kernel.org/msg33387.=
html
>>
>> Testing Updates:
>> ----------------
>> Was tested using data transfer test module available at:
>> http://dev.omapzoom.org/?p=3Dricho/device_driver_test.git;a=3Dblob;f=
=3Dmcspi/test_code/
>> utils/mcspi_modules/omap_mcspi_datatest.c;
>> h=3De42ec10c5c844abdde6a7175a268b379fbbdb655;
>> hb=3D5d9a755d50e58de861c5e8991f2f607bc49b5dc3
>> This test basically involves MISO <--> MOSI lines looped and data tr=
ansfer test
>> done using the above test module.
>> System wide suspend and ret/off counts observation, ensured that no =
behavioral
>> difference with and without this patch series.
>>
>> Benoit Cousson (1):
>> =A0 OMAP4: hwmod data: Add McSPI
>>
>> Charulatha V (4):
>> =A0 OMAP2420: hwmod data: Add McSPI
>> =A0 OMAP2430: hwmod data: Add McSPI
>> =A0 OMAP3: hwmod data: Add McSPI
>> =A0 OMAP: devices: Modify McSPI device to adapt to hwmod framework
>>
>> Govindraj.R (1):
>> =A0 OMAP: runtime: McSPI driver runtime conversion
>>
>> =A0arch/arm/mach-omap2/devices.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0187=
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
224 +++++++---------------
>> =A07 files changed, 1044 insertions(+), 300 deletions(-)
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
