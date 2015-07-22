From: Graeme Gregory <gg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org>
Subject: Re: twl6030-gpadc support for twl6037
Date: Wed, 22 Jul 2015 20:33:48 +0100
Message-ID: <1437593628.2381718.330572297.2F6F1C50@webmail.messagingengine.com>
References: <CAAfyv354=J+iDgLcu9KRZSScGSzYrRsCMmUEc_tW84GfduSebw@mail.gmail.com>
 <CAAfyv35bUMZKfMQDJYwD_uGRNOiqLqAB4UG=gREgCSWa8vhjdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAAfyv35bUMZKfMQDJYwD_uGRNOiqLqAB4UG=gREgCSWa8vhjdw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Belisko Marek <marek.belisko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Dr. H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, balajitk-l0cyMroinI0@public.gmane.org, oleksandr.kozaruk-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org



On Wed, 22 Jul 2015, at 08:28 PM, Belisko Marek wrote:
> Adding also twl6030-gpadc driver authors to loop
> 
> On Mon, Jul 20, 2015 at 8:57 AM, Belisko Marek <marek.belisko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> wrote:
> > Hi all,
> >
> > I'm trying to figure out what is relation between palmas mfd driver
> > and twl-core for twl603x devices.
> > twl-core driver seems to be older than palmas driver but seems both
> > export same functionality (except that palmas have defined structs for
> > gpadc but functionality is missing). My main focus is to add support
> > for twl6037 to gpadc iio driver in iio/adc/twl6030-gpadc which is
> > using twl-core for twl6030 and twl6032. Adding twl6037 support should
> > be straightforward but dts file used in omap5-uevm using palmas driver
> > and not twl6030. So it's completely confusing to me how to proceed or
> > which direction is correct. Seems I'm missing some parts of puzzle ;)
> > Thanks for any hints.
> >
Phoenix is twl6030, twl6032

Palmas is twl6035, twl6037 and maybe others.

Phoenix and Palmas are two totally different chips but marketing gave
them numbers near each other for unknown reasons.

Graeme
