From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 05/14] omap: Use ioremap in gpio.c
Date: Sat, 17 Oct 2009 09:13:48 -0700
Message-ID: <20091017161347.GJ12576@atomide.com>
References: <20091016233624.2463.26653.stgit@localhost> <20091016234104.2463.54276.stgit@localhost> <20091017081004.GA648@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:54741 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752724AbZJQQN5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 17 Oct 2009 12:13:57 -0400
Content-Disposition: inline
In-Reply-To: <20091017081004.GA648@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [091017 01:10]:
> On Fri, Oct 16, 2009 at 04:41:04PM -0700, Tony Lindgren wrote:
> > +	{ OMAP1_MPUIO_VBASE, 0, INT_MPUIO, IH_MPUIO_BASE,
> 
> That 0 should be NULL - it's a pointer.

Right, thanks, will update.

Tony
