From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/3] ti_adc: Update with IIO map interface
Date: Wed, 31 Oct 2012 19:07:43 +0100
Message-ID: <509168EF.9040000@metafoo.de>
References: <1351783496-11557-1-git-send-email-panto@antoniou-consulting.com> <50916563.8080704@metafoo.de> <F29A4A48-CDFA-4058-BED1-C09242B23326@antoniou-consulting.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <F29A4A48-CDFA-4058-BED1-C09242B23326@antoniou-consulting.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pantelis Antoniou <panto@antoniou-consulting.com>
Cc: Jonathan Cameron <jic23@cam.ac.uk>, "Patil, Rachna" <rachna@ti.com>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Koen Kooi <koen@dominion.thruhere.net>, Matt Porter <mporter@ti.com>, Russ Dill <Russ.Dill@ti.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 10/31/2012 06:55 PM, Pantelis Antoniou wrote:
> [...]
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

That's the 'or similar' ;) Unfortunately we do not have a device tree
binding for IIO yet. But I think we should aim at a interface similar like
we have in other subsystems like the clk, regulator or dma framework.

- Lars
