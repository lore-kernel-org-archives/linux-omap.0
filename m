From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] [RFC] dmtimer library is very inefficient today
Date: Thu, 20 Mar 2008 10:58:59 +0200
Message-ID: <20080320085858.GB14978@atomide.com>
References: <ae36f8040803061301y6e0823a8pbdf0b6f0b47e5639@mail.gmail.com> <3B6D69C3A9EBCA4BA5DA60D91302742903AFC880@dlee13.ent.ti.com> <20080307071454.GC7635@atomide.com> <3B6D69C3A9EBCA4BA5DA60D91302742903C4A2ED@dlee13.ent.ti.com> <87abkv9917.fsf@paris.hilman.org> <20080319195230.GA20320@michl.2n.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:62623 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753554AbYCTI7F (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Mar 2008 04:59:05 -0400
Content-Disposition: inline
In-Reply-To: <20080319195230.GA20320@michl.2n.cz>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: Kevin Hilman <khilman@mvista.com>, linux-omap@vger.kernel.org

* Ladislav Michl <ladis@linux-mips.org> [080319 22:32]:
> On Tue, Mar 18, 2008 at 11:33:40AM -0700, Kevin Hilman wrote:
> > and upstream folks tend dislike the polling loops like this:
> > 
> >    while(condition);
> > 
> > and prefer the semicolon on its own line to be clear that the loop is
> > indeed doing nothing.
> > 
> >    while(condition)
> >            ;
> > 
> 
> Once there, polling loops usually looks like this
> 
> 	while (condition)
> 		cpu_relax();

Thanks, I'll add those to the while looops.

Tony
