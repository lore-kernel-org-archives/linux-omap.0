From: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 1/8] drivers:input:tsc2007: add new common binding
 names, pre-calibration, flipping and rotation
Date: Sun, 30 Oct 2016 22:39:21 -0500
Message-ID: <CAL_JsqLhBwb4eJdrAqLLksovcfP1xm9RGTUQKVvF_WxJaMn4WA@mail.gmail.com>
References: <cover.1476712675.git.hns@goldelico.com> <76746b85957c9f3ef7101a7ee883898a414cabd8.1476712675.git.hns@goldelico.com>
 <CAL_JsqJhzZC6Hw3eRLFDiBA8jih=N507WvEh=TRbPhLS9EjhBQ@mail.gmail.com> <3D3CBADC-42F7-4A2B-9D0D-40A0649F79FB@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <3D3CBADC-42F7-4A2B-9D0D-40A0649F79FB-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>, =?UTF-8?Q?Mika_Penttil=C3=A4?= <mika.penttila-MRsr7dthA9VWk0Htik3J/w@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>linux-omap <lin>
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 18, 2016 at 12:27 PM, H. Nikolaus Schaller
<hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org> wrote:
> Hi Rob,
>
>> Am 18.10.2016 um 18:22 schrieb Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>:
>>
>> On Mon, Oct 17, 2016 at 8:57 AM, H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org> wrote:
>>> commit b98abe52fa8e ("Input: add common DT binding for touchscreens")
>>> introduced common DT bindings for touchscreens [1] and a helper function to
>>> parse the DT.
>>>
>>> commit ed7c9870c9bc ("Input: of_touchscreen - add support for inverted / swapped axes")
>>> added another helper for parsing axis inversion and swapping
>>> and applying them to x and y coordinates.
>>>
>>> Both helpers have been integrated to accommodate any orientation of the
>>> touch panel in relation to the LCD.
>>
>> Please add the explanation of why this is a compatible change here.
>
> Can you please describe in more detail what you are missing here?

You stop handling ti,fuzzx for example. So the default driver value
will be used and this is okay because...

Seems like you would have a regression in behavior if the fuzz values
specified in an existing DT are ignored.

> The patch simply makes use of the generic helper function introduced by the
> two patches cited above and is therefore automatically compatible if none of
> the new properties is defined.
>
> The tsc2007 didn't have these features before. So what should we say
> about compatibility?

It certainly had the fuzz features before.


>>> -- ti,max-rt: maximum pressure.
>>> -- ti,fuzzx: specifies the absolute input fuzz x value.
>>> -  If set, it will permit noise in the data up to +- the value given to the fuzz
>>> -  parameter, that is used to filter noise from the event stream.
>>> -- ti,fuzzy: specifies the absolute input fuzz y value.
>>> -- ti,fuzzz: specifies the absolute input fuzz z value.
>>> +- ti,max-rt: maximum pressure resistance above which samples are ignored
>>> +  (default: 4095).
>>> +- ti,report-resistance: report resistance (no pressure = max_rt) instead
>>> +  of pressure (no pressure = 0).
>>> +- ti,min-x: minimum value reported by X axis ADC (default 0).
>>> +- ti,max-x: maximum value reported by X axis ADC (default 4095).
>>> +- ti,min-y: minimum value reported by Y axis ADC (default 0).
>>> +- ti,max-y: maximum value reported by Y axis ADC (default 4095).
>>
>> I thought these were going to be common? I think they should be.
>
> Yes, we had discussed that before.
>
> In a second thought, I found that they are not even existing for the different
> touch chip drivers that are around. And some chip might not need them (because
> e.g. min/max are constants or defined my means outside the DT or the chip itself
> can store them in NV memory).
>
> And, since they define ADC raw-values, they are very closely related to the
> individual chip, so that I am not sure if it is really necessary to make
> them common. At least if they are properly documented in the bindings for
> the specific chip they can have different names without disturbing each
> other.

They wouldn't disturb each other, but then there is no chance to have
common parsing either.

> So I think it is perfectly reasonable to define common bindings towards
> the input event layer (e.g. size, fuzz, swapping, inversion) and support
> them by common code which bakes raw coordinates into input events. The latest
> helper functions already do most of that fully automatic.

I could argue that size in pixels has no business being in DT. That's
a property of the panel the touchscreen is glued to. I guess in some
cases, the controller is internally scaling the ADC values.

> Next, I had simply copied them from the ads7846 driver where they
> exist for a long time. So this is sort of "common", at least for two different
> chips now. See also patch 6/8 of this series which adds the common properties
> to the ads7846 as well.
>
> For more reference about the existing bindings:
>
> Documentation/devicetree/bindings/input/ads7846.txt
>
> (btw I think someone should move them to bindings/input/touchscreen).

Patches welcome.

> It appears as if there is some overlap of the new generic properties (for x/y
> swapping) with the old ads7846 properties, but that is something you had
> already proposed a while ago to make me the driver recognize both properties to
> stay compatible with older DT files.
>
> So if we now rename the min/max-x/y properties for the tsc2007 we have to rename
> them for the ads7846 (and maybe others) as well, which might break out-of-tree
> ads7846 devices or leads to more complex code for handling of property aliases.

We don't have to rename them for ads7846. That's already baked. But
there's a trend here. You're defining the same property. Use a common
name, so when the 3rd binding comes along needing the same thing, we
already have a common binding. If we're catching this on only the 2nd
binding, we're doing pretty good.

Rob
