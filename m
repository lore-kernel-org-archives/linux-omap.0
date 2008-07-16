From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/0] Refreshed omap2 clock and powerdomain patches
Date: Wed, 16 Jul 2008 18:22:46 +0300
Message-ID: <20080716152243.GA8414@atomide.com>
References: <20080716094103.GD23468@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:63907 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760432AbYGPPVT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Jul 2008 11:21:19 -0400
Content-Disposition: inline
In-Reply-To: <20080716094103.GD23468@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [080716 12:41]:
> On Wed, Jul 16, 2008 at 11:53:20AM +0300, Tony Lindgren wrote:
> > This series contains the refreshed omap2 clock and powerdomain
> > patches as some of the patches in this series have been already
> > integrated.
> 
> I think the clock and power domain patches need much more review.
> They're introducing a couple of new management subsystems which may
> be of interest to other SoCs, maybe even different architectures.

Sure the power domain and clock domain code can be worked into
something more generic once we've figured out what can be shared.

I've posted these patches to LKML and linux-pm for other arch people to
look at too.

Regards,

Tony
