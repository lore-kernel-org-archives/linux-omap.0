From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: v3.10-rc1: backlight brightness after boot on N900
Date: Fri, 17 May 2013 23:51:13 +0200
Message-ID: <CACRpkdbnN9_3hRR4i9E9V3ULa6ZbvtqSow3BxBfhN=0_ed-L8Q@mail.gmail.com>
References: <20130515171845.GB3157@blackmetal.musicnaut.iki.fi>
	<519465FC.9090002@ti.com>
	<20130517182504.GC31836@blackmetal.musicnaut.iki.fi>
	<20130517184534.GZ5600@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:57289 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932072Ab3EQVvO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 May 2013 17:51:14 -0400
Received: by mail-ie0-f171.google.com with SMTP id e11so10431252iej.16
        for <linux-omap@vger.kernel.org>; Fri, 17 May 2013 14:51:13 -0700 (PDT)
In-Reply-To: <20130517184534.GZ5600@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jon Hunter <jon-hunter@ti.com>, Linux-OMAP <linux-omap@vger.kernel.org>

On Fri, May 17, 2013 at 8:45 PM, Tony Lindgren <tony@atomide.com> wrote:

> OK that should be fixed by ab6ec0fb (gpio/omap: ensure gpio context is initialised)
> in linux-next. Can you check if that helps?
>
> Looks like it has not yet been merged to mainline tree.
> Linus W, any news on when you might be sending that fix upstream?

It fell out because of the other debacle during the merge window.

I'm more than overloaded (due to the ever increasing development pace
of the kernel I guess) so queueing fixes takes some time.

Yours,
Linus Walleij
