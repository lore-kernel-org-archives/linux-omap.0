From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: Re: linux-next - multi-omap image fails to boot on omap3/4
Date: Wed, 20 Oct 2010 05:16:46 +0530
Message-ID: <AANLkTikrVJ3bw3aKE6V7uH9DmheVDihedNOP+wypYunC@mail.gmail.com>
References: <4CBDAFFF.2030409@ti.com> <20101019182149.GC3038@atomide.com>
 <AANLkTikYGwH-kQV3b+gqDYOKVvuiXOU=kBDVLy3ryNjR@mail.gmail.com>
 <20101019225726.GE3038@atomide.com> <20101019233204.GA30991@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:42271 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753368Ab0JSXrI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Oct 2010 19:47:08 -0400
Received: by mail-ww0-f54.google.com with SMTP id 39so2021271wwb.11
        for <linux-omap@vger.kernel.org>; Tue, 19 Oct 2010 16:47:06 -0700 (PDT)
In-Reply-To: <20101019233204.GA30991@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Wed, Oct 20, 2010 at 5:02 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Tony Lindgren <tony@atomide.com> [101019 15:48]:
>> * Gadiyar, Anand <gadiyar@ti.com> [101019 11:26]:
>> > On Tue, Oct 19, 2010 at 11:51 PM, Tony Lindgren <tony@atomide.com> wrote:
>> > > * Anand Gadiyar <gadiyar@ti.com> [101019 07:41]:
>> > >> Hi all,
>> > >>
>> > >> linux-next, as of 20101019, built with the omap2plus_defconfig fails
>> > >> to boot on omap3 and omap4. (I've disabled CONFIG_ARCH_OMAP2 or
>> > >> CONFIG_SWP_EMULATE to get the image to build). Building with only
>> > >> ARCH_OMAP3 allows the resultant image to boot up on OMAP3. Likewise,
>> > >> an image built with only ARCH_OMAP4 boots up on OMAP4 boards.
>> > >>
>> > >> earlyprintk does not provide any additional prints after
>> > >> "Uncompressing Linux... done, booting the kernel."
>> > >>
>> > >> Any ideas where to look?
>> > >
>> > > Hmm I did a quick test merge of linux-omap master and rmk/devel
>> > > branches and that boots just fine.
>> > >
>> > > So it's probably something that already got fixed in rmk/devel
>> > > but is not yet in next, or something that came from elsewhere,
>> > > or something that we have in omap-testing branch that's not in
>> > > for-next for some reason.
>> >
>> > I tried bisecting linux-next between v2.6.36-rc8 and HEAD, but
>> > there's a commit in between that breaks the build. I'll take another
>> > stab at this in a while.
>>
>> Looks like current next at 80f8f1f8b33750d954beb386c0c8142d0c01c25c
>> boots again except on 2430sdp it produces a NULL pointer at ubi_io_write.
>
> Oops, sorry it's still broken, wrong tree.
>

I've started bisecting again - I needed to pick commit 5bac0926121e
(driver core: platform_bus: allow runtime override of dev_pm_ops) to
solve the build break.

Will report back if I find something.

- Anand
