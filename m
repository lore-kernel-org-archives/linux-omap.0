From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP3+: dpll: optimize noncore dpll locking logic
Date: Thu, 24 May 2012 08:57:45 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1205240856140.2572@utopia.booyaka.com>
References: <1337369838-15185-1-git-send-email-nm@ti.com> <alpine.DEB.2.00.1205240147510.2572@utopia.booyaka.com> <CAOMWX4c7T+8TcnjvcMonEQwAbpBFJXRhiBu_cu4i36W81AgLWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51044 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932287Ab2EXO5q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 May 2012 10:57:46 -0400
In-Reply-To: <CAOMWX4c7T+8TcnjvcMonEQwAbpBFJXRhiBu_cu4i36W81AgLWg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: Vikram Pandita <vikram.pandita@ti.com>, Tony Lindgren <tony@atomide.com>, Jon Hunter <jon-hunter@ti.com>, Mike Turquette <mturquette@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, 24 May 2012, Menon, Nishanth wrote:

> On Thu, May 24, 2012 at 2:49 AM, Paul Walmsley <paul@pwsan.com> wrote:
> > On Fri, 18 May 2012, Nishanth Menon wrote:
> >
> >> From: Vikram Pandita <vikram.pandita@ti.com>
> >>
> >> If the dpll is already locked, code can be optimized
> >> to return much earlier than doing redundent set of lock mode
> >> and wait on idlest.
> >>
> >> Cc: Tony Lindgren <tony@atomide.com>
> >> Cc: Jon Hunter <jon-hunter@ti.com>
> >> Cc: Paul Walmsley <paul@pwsan.com>
> >> Cc: Mike Turquette <mturquette@ti.com>
> >> Cc: linux-omap@vger.kernel.org
> >> Cc: linux-arm-kernel@lists.infradead.org
> >>
> >> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
> >
> > Did you intend to add your Signed-off-by: to this patch?
> 
> Other than forwarding the patch over(since it seems to have slipped
> through the fingers of folks monitoring the product trees), I have had
> no other contributions to the patch.

Okay.  As I understand it, the maintainers above me would like 
Signed-off-by:s from the entire submission patch, even if there are no 
contributions to the patch itself.  So please let me know if it's okay for 
me to add your S-o-b.


- Paul
