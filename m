From: Bryan Wu <bryan.wu@canonical.com>
Subject: Re: [PATCH v2] leds: leds-gpio: adopt pinctrl support
Date: Sat, 8 Sep 2012 00:00:47 +0800
Message-ID: <CAK5ve-KZdpLm6hNN+k7RZJSUp34vqoGwRRkk2dzWH2n+aLxLKA@mail.gmail.com>
References: <1346487390-11399-1-git-send-email-anilkumar@ti.com>
 <201209060405.08997.marex@denx.de> <20120906174531.GX1303@atomide.com>
 <201209070209.35379.marex@denx.de> <331ABD5ECB02734CA317220B2BBEABC13EA2964C@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:56693 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750781Ab2IGQBJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Sep 2012 12:01:09 -0400
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EA2964C@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "AnilKumar, Chimata" <anilkumar@ti.com>
Cc: Marek Vasut <marex@denx.de>, Tony Lindgren <tony@atomide.com>, Shawn Guo <shawn.guo@linaro.org>, "rpurdie@rpsys.net" <rpurdie@rpsys.net>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>

On Fri, Sep 7, 2012 at 3:59 PM, AnilKumar, Chimata <anilkumar@ti.com> wrote:
> On Fri, Sep 07, 2012 at 05:39:35, Marek Vasut wrote:
>> Dear Tony Lindgren,
>>
>> > * Marek Vasut <marex@denx.de> [120905 19:05]:
>> > > Hi Tony,
>> > >
>> > > > * Marek Vasut <marex@denx.de> [120904 20:13]:
>> > > > > Dear Bryan Wu,
>> > > > >
>> > > > > > On Sat, Sep 1, 2012 at 4:16 PM, AnilKumar Ch <anilkumar@ti.com> wrote:
>> > > > > > > Adopt pinctrl support to leds-gpio driver based on leds-gpio
>> > > > > > > device pointer, pinctrl driver configure SoC pins to GPIO
>> > > > > > > mode according to definitions provided in .dts file.
>> > > > > >
>> > > > > > Thanks for this, actually Marek Vasut submitted a similar patch
>> > > > > > before. I'm pretty fine with this patch.
>> > > > >
>> > > > > Thanks for submitting this actually ... I didn't have time to
>> > > > > properly investigate this.
>> > > > >
>> > > > > > But without proper DT setting, it will also give us warning I
>> > > > > > think. or we can provide some dummy functions as a temp solution
>> > > > > > as Shawn pointed out before.
>> > > > >
>> > > > > But this driver is also used on hardware that's not yet coverted to
>> > > > > DT, so I'd say dev_warn() if CONFIG_OF is enabled and otherwise
>> > > > > simply go on ? Actually, can we not skip whole this pinctrl thing if
>> > > > > CONFIG_OF is disabled? Actually (2), what's the relationship between
>> > > > > OF and pinctrl?
>> > > >
>> > > > The warning should be pinctrl related as the pinctrl drivers may not be
>> > > > device tree based drivers.
>> > >
>> > > Exactly my concern. Also the warning shouldnt be present on systems where
>> > > pinctrl is disabled.
>> >
>> > But pinctrl_get_select() returns 0 in include/linux/pinctrl/consumer.h if
>> > CONFIG_PINCTRL is not selected, so no warning is produced AFAIK ;)
>>
>> Oh all right then.
>>
>
> Bryan,
>
> If this patch looks fine, can you queue this for 3.7?
>

I've applied this to my for-next branch.

Thanks,
-Bryan
