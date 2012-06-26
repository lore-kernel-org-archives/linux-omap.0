From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH v3 4/4] memory: emif: add device tree support to emif
 driver
Date: Tue, 26 Jun 2012 10:56:15 +0530
Message-ID: <4FE947F7.9030000@ti.com>
References: <1339669764-27244-1-git-send-email-santosh.shilimkar@ti.com> <1339669764-27244-5-git-send-email-santosh.shilimkar@ti.com> <20120614154820.GG17140@kroah.com> <CAMQu2gx5CCDyrvozX06neBnA8J2heg+HL7DOewDm5voxqbpetw@mail.gmail.com> <CAMQu2gy7oj-+1qCteAFMXEeOL-Wdrs6e4gKWM=HsOukXcPuv-A@mail.gmail.com> <20120625182830.GA23850@kroah.com> <CAMQu2gxDG=69X7UQPUoTLP5h1ZLpHngp=3C4vSDOS6L-N2XZSw@mail.gmail.com> <4FE9467A.2050906@ti.com> <CAMQu2gzOszT54ZU0Z3-9k=mMM7yTCH_MCZV=gRKwGoGRj0zjaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog131.obsmtp.com ([74.125.149.247]:35547 "EHLO
	na3sys009aog131.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756333Ab2FZF0W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Jun 2012 01:26:22 -0400
Received: by obbeh20 with SMTP id eh20so7333878obb.38
        for <linux-omap@vger.kernel.org>; Mon, 25 Jun 2012 22:26:21 -0700 (PDT)
In-Reply-To: <CAMQu2gzOszT54ZU0Z3-9k=mMM7yTCH_MCZV=gRKwGoGRj0zjaA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, tony@atomide.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Aneesh V <aneesh@ti.com>

On Tuesday 26 June 2012 10:53 AM, Shilimkar, Santosh wrote:
> On Tue, Jun 26, 2012 at 10:49 AM, Rajendra Nayak<rnayak@ti.com>  wrote:
>> On Tuesday 26 June 2012 10:39 AM, Shilimkar, Santosh wrote:
>>>>>
>>>>> +#if defined(CONFIG_OF)
>>>>>>   >    +static const struct of_device_id emif_of_match[] = {
>>>>>>   >    +             { .compatible = "ti,emif-4d" },
>>>>>>   >    +             { .compatible = "ti,emif-4d5" },
>>>>>>   >    +             {},
>>>>>>   >    +};
>>>>>>   >    +MODULE_DEVICE_TABLE(of, emif_of_match);
>>>>>>   >    +#endif
>>>>>>   >    +
>>>>>>   >      static struct platform_driver emif_driver = {
>>>>>>   >           .remove         = __exit_p(emif_remove),
>>>>>>   >           .shutdown       = emif_shutdown,
>>>>>>   >           .driver = {
>>>>>>   >                   .name = "emif",
>>>>>>   >    +#if defined(CONFIG_OF)
>>>>>>   >    +             .of_match_table = of_match_ptr(emif_of_match),
>>>>>>   >    +#endif
>>>>
>>>>>
>>>>>   Are these two still #if defined needed?
>>>>>
>>>>>   Also, what about the IS_DEFINED macro?
>>>>>
>>>
>>> Yes. To avoid the build break in !DT build.
>>>
>>
>> No, infact of_match_ptr is there just so you can avoid a
>> #ifdef around and not break !CONFIG_OF.
>
> Need to recheck but the build was throwing error becasue of "emif_of_match"
> mostly.

You still need the first one. I meant the second one around
'of_match_ptr' should be removed.

With !CONFIG_OF, of_match_ptr(_ptr) is just defined as NULL.

> Regards
> Santosh

