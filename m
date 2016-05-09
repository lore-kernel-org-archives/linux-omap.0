From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 4/7] [media] ir-rx51: add DT support to driver
Date: Mon, 9 May 2016 16:07:35 -0500
Message-ID: <CAL_JsqJPZS1ne_xAuBFtCc5L1HKFJf0LDUJ7CRSFXhc3adkTfA@mail.gmail.com>
References: <1462634508-24961-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <1462634508-24961-5-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <20160509200657.GA3379@rob-hp-laptop> <5730F8BA.5000402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5730F8BA.5000402-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Mauro Carvalho Chehab <mchehab-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux PWM List <linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Mon, May 9, 2016 at 3:53 PM, Ivaylo Dimitrov
<ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Hi,
>
> On  9.05.2016 23:06, Rob Herring wrote:
>>
>> On Sat, May 07, 2016 at 06:21:45PM +0300, Ivaylo Dimitrov wrote:
>>>
>>> With the upcoming removal of legacy boot, lets add support to one of the
>>> last N900 drivers remaining without it. As the driver still uses omap
>>> dmtimer, add auxdata as well.
>>>
>>> Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>> ---
>>>   .../devicetree/bindings/media/nokia,lirc-rx51         | 19
>>> +++++++++++++++++++
>>>   arch/arm/mach-omap2/pdata-quirks.c                    |  6 +-----
>>>   drivers/media/rc/ir-rx51.c                            | 11 ++++++++++-
>>>   3 files changed, 30 insertions(+), 6 deletions(-)
>>>   create mode 100644
>>> Documentation/devicetree/bindings/media/nokia,lirc-rx51
>>>
>>> diff --git a/Documentation/devicetree/bindings/media/nokia,lirc-rx51
>>> b/Documentation/devicetree/bindings/media/nokia,lirc-rx51
>>> new file mode 100644
>>> index 0000000..5b3081e
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/media/nokia,lirc-rx51
>>> @@ -0,0 +1,19 @@
>>> +Device-Tree bindings for LIRC TX driver for Nokia N900(RX51)
>>> +
>>> +Required properties:
>>> +       - compatible: should be "nokia,lirc-rx51".
>>
>>
>> lirc is a Linux term. Also, nokia,rx51-... would be conventional
>> ordering.
>>
>
> I used the driver name ("lirc_rx51") to not bring confusion. Also, it
> registers itself through lirc_register_driver() call, so having lirc in its
> name somehow makes sense.
>
> I am not very good in inventing names, the best compatible I can think of is
> "nokia,rx51-ir". Is that ok?

Sure, but...

>> Is this anything more than a PWM LED?
>>
>
> It is an IR LED connected through a driver to McSPI2_SIMO pin of OMAP3,
> which pin can be configured as PWM or GPIO(there are other configurations,
> but they don't make sense). In theory it could be used for various things
> (like uni-directional serial TX, or stuff like that), but in practice it
> allows N900 to be act as an IR remote controller. I guess that fits in
> "nothing more than a PWM LED", more or less.

There's already a pwm-led binding that can be used. Though there may
be missing consumer IR to LED subsystem support in the kernel. You
could list both compatibles, use the rx51 IR driver now, and then move
to pwm-led driver in the future.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
