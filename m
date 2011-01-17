From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v3 0/6] OMAP: McSPI: Hwmod adaptation + runtime conversion
Date: Mon, 17 Jan 2011 17:00:11 +0100
Message-ID: <4D34678B.702@ti.com>
References: <32036.10.24.255.18.1295274181.squirrel@dbdmail.itg.ti.com> <AANLkTinOg3aPQrX+rp=UOf4UcMw2CVA=6COgfGpRkVm0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41536 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751254Ab1AQQA2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Jan 2011 11:00:28 -0500
In-Reply-To: <AANLkTinOg3aPQrX+rp=UOf4UcMw2CVA=6COgfGpRkVm0@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: "Raja, Govindraj" <govindraj.raja@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, spi-devel-general <spi-devel-general@lists.sourceforge.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Varadarajan, Charulatha" <charu@ti.com>, Paul Walmsley <paul@pwsan.com>, "Hilman, Kevin" <khilman@ti.com>, Tony Lindgren <tony@atomide.com>

Hi Grant,

On 1/17/2011 4:47 PM, Grant Likely wrote:
> On Mon, Jan 17, 2011 at 7:23 AM, Govindraj.R<govindraj.raja@ti.com>  wrote:
>> Changes invloves:
>> ----------------
>> 1) Addition of hwmod data for omap2/3/4.
>> 2) McSPI driver hwmod adaptation with cleanup of base address
>>    macros and using omap-device API's.
>> 3) Runtime Conversion of McSPI driver.
>>
>> Changes from v2:
>> ---------------
>> 1) Fixing minor comments and adding ack from Grant Likely.
>>         https://patchwork.kernel.org/patch/371321/
>>         https://patchwork.kernel.org/patch/371331/
>
> Hi Govindraj,
>
> My comment still stands that it looks like a lot of duplicate data is
> being generated, which makes this patch set larger than it appears to
> need to be, but those files aren't in a directory that I maintain so
> it's not my call.  :-)

As Paul said in a previous email, we are well aware of that issue. This 
is something I will work on for the future OMAP4 variants.
Since these files are manually done on OMAP2 & 3 and generated for 
OMAP4, it will require some time and a bunch of scripts to manage easily 
the delta between OMAP2, 3 and 4.
It should be much more straightforward for OMAP4 and beyond.

Regards,
Benoit

>
> Tony, I'm okay with your merging this series through your tree.
>
> g.
>
>>
>> Changes from v1:
>> ---------------
>> 1) Fixing patch 5/5 comments for hwmod+runtime
>>   Split the patch 5/5 to hwmod adaptation
>>   and then runtime conversion
>>   http://www.mail-archive.com/linux-omap@vger.kernel.org/msg33387.html
>>
>> Testing Updates:
>> ----------------
>> Was tested using data transfer test module available at:
>> http://dev.omapzoom.org/?p=richo/device_driver_test.git;a=blob;f=mcspi/test_code/
>> utils/mcspi_modules/omap_mcspi_datatest.c;
>> h=e42ec10c5c844abdde6a7175a268b379fbbdb655;
>> hb=5d9a755d50e58de861c5e8991f2f607bc49b5dc3
>> This test basically involves MISO<-->  MOSI lines looped and data transfer test
>> done using the above test module.
>> System wide suspend and ret/off counts observation, ensured that no behavioral
>> difference with and without this patch series.
>>
>> Charulatha V (1):
>>   OMAP: devices: Modify McSPI device to adapt to hwmod framework
>>
>> Govindraj.R (5):
>>   OMAP2420: hwmod data: Add McSPI
>>   OMAP2430: hwmod data: Add McSPI
>>   OMAP3: hwmod data: Add McSPI
>>   OMAP4: hwmod data: Add McSPI
>>   OMAP: runtime: McSPI driver runtime conversion
>>
>>   arch/arm/mach-omap2/devices.c              |  187 ++++---------------
>>   arch/arm/mach-omap2/omap_hwmod_2420_data.c |  156 ++++++++++++++++
>>   arch/arm/mach-omap2/omap_hwmod_2430_data.c |  219 ++++++++++++++++++++++
>>   arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  280 ++++++++++++++++++++++++++++
>>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  266 ++++++++++++++++++++++++++
>>   arch/arm/plat-omap/include/plat/mcspi.h    |   11 +
>>   drivers/spi/omap2_mcspi.c                  |  224 +++++++---------------
>>   7 files changed, 1043 insertions(+), 300 deletions(-)
>>
>>
>>
>
>
>

