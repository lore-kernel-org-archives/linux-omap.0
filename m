From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH v5 2/3] wl18xx: add basic device-tree support
Date: Wed, 11 Mar 2015 11:05:47 +0100
Message-ID: <CABxcv=nn9-1a-3809Y1JgC5ExkwHqQmCXRT3tX=h7Z6C7c+m2A@mail.gmail.com>
References: <1425915402-10012-1-git-send-email-eliad@wizery.com>
	<1425915402-10012-2-git-send-email-eliad@wizery.com>
	<CABxcv=mygdT2Q+ByVKPx4+o_Oj9KSy=zVX9ng9yN25ivkfSn1A@mail.gmail.com>
	<2121942.zIG9BfPsTV@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:41756 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751847AbbCKKFt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Mar 2015 06:05:49 -0400
Received: by wghl2 with SMTP id l2so7966181wgh.8
        for <linux-omap@vger.kernel.org>; Wed, 11 Mar 2015 03:05:48 -0700 (PDT)
In-Reply-To: <2121942.zIG9BfPsTV@wuerfel>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Eliad Peller <eliad@wizery.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Ido Yariv <ido@wizery.com>

Hello Arnd,

On Wed, Mar 11, 2015 at 10:51 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 11 March 2015 01:34:19 Javier Martinez Canillas wrote:
>> > +
>> > +static struct wl12xx_platform_data *
>> > +wlcore_get_platform_data(struct device *dev)
>> > +{
>> > +       struct wl12xx_platform_data *pdata;
>> > +
>> > +       /* first, look for DT data */
>>
>> I thought it was the opposite, that platform data should over-rule DT.
>> That way you can still use the data filled in
>> arch/arm/mach-omap2/pdata-quirks.c even after the driver supports your
>> new DT binding.
>
> No, the pdata-quirks stuff for this driver must die, it was a hack
> that only exists because we previously could not attach data to an
> sdio function.
>

Ok sorry, I misunderstood and thought that the output from the
discussion in patch 3/3 was that the pdata could not still be removed
due not having a way to configure the clocks for wl12xx.

I totally agree with removing the pdata on this driver, in fact I
would go an just remove all the remaining OMAP2+ board files and
pdata-quirks completely. Most OMAP2+ boards have been converted to DT
years ago and if someone really cares about mainline support for these
boards, they can add a DTS and DT bindings for the drivers that still
needed like this one.

Best regards,
Javier
