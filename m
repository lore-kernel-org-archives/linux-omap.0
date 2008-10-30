From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC 0/21 Continue phasing out legacy GPIO calls
Date: Thu, 30 Oct 2008 10:32:16 -0700
Message-ID: <20081030173215.GU13227@atomide.com>
References: <1225280189-6559-1-git-send-email-jarkko.nikula@nokia.com> <20081029160056.GD20456@atomide.com> <200810300043.07813.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:60736 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753596AbYJ3RcS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Oct 2008 13:32:18 -0400
Content-Disposition: inline
In-Reply-To: <200810300043.07813.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>, linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [081030 00:43]:
> On Wednesday 29 October 2008, Tony Lindgren wrote:
> > Let's do the clean-up patches in two phases, one series that
> > applies against the mainline kernel, then additional patches for
> > linux-omap. Otherwise we'll never get out of this merge hell.
> 
> Note that the patches I sent were in two phases ... but the
> other way around.  The OMAP-only patches can go in immediately,
> and won't change anything of node.

OK, thanks.

> But since the ones that "also" apply against mainline remove
> the legacy calls, they need to go later.  If it were realistic
> to merge them for 2.6.28, they could safely be pulled down IFF
> the OMAP-only patches were already in the OMAP tree.

Great, to me those look safe to merge. Can you Cc Russell on the
arch/arm/*omap* patches if you merge them via gpiolib patches?

Basically anything that will cause merge conflicts for omap-all
should go via Russell so we don't frustrate him further, but
I don't think these will cause an issue for him.

Tony
