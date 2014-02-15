From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 0/6] IIO pulse capture support for TI ECAP
Date: Sat, 15 Feb 2014 11:48:25 +0000
Message-ID: <52FF5409.8050903@kernel.org>
References: <1391626901-31684-1-git-send-email-mporter@linaro.org> <52F29DBD.9050305@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <52F29DBD.9050305-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, Matt Porter <mporter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Devicetree List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux PWM List <linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux IIO List <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 05/02/14 20:23, Sergei Shtylyov wrote:
> Hello.
>
> On 02/05/2014 10:01 PM, Matt Porter wrote:
>
> [...]
>
>> This series adds support for PWM capture devices within IIO and
>> adds a TI ECAP IIO driver.
>
>> PWM capture devices are supported using a new IIO "pulse" channel type.
>
>> The IIO ECAP driver implements interrupt driven triggered buffer capture
>> only as raw sample reads are not applicable to this hardware.
>> Initially, the driver supports a single pulse width measurement with
>> configurable polarity. The ECAP hardware can support measurement of a
>> complete period and duty cycle but this is not yet implemented.
>

> How about pulse counting? I have the hardware that can also
> countpulses in addition to measuring the periods, so I'm interested
> in this work (initially I supported it in driver/misc/ but it got
> turned down for iio).
>
I'm afraid I'd forgotten this completely if you can dig out some links
to that discussion it would be great. Only one I can find right now
is a request that you post an ABI introducing this as a generic pulse
counter rather than a speed measurement.

Good point though - under my previous sketched outline, perhaps

in_waveform_cyclecount_input?  (I would imagine that it doesn't come
out needing scaling!)

> WBR, Sergei
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
