From: Nikolay Dimitrov <picmaster@mail.bg>
Subject: Re: [alsa-devel] Patches to bind the SGTL5000 chip to AM33XX McASP
Date: Fri, 20 Mar 2015 17:51:52 +0200
Message-ID: <550C4218.80901@mail.bg>
References: <1426741659.10003.9.camel@midgaarde>	<550AC783.8040304@ti.com> <CAAQQ3u=opRm3UzD+bG6aJvhQU2CFmzH4sXzuA=GxDp2d+MMiNg@mail.gmail.com> <550AF442.5040203@ti.com> <550B1017.2000405@mail.bg> <550BD4D1.5080604@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx2.mail.bg ([193.201.172.118]:37685 "EHLO mx2.mail.bg"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751440AbbCTPv4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Mar 2015 11:51:56 -0400
In-Reply-To: <550BD4D1.5080604@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Greg Knight <g.knight@symetrica.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Peter,

On 03/20/2015 10:05 AM, Peter Ujfalusi wrote:
> On 03/19/2015 08:06 PM, Nikolay Dimitrov wrote:
>> Slight clarification here - I can't find any such reference in the
>> SGTL5000 datasheet where it's explicitly written that the I2C bus
>> *requires* the MCLK running. Unfortunately, all of us found this
>> obscure dependency empirically.
>
> It is not spelled out as such, but in:
> http://cache.freescale.com/files/analog/doc/data_sheet/SGTL5000.pdf?pspll=1
> bottom of page9 (note 1) and the power up sequence in page10. See also page13,
> RESET section.
>
>>> If you change audio controls while you don't have audio activity, you will
>>> still need to have the MCLK running.
>>
>> Correct. And this is a big issue. As far as I know, the kernel drivers
>> control separately the clock domains, and separately i2c devices, so
>> the basic expectation on the kernel side is that there's no connection
>> between these 2. In this specific case, because of the SGTL5000's
>> implementation, there's a dependency. Right now as I see it, there are
>> several ways to resolve it:
>>
>> 1. Run the reference clock all the time, so the SGTL5000 codec is
>> happy, and DAPM widgets can work as-is. We've been doing this all the
>> time - the reference clocks are routinely configured either in the
>> bootloader, or in the DTS iomuxc node. While this can work in some
>> cases (or until someone touches the same clock or one of its parents
>> :D), there are other cases (like battery-powered devices) where people
>> would want more aggressive power management, which means controlling
>> the reference clock at runtime (see #2).
>
> Note the the codec driver will enable the clock and will not let it to be
> turned off. You need to work on the codec driver to sort this out.
>
>> 2. Add "hacks" in the DAPM widgets that add control to the codec's
>> reference clocks. While this seems the preferred route to many, the
>> general feeling is that such approach is not very welcome in upstream.
>
> SND_SOC_DAPM_CLOCK_SUPPLY()
>
>> 3. Add explicit support in the kernel's audio subsystem for
>> dependencies between i2c devices and clocks, maybe via "DAPM clock
>> widget" or something like this. Provided that the DAPM graphs are
>> defined properly, this will work out-of-the-box for all use cases,
>> without the hacks (until we see even more twisted cases).
>
> This can be handled within the codec driver with some changes. If you have
> external clock which can be enabled/diabled with a GPIO, then you can use
> that. We already have binding for this type of external clocks (in
> linux-next): look for "gpio-gate-clock"
> You define your external GPIO controlled clock with this binding and use the
> phandle in the codec driver.
> Change the codec driver to enable/disable the clock when needed.
> When you do not have audio activity, set the regmap to cache only so any
> change in the controls will not reach the HW. When you power up next time the
> regmap will sync the changes to the chip, so you will have the changes commited.

Thanks a lot for your detailed explanation!

Kind regards,
Nikolay
