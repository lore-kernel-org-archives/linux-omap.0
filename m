From: Nick Krause <xerofoify@gmail.com>
Subject: Re: Nokia N900 FB regression?
Date: Wed, 23 Jul 2014 11:22:57 -0400
Message-ID: <CAPDOMVhgKSQ37vwfd=YpnrhzCjDn1gEeER=QWZRhTccOL-20NA@mail.gmail.com>
References: <20140722212318.GC2615@drone.musicnaut.iki.fi>
	<20140723073706.GH18374@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vc0-f175.google.com ([209.85.220.175]:57907 "EHLO
	mail-vc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756440AbaGWPW6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Jul 2014 11:22:58 -0400
Received: by mail-vc0-f175.google.com with SMTP id hu12so2443100vcb.20
        for <linux-omap@vger.kernel.org>; Wed, 23 Jul 2014 08:22:57 -0700 (PDT)
In-Reply-To: <20140723073706.GH18374@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, Pavel Machek <pavel@ucw.cz>

On Wed, Jul 23, 2014 at 3:37 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Aaro Koskinen <aaro.koskinen@iki.fi> [140722 14:25]:
>> Hi,
>>
>> Somewhere between 3.16-rc2 and rc6 (I was on holidays...) I noticed
>> the framebuffer stopped working on N900 (nothing on screen).
>>
>> I bisected this to 9188883fd66e9809e93e06d5bbd49cf99a6cdbee (ARM: dts:
>> Enable twl4030 off-idle configuration for selected omaps).
>> With this commit reverted, I can see the Tux again with 3.16-rc6.
>>
>> Any ideas?
>
> Hmm, OK yeah that enables the deeper idle states. I have tested
> this on n900, but only have remote access to it so could not see
> the framebuffer.
>
> Sounds like there's some twl regulator that we cannot idle
> by default on n900. Here are the steps to narrow it down:
>
> 1. Try ti,twl4030-power-idle in omap3-n900.dts instead of
>    ti,twl4030-power-idle-osc-off. This probably won't help
>    unless you're enabling off-idle though, so if it does not
>    help, just keep on using ti,twl4030-power-idle-osc-off.
>
> 2. Try commenting out one or more of the TWL_REMAP_SLEEP or
>    TWL_REMAP_OFF lines in omap3_idle_rconfig in file
>    drivers/mfd/twl4030-power.c. That's the recommended init
>    sequence like the comments in the code mention. Chances
>    are we're missing a regulator_get somewhere but finding
>    out which one in omap3_idle_rconfig will help narrow it
>    down :)
>
> 3. If it looks like a more complicated fix, we can just use
>    compatible = "ti,twl4030-power-n900" to disable the twl
>    features for v3.16 and re-enable it for v3.17.
>
> Regards,
>
> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Thanks Tony for the help, seems that this will be fixed before the 3.17 and
needs no more assist from me.
Cheers Nick
