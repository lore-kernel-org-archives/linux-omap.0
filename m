From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: Re: [PATCH 1/3] ti_adc: Update with IIO map interface
Date: Wed, 31 Oct 2012 20:10:44 +0100
Message-ID: <509177B4.6010405@metafoo.de>
References: <1351783496-11557-1-git-send-email-panto@antoniou-consulting.com> <50916563.8080704@metafoo.de> <F29A4A48-CDFA-4058-BED1-C09242B23326@antoniou-consulting.com> <509168EF.9040000@metafoo.de> <C105B6BF-8407-4484-826A-A979E16B6B44@antoniou-consulting.com> <50916FA2.2000802@metafoo.de> <67596D26-26EC-483A-A83A-8A7F43BDE466@antoniou-consulting.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <67596D26-26EC-483A-A83A-8A7F43BDE466-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
Cc: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, "Patil, Rachna" <rachna-l0cyMroinI0@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>, Matt Porter <mporter-l0cyMroinI0@public.gmane.org>, Russ Dill <Russ.Dill-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 10/31/2012 07:43 PM, Pantelis Antoniou wrote:
> 
> On Oct 31, 2012, at 8:36 PM, Lars-Peter Clausen wrote:
> 
>> On 10/31/2012 07:12 PM, Pantelis Antoniou wrote:
>>>
>>> On Oct 31, 2012, at 8:07 PM, Lars-Peter Clausen wrote:
>>>
>>>> On 10/31/2012 06:55 PM, Pantelis Antoniou wrote:
>>>>> [...]
>>>>>>> 	}
>>>>>>>
>>>>>>> 	indio_dev->channels = chan_array;
>>>>>>> +	indio_dev->num_channels = channels;
>>>>>>> +
>>>>>>> +	size = (channels + 1) * sizeof(struct iio_map);
>>>>>>> +	adc_dev->map = kzalloc(size, GFP_KERNEL);
>>>>>>> +	if (adc_dev->map == NULL) {
>>>>>>> +		kfree(chan_array);
>>>>>>> +		return -ENOMEM;
>>>>>>> +	}
>>>>>>> +
>>>>>>> +	for (i = 0; i < indio_dev->num_channels; i++) {
>>>>>>> +		adc_dev->map[i].adc_channel_label = chan_array[i].datasheet_name;
>>>>>>> +		adc_dev->map[i].consumer_dev_name = "any";
>>>>>>> +		adc_dev->map[i].consumer_channel = chan_array[i].datasheet_name;
>>>>>>> +	}
>>>>>>> +	adc_dev->map[i].adc_channel_label = NULL;
>>>>>>> +	adc_dev->map[i].consumer_dev_name = NULL;
>>>>>>> +	adc_dev->map[i].consumer_channel = NULL;
>>>>>>
>>>>>> The map should be passed in via platform data or similar. All the fields of
>>>>>> the map depend on the specific user, so you can't use a generic map. In fact
>>>>>> if we were able to use a generic map, we wouldn't need a map at all.
>>>>>
>>>>> There's no platform data in the board I'm using. It's board-generic using
>>>>> device tree only.
>>>>
>>>> That's the 'or similar' ;) Unfortunately we do not have a device tree
>>>> binding for IIO yet. But I think we should aim at a interface similar like
>>>> we have in other subsystems like the clk, regulator or dma framework.
>>>>
>>>> - Lars
>>>
>>> So in the meantime no-one can use IIO ADC in any OF only platform.
>>
>> Yes, nobody can use it until somebody implements it. So far nobody needed
>> it, so that's why it hasn't been implemented yet. The whole in kernel
>> consumer API for IIO is still very young and only a very few drivers support
>> it yet.
>>
>>>
>>> In the meantime, this is pretty reasonable IMO. This is only for a specific 
>>> board with known channel mappings.
>>
>> Unfortunately it is not. It is adding a device specific hack to a generic
>> driver and it is also completely misusing the API.
>>
>>>
>>> I'm not out to fix IIO, I'm out to fix a single board.
>>>
>>
>> It's not about fixing IIO, it's about extending IIO to be able to serve your
>> needs. See, the issue is if everybody would work around the lack of DT
>> bindings we'll never have DT bindings for IIO, so the right thing to do is
>> to implement them instead of working around the lack of.
>>
>> - Lars
> 
> OK, OK,
> 

ok :)

> I see the point. It's just that I'm under the gun for more pressing matters ATM.
> Can at least get a small write-up about how the bindings should look like?
> 
> There's absolutely nothing, not even a hint of one out there in the intertubes,
> on how the channel mapping should look like.

Again, that's because nobody probably has given this much though yet. As I said
the in-kernel consumer framework is still young and so far only a tiny fraction
of the drivers support it. If you want to I can try to give this some though
and come up with a small proof of concept, but this would have to wait until
next week, since I have a few other things on my desk as well.

I think a good start might be to take a closer look at the clk dt bindings
(Documentation/devicetree/bindings/clock/clock-bindings.txt).

- Lars
