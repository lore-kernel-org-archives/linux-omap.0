From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/3] omap: rx51: Add supplies for the tlv320aic3x codec
 driver
Date: Wed, 5 May 2010 14:11:41 -0700
Message-ID: <20100505211140.GF29604@atomide.com>
References: <1272902176-21033-1-git-send-email-jhnikula@gmail.com>
 <1272902176-21033-3-git-send-email-jhnikula@gmail.com>
 <20100505172011.c57044f0.jhnikula@gmail.com>
 <20100505142513.GA11441@sirena.org.uk>
 <20100505151539.GU29604@atomide.com>
 <20100505214158.0605f710.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:52714 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757885Ab0EEVLn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 17:11:43 -0400
Content-Disposition: inline
In-Reply-To: <20100505214158.0605f710.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-omap@vger.kernel.org, Eduardo Valentin <eduardo.valentin@nokia.com>

* Jarkko Nikula <jhnikula@gmail.com> [100505 11:35]:
> On Wed, 5 May 2010 08:15:39 -0700
> Tony Lindgren <tony@atomide.com> wrote:
> 
> > * Mark Brown <broonie@opensource.wolfsonmicro.com> [100505 07:20]:
> > > Seems sensible to merge this along with the CODEC driver patch it
> > > depends on if everyone else is happy (assuming no merge issues)?
> > 
> > Sounds good to me. I'll take the other ones, if there are merge issues
> > then we can move some of the other patches into your tree too.
> > 
> > Acked-by: Tony Lindgren <tony@atomide.com>
> 
> I would rather keep the board-rx51-peripherals.c in linux-omap sync
> than get the N900 audio working as soon as possible :-)
> 
> None of these patches are build or boot critical so I can wait & repost
> the last one when the codec patches hit into mainline.
> 
> Only harm from some missing board-rx51-peripherals.c patch is that
> codec either doesn't probe or is kept in reset but system boots up
> fine. And trees are clean too!

OK, fine with me.

Tony

