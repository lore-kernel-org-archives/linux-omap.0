From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: omap2: remove CONFIG_ARCH_OMAP2PLUS_TYPICAL
Date: Thu, 16 May 2013 08:23:41 -0700
Message-ID: <20130516152338.GQ5600@atomide.com>
References: <1368710950-2306-1-git-send-email-robherring2@gmail.com>
 <20130516151126.GP5600@atomide.com>
 <CAL_JsqJgc39YO3-L=-kgJ=wmXhe-dAP5nHngaCLbxfheAEvduA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:24741 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752163Ab3EPPXp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 May 2013 11:23:45 -0400
Content-Disposition: inline
In-Reply-To: <CAL_JsqJgc39YO3-L=-kgJ=wmXhe-dAP5nHngaCLbxfheAEvduA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Rob Herring <rob.herring@calxeda.com>, linux-omap <linux-omap@vger.kernel.org>

* Rob Herring <robherring2@gmail.com> [130516 08:25]:
> On Thu, May 16, 2013 at 10:11 AM, Tony Lindgren <tony@atomide.com> wrote:
> > * Rob Herring <robherring2@gmail.com> [130516 06:34]:
> >> From: Rob Herring <rob.herring@calxeda.com>
> >>
> >> CONFIG_ARCH_OMAP2PLUS_TYPICAL is selecting user defined features, not h/w
> >> required options. This does not play well with multi-platform kernels and
> >> belongs in a defconfig.
> >
> > Yes we can remove this. But let's update omap2plus_defconfig with these
> > options where needed. I can update this patch for that and queue it
> > if that works for you.
> >
> 
> Yes, that's fine. You might also want to enable the h/w related
> features to multi_v7_defconfig as well.

Yes will do. BTW, getting rid of CONFIG_ARCH_OMAP2PLUS_TYPICAL was the
reason I did not update multi_v7_defconfig yet.

I'll also update Arnd's randconfig fix patch and post it, then
will stick all three patches into one branch.

Regards,

Tony
