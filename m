From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC/PATCH] twl4030: Set irq number based upon cpu type rather
	than requiring #define in board.h files
Date: Tue, 6 May 2008 16:29:51 -0700
Message-ID: <20080506232950.GK18682@atomide.com>
References: <5e088bd90805061214i2ff9a22x118bcc26b0578cbc@mail.gmail.com> <20080506212809.GC18682@atomide.com> <20080506223844.GA12414@kedavra.cpe.vivax.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:50553 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754069AbYEFX3x (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 May 2008 19:29:53 -0400
Content-Disposition: inline
In-Reply-To: <20080506223844.GA12414@kedavra.cpe.vivax.com.br>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: Steve Sakoman <sakoman@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Felipe Balbi <me@felipebalbi.com> [080506 15:37]:
> On Tue, May 06, 2008 at 02:28:09PM -0700, Tony Lindgren wrote:
> > * Steve Sakoman <sakoman@gmail.com> [080506 12:15]:
> > > From: Steve Sakoman <steve@sakoman.com>
> > > 
> > > Set twl4030 irq number based upon cpu type rather than requiring
> > > #define in board.h files
> > 
> > Thanks, looks good to me until we have a patch that passes the irq
> > in struct i2c_board_info.
> 
> I started working on this, but it's really a lot of work. Any changes in
> twl4030-core seems to break other modules. So i'll try to make it not
> too invasive on the current code for now.
> 
> Anyway, try to make it before 2.6.27 :-p

OK, good to hear you're working on it. I'll push Steve's patch
meanwhile.

Tony
