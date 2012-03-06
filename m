From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCH RFC] spi/omap: Trivial cleanup
Date: Tue, 06 Mar 2012 18:45:13 +0530
Message-ID: <4F560DE1.3090809@ti.com>
References: <1330524246-8864-1-git-send-email-shubhrajyoti@ti.com> <4F55E412.5050409@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4F55E412.5050409@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: spi-devel-general@lists.sourceforge.net, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 06 March 2012 03:46 PM, Cousson, Benoit wrote:
> Hi Shubhro,
>
> On 2/29/2012 3:04 PM, Shubhrajyoti D wrote:
>> The context is stored directly inside drvdata structure post
>> [f887876 spi/omap: Remove bus_num usage for instance index].
>> Remove the OMAP2_MCSPI_MAX_CTRL macro as it is not needed anymore.
>>
>> Cc: Benoit Cousson<b-cousson@ti.com>
>> Signed-off-by: Shubhrajyoti D<shubhrajyoti@ti.com>
>
> Thanks for that extra cleanup, I missed it.
>
> Acked-by: Benoit Cousson <b-cousson@ti.com>
>
>> ---
>> Applies on Benoit's for_3.4/dt_spi_eth
>>
>>   drivers/spi/spi-omap2-mcspi.c |    3 ---
>>   1 files changed, 0 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/spi/spi-omap2-mcspi.c
>> b/drivers/spi/spi-omap2-mcspi.c
>> index d1eb26c..3526281 100644
>> --- a/drivers/spi/spi-omap2-mcspi.c
>> +++ b/drivers/spi/spi-omap2-mcspi.c
>> @@ -45,9 +45,6 @@
>>
>>   #define OMAP2_MCSPI_MAX_FREQ        48000000
>>
>> -/* OMAP2 has 3 SPI controllers, while OMAP3 has 4 */
>> -#define OMAP2_MCSPI_MAX_CTRL         4
>> -
>
> I guess it can be included in the "spi/omap: Remove bus_num usage for
> instance index"?
> Is that OK for you?
Yes, sure.
>
>
> Thanks,
> Benoit
>
