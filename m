From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v4 1/2] gpio/omap: don't create an IRQ mapping for every
 GPIO on DT
Date: Mon, 1 Jul 2013 10:04:18 +0200
Message-ID: <CACRpkdaQ+zvrYF6o65Emkf2yiMR4YOfutBv-LTDc0xOmnkZkBg@mail.gmail.com>
References: <1372433223-9053-1-git-send-email-javier.martinez@collabora.co.uk>
	<CACRpkdZryWYZuOLx5E2njLNRd1SLj4VgtEyEETh88+3SS5ckyQ@mail.gmail.com>
	<CAAwP0s2jtVEoqMVE7ru-tcXMX8ZKZObnDz0UDWiS4QkbJODOHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f45.google.com ([209.85.219.45]:57939 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752738Ab3GAIET (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Jul 2013 04:04:19 -0400
Received: by mail-oa0-f45.google.com with SMTP id j1so4447095oag.4
        for <linux-omap@vger.kernel.org>; Mon, 01 Jul 2013 01:04:18 -0700 (PDT)
In-Reply-To: <CAAwP0s2jtVEoqMVE7ru-tcXMX8ZKZObnDz0UDWiS4QkbJODOHA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Grant Likely <grant.likely@linaro.org>, Jon Hunter <jgchunter@gmail.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Enric Balletbo Serra <eballetbo@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Florian Vaussard <florian.vaussard@epfl.ch>, Aaro Koskinen <aaro.koskinen@iki.fi>

On Sun, Jun 30, 2013 at 2:25 AM, Javier Martinez Canillas
<martinez.javier@gmail.com> wrote:

> Yes, It doesn't apply cleanly to your "next" branch cleanly because
> this patch-set depends on the following bugfix patch merged late on
> the -rc cycle (3.10-rc7):
>
> 397eada9 ("gpio/omap: don't use linear domain mapping for OMAP1")

Aha, well this fix was only CC:ed to Grant so I never saw it
happen. Obviously it cannot be merged through my GPIO tree
then.

> So, I could change the patches so they can be applied cleanly on your
> branch but then it will not apply cleanly when you send your pull
> request to Torvalds.

That will probably not work as it would cause even more conflicts
upstream, and now the merge window is open so no way can I
rebase the tree either.

Let's see if we can cram it in as part of a late v3.11 merge or
if we'll have to defer to v3.12.

Yours,
Linus Walleij
