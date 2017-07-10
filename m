From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [RESEND PATCH v6 0/8] mfd: Add OF device table to I2C drivers
 that are missing it
Date: Mon, 10 Jul 2017 10:34:54 +0200
Message-ID: <CABxcv=nOnKwOGQT1AyC2XizrLiz067dH2jVWyWDooLFNb8JFfQ@mail.gmail.com>
References: <20170615184928.12007-1-javier@dowhile0.org> <CABxcv=k8g8c3KmLK+ZqQiG+-+j2Y=FuRpadQ=xguXG5qGGWwhg@mail.gmail.com>
 <20170710080712.3oyktu3pjdbgxx7k@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170710080712.3oyktu3pjdbgxx7k@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Russell King <linux@armlinux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux I2C <linux-i2c@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Jul 10, 2017 at 10:07 AM, Lee Jones <lee.jones@linaro.org> wrote:
> On Mon, 10 Jul 2017, Javier Martinez Canillas wrote:
>
>> Hello Lee,
>>
>> On Thu, Jun 15, 2017 at 8:49 PM, Javier Martinez Canillas
>> <javier@dowhile0.org> wrote:
>> >
>> > This series add OF device ID tables to mfd I2C drivers whose devices are
>> > either used in Device Tree source files or are listed in binding docs as
>> > a compatible string.
>> >
>> > That's done because the plan is to change the I2C core to report proper OF
>> > modaliases instead of always reporting a MODALIAS=i2c:<foo> regardless if
>> > a device was registered via DT or using the legacy platform data mechanism.
>> >
>> > So these patches will make sure that mfd I2C drivers modules will continue
>> > to be autoloaded once the I2C core is changed to report proper OF modalias.
>> >
>> > Users didn't have a vendor prefix in the used compatible strings, but since
>> > there wasn't a DT binding document for these drivers, it can be said that
>> > were working for mere luck and so this series fixes the users and add a DT
>> > binding doc for the drivers.
>> >
>> > Most patches can be applied independently, with the exception of patches
>> > 2 to 4 that should be applied in the same tree to keep bisect-ability. I
>> > suggest these to go through the MFD subsystem tree.
>> >
>> > Best regards,
>> > Javier
>> >
>>
>> Are you planning to pick this series? It has been in the list for
>> months and were resent many times...
>
> I think you exaggerate a little.  Your last Ack (from Linus) was only
> collected in v6, which has only been resent once with that Ack
> applied. =:)
>

You are right, sorry for the impatience.

> We are currently only half way through the merge-window.  This patch
> will be hoovered up during the early -rcs.  Please be patient around
> the time of the merge-window, since Maintainers are either usually
> very busy with pull-requests, or taking a 2 minute breather before
> the chaos starts over.
>

Great, I just was worried that it could fell through the cracks.
Thanks for your answer.

Best regards,
Javier
