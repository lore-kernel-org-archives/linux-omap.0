From: "Dr. H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: Re: twl6030-gpadc support for twl6037
Date: Wed, 22 Jul 2015 22:12:23 +0200
Message-ID: <DEFD67FD-1E05-4968-989B-73D9277C178A@goldelico.com>
References: <CAAfyv354=J+iDgLcu9KRZSScGSzYrRsCMmUEc_tW84GfduSebw@mail.gmail.com> <CAAfyv35bUMZKfMQDJYwD_uGRNOiqLqAB4UG=gREgCSWa8vhjdw@mail.gmail.com> <1437593628.2381718.330572297.2F6F1C50@webmail.messagingengine.com> <1437594062.2382998.330577153.4CE28783@webmail.messagingengine.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1437594062.2382998.330577153.4CE28783-2RFepEojUI2N1INw9kWLP6GC3tUn3ZHUQQ4Iyu8u01E@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Graeme Gregory <gg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org>
Cc: Belisko Marek <marek.belisko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balajitk-l0cyMroinI0@public.gmane.org, oleksandr.kozaruk-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org


Am 22.07.2015 um 21:41 schrieb Graeme Gregory <gg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org>:

> 
> 
> On Wed, 22 Jul 2015, at 08:33 PM, Graeme Gregory wrote:
>> 
>> 
>> On Wed, 22 Jul 2015, at 08:28 PM, Belisko Marek wrote:
>>> Adding also twl6030-gpadc driver authors to loop
>>> 
>>> On Mon, Jul 20, 2015 at 8:57 AM, Belisko Marek <marek.belisko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>> wrote:
>>>> Hi all,
>>>> 
>>>> I'm trying to figure out what is relation between palmas mfd driver
>>>> and twl-core for twl603x devices.
>>>> twl-core driver seems to be older than palmas driver but seems both
>>>> export same functionality (except that palmas have defined structs for
>>>> gpadc but functionality is missing). My main focus is to add support
>>>> for twl6037 to gpadc iio driver in iio/adc/twl6030-gpadc which is
>>>> using twl-core for twl6030 and twl6032. Adding twl6037 support should
>>>> be straightforward but dts file used in omap5-uevm using palmas driver
>>>> and not twl6030. So it's completely confusing to me how to proceed or
>>>> which direction is correct. Seems I'm missing some parts of puzzle ;)
>>>> Thanks for any hints.
>>>> 
>> Phoenix is twl6030, twl6032
>> 
>> Palmas is twl6035, twl6037 and maybe others.
>> 
>> Phoenix and Palmas are two totally different chips but marketing gave
>> them numbers near each other for unknown reasons.
>> 
> Also this might be useful.
> 
> https://github.com/slimlogic/linux/commit/312a6a1c8013fd056431c31567b43d8eef40f333

That is basically what we are looking for.

We will give it a try asap and let you know results.

> 
> A pre IIO palmas ADC driver which I never got around to upstreaming

Well, unless it already exists somewhere, it should be converterd to iio by updating the
driver structure to follow iio/adc/twl6030-gpadc.

> because TIpocalypse left me with no access to a palmas chip.

The OMAP5432EVM by SVtronics [1] comes with a twl6037 (and it is
supported by mainline device tree omap5-uevm.dts). And we hope
that the pyra-handheld.com hardware is finished soon. For hardware
bring-up it would be good to already have the gpadc available - so
we have some hen-and-egg situation here.

BR and thanks,
Nikolaus

[1]: http://www.svtronics.com/5432
