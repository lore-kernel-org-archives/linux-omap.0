From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH 0/7 v2] OMAP: McSPI: Hwmod adaptation + runtime conversion
Date: Fri, 17 Dec 2010 18:22:47 +0530
Message-ID: <AANLkTinBafsUsNuxc25sTEBPX=fD-=StRHF8-jL+mqCc@mail.gmail.com>
References: <33183.10.24.255.18.1291212072.squirrel@dbdmail.itg.ti.com>
 <87d3p3kobt.fsf@deeprootsystems.com> <AANLkTikgzMjU9wfzzMjEXzFCUvRz6hKtv=N8dKXf10YM@mail.gmail.com>
 <874oadfuq9.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:64063 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754042Ab0LQMxI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Dec 2010 07:53:08 -0500
Received: by qyj19 with SMTP id 19so1573059qyj.19
        for <linux-omap@vger.kernel.org>; Fri, 17 Dec 2010 04:53:08 -0800 (PST)
In-Reply-To: <874oadfuq9.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Raja, Govindraj" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, spi-devel-general <spi-devel-general@lists.sourceforge.net>, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>, Benoit Cousson <b-cousson@ti.com>, "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>, Partha Basak <p-basak2@ti.com>

On Thu, Dec 16, 2010 at 11:47 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Hi Govindraj,
>
> "Raja, Govindraj" <govindraj.raja@ti.com> writes:
>
>> On Wed, Dec 15, 2010 at 9:42 PM, Kevin Hilman <khilman@deeprootsyste=
ms.com>
>> wrote:
>>
>> =A0 =A0 "Govindraj.R" <govindraj.raja@ti.com> writes:
>>
>> =A0 =A0 > Changes invloves:
>> =A0 =A0 > ----------------
>> =A0 =A0 > 1) Addition of hwmod data for omap2/3/4.
>> =A0 =A0 > 1) McSPI driver hwmod adaptation with cleanup of base addr=
ess
>> =A0 =A0 > =A0 =A0macros and using omap-device API's.
>> =A0 =A0 > 2) Runtime Conversion of McSPI driver
>> =A0 =A0 >
>> =A0 =A0 > Changes from v1:
>> =A0 =A0 > ---------------
>> =A0 =A0 > 1) Fixing patch 5/5 comments for hwmod+runtime
>> =A0 =A0 > =A0 =A0Split the patch 5/5 to hwmod adaptation
>> =A0 =A0 > =A0 =A0and then runtime conversion
>> =A0 =A0 > =A0 =A0http://www.mail-archive.com/linux-omap@vger.kernel.=
org/msg33387.html
>> =A0 =A0 >
>> =A0 =A0 > Testing Updates:
>> =A0 =A0 > ----------------
>> =A0 =A0 > Was tested using data transfer test module available at:
>> =A0 =A0 > http://dev.omapzoom.org/?p=3Dricho/device_driver_test.git;=
a=3Dblob;f=3Dmcspi/
>> =A0 =A0 test_code/
>> =A0 =A0 > utils/mcspi_modules/omap_mcspi_datatest.c;
>> =A0 =A0 > h=3De42ec10c5c844abdde6a7175a268b379fbbdb655;
>> =A0 =A0 > hb=3D5d9a755d50e58de861c5e8991f2f607bc49b5dc3
>>
>> =A0 =A0 Can you summarize what this test does?
>>
>> =A0 =A0 On what platforms was this tested?
>>
>> =A0 =A0 How was it tested for OMAP1 and OMAP2?
>>
>>
>>
>> Using the above mentioned test module we had done some
>> data transfer tests.
>> Platforms used used where :
>> 1) OMAP2430 SDP.
>> 2) OMAP3 (ZOOM boards zoom2/3).
>> 3) OMAP4430 SDP [ Here even basic=A0Ethernet=A0functionality=A0was c=
hecked which is
>> over SPI interface]
>
> Can you describe a little more about the testing please? =A0What exac=
tly
> does the data transfer test do? =A0Is it a loopback test? =A0Does it =
use
> on-board SPI peripherals? =A0If so, which ones, etc.
>

Yes its an loopback test based on SPI interface available from
development board expansion connector.

MISO <---> MOSI [Loopback test]

So basically looking into the Board schematics we decide
which SPI interface is available on the board expansion connector
and use SPI interface available.

On zoom boards SPI3 was available on expansion connector
and same was used. On 4430SDP SPI2 interface was used.
On 2430SDP SPI2.

Also for testing, spi_board_info was populated in board file
and spi_register_board_info was done, here bus info was populated
based on spi bus available on the board. In spi_board_info structure
we initialize spi_bus and name as spitst and speed and chip-select
later once test module is loaded word-length, speed etc is modified
from proc interface available from the test module and data test
is done.

--
Thanks,
Govindraj.R


>> We boot tested on 2420/n800.
>>
>> Coming to omap1,
>>
>> This driver[omap2_mcspi.c] is applicable only from omap2_plus
>> for omap1=A0omap_uwire.c is the spi driver file.
>
> OK, thanks for clarification.
>
> Kevin
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
