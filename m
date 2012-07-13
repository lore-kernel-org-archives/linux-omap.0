From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP3: clockdomain: fix accidental duplicate
 registration
Date: Thu, 12 Jul 2012 23:47:14 -0700
Message-ID: <20120713064713.GI1122@atomide.com>
References: <alpine.DEB.2.00.1207120448120.25585@utopia.booyaka.com>
 <87394wg97u.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:58035 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752724Ab2GMGrS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Jul 2012 02:47:18 -0400
Content-Disposition: inline
In-Reply-To: <87394wg97u.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Joe Woodward <jw@terrafix.co.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Kevin Hilman <khilman@ti.com> [120712 10:55]:
> Paul Walmsley <paul@pwsan.com> writes:
> 
> > Commit 3dd50d0545bd5a8ad83d4339f07935cd3e883271 ("Merge tag 
> > 'omap-cleanup-for-v3.6' into tmp-merge") inadvertently caused a 
> > clockdomain to be registered twice on OMAP3 boards.  This causes warnings 
> > on boot, wild pointer dereferences, and PM regressions.  Fix the double 
> > registration and add some clockdomain code to prevent this from happening 
> > again.
> >
> > Reported-by: Joe Woodward <jw@terrafix.co.uk>
> > Cc: Tony Lindgren <tony@atomide.com>
> > Cc: Kevin Hilman <khilman@ti.com>
> > Signed-off-by: Paul Walmsley <paul@pwsan.com>
> 
> Acked-by: Kevin Hilman <khilman@ti.com>
> 
> This fixes the problem I reported here:
> 
>      http://marc.info/?l=linux-omap&m=134203768012711&w=2

OK thanks good to hear.

Regards,

Tony
