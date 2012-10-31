From: Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
Subject: Re: [PATCH 1/3] ti_adc: Update with IIO map interface
Date: Wed, 31 Oct 2012 20:12:40 +0200
Message-ID: <C105B6BF-8407-4484-826A-A979E16B6B44@antoniou-consulting.com>
References: <1351783496-11557-1-git-send-email-panto@antoniou-consulting.com> <50916563.8080704@metafoo.de> <F29A4A48-CDFA-4058-BED1-C09242B23326@antoniou-consulting.com> <509168EF.9040000@metafoo.de>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <509168EF.9040000-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Cc: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, "Patil, Rachna" <rachna-l0cyMroinI0@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>, Matt Porter <mporter-l0cyMroinI0@public.gmane.org>, Russ Dill <Russ.Dill-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


On Oct 31, 2012, at 8:07 PM, Lars-Peter Clausen wrote:

> On 10/31/2012 06:55 PM, Pantelis Antoniou wrote:
>> [...]
>>>> 	}
>>>> 
>>>> 	indio_dev->channels = chan_array;
>>>> +	indio_dev->num_channels = channels;
>>>> +
>>>> +	size = (channels + 1) * sizeof(struct iio_map);
>>>> +	adc_dev->map = kzalloc(size, GFP_KERNEL);
>>>> +	if (adc_dev->map == NULL) {
>>>> +		kfree(chan_array);
>>>> +		return -ENOMEM;
>>>> +	}
>>>> +
>>>> +	for (i = 0; i < indio_dev->num_channels; i++) {
>>>> +		adc_dev->map[i].adc_channel_label = chan_array[i].datasheet_name;
>>>> +		adc_dev->map[i].consumer_dev_name = "any";
>>>> +		adc_dev->map[i].consumer_channel = chan_array[i].datasheet_name;
>>>> +	}
>>>> +	adc_dev->map[i].adc_channel_label = NULL;
>>>> +	adc_dev->map[i].consumer_dev_name = NULL;
>>>> +	adc_dev->map[i].consumer_channel = NULL;
>>> 
>>> The map should be passed in via platform data or similar. All the fields of
>>> the map depend on the specific user, so you can't use a generic map. In fact
>>> if we were able to use a generic map, we wouldn't need a map at all.
>> 
>> There's no platform data in the board I'm using. It's board-generic using
>> device tree only.
> 
> That's the 'or similar' ;) Unfortunately we do not have a device tree
> binding for IIO yet. But I think we should aim at a interface similar like
> we have in other subsystems like the clk, regulator or dma framework.
> 
> - Lars

So in the meantime no-one can use IIO ADC in any OF only platform.

In the meantime, this is pretty reasonable IMO. This is only for a specific 
board with known channel mappings.

I'm not out to fix IIO, I'm out to fix a single board.

Regards

-- Pantelis --
To unsubscribe from this list: send the line "unsubscribe linux-iio" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
