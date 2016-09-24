From: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: Re: [PATCH v3 3/8] drivers:input:tsc2007: add iio interface to read external ADC input, temperature and raw conversion values
Date: Sat, 24 Sep 2016 19:51:01 +0200
Message-ID: <1D1171A5-21D2-4D5D-8182-02CB8DE06564@goldelico.com>
References: <cover.1474634475.git.hns@goldelico.com> <909d06d4f54359c7ac0dcf36a49cbd3ff7e8ebf2.1474634475.git.hns@goldelico.com> <af39fdf1-b6e4-1ab7-9b41-ddb25bfab829@kernel.org> <8A30B517-FE25-418B-9921-407243B0B72B@goldelico.com> <CAKdAkRS3OhUp=WXtrLxQSJAvtgt24jo2W8Nw_NwR4O=R9jboaA@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAKdAkRS3OhUp=WXtrLxQSJAvtgt24jo2W8Nw_NwR4O=R9jboaA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>, =?utf-8?Q?Mika_Penttil=C3=A4?= <mika.penttila-MRsr7dthA9VWk0Htik3J/w@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Discussions
List-Id: linux-omap@vger.kernel.org

Hi Dmitry,

> Am 24.09.2016 um 19:44 schrieb Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> 
> On Sat, Sep 24, 2016 at 10:07 AM, H. Nikolaus Schaller
> <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org> wrote:
>> Hi Jonathan,
>> 
>>> Am 24.09.2016 um 18:07 schrieb Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>:
>>> 
>>> On 23/09/16 13:41, H. Nikolaus Schaller wrote:
>>>> The tsc2007 chip not only has a resistive touch screen controller but
>>>> also an external AUX adc imput which can be used for an ambient
>>>> light sensor, battery voltage monitoring or any general purpose.
>>>> 
>>>> Additionally it can measure the chip temperature.
>>>> 
>>>> This extension provides an iio interface for these adc channels
>>>> in addition to the raw x, y, z values and the estimated touch
>>>> screen resistance. This can be used for debugging or special
>>>> applications.
>>> I'm unconvinced that exposing the touch related channels is terribly
>>> useful.
>> 
>> Mostly for debugging of if someone wants to do a (better) touch detection

s/of/or/

>> in user space.
> 
> For that we should probably export data as a heat map via V4L2
> interface, similarly to what Nick Dyer did for Synaptics and Atmel
> drivers (albeit their heatmap functions are too slow for real
> processing and only suitable for debug/validation).

Sorry for my ignorance, but what is a heat map?
Does it allow to cat /sys/bus/something the raw values?

And why introduce another interface if we already get the iio that
easily reports such values by just adding more channels and some
lines of code?

BR,
Nikolaus
