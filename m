From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH] ARM: omap: rework platform selection
Date: Tue, 17 Jun 2014 10:03:07 -0500
Message-ID: <CAL_Jsq+MK+HMqE3k8p06bzzohzS0qu84N12C=VgF9_dMcSGGOQ@mail.gmail.com>
References: <5701099.0P1SIXsHc1@wuerfel> <20140616141712.GL17845@atomide.com>
 <CABGGisxdKznLzR+0b0oYrN+aiWM0gNFbzYwfPtAZF=AiapU=eQ@mail.gmail.com> <201406171557.15819.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ve0-f179.google.com ([209.85.128.179]:41718 "EHLO
	mail-ve0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933047AbaFQPD2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Jun 2014 11:03:28 -0400
Received: by mail-ve0-f179.google.com with SMTP id sa20so5909781veb.10
        for <linux-omap@vger.kernel.org>; Tue, 17 Jun 2014 08:03:27 -0700 (PDT)
In-Reply-To: <201406171557.15819.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Rob Herring <rob.herring@linaro.org>, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, "arm@kernel.org" <arm@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On Tue, Jun 17, 2014 at 8:57 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 16 June 2014, Rob Herring wrote:
>> > So far I have not come up with no great ideas on fixing this
>> > properly short of requiring all omap .config files to add
>> > CONFIG_ARCH_OMAP=y manually. Anybody got good ideas for that?
>>
>> I've failed to come up with anything...
>>
>
> I have two ideas, but neither is great:
>
> a) we leave the individual per-soc options in the top-level menu
>    and move the sub-options under those. This is a bit or a problem
>    for options concerning all of OMAP, but I'm not sure how many of
>    those are actually required.
>
> b) We go back to Rob's version and make CONFIG_ARCH_OMAP the
>    user-selectable option, and then find another solution for
>    building a kernel with ARCH_OMAP set but none of individual
>    options. This will work for anybody who has a full .config
>    file, but still break the 'make savedefconfig' generated ones.

After playing with this more yesterday, I think ARCH_OMAP2PLUS instead
of ARCH_OMAP is actually a better choice to make the menuconfig item.
It still has the same defconfig issues, but doesn't affect OMAP1.

Doing your trick of a default selection with "select ARCH_OMAP2 if
!(ARCH_OMAP3 || ARCH_OMAP4 || ...)" in the menuconfig option can fix
the build issues. We'd actually need 2 selects for v6 and v7 only
builds.

Rob
