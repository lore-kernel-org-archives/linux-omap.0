From: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 1/2] input: misc: Add generic input driver to read
 encoded GPIO lines
Date: Wed, 24 Aug 2016 12:09:42 +0530
Message-ID: <8e38becb-137f-7346-258d-1c4dbb890643@ti.com>
References: <20160823061649.3394-1-vigneshr@ti.com>
 <20160823061649.3394-2-vigneshr@ti.com>
 <949d92f3-4510-ada5-d3d6-a29544465fd6@ti.com> <20160823200335.GC6712@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160823200335.GC6712@dtor-ws>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Daniel Hung-yu Wu <hywu-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, S Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Moritz Fischer <moritz.fischer-+aYTwkv1SeIAvxtiuMwx3w@public.gmane.org>, Jorge Ramirez-Ortiz <jorge.ramirez-ortiz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org



On Wednesday 24 August 2016 01:33 AM, Dmitry Torokhov wrote:
> On Tue, Aug 23, 2016 at 10:27:59AM -0500, Andrew F. Davis wrote:
>> On 08/23/2016 01:16 AM, Vignesh R wrote:
>>> Add a driver to read group of GPIO lines and provide its status as a
>>> numerical value as input event to the system. This will help in
>>> intefacing devices, that can be connected over GPIOs, that provide input
>>> to the system by driving GPIO lines connected to them like a rotary dial
>>> or a switch.
>>>
>>> For example, a rotary switch can be connected to four GPIO lines. The
>>> status of the GPIO lines reflect the actual position of the rotary
>>> switch dial. For example, if dial points to 9, then the four GPIO lines
>>> connected to the switch will read HLLH(0b'1001 = 9). This value
>>> can be reported as an ABS_* event to the input subsystem.
>>>
>>> Signed-off-by: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
>>> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>>> ---
>>>
>>> v2: Use decoder,max-value instead of gpio-decoder,max-value.
> 
> That's not what Rob asked for. "decoder-max-value", not "decoder" vendor
> prefix.
> 

Sorry.. Will fix this in v3.


-- 
Regards
Vignesh
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
