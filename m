From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH] ARM: omap: rework platform selection
Date: Tue, 17 Jun 2014 11:40:44 -0500
Message-ID: <CAL_JsqJ_Q8x03wu5w0i6qNa5KrmSF0id0TOp-nSw9jSorC6atw@mail.gmail.com>
References: <5701099.0P1SIXsHc1@wuerfel> <20140616141712.GL17845@atomide.com>
 <CABGGisxdKznLzR+0b0oYrN+aiWM0gNFbzYwfPtAZF=AiapU=eQ@mail.gmail.com>
 <201406171557.15819.arnd@arndb.de> <CAL_Jsq+MK+HMqE3k8p06bzzohzS0qu84N12C=VgF9_dMcSGGOQ@mail.gmail.com>
 <20140617152542.GU17845@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ve0-f180.google.com ([209.85.128.180]:53162 "EHLO
	mail-ve0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964824AbaFQQlG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Jun 2014 12:41:06 -0400
Received: by mail-ve0-f180.google.com with SMTP id jw12so7904398veb.11
        for <linux-omap@vger.kernel.org>; Tue, 17 Jun 2014 09:41:06 -0700 (PDT)
In-Reply-To: <20140617152542.GU17845@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Rob Herring <rob.herring@linaro.org>, linux-omap <linux-omap@vger.kernel.org>, "arm@kernel.org" <arm@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On Tue, Jun 17, 2014 at 10:25 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Rob Herring <robherring2@gmail.com> [140617 08:05]:
>> On Tue, Jun 17, 2014 at 8:57 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Monday 16 June 2014, Rob Herring wrote:
>> >> > So far I have not come up with no great ideas on fixing this
>> >> > properly short of requiring all omap .config files to add
>> >> > CONFIG_ARCH_OMAP=y manually. Anybody got good ideas for that?
>> >>
>> >> I've failed to come up with anything...
>> >>
>> >
>> > I have two ideas, but neither is great:
>> >
>> > a) we leave the individual per-soc options in the top-level menu
>> >    and move the sub-options under those. This is a bit or a problem
>> >    for options concerning all of OMAP, but I'm not sure how many of
>> >    those are actually required.
>> >
>> > b) We go back to Rob's version and make CONFIG_ARCH_OMAP the
>> >    user-selectable option, and then find another solution for
>> >    building a kernel with ARCH_OMAP set but none of individual
>> >    options. This will work for anybody who has a full .config
>> >    file, but still break the 'make savedefconfig' generated ones.
>>
>> After playing with this more yesterday, I think ARCH_OMAP2PLUS instead
>> of ARCH_OMAP is actually a better choice to make the menuconfig item.
>> It still has the same defconfig issues, but doesn't affect OMAP1.
>
> Well eventually we'll have the same problem for both ARCH_OMAP1
> and ARCH_OMAP2PLUS so from that point of view it might make sense
> to use ARCH_OMAP to start with.

But OMAP1 and OMAP2PLUS are mutually exclusive being v5 and v6+. So
there would not be any user visible difference having 2 visible
options. Do you expect any of these kconfig symbols to become
obsolete?

>> Doing your trick of a default selection with "select ARCH_OMAP2 if
>> !(ARCH_OMAP3 || ARCH_OMAP4 || ...)" in the menuconfig option can fix
>> the build issues. We'd actually need 2 selects for v6 and v7 only
>> builds.
>
> Yes that or the options in mach-omap2/Makefile can be fixed up
> further for building things only when a SoC is selected.
>
> So really the issue is how to deal with make oldconfig for
> existing .config files. I don't know if there's any solution to
> that short of doing make CONFIG_ARCH_OMAP=y oldconfig.

.config files are the full config, so wouldn't they be okay? It is
only the reduced savedefconfig that would break.

Rob

>
> Regards,
>
> Tony
