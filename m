From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 02/10] ARM: OMAP: Fix sparse, checkpatch warnings in
 OMAP2/3 PRCM/PM code
Date: Mon, 6 Oct 2008 09:13:39 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0810060911500.354@utopia.booyaka.com>
References: <20081002163508.15385.43247.stgit@localhost.localdomain> <20081002163749.15385.75147.stgit@localhost.localdomain> <20081004131911.GA5674@flint.arm.linux.org.uk> <alpine.DEB.2.00.0810060848470.354@utopia.booyaka.com>
 <20081006150903.GA27466@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:57776 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752618AbYJFPNe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Oct 2008 11:13:34 -0400
In-Reply-To: <20081006150903.GA27466@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Mon, 6 Oct 2008, Russell King - ARM Linux wrote:

> On Mon, Oct 06, 2008 at 08:52:46AM -0600, Paul Walmsley wrote:
> > OK.  Tony's tree contains some patches which thoroughly clean this 
> > function up, but they are large.  Would you like me to send those along 
> > with this patch set, or would you prefer that I just drop this part of the 
> > patch and repost?
> 
> Probably the most productive solution is to drop that part and repost.

Will do.

> However, my thoughts from looking over the existing clock code is that,
> at some point, I'd like to rewrite the entire OMAP clk code to get rid
> of stuff like this.  Realistically, I'm scared to do so - the current
> implementation is very complex that getting a proper overview is rather
> difficult...

Perhaps the current code in Tony's tree at:

http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=blob;f=arch/arm/mach-omap2/clock.c;h=c3af24e8e3e557029f3cc07a7c8384d3a4befdd2;hb=HEAD#l298

is more reasonable?

(human readable reference: line 298 of arch/arm/mach-omap2/clock.c)


- Paul
