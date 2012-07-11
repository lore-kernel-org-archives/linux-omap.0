From: Omar Ramirez Luna <omar.luna@linaro.org>
Subject: Re: suspend broken on 3.5-rc1?
Date: Wed, 11 Jul 2012 18:58:18 -0500
Message-ID: <CALLhW=7FwtPy0_u863fH7-nSMW4AvxuqHvNeO2CqtF3aJEgh4Q@mail.gmail.com>
References: <4FD1D570.1010508@ti.com>
	<20120608105611.GO12766@atomide.com>
	<4FD1EF25.3060906@ti.com>
	<1339160732.2091.47.camel@sokoban>
	<4FD1FB47.8040007@ti.com>
	<4FD72FB7.60905@ti.com>
	<CALLhW=5HUJuUbEoz7GXJ3h75iqB_9_bNrofBU45zKQejkKExAQ@mail.gmail.com>
	<87mx36ht3y.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:54835 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755540Ab2GKX6T (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Jul 2012 19:58:19 -0400
Received: by vcbf11 with SMTP id f11so1151718vcb.19
        for <linux-omap@vger.kernel.org>; Wed, 11 Jul 2012 16:58:18 -0700 (PDT)
In-Reply-To: <87mx36ht3y.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>, t-kristo@ti.com, Tony Lindgren <tony@atomide.com>, loml <linux-omap@vger.kernel.org>

Hi Kevin,

On 11 July 2012 16:42, Kevin Hilman <khilman@ti.com> wrote:
> Omar Ramirez Luna <omar.luna@linaro.org> writes:
>
>> On 12 June 2012 07:01, Rajendra Nayak <rnayak@ti.com> wrote:
>
> [...]
>
>>> ..anyone knows of any more fixes going around?
>>
>> I'm seeing the same thing, it gets stuck trying to enable CPU1, tried
>> this with pm-20120710 from linux-omap-pm and current LO master (based
>> on 3.5-rc6), also using a Panda 4460.
>
> When reporing problems like this, it is greatly helpful to report your
> defconfig (specifically, any changes from omap2plus_defconfig.)

Sorry, I missed this since it was omap2plus_defconfig +
CONFIG_DMADEVICES and CONFIG_DMA_OMAP.

> Specifically, do you have CONFIG_MFD_OMAP_USB_HOST in your defconfig?

No.

> There are known bugs that cause the USB host driver to hang suspend in
> mainline.  Because of this, and the fact that the USB developers did not
> fix try to this for v3.5, current l-o master (and my pm branch) now have
> this disabled by default in omap2plus_defconfig.
>
>> Would appreciate patches if any.
>
> If it's the USB host problem you need fixed, Russ Dill has posted a
> couple patches and Keshava has posted a bigger revert, but there hasn't
> been any conclusion on the fix yet.
>
> Can you try to reproduce with omap2plus_defconfig (+ DMA engine if you
> need MMC rootfs.)
>
> With omap2plus_defconfig + initramfs and omap2plus_defconfig + DMAengine
> for MMC rootfs, this is working fine for me on my 4430 Panda using RTC
> wakeups:

I suspect this might be specific to 4460 as Rajendra reported it was
working for him on 4430 but not on 4460, I haven't tried 4430 but let
me see if I can find one.

Thanks,

Omar
