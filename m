From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] arm: omap: ehci: avoid compiler error with
 touchbook
Date: Tue, 9 Mar 2010 07:38:27 -0800
Message-ID: <20100309153827.GR2900@atomide.com>
References: <20100304074434.GI15954@nokia.com>
 <1267688753-6344-1-git-send-email-felipe.balbi@nokia.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0321CBCDFE@dbde02.ent.ti.com>
 <a05a09f453a7473f2ba54a9056589b72@secure211.sgcpanel.com>
 <20100305070330.GB12757@nokia.com>
 <20100308230422.GH2900@atomide.com>
 <20100309143020.GA12260@gandalf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:60779 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751591Ab0CIPhN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Mar 2010 10:37:13 -0500
Content-Disposition: inline
In-Reply-To: <20100309143020.GA12260@gandalf>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, "Gadiyar, Anand" <gadiyar@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

* Felipe Balbi <me@felipebalbi.com> [100309 06:27]:
> Hi,
> 
> On Mon, Mar 08, 2010 at 03:04:23PM -0800, Tony Lindgren wrote:
> > Hmm yeah thanks for digging into this mystery. Looks like we're
> > hitting some Linux initdata limitation.
> > 
> > We can't mark everything as __initconst. Some platform data can
> > get dynamically set based on the board type for resources.
> > 
> > So to me it sounds like the only solution is to mark everything
> > as __initdata and ignore the (correct) const for now for __initdata.
> > 
> > Or am I missing something?
> 
> sure. I'll cook something. But then it means all ehci_hcd_platform_data
> won't be able to be declared as const or that might cause problems as
> well later.

But sounds like your fix to mark anything going to init.rodata as const
is correct since it is rodata. I was originally thinking this is somehow
related to __init vs __initconst, but it's for __initconst only, and
we should use const there as it's read only.

Let me take another look at your patches and make sure everything
compiles OK, I don't think we're using __initconst in that many places.

Regards,

Tony
