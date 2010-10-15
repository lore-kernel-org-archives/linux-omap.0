From: Jason Wang <jason77.wang@gmail.com>
Subject: Re: [PATCH 4/4] Input: ads7846 - modificatons of _stop()/_disable()
 conditions
Date: Fri, 15 Oct 2010 10:29:52 +0800
Message-ID: <4CB7BCA0.1080604@gmail.com>
References: <1284634286-8871-1-git-send-email-jason77.wang@gmail.com>	<1284634286-8871-4-git-send-email-jason77.wang@gmail.com>	<1284634286-8871-5-git-send-email-jason77.wang@gmail.com>	<201009162339.06395.dmitry.torokhov@gmail.com>	<4C9332CE.6040905@gmail.com>	<20100917160709.GC14186@core.coreip.homeip.net>	<4C9718E9.5040104@gmail.com>	<4CB4314C.7050308@gmail.com>	<20101012160055.GA6355@core.coreip.homeip.net>	<4CB523B7.8010209@gmail.com>	<AANLkTi=0b-q3LK3-4mgdpSP7pScVSF1ZWzD45bLoAmJO@mail.gmail.com>	<4CB66777.5060309@gmail.com> <AANLkTimRqaFkNkRzubY4-Gx=y0yJ_C1VFycL0+uEa_Wm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:44860 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755968Ab0JOCZs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Oct 2010 22:25:48 -0400
In-Reply-To: <AANLkTimRqaFkNkRzubY4-Gx=y0yJ_C1VFycL0+uEa_Wm@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Jason Wang <jason77.wang@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, vapier@gentoo.org, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, grant.likely@secretlab.ca, roman.tereshonkov@nokia.com

Grazvydas Ignotas wrote:
> On Thu, Oct 14, 2010 at 5:14 AM, Jason Wang <jason77.wang@gmail.com> wrote:
>   
>> Grazvydas Ignotas wrote:
>>     
>>> Working here on pandora too, applied on top of linux-next (did not
>>> test suspend though).
>>>
>>> Not caused by this patch, but the old problem where lower measurement
>>> bits get lost is back - when I draw diagonal line it looks like
>>> stairs. I think it's caused by OMAP SPI driver, CCing linux-omap.
>>>
>>>
>>>       
>> Yes, it is OMAP spi driver issues, I have met the same problem before,
>> please refer to:
>> http://www.spinics.net/lists/arm-kernel/msg91538.html
>>
>> you can apply this patch and test again.
>>     
>
> It solves my issue, thanks
> Tested-by: Grazvydas Ignotas <notasas@gmail.com>
>
> BTW I have done similar patch almost 2 years ago for exactly the same problem:
> http://marc.info/?l=linux-omap&m=122565580616920&w=2
> but then problem went away after random kernel update (from what I
> remember), and my patch was no longer needed.
>
>   
Really similar problem and similar solution, :-)

>   
>> From 393f445ab899abaf5d60a55a54f242c430507047 Mon Sep 17 00:00:00 2001
>> From: Jason Wang <jason77.wang@gmail.com>
>> Date: Thu, 14 Oct 2010 10:08:07 +0800
>> Subject: [PATCH] spi/omap2_mcspi: disable channel after TX_ONLY transfer in
>> PIO mode
>>
>> In TX_ONLY transfer, the SPI controller can also receive data
>> simultaneously and saves them in rx register. After the TX_ONLY
>> transfer, the rx register will hold random data received during
>> last tx transaction.
>>
>> If the next transfer is RX_ONLY, this random data has
>> the possibility to affect this transfer like this:
>>
>>  If the spi controller is changed from TX_ONLY to RX_ONLY mode,
>>  The random data makes the rx register full imediately and
>>  triggers a dummy write (in SPI RX_ONLY transfer, we need a dummy
>>  write to trigger the first transaction).
>>
>>  So the first data received in RX_ONLY transfer will be that
>>  random data instead of something meaningfug.
>>
>> We can avoid this by a Disable/reenable toggle of the spi channel
>> after the TX_ONLY transfer, since it purges the rx register.
>>
>> Signed-off-by: Jason Wang <jason77.wang@gmail.com>
>> ---
>> drivers/spi/omap2_mcspi.c |    6 ++++++
>> 1 files changed, 6 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
>> index b3a94ca..43fab41 100644
>> --- a/drivers/spi/omap2_mcspi.c
>> +++ b/drivers/spi/omap2_mcspi.c
>> @@ -644,6 +644,12 @@ omap2_mcspi_txrx_pio(struct spi_device *spi, struct
>> spi_transfer *xfer)
>>               } else if (mcspi_wait_for_reg_bit(chstat_reg,
>>                               OMAP2_MCSPI_CHSTAT_EOT) < 0)
>>                       dev_err(&spi->dev, "EOT timed out\n");
>> +
>> +               /* disable chan to purge rx datas received in TX_ONLY
>> transfer,
>> +                * otherwise these rx datas will affect the direct following
>> +                * RX_ONLY transfer.
>> +                */
>> +               omap2_mcspi_set_enable(spi, 0);
>>       }
>> out:
>>       omap2_mcspi_set_enable(spi, 1);
>> --
>> 1.5.6.5
>>
>>
>>     
>
>   

