From: Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 0/2] AM335x-ICE: Add support for rotary switch
Date: Wed, 24 Aug 2016 13:01:44 +0200
Message-ID: <86711a29-8fb5-9804-8642-2f390081e677@zonque.org>
References: <20160824075859.30979-1-vigneshr@ti.com>
 <c5385d42-14e4-d5ca-370e-5b04e37d873d@zonque.org>
 <5294e820-4946-a196-549f-76a349b6606d@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5294e820-4946-a196-549f-76a349b6606d-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Daniel Hung-yu Wu <hywu-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, S Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Moritz Fischer <moritz.fischer-+aYTwkv1SeIAvxtiuMwx3w@public.gmane.org>, Jorge Ramirez-Ortiz <jorge.ramirez-ortiz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "Andrew F . Davis" <afd-l0cyMroinI0@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 08/24/2016 11:15 AM, Vignesh R wrote:
> On Wednesday 24 August 2016 02:05 PM, Daniel Mack wrote:
>> On 08/24/2016 09:58 AM, Vignesh R wrote:
>>> This series adds support for rotary-switch on AM335x-ICE that is
>>> connected to TI PCA9536 I2C GPIO expander.
>>> First patch adds new generic driver to read status of group of GPIO
>>> lines and report the value as an input event. The second patch adds DT
>>> entries for the same.
>>>
>>> v2: https://lkml.org/lkml/2016/8/23/111
>>> v1: https://lkml.org/lkml/2016/8/12/7
>>
>> Is there a reason why the rotary-encoder driver cannot handle this?
>> Commit 7dde4e74744 ("Input: rotary-encoder - support more than 2 gpios
>> as input") added support for that mode AFAIU.
>>
> 
> Rotary encoder driver handles incremental encoders only and does not
> support absolute encoders. The rotary switch on am335x-ice is different
> from the incremental encoders in the
> sense that GPIO line status directly reflect the position(number)
> pointed by the dial of the encoder. So, there is no need to count steps
> or know the direction of rotation as it does not matter.
> 
> I did try to enhance rotary-encoder driver to support absolute
> encoder[1] but the comment there was to write new driver that simply
> translates gpio-encoded value into ABS* event. Indeed, the new driver
> looks more simple and can handle more such hardwares.

Okay. Yes, that makes sense. Thanks for the explanation!


Daniel

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
