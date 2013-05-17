From: Tony Lindgren <tony@atomide.com>
Subject: Re: v3.10-rc1: backlight brightness after boot on N900
Date: Fri, 17 May 2013 15:09:09 -0700
Message-ID: <20130517220909.GC10378@atomide.com>
References: <20130515171845.GB3157@blackmetal.musicnaut.iki.fi>
 <519465FC.9090002@ti.com>
 <20130517182504.GC31836@blackmetal.musicnaut.iki.fi>
 <20130517184534.GZ5600@atomide.com>
 <CACRpkdbnN9_3hRR4i9E9V3ULa6ZbvtqSow3BxBfhN=0_ed-L8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:23618 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757279Ab3EQWJO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 May 2013 18:09:14 -0400
Content-Disposition: inline
In-Reply-To: <CACRpkdbnN9_3hRR4i9E9V3ULa6ZbvtqSow3BxBfhN=0_ed-L8Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Grant Likely <grant.likely@secretlab.ca>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jon Hunter <jon-hunter@ti.com>, Linux-OMAP <linux-omap@vger.kernel.org>

* Linus Walleij <linus.walleij@linaro.org> [130517 14:56]:
> On Fri, May 17, 2013 at 8:45 PM, Tony Lindgren <tony@atomide.com> wrote:
> 
> > OK that should be fixed by ab6ec0fb (gpio/omap: ensure gpio context is initialised)
> > in linux-next. Can you check if that helps?
> >
> > Looks like it has not yet been merged to mainline tree.
> > Linus W, any news on when you might be sending that fix upstream?
> 
> It fell out because of the other debacle during the merge window.
> 
> I'm more than overloaded (due to the ever increasing development pace
> of the kernel I guess) so queueing fixes takes some time.

Yes I can totally understand that, thanks for the update!

Regards,

Tony

