From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: [PATCH] [RFC] dmtimer library is very inefficient today
Date: Wed, 19 Mar 2008 20:52:30 +0100
Message-ID: <20080319195230.GA20320@michl.2n.cz>
References: <ae36f8040803061301y6e0823a8pbdf0b6f0b47e5639@mail.gmail.com> <3B6D69C3A9EBCA4BA5DA60D91302742903AFC880@dlee13.ent.ti.com> <20080307071454.GC7635@atomide.com> <3B6D69C3A9EBCA4BA5DA60D91302742903C4A2ED@dlee13.ent.ti.com> <87abkv9917.fsf@paris.hilman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ex.2n.cz ([213.29.92.11]:6484 "EHLO ex.2n.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754658AbYCSUCk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Mar 2008 16:02:40 -0400
Content-Disposition: inline
In-Reply-To: <87abkv9917.fsf@paris.hilman.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@mvista.com>
Cc: linux-omap@vger.kernel.org

On Tue, Mar 18, 2008 at 11:33:40AM -0700, Kevin Hilman wrote:
> and upstream folks tend dislike the polling loops like this:
> 
>    while(condition);
> 
> and prefer the semicolon on its own line to be clear that the loop is
> indeed doing nothing.
> 
>    while(condition)
>            ;
> 

Once there, polling loops usually looks like this

	while (condition)
		cpu_relax();

