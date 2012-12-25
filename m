From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: Re: [PATCH 00/15] OMAP SHAM & AES Crypto Updates
Date: Tue, 25 Dec 2012 12:17:03 -0700
Message-ID: <20121225191703.GB4846@animalcreek.com>
References: <1356107295-11121-1-git-send-email-mgreer@animalcreek.com>
 <87a9t78boa.fsf@dell.be.48ers.dk>
 <20121221192234.GA10722@animalcreek.com>
 <87hancu55q.fsf@dell.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:48927 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754082Ab2LYTRF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Dec 2012 14:17:05 -0500
Content-Disposition: inline
In-Reply-To: <87hancu55q.fsf@dell.be.48ers.dk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, paul@pwsan.com

On Sun, Dec 23, 2012 at 05:03:45PM +0100, Peter Korsgaard wrote:
> >>>>> "Mark" == Mark A Greer <mgreer@animalcreek.com> writes:
> 
> Hi,
> 
>  >> Huh, does am335x have a sham module? I don't see any mention of that
>  >> in spruh73g.pdf
> 
>  Mark> Yes.  It has sham, aes, and rng modules.
> 
> Ok, interesting.
> 
>  Mark> They are not described in the TRM.  In fact, I had to use the
>  Mark> omap4 description (closely guarded by TI) because AFAIK there
>  Mark> isn't a doc for the am33xx.  The am33xx modules are identical to
>  Mark> the omap4 ones except for the register addresses and dma channels
>  Mark> so that doc worked.
> 
> Odd. How did you figure out the am335x base address / dma channels?

>From the SDK code.  :)

That is, the am335x evm SDK from TI.  I looked at it to determine the
addresses, etc.

Mark
--
