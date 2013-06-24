From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: [BISECTED] 3.10-rc1 OMAP1 GPIO IRQ regression
Date: Mon, 24 Jun 2013 03:01:41 +0200
Message-ID: <CAAwP0s00RwP7jCMF1O8j8Ndhu=VfD2dMA5fzr6jWvQ7PziXBCw@mail.gmail.com>
References: <20130513205302.GA3157@blackmetal.musicnaut.iki.fi>
 <20130516180933.GG5600@atomide.com> <20130516210006.GA31836@blackmetal.musicnaut.iki.fi>
 <20130516214430.GN5600@atomide.com> <20130520174621.GI10378@atomide.com>
 <20130605223355.EDC113E10E4@localhost> <20130606155341.GL3331@atomide.com>
 <20130623221605.GA3150@blackmetal.musicnaut.iki.fi> <CAAwP0s1DkMu8Vfka43hS4Wj-927q=O5u-coyFsPBgy3qtA_vjw@mail.gmail.com>
 <20130623234326.GA20703@blackmetal.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:62132 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750872Ab3FXBCB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 23 Jun 2013 21:02:01 -0400
Received: by mail-ie0-f180.google.com with SMTP id f4so23613598iea.11
        for <linux-omap@vger.kernel.org>; Sun, 23 Jun 2013 18:02:01 -0700 (PDT)
In-Reply-To: <20130623234326.GA20703@blackmetal.musicnaut.iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Jon Hunter <jgchunter@gmail.com>

On Mon, Jun 24, 2013 at 1:43 AM, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> Hi,
>
> On Mon, Jun 24, 2013 at 01:06:37AM +0200, Javier Martinez Canillas wrote:
>> On Mon, Jun 24, 2013 at 12:16 AM, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
>> > What is the status of this patch? We're already at 3.10-rc7 and GPIO
>> > IRQs are still broken on OMAP1.
>
> [...]
>
>> There is a problem with this patch.
>
> [...]
>
>> So I think that the correct solution is to add SPARSE_IRQ support to
>> omap1 and not reverting Jon's patch. Of course this may not be
>> possible since we are so close to 3.10 and most OMAP patches already
>> merged for 3.11 but we should definitely try to have this at least for
>> 3.12. Otherwise we won't be able to move to DT-only booting for
>> OMAP2+.
>
> OMAP1 does not use DT. So we could put this code under #ifdef
> CONFIG_ARCH_OMAP1 or similar. It's just a few lines of code. OMAP2+
> work should not regress OMAP1.
>
> Demanding SPARSE_IRQ support for OMAP1 should have been discussed before
> these changes were made. It's not reasonable to assume such things can
> be made during rc-cycle. Also, now, I don't think it's reasonable to
> wait for that to be done, as it would take until 3.12 or even later to
> get OMAP1 functional again.
>
> A.

Hi,

Yes, since we are so late in the -rc cycle and OMAP1 is currently
broken I agree that the only sensible solution is to revert the patch
for now.

I just wanted to point out the issue that keeping the OMAP GPIO driver
using legacy mapping domain represents a blocker to have GPIO-IRQ
working with Device Tree for OMAP2+

Thanks a lot and best regards,
Javier
