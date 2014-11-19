From: Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [RFC] adp1653: Add device tree bindings for LED controller
Date: Wed, 19 Nov 2014 10:45:09 +0100
Message-ID: <546C66A5.6060201@samsung.com>
References: <20141116075928.GA9763@amd>
 <20141117145857.GO8907@valkosipuli.retiisi.org.uk>
 <546AFEA5.9020000@samsung.com> <20141118084603.GC4059@amd>
 <546B19C8.2090008@samsung.com> <20141118113256.GA10022@amd>
 <546B40FA.2070409@samsung.com> <20141118132159.GA21089@amd>
 <546B6D86.8090701@samsung.com> <20141118165148.GA11711@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <20141118165148.GA11711@amd>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org>
Cc: pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org, sre-GFxCN5SEZAc@public.gmane.org, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, aaro.koskinen-X3B1VOXEql0@public.gmane.org, freemangordon-uiMcrn6V0Vs@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux LED Subsystem <linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Pavel, Sakari,

On 11/18/2014 05:51 PM, Pavel Machek wrote:
> Hi!
>
>>> If the hardware LED changes with one that needs different current, the
>>> block for the adp1653 stays the same, but white LED block should be
>>> updated with different value.
>>
>> I think that you are talking about sub nodes. Indeed I am leaning
>> towards this type of design.
>
> I think I am :-).
>
>>>> I agree that flash-timeout should be per led - an array, similarly
>>>> as in case of iout's.
>>>
>>> Agreed about per-led, disagreed about the array. As all the fields
>>> would need arrays, and as LED system currently does not use arrays for
>>> label and linux,default-trigger, I believe we should follow existing
>>> design and model it as three devices. (It _is_ physically three devices.)
>>
>> Right, I missed that the leds/common.txt describes child node.
>>
>> I propose following modifications to the binding:
>>
>> Optional properties for child nodes:
>> - iout-mode-led : 	maximum intensity in microamperes of the LED
>> 		  	(torch LED for flash devices)
>> - iout-mode-flash : 	initial intensity in microamperes of the
>> 			flash LED; it is required to enable support
>> 			for the flash led
>> - iout-mode-indicator : initial intensity in microamperes of the
>> 			indicator LED; it is required to enable support
>> 			for the indicator led
>> - max-iout-mode-led : 	maximum intensity in microamperes of the LED
>> 		  	(torch LED for flash devices)
>> - max-iout-mode-flash : maximum intensity in microamperes of the
>> 			flash LED
>> - max-iout-mode-indicator : maximum intensity in microamperes of the
>> 			indicator LED
>> - flash-timeout :	timeout in microseconds after which flash
>> 			led is turned off
>
> Ok, I took a look, and "iout" is notation I understand, but people may
> have trouble with and I don't see it used anywhere else.
>
> Also... do we need both "current" and "max-current" properties?
>
> But regulators already have "regulator-max-microamp" property. So what
> about:
>
> max-microamp : 	maximum intensity in microamperes of the LED
>   		  	(torch LED for flash devices)
> max-flash-microamp : 	initial intensity in microamperes of the
>   			flash LED; it is required to enable support
>   			for the flash led
> flash-timeout-microseconds : timeout in microseconds after which flash
>   			led is turned off
>
> If you had indicator on the same led, I guess
>
> indicator-microamp : recommended intensity in microamperes of the LED
> 		         for indication
>
> ...would do?


Ongoing discussion allowed me for taking a look at the indicator issue
from different perspective. This is also vital for the issue of
whether a v4l2-flash sub-device should be created per device or
per sub-led [1].

Currently each sub-led is represented as a separate device tree
sub node and the led drivers create separate LED class device for the
sub nodes. What this implies is that indicator led also must be
represented by the separate LED class device.

This is contrary to the way how V4L2 Flash API approaches this issue,
as it considers a flash device as a regulator chip driven through
a bus. The API allows to set the led in torch or flash mode and
implicitly assumes that there can be additional indicator led
supported, which can't be turned on separately, but the drivers apply
the indicator current to the indicator led when the torch or flash led
is activated.

I propose to create separate v4l2-flash device for the indicator led,
and treat it as a regular sub-led similarly like it is done in the
LED subsystem. LED Flash class driver would only add a flag
LED_DEV_CAP_INDICATOR and basing on it the v4l2-flash sub-device
would create only V4L2_CID_FLASH_INDICATOR_INTENSITY control for it.
There could ba also additional control added:
V4L2_CID_FLASH_INDICATOR_PATTERN to support the feature
supported by some LED class drivers.

 From the media device perspective such an approach would
be harmful, as the indicator led could be turned on right
before strobing the flash or turning the torch on, by
separate calls to different v4l2-flash sub-devices.

The design described above would allow for avoiding issues I touched
in the message [1].

Regarding DT documentation:

I would also swap the segments of a property name to follow the 
convention as in case of "regulator-max-microamp".

Updated version:

==========================================================

Optional properties for child nodes:
- max-microamp : maximum intensity in microamperes of the LED
		 (torch LED for flash devices)
- flash-max-microamp : maximum intensity in microamperes of the
		       flash LED; it is mandatory if the led should
		       support the flash mode
- flash-timeout-microsec : timeout in microseconds after which the flash
		           led is turned off
- indicator-pattern : identifier of the blinking pattern for the
		      indicator led

==========================================================

Regards,
Jacek

[1] 
http://permalink.gmane.org/gmane.linux.drivers.video-input-infrastructure/84643
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
