From: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 0/3] increase TSCADC clock to 24MHz and fix
 ti,charge-delay to represent in nS
Date: Mon, 5 Dec 2016 09:24:57 +0530
Message-ID: <bed2095b-9a1b-3740-6f57-f2766ad65cde@ti.com>
References: <20161110163515.27598-1-mugunthanvnm@ti.com>
 <71482721-fd60-65b2-d601-f1698ce5fa0a@ti.com>
 <20161125095918.GZ10134@dell.home>
 <8b97b7e6-1ea4-bf13-7da5-55135a994231@ti.com>
 <20161129210949.GB20680@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161129210949.GB20680@dtor-ws>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Lee Jones

On Wednesday 30 November 2016 02:39 AM, Dmitry Torokhov wrote:
> On Tue, Nov 29, 2016 at 11:11:35AM +0530, Mugunthan V N wrote:
>> On Friday 25 November 2016 03:29 PM, Lee Jones wrote:
>>> On Fri, 25 Nov 2016, Mugunthan V N wrote:
>>>
>>>> Hi Dmitry Torokhov,
>>>>
>>>> On Thursday 10 November 2016 10:05 PM, Mugunthan V N wrote:
>>>>> This patch series enables ADC to be clocked at 24MHz as the
>>>>> TI AM335x ADC driver has already adopted to use DMA to transfer
>>>>> ADC samples. Now ADC can generated upto 800K Samples per second
>>>>> with the patch [1] on AM335x BBB and AM437x GP EVM.
>>>>>
>>>>> when ADC ref clock is set at 24MHz, I am seeing some issue with
>>>>> touch screen pointer as the pointer jumps to random locations
>>>>> with free draw application. The issue is due to increase in ADC
>>>>> clock and charge delay for the touchscreen ADC line duration
>>>>> reduced.
>>>>>
>>>>> So the notation of ti,charge-delay in terms of ADC clock is
>>>>> wrong, it has to be represented in time and driver has to convert
>>>>> the charge delay time to ADC clocks based on what ADC clock
>>>>> frequency is set.
>>>>>
>>>>> Measured the performance with the iio_generic_buffer with the
>>>>> patch [2] applied
>>>>>
>>>>> Verified the touch screen on AM335x GP EVM and AM335x BBB LCD7
>>>>> cape with [3] dts for display and touch screen to work.
>>>>>
>>>>
>>>> Since there are acks from DT and MFD maintainers, can you pull the patch
>>>> series if you do not have any more comments.
>>>
>>> Cant do anything without *all* Acks.
>>>
>> Hi Dmitry Torokhov,
>>
>> Can you provide your inputs on the patch series.
> 
> You have my ack for the input bit.
> 

A gentle ping

Regards
Mugunthan V N
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
