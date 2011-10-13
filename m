From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] arm: omap: Fix errors and warnings when building for
	one board
Date: Thu, 13 Oct 2011 16:21:42 +0100
Message-ID: <20111013152142.GC22076@n2100.arm.linux.org.uk>
References: <1318517623-16066-1-git-send-email-premi@ti.com> <20111013145615.GB22076@n2100.arm.linux.org.uk> <B85A65D85D7EB246BE421B3FB0FBB5930257A57F4E@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:39581 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932093Ab1JMPVv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Oct 2011 11:21:51 -0400
Content-Disposition: inline
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB5930257A57F4E@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, Oct 13, 2011 at 08:36:19PM +0530, Premi, Sanjeev wrote:
> > -----Original Message-----
> > From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk] 
> > Sent: Thursday, October 13, 2011 8:26 PM
> > To: Premi, Sanjeev
> > Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> > Subject: Re: [PATCH] arm: omap: Fix errors and warnings when 
> > building for one board
> > 
> > On Thu, Oct 13, 2011 at 08:23:43PM +0530, Sanjeev Premi wrote:
> > > +#if defined(CONFIG_ARCH_OMAP4)
> > 
> > Please use #ifdef unless you're intending to expand the condition.
> > 
> 
> I tried to be consistent with existing use of #if defined() in the
> file(s). Will change it.

Thanks.

> Should I change the other instances as well?

I'd suggest not - though I can't really tell as I don't have a version
with that to look at.
