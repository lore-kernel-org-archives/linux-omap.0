From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [RFC/PATCH] twl4030: Set irq number based upon cpu type rather
	than requiring #define in board.h files
Date: Wed, 7 May 2008 01:38:45 +0300
Message-ID: <20080506223844.GA12414@kedavra.cpe.vivax.com.br>
References: <5e088bd90805061214i2ff9a22x118bcc26b0578cbc@mail.gmail.com> <20080506212809.GC18682@atomide.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:48764 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933486AbYEFWhp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 May 2008 18:37:45 -0400
Content-Disposition: inline
In-Reply-To: <20080506212809.GC18682@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Steve Sakoman <sakoman@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, May 06, 2008 at 02:28:09PM -0700, Tony Lindgren wrote:
> * Steve Sakoman <sakoman@gmail.com> [080506 12:15]:
> > From: Steve Sakoman <steve@sakoman.com>
> > 
> > Set twl4030 irq number based upon cpu type rather than requiring
> > #define in board.h files
> 
> Thanks, looks good to me until we have a patch that passes the irq
> in struct i2c_board_info.

I started working on this, but it's really a lot of work. Any changes in
twl4030-core seems to break other modules. So i'll try to make it not
too invasive on the current code for now.

Anyway, try to make it before 2.6.27 :-p

-- 
Best Regards,

Felipe Balbi
me@felipebalbi.com
http://blog.felipebalbi.com
