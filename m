From: "Porter, Matt" <mporter-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/3] ti_adc: Update with IIO map interface
Date: Wed, 31 Oct 2012 18:16:18 +0000
Message-ID: <0D509040-2DC5-46BF-B782-96B5B7B2620B@ti.com>
References: <1351783496-11557-1-git-send-email-panto@antoniou-consulting.com>
 <50916563.8080704@metafoo.de>
 <F29A4A48-CDFA-4058-BED1-C09242B23326@antoniou-consulting.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <F29A4A48-CDFA-4058-BED1-C09242B23326-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
Content-Language: en-US
Content-ID: <18773C2E86EA5A4FBE71C1F0C2878288-q8tqbTl1AnqmHdYHvhjUOg@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
Cc: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, "Patil, Rachna" <rachna-l0cyMroinI0@public.gmane.org>, "<linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "<linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>, "Dill, Russ" <russ.dill-l0cyMroinI0@public.gmane.org>, "<linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


On Oct 31, 2012, at 1:55 PM, Pantelis Antoniou wrote:

> 
> On Oct 31, 2012, at 7:52 PM, Lars-Peter Clausen wrote:
> 
>> On 11/01/2012 04:24 PM, Pantelis Antoniou wrote:
>>> Add an IIO map interface that consumers can use.
>> 
>> Hi,
>> 
>> Looks like you overlooked the review comments I had inline last time. I've
>> put them in again, see below.
>> 
>>> 
>>> Signed-off-by: Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
>>> ---
>>> drivers/iio/adc/ti_am335x_adc.c | 60 +++++++++++++++++++++++++++++++++--------
>>> 1 file changed, 49 insertions(+), 11 deletions(-)
>>> 
>>> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
>>> index 02a43c8..8595a90 100644
>>> --- a/drivers/iio/adc/ti_am335x_adc.c
>>> +++ b/drivers/iio/adc/ti_am335x_adc.c
>>> @@ -20,8 +20,9 @@
>>> #include <linux/slab.h>
>>> #include <linux/interrupt.h>
>>> #include <linux/platform_device.h>
>>> -#include <linux/io.h>
>>> #include <linux/iio/iio.h>
>>> +#include <linux/iio/machine.h>
>>> +#include <linux/iio/driver.h>
>>> 
>>> #include <linux/mfd/ti_am335x_tscadc.h>
>>> #include <linux/platform_data/ti_am335x_adc.h>
>>> @@ -29,6 +30,8 @@
>>> struct tiadc_device {
>>> 	struct ti_tscadc_dev *mfd_tscadc;
>>> 	int channels;
>>> +	char *buf;
>> 
>> buf doesn't seem to be used anywhere
>> 
> 
> Duh
> 
>>> +	struct iio_map *map;
>>> };
>>> 
>>> static unsigned int tiadc_readl(struct tiadc_device *adc, unsigned int reg)
>>> @@ -72,27 +75,62 @@ static void tiadc_step_config(struct tiadc_device *adc_dev)
>>> 	tiadc_writel(adc_dev, REG_SE, STPENB_STEPENB);
>>> }
>>> 
>>> -static int tiadc_channel_init(struct iio_dev *indio_dev, int channels)
>>> +static int tiadc_channel_init(struct iio_dev *indio_dev,
>>> +		struct tiadc_device *adc_dev)
>>> {
>>> 	struct iio_chan_spec *chan_array;
>>> -	int i;
>>> -
>>> -	indio_dev->num_channels = channels;
>>> -	chan_array = kcalloc(indio_dev->num_channels,
>>> -			sizeof(struct iio_chan_spec), GFP_KERNEL);
>>> +	struct iio_chan_spec *chan;
>>> +	char *s;
>>> +	int i, len, size, ret;
>>> +	int channels = adc_dev->channels;
>>> 
>>> +	size = channels * (sizeof(struct iio_chan_spec) + 6);
>>> +	chan_array = kzalloc(size, GFP_KERNEL);
>>> 	if (chan_array == NULL)
>>> 		return -ENOMEM;
>>> 
>>> -	for (i = 0; i < (indio_dev->num_channels); i++) {
>>> -		struct iio_chan_spec *chan = chan_array + i;
>>> +	/* buffer space is after the array */
>>> +	s = (char *)(chan_array + channels);
>>> +	chan = chan_array;
>>> +	for (i = 0; i < channels; i++, chan++, s += len + 1) {
>>> +
>>> +		len = sprintf(s, "AIN%d", i);
>>> +
>>> 		chan->type = IIO_VOLTAGE;
>>> 		chan->indexed = 1;
>>> 		chan->channel = i;
>>> -		chan->info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT;
>>> +		chan->datasheet_name = s;
>>> +		chan->scan_type.sign = 'u';
>>> +		chan->scan_type.realbits = 12;
>>> +		chan->scan_type.storagebits = 32;
>>> +		chan->scan_type.shift = 0;
>> 
>> The scan type assignment should go in a separate patch if possible.
> 
> ok.
> 
>> 
>>> 	}
>>> 
>>> 	indio_dev->channels = chan_array;
>>> +	indio_dev->num_channels = channels;
>>> +
>>> +	size = (channels + 1) * sizeof(struct iio_map);
>>> +	adc_dev->map = kzalloc(size, GFP_KERNEL);
>>> +	if (adc_dev->map == NULL) {
>>> +		kfree(chan_array);
>>> +		return -ENOMEM;
>>> +	}
>>> +
>>> +	for (i = 0; i < indio_dev->num_channels; i++) {
>>> +		adc_dev->map[i].adc_channel_label = chan_array[i].datasheet_name;
>>> +		adc_dev->map[i].consumer_dev_name = "any";
>>> +		adc_dev->map[i].consumer_channel = chan_array[i].datasheet_name;
>>> +	}
>>> +	adc_dev->map[i].adc_channel_label = NULL;
>>> +	adc_dev->map[i].consumer_dev_name = NULL;
>>> +	adc_dev->map[i].consumer_channel = NULL;
>> 
>> The map should be passed in via platform data or similar. All the fields of
>> the map depend on the specific user, so you can't use a generic map. In fact
>> if we were able to use a generic map, we wouldn't need a map at all.
> 
> There's no platform data in the board I'm using. It's board-generic using
> device tree only.

How about a DT binding for the map?

-Matt--
To unsubscribe from this list: send the line "unsubscribe linux-iio" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
