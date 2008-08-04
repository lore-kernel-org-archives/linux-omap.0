From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: Re: [PATCH] MTD: OMAP2-NAND: Fix partition reading from board info
Date: Mon, 4 Aug 2008 22:56:17 +0200
Message-ID: <20080804205617.GF31974@xi.wantstofly.org>
References: <9c9fda240807011627v60428f9eh3c2bb17cdc8ce6ea@mail.gmail.com> <200808041302.46323.david-b@pacbell.net> <20080804201715.GD31974@xi.wantstofly.org> <200808041326.38840.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from xi.wantstofly.org ([83.160.184.112]:45580 "EHLO
	xi.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762750AbYHDU4V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Aug 2008 16:56:21 -0400
Content-Disposition: inline
In-Reply-To: <200808041326.38840.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Tony Lindgren <tony@atomide.com>, "Kamat, Nishant" <nskamat@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kyungmin Park <kmpark@infradead.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>

On Mon, Aug 04, 2008 at 01:26:38PM -0700, David Brownell wrote:

> > > > Looks like this driver does not exist outside linux-omap tree,
> > > > care to send the whole driver to MTD list?
> > > 
> > > Unless someone created a big-endian OMAP,
> > 
> > Don't they use standard ARM ARM cores, which can all be used in both
> > LE and BE modes?
> 
> And when those cores turn into silicon, the choice is usually
> hard-wired.

I've never seen CPU endianity being hardwired in any ARM system ever
-- but maybe OMAP is different.

(Out of all the ARM subarchs supported in the kernel right now, I've had
ep93xx'es, iop13xx'es, iop32x'es, iop33x'es, ixp2000s, ixp23xx'es,
ixp4xx'es, kirkwoods, mv78xx0's, and orion5x'es all running in BE mode
at some point.)
