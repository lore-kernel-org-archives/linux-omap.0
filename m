From: Matt Sealey <neko@bakuhatsu.net>
Subject: Re: [PATCHv9 05/43] CLK: TI: add DT alias clock registration mechanism
Date: Mon, 4 Nov 2013 16:45:57 -0600
Message-ID: <CAHCPf3vkKMmTsk_Pdm5tAmPm7yRW7_yxLGr1w18A4aqbYh2+5Q@mail.gmail.com>
References: <1382716658-6964-1-git-send-email-t-kristo@ti.com>
	<1382716658-6964-6-git-send-email-t-kristo@ti.com>
	<CAHCPf3uPhkVhdn3Db06YZfrwQuA7khdZEXiZ+pqJ06J9YdBoLg@mail.gmail.com>
	<1545474.t3t8VtRE27@flatron>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f51.google.com ([209.85.160.51]:38268 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750749Ab3KDWp6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Nov 2013 17:45:58 -0500
Received: by mail-pb0-f51.google.com with SMTP id xa7so1850130pbc.38
        for <linux-omap@vger.kernel.org>; Mon, 04 Nov 2013 14:45:57 -0800 (PST)
In-Reply-To: <1545474.t3t8VtRE27@flatron>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, paul@pwsan.com, Mike Turquette <mturquette@linaro.org>, Tony Lindgren <tony@atomide.com>, rnayak@ti.com, Benoit Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org

On Sat, Nov 2, 2013 at 8:49 AM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> Hi Matt,
>
>> I have one question here, what makes this part of the patch
>> TI-specific at all except the definition of the structure ti_dt_clk?
>> Mapping DT clocks to generic clkdev legacy namings seems like it would
>> be a necessary evil across *all* SoC platforms.
>
> SoC platforms that are fully converted to Device Tree do not need any
> legacy clkdev namings, because they have all clkdev look-ups performed
> using data from DT (see generic clock bindings).
>
> So this would be not "*all* SoC platforms", but instead "SoC platforms,
> which are currently undergoing conversion to DT or conversion of which is
> yet to be started".

That is well understood here, I have a long-running hobby project to
do this for i.MX5 and i.MX6 - I have a tree from months ago where I
restructured the way clocks are probed for both these (moving from
mach-imx to drivers/clk and putting in the right places) and
successfully moved 8 clocks (on i.MX51, 3 core PLLs, some fixed clocks
which got done in the meantime upstream, and one in the CCM - the CPU
freq divider) with the correct references and it all operated really
well.

In the meantime I had to add a bunch of weird hacks to the drivers to
deal with the missing connection names, so this being generic would
allow the core clock work to be finished while the drivers are brought
up to the new convention.

> Still this might be a good enough justification for having a generic
> solution for this problem, but I would wait with this until the real need
> on some of such platforms shows up. I don't see anything wrong in
> implementing this first as TI-specific quirk and then possibly making it
> generic if such need shows up.

Indeed.. and I would like to make use of it but I'm not coding on a TI
platform or a Samsung platform:)

> By the way, we already have something like this in clk/samsung/clk.c .
> This is called aliases there and allows registering clkdev look-ups for
> particular clocks. However this is specific to our clock drivers that
> register all clocks inside a single clock privder, based on static ID
> assignment and all clocks statically listed in clock driver - see
> clk/samsung/clk-s3c64xx.c for an example.

Right. I'll keep it in mind as I do this.

Thanks, this does make my life a lot easier, means I might have it
working and submitted before the end of the month instead of sometime
next year, I was dreading reworking all these drivers up front ;)

Matt Sealey <neko@bakuhatsu.net>
