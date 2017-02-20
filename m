From: Petr Cvek <petr.cvek-qphu/3gb4gc@public.gmane.org>
Subject: Re: [PATCH v9 1/8] drivers:input:tsc2007: add new common binding
 names, pre-calibration, flipping and rotation
Date: Mon, 20 Feb 2017 23:26:59 +0100
Message-ID: <e3dd020e-8590-6e65-9151-b5f1492debcb@tul.cz>
References: <20170218225435.GA4693@amd>
 <CC600A84-A5C8-4A8C-8CF4-B54C57DF73F3@goldelico.com>
 <20170219141715.GA7159@amd>
 <05F3816F-46E6-4BC2-9E2E-F20E645F7197@goldelico.com>
 <20170219171518.GA12833@amd>
 <B41253A6-95D5-4E0F-ABD6-6909362843C4@goldelico.com>
 <20170219190547.GA17292@amd>
 <EB41EEED-0D94-473F-944F-757B25350A4C@goldelico.com>
 <20170219205708.GA9641@amd>
 <6DF7B03A-8B63-422C-9561-69A34A7FBF35@goldelico.com>
 <20170219221930.GA1568@amd>
 <6610D852-4717-47A7-BFDE-52C8E9E614BB@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <6610D852-4717-47A7-BFDE-52C8E9E614BB-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>, =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila-MRsr7dthA9VWk0Htik3J/w@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>, Eric Engestrom <eric-op+oiCINJLTt9jDmeYuA0g@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Benjamin Tissoires <benjam>
List-Id: linux-omap@vger.kernel.org

Hi

Dne 20.2.2017 v 17:50 H. Nikolaus Schaller napsal(a):
> Hi Pavel,
> 
>> Am 19.02.2017 um 23:19 schrieb Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>:
>>
>> hi!
>>
>>>>> But as said I don't think we need float or fixed point for practical systems
>>>>> at all.
>>>>
>>>> So you are going to loose precision. And if userspace decides to
>>>> calibrate it slightly differently from kernel, lost precision will
>>>> matter.
>>>
>>> Really?
>>
>> Really.
>>
>>> Example:
>>>
>>> ADC values go 100 .. 3995 (i.e. touch margin is 100 steps in pre-calibration)
>>>
>>> This is scaled to let's say 0..640.
>>
>> Ok. Now userspace realizes that kernel alignemnt is off, and it would
>> want to scale it to 1..642.
> 
> Screen coordinates are still 0..639.
> 
>> That will mean that single pixel will be
>> inaccessible, right?
> 
> Yes, that can happen if the additional user-space scale is > 1.0.
> 
> As long as it is small (I expect <1.01 = 1% error in scale) it is
> barely noticeable.
> 
> Therefore, I asked before: how big in pixels is your finger or stylus?
> Does this effect matter?
> 
> A resistive touch is a man-machine-interface where people press buttons of at
> least 12x12 pixels size (or they are no longer visually recognizable).

Smallest kernel font is 4x6 (i think) and I'm regularly using 8x8. I would like
to be able to select a single letter in the console.

cheers,
Petr
