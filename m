From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH 0/2] Fix few omap gpmc regressions when booted with device tree
Date: Wed, 23 Apr 2014 20:42:59 +0200
Message-ID: <CABxcv=nUXPT_FZwPxyVD1OrxtqGmqD81vHKJSnNNYPOGzErWWg@mail.gmail.com>
References: <1398128080-18903-1-git-send-email-tony@atomide.com>
	<CABxcv=nDAp=iDXxVrajELJzEG=hEV3ceMJkUaiFOpe79za+LKA@mail.gmail.com>
	<20140422152347.GB19317@atomide.com>
	<20140423000012.GD12204@atomide.com>
	<20140423180844.GC4833@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:36532 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753665AbaDWSnA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Apr 2014 14:43:00 -0400
Received: by mail-wg0-f45.google.com with SMTP id l18so1232635wgh.4
        for <linux-omap@vger.kernel.org>; Wed, 23 Apr 2014 11:42:59 -0700 (PDT)
In-Reply-To: <20140423180844.GC4833@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Pekon Gupta <pekon@ti.com>, Dmitry Lifshitz <lifshitz@compulab.co.il>

Hello Tony,

On Wed, Apr 23, 2014 at 8:08 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Tony Lindgren <tony@atomide.com> [140422 17:01]:
>> * Tony Lindgren <tony@atomide.com> [140422 08:24]:
>> > * Javier Martinez Canillas <javier@dowhile0.org> [140421 23:55]:
>> > > On Tue, Apr 22, 2014 at 2:54 AM, Tony Lindgren <tony@atomide.com> wrote:
>> > > >
>> > > > 2. There seems to be some timing issues with smc911x where
>> > > >    rsync of larger files and apt-get dist-upgrade can produce
>> > > >    strange errors. This seems to work reliably when booted in
>> > > >    legacy mode.
>> > > >
>> > >
>> > > In what board are you having this issue? The smsc911x driver supports
>> > > both SMSC's LAN911x and LAN921x families and I see that we have two
>> > > .dtsi files with different timings
>> > > (arm/boot/dts/omap-gpmc-smsc{911x,9221}.dtsi).
>> > >
>> > > This is only a wild guess, but maybe your board has a smsc LAN921x
>> > > chip but is including omap-gpmc-smsc911x.dtsi on its DTS?
>> >
>> > Yes it seems to have two LAN9220s, so this could be the reason.
>> > I don't think we had the omap-gpmc-smsc9221.dtsi when I added the
>> > timings initially.
>> >
>> > This is on a sbc-t3730 that I'm using as a gateway that was behaving
>> > reliably before I upgraded it to DT based booting. It's currently
>> > at v3.13-rc3 something, but I don't think we've much GPMC changes
>> > since then.
>> >
>> > I'll try upgrading the kernel today and running some tests with
>> > rsync. Looks like we can also remove quite a bit of duplicate
>> > timing data by using omap-gpmc-smsc9221.dtsi, I'll try something
>> > like the patch below.
>> >
>> > In any case, I suggest others run some tests on their GPMC Ethernet
>> > too.
>> >
>> > +#include "omap-gpmc-smsc9221.dtsi"
>> > +
>>
>> The 9221 timings won't work at all on 9220, it requires a 9221.
>> I'll post a better clean-up patch to use the 911x timings.
>>
>> Upgraded the kernel and the occasional corruption is still
>> there. I guess I need to test also the same kernel in legacy
>> mode to try to narrow it down.
>
> OK hopefully got it figured out now. For legacy booting we were
> always using just the bootloader timings. With device tree, we
> started using the timings with your commit d72b4415 (ARM: dts:
> omap3-igep0020: Add SMSC911x LAN chip support) that was probably
> actually tested on a LAN9221 instead of LAN9220?
>

Right, since the same driver (drivers/net/ethernet/smsc/smsc911x.c) is
used for both SMSC families I assumed that the same timings could be
used by both chips.

So I took the timings from IGEP board support in u-boot but then you
did the refactoring and later Florian added another .dtsi for SMSC
9221 in commit aac9aa3 ("ARM: dts: omap: Add common file for
SMSC9221").

I didn't notice about this new .dtsi file until you reported your
issue and the IGEPv2 does indeed have a SMSC LAN9221i ethernet chip so
it is wrongly including omap-gpmc-smsc911x.dtsi and should include
omap-gpmc-smsc9221.dtsi instead.

> In any case, I've patched omap-gpmc-smsc911x.dtsi so the values
> match the u-boot values, and so far that seems to be working just
> fine. Will post few patches shortly.
>

Great, I'll patch the IGEPv2 DTS file too to use
omap-gpmc-smsc9221.dtsi, do some testing and post a patch.

> Regards,
>
> Tony
>

Thanks a lot and best regards,
Javier
