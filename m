From: Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH v4 1/2] gpio/omap: don't create an IRQ mapping for every
 GPIO on DT
Date: Mon, 1 Jul 2013 13:49:15 +0100
Message-ID: <CACxGe6sf4SEMuiYAPpUq=zE1ENu8cwPkz6G_9X8j5TjrmVDEhw@mail.gmail.com>
References: <1372433223-9053-1-git-send-email-javier.martinez@collabora.co.uk>
 <CACRpkdZryWYZuOLx5E2njLNRd1SLj4VgtEyEETh88+3SS5ckyQ@mail.gmail.com>
 <CAAwP0s2jtVEoqMVE7ru-tcXMX8ZKZObnDz0UDWiS4QkbJODOHA@mail.gmail.com> <CACRpkdaQ+zvrYF6o65Emkf2yiMR4YOfutBv-LTDc0xOmnkZkBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:35253 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753553Ab3GAMtg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Jul 2013 08:49:36 -0400
Received: by mail-ie0-f172.google.com with SMTP id 16so9173185iea.31
        for <linux-omap@vger.kernel.org>; Mon, 01 Jul 2013 05:49:35 -0700 (PDT)
In-Reply-To: <CACRpkdaQ+zvrYF6o65Emkf2yiMR4YOfutBv-LTDc0xOmnkZkBg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Javier Martinez Canillas <martinez.javier@gmail.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Jon Hunter <jgchunter@gmail.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Enric Balletbo Serra <eballetbo@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Florian Vaussard <florian.vaussard@epfl.ch>, Aaro Koskinen <aaro.koskinen@iki.fi>

On Mon, Jul 1, 2013 at 9:04 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Sun, Jun 30, 2013 at 2:25 AM, Javier Martinez Canillas
> <martinez.javier@gmail.com> wrote:
>
>> Yes, It doesn't apply cleanly to your "next" branch cleanly because
>> this patch-set depends on the following bugfix patch merged late on
>> the -rc cycle (3.10-rc7):
>>
>> 397eada9 ("gpio/omap: don't use linear domain mapping for OMAP1")
>
> Aha, well this fix was only CC:ed to Grant so I never saw it
> happen. Obviously it cannot be merged through my GPIO tree
> then.
>
>> So, I could change the patches so they can be applied cleanly on your
>> branch but then it will not apply cleanly when you send your pull
>> request to Torvalds.
>
> That will probably not work as it would cause even more conflicts
> upstream, and now the merge window is open so no way can I
> rebase the tree either.
>
> Let's see if we can cram it in as part of a late v3.11 merge or
> if we'll have to defer to v3.12.

Linus, you can actually merge in the final v3.10 tag into your
gpio-next branch and then apply on top of that. I would send it as two
separate pull requests though. One pull with all the stuff that was in
linux-next, and a second that includes the v3.10 merge and the OMAP
patches. Include an explaination in that pull request that it is an
important bug fix, but it took a bit of time to get it worked out
correctly; hence the reason for the merge. That will let Linus T make
a decision about whether or not to merge it without affecting the bulk
of the gpio changes.

g.
