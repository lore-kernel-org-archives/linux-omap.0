From: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/2] iio: adc: ti_am335x_adc: Protect FIFO1 from
 concurrent access
Date: Tue, 9 Aug 2016 15:27:49 +0530
Message-ID: <a2b89956-5a1a-d311-8f5c-84ce2378c2e9@ti.com>
References: <20160808110501.29586-1-vigneshr@ti.com>
 <20160808110501.29586-2-vigneshr@ti.com>
 <CAKzfze92jp-O1Zy_9gpFTjPdE4Oq_Tt26dAe7854jD30oAEKvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAKzfze92jp-O1Zy_9gpFTjPdE4Oq_Tt26dAe7854jD30oAEKvg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matt Ranostay <mranostay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "Andrew F . Davis" <afd-l0cyMroinI0@public.gmane.org>, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org



On Tuesday 09 August 2016 03:21 PM, Matt Ranostay wrote:
> On Mon, Aug 8, 2016 at 4:05 AM, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org> wrote:
>> It is possible that two or more ADC channels can be simultaneously
>> requested for raw samples, in which case there can be race in access to
>> FIFO data resulting in loss of samples.
>> If am335x_tsc_se_set_once() is called again from tiadc_read_raw(), when
>> ADC is still acquired to sample one of the channels, the second process
>> might be put into uninterruptible sleep state. Fix these issues, by
>> protecting FIFO access and channel configurations with a mutex. Since
>> tiadc_read_raw() might take anywhere between few microseconds to few
>> milliseconds to finish execution (depending on averaging and delay
>> values supplied via DT), its better to use mutex instead of spinlock.
>>
>> Signed-off-by: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
>> ---
>>  drivers/iio/adc/ti_am335x_adc.c | 14 +++++++++++---
>>  1 file changed, 11 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
>> index 8a368756881b..bed9977a1863 100644
>> --- a/drivers/iio/adc/ti_am335x_adc.c
>> +++ b/drivers/iio/adc/ti_am335x_adc.c
>> @@ -32,6 +32,7 @@
>>
>>  struct tiadc_device {
>>         struct ti_tscadc_dev *mfd_tscadc;
>> +       struct mutex fifo1_lock; /* to protect fifo access */
> 
> Are there more than one FIFOs, or even possible? Just wondering the
> number indexing here..

ADC IP as such as two FIFOs: FIFO0 and FIFO1. FIFO0 is dedicated for
touchscreen channels and FIFO1 is used for ADC channels. Its not
possible to use FIFO0 for ADC, but to match h/w register naming, I used
above name for mutex.

-- 
Regards
Vignesh
