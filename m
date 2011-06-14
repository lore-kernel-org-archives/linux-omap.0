From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap3evm: Add Mistral WL12XX config support
Date: Tue, 14 Jun 2011 06:55:19 -0700
Message-ID: <20110614135518.GH23145@atomide.com>
References: <1308053788-25937-1-git-send-email-shahar@wizery.com>
 <20110614123359.GB23145@atomide.com>
 <BANLkTikE_caRE9uD6KN7h7OcY4nyUoRk9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:64609 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751586Ab1FNNzV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Jun 2011 09:55:21 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTikE_caRE9uD6KN7h7OcY4nyUoRk9g@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shahar Lev <shahar@wizery.com>
Cc: linux-omap@vger.kernel.org, linux-arm <linux-arm-kernel@lists.infradead.org>

* Shahar Lev <shahar@wizery.com> [110614 06:21]:
> On Tue, Jun 14, 2011 at 3:34 PM, Tony Lindgren <tony@atomide.com> wrote:
> >
> > This your should try to remove as it won't work nicely for supporting
> > various boards with the same kernel as we already do with
> > omap2plus_defconfig.
> >
> > Can you somehow detect the daughter board dynamically and then
> > set the flags?
> >
> 
> We thought about multi-board kernels, but unfortunately have no
> better solution, since there is no dynamic way to probe these cards.
> Even worse, these cards sometimes come with different clocks in them,
> hence the 2nd OMAP3EVM_MISTRAL_WL12XX_REFCLOCK entry we had to
> introduce...
> 
> Maybe we should add two bootargs with which the user can override this
> Kconfig configuration? This should allow using the same kernel binary
> with different omap3evm boards.
> 
> It's a bit cumbersome though..

Yes cmdline should do the trick until we have devicetree data
available..

Tony
