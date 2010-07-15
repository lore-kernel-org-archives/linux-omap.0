From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH resend] omap: 3630: disable TLL SAR on 3630 ES1
Date: Wed, 14 Jul 2010 23:01:09 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1007142257250.4823@utopia.booyaka.com>
References: <1278718469-7940-1-git-send-email-gadiyar@ti.com> <alpine.DEB.2.00.1007121414430.10106@utopia.booyaka.com> <5A47E75E594F054BAF48C5E4FC4B92AB0323A2C0F6@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:43650 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932267Ab0GOFBK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Jul 2010 01:01:10 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0323A2C0F6@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, 14 Jul 2010, Gadiyar, Anand wrote:

> Paul Walmsley wrote:
> 
> > Tony, once Anand does that, it's
> > 
> > Acked-by: Paul Walmsley <paul@pwsan.com>
> > 
> > if you want it for .36; otherwise, for .37, I'd be happy to queue it.
> 
> I assume you mean .35 and .36 here - isn't .37 another 3+ months away?

I mean .35 and .36 -- we're operating under the idea that Linus only wants 
regressions for the -rc series; and due to summer vacations, Kevin and I 
have already sent our patch queues for .36 to Tony.  So it's likely to be 
in .37, but it might get in for .36 depending on how schedules pan out.  
This patch seems quite straightforward to me.


- Paul
