From: Graeme Gregory <gg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org>
Subject: Re: gpadc iio support for tlw6037/palmas [was: twl6030-gpadc support for
 twl6037]
Date: Thu, 23 Jul 2015 14:12:49 +0100
Message-ID: <1437657169.3419965.331206849.51D66A2E@webmail.messagingengine.com>
References: <CAAfyv354=J+iDgLcu9KRZSScGSzYrRsCMmUEc_tW84GfduSebw@mail.gmail.com>
 <CAAfyv35bUMZKfMQDJYwD_uGRNOiqLqAB4UG=gREgCSWa8vhjdw@mail.gmail.com>
 <1437593628.2381718.330572297.2F6F1C50@webmail.messagingengine.com>
 <1437594062.2382998.330577153.4CE28783@webmail.messagingengine.com>
 <CB1BA4C2-51EC-493D-A290-E506DE974605@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CB1BA4C2-51EC-493D-A290-E506DE974605-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Dr. H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Belisko Marek <marek.belisko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, balajitk-l0cyMroinI0@public.gmane.org, oleksandr.kozaruk-l0cyMroinI0@public.gmane.org, Michael Mrozek <EvilDragon-in7WBhxDdJqvTmjiLVyRpw@public.gmane.org>, Grazvydas Ignotas <notaz-in7WBhxDdJqvTmjiLVyRpw@public.gmane.org>
List-Id: linux-omap@vger.kernel.org



On Thu, 23 Jul 2015, at 01:58 PM, Dr. H. Nikolaus Schaller wrote:
> Hi Graeme,
> 
> Am 22.07.2015 um 21:41 schrieb Graeme Gregory <gg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org>:
> 
> > 
> > 
> > On Wed, 22 Jul 2015, at 08:33 PM, Graeme Gregory wrote:
> >> 
> >> 
> >> On Wed, 22 Jul 2015, at 08:28 PM, Belisko Marek wrote:
> >>> Adding also twl6030-gpadc driver authors to loop
> >>> 
> >>> On Mon, Jul 20, 2015 at 8:57 AM, Belisko Marek <marek.belisko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >>> wrote:
> >>>> Hi all,
> >>>> 
> >>>> I'm trying to figure out what is relation between palmas mfd driver
> >>>> and twl-core for twl603x devices.
> >>>> twl-core driver seems to be older than palmas driver but seems both
> >>>> export same functionality (except that palmas have defined structs for
> >>>> gpadc but functionality is missing). My main focus is to add support
> >>>> for twl6037 to gpadc iio driver in iio/adc/twl6030-gpadc which is
> >>>> using twl-core for twl6030 and twl6032. Adding twl6037 support should
> >>>> be straightforward but dts file used in omap5-uevm using palmas driver
> >>>> and not twl6030. So it's completely confusing to me how to proceed or
> >>>> which direction is correct. Seems I'm missing some parts of puzzle ;)
> >>>> Thanks for any hints.
> >>>> 
> >> Phoenix is twl6030, twl6032
> >> 
> >> Palmas is twl6035, twl6037 and maybe others.
> >> 
> >> Phoenix and Palmas are two totally different chips but marketing gave
> >> them numbers near each other for unknown reasons.
> >> 
> > Also this might be useful.
> > 
> > https://github.com/slimlogic/linux/commit/312a6a1c8013fd056431c31567b43d8eef40f333
> > 
> > A pre IIO palmas ADC driver which I never got around to upstreaming
> > because TIpocalypse left me with no access to a palmas chip.
> 
> We managed to integrate your code into our 4.1 kernel (needed minor fixes
> mainly for
> irq initialization) and it appears to work on the omap5432evm. Especially
> channels
> in6_channel and in7_channel in
> /sys/bus/platform/drivers/palmas-gpadc/48070000.i2c:palmas@48:gpadc
> show reasonable (and slightly fluctuating) volt values.
> 
> Now the question is how to proceed. We could either write some
> drivers/iio/adc/palmas-gpadc.c
> wrapper around your driver, or could try this one which appears to be a
> pure iio implementation:
>
Pure IIO is better, one of the reasons my driver never got sent upstream
is I knew IIO was due "real soon now" but I lost access to the chip and
documentation before IIO landed in the kernel.
 
> https://android.googlesource.com/kernel/tegra.git/+/28f245bb8f590f61bb244f1b4d03f4b4919d32ea/Documentation/devicetree/bindings/iio/adc/palmas-gpadc.txt
> https://android.googlesource.com/kernel/tegra/+/aaabb2e045f31e5a970109ffdaae900dd403d17e/drivers/staging/iio/adc/palmas_gpadc.c
> 
> Do you think the latter has a chance to be accepted upstream?
> 
I see nothing with a quick scan that looks controversial.

> The reason we ask is that we neither want to write new code if something
> exists nor base
> our work on something that can not be upstreamed.
>
I would base your product on the nvidia driver and if they are not
planning to upstream then submit yourself.
 
Graeme
