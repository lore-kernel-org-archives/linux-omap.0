From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH v3 4/4] memory: emif: add device tree support to emif
 driver
Date: Fri, 29 Jun 2012 16:28:36 -0500
Message-ID: <4FEE1E04.1060600@ti.com>
References: <20120614154820.GG17140@kroah.com> <CAMQu2gx5CCDyrvozX06neBnA8J2heg+HL7DOewDm5voxqbpetw@mail.gmail.com> <CAMQu2gy7oj-+1qCteAFMXEeOL-Wdrs6e4gKWM=HsOukXcPuv-A@mail.gmail.com> <20120625182830.GA23850@kroah.com> <CAMQu2gxDG=69X7UQPUoTLP5h1ZLpHngp=3C4vSDOS6L-N2XZSw@mail.gmail.com> <4FE9467A.2050906@ti.com> <CAMQu2gzOszT54ZU0Z3-9k=mMM7yTCH_MCZV=gRKwGoGRj0zjaA@mail.gmail.com> <4FE947F7.9030000@ti.com> <CAMQu2gwzFV-79CuEAmOHCZ7XivXrALjXkoB+J-QpgJkZ_PoRVg@mail.gmail.com> <CAMQu2gx2RT0iyo+LD1TyTJg9FRSUD8SK2tA=nxAoULzQOa6L7A@mail.gmail.com> <20120629210752.GA13859@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48406 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754494Ab2F2V2k (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Jun 2012 17:28:40 -0400
In-Reply-To: <20120629210752.GA13859@kroah.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, tony@atomide.com, linux-omap@vger.kernel.org, Aneesh V <aneesh@ti.com>, linux-arm-kernel@lists.infradead.org


On 06/29/2012 04:07 PM, Greg Kroah-Hartman wrote:
> On Fri, Jun 29, 2012 at 07:16:19PM +0530, Shilimkar, Santosh wrote:
>> Greg,
>>
>> On Tue, Jun 26, 2012 at 1:19 PM, Shilimkar, Santosh
>> <santosh.shilimkar@ti.com> wrote:
>>>
>>> On Tue, Jun 26, 2012 at 10:56 AM, Rajendra Nayak <rnayak@ti.com> wrote:
>>>> On Tuesday 26 June 2012 10:53 AM, Shilimkar, Santosh wrote:
>>>>>
>>>>> On Tue, Jun 26, 2012 at 10:49 AM, Rajendra Nayak<rnayak@ti.com>  wrote:
>>>>>>
>>>>>> On Tuesday 26 June 2012 10:39 AM, Shilimkar, Santosh wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> +#if defined(CONFIG_OF)
>>>>>>>>>>
>>>>>>>>>>  >    +static const struct of_device_id emif_of_match[] = {
>>>>>>>>>>  >    +             { .compatible = "ti,emif-4d" },
>>>>>>>>>>  >    +             { .compatible = "ti,emif-4d5" },
>>>>>>>>>>  >    +             {},
>>>>>>>>>>  >    +};
>>>>>>>>>>  >    +MODULE_DEVICE_TABLE(of, emif_of_match);
>>>>>>>>>>  >    +#endif
>>>>>>>>>>  >    +
>>>>>>>>>>  >      static struct platform_driver emif_driver = {
>>>>>>>>>>  >           .remove         = __exit_p(emif_remove),
>>>>>>>>>>  >           .shutdown       = emif_shutdown,
>>>>>>>>>>  >           .driver = {
>>>>>>>>>>  >                   .name = "emif",
>>>>>>>>>>  >    +#if defined(CONFIG_OF)
>>>>>>>>>>  >    +             .of_match_table = of_match_ptr(emif_of_match),
>>>>>>>>>>  >    +#endif
>>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>>  Are these two still #if defined needed?
>>>>>>>>>
>>>>>>>>>  Also, what about the IS_DEFINED macro?
>>>>>>>>>
>>>>>>>
>>>>>>> Yes. To avoid the build break in !DT build.
>>>>>>>
>>>>>>
>>>>>> No, infact of_match_ptr is there just so you can avoid a
>>>>>> #ifdef around and not break !CONFIG_OF.
>>>>>
>>>>>
>>>>> Need to recheck but the build was throwing error becasue of
>>>>> "emif_of_match"
>>>>> mostly.
>>>>
>>>>
>>>> You still need the first one. I meant the second one around
>>>> 'of_match_ptr' should be removed.
>>>>
>>>> With !CONFIG_OF, of_match_ptr(_ptr) is just defined as NULL.
>>>>
>>> Yep. That make sense too.
>>> Will drop the second check.
>>>
>> Posted the entire series again with updated $subject patch.
>> With your ack, I will ask Tony to pull this series for 3.6.
> 
> Sent them where?  I didn't see a copy here :(

Hi Greg, should have hit both linux-omap and linux-arm. See:

http://marc.info/?l=linux-omap&m=134097764625471&w=2

Cheers
Jon
