From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFCv4 06/11] misc: Introduce Nokia CMT driver
Date: Mon, 16 Dec 2013 14:31:53 +0100
Message-ID: <CACRpkdbx=Ye8xo4wMkyntME45xv15DeyqV32aeCAcSaa+vDpfA@mail.gmail.com>
References: <1387150085-23173-1-git-send-email-sre@debian.org>
	<1387150085-23173-7-git-send-email-sre@debian.org>
	<CACRpkdYjjXgE_W8gq1e6z=nGMF=r-m+o2kkvrBFrEMm3o0=RwQ@mail.gmail.com>
	<20131216121524.GA6177@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20131216121524.GA6177@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Shubhrajyoti Datta <omaplinuxkernel@gmail.com>, Carlos Chinea <cch.devel@gmail.com>, Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Landley <rob@landley.net>, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, =?ISO-8859-1?Q?Pali_Roh=E1r?= <pali.rohar@gmail.com>, =?windows-1251?B?yOLg6evuIMTo7Ojy8O7i?= <freemangordon@abv.bg>, Joni Lapilainen <joni.lapilainen@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: linux-omap@vger.kernel.org

On Mon, Dec 16, 2013 at 1:15 PM, Sebastian Reichel <sre@debian.org> wrote:
> On Mon, Dec 16, 2013 at 10:48:06AM +0100, Linus Walleij wrote:

>> I.e. it doesn't look device-specific at all, just like some
>> generic glue code that could be useful to many such
>> scenarios.
>
> I like the idea.
>
> Probably the remaining gpio exporting code can be converted into
> some generic gpio-sysfs-export driver as well.

I am very reluctant in letting device trees specify exports of GPIOs
to userspace, not so much because it's Linux-specific but for
the fact that people are doing things in userspace that should not
be done in userspace.

Last time it was proposed I asked to the specific usecase,
exactly why userspace needed this handle on a physical
GPIO line, and why it can't use another userspace interface
(example: leds, keys etc.)

> What do you think about the following?
>
> /*
>  * driver, which provides generic reset notifications
>  */
> cmt_reset: reset-notifier {
>     compatible = "linux,reset-notification";
>
>     interrupts = <gpio>;
> };

Looks good to me.

> /*
>  * driver, which exports the specified gpios in sysfs with the
>  * supplied names. The device will be named according to the
>  * label
>  */
> cmt_gpios: gpio-sysfs-export {
>     compatible = "linux,gpio-sysfs-export";
>     label = "nokia-cmt";
>
>     gpios = <A>, <B>, ...;
>     gpio-names = "A", "B", ...;
> };

Please follow the discussion on this topic:
http://marc.info/?l=linux-gpio&m=138201170431416&w=2

>> Why are you using a tasklet rather than a work
>> for this?
>
> No particular reason. I just took this over from Nokia's code.

Can you try to use a work instead?

Yours,
Linus Walleij
