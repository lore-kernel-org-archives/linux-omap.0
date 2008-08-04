From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] MTD: OMAP2-NAND: Fix partition reading from board info
Date: Mon, 4 Aug 2008 13:26:38 -0700
Message-ID: <200808041326.38840.david-b@pacbell.net>
References: <9c9fda240807011627v60428f9eh3c2bb17cdc8ce6ea@mail.gmail.com> <200808041302.46323.david-b@pacbell.net> <20080804201715.GD31974@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp123.sbc.mail.sp1.yahoo.com ([69.147.64.96]:48608 "HELO
	smtp123.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1763904AbYHDU0k (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Aug 2008 16:26:40 -0400
In-Reply-To: <20080804201715.GD31974@xi.wantstofly.org>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: "Kamat, Nishant" <nskamat@ti.com>, Tony Lindgren <tony@atomide.com>, Kyungmin Park <kmpark@infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>

On Monday 04 August 2008, Lennert Buytenhek wrote:
> On Mon, Aug 04, 2008 at 01:02:46PM -0700, David Brownell wrote:
> 
> > > Looks like this driver does not exist outside linux-omap tree,
> > > care to send the whole driver to MTD list?
> > 
> > Unless someone created a big-endian OMAP,
> 
> Don't they use standard ARM ARM cores, which can all be used in both
> LE and BE modes?

And when those cores turn into silicon, the choice is usually
hard-wired.  Regardless, all OMAP cores I've worked with are
set up for LE mode ... and then there's still the point that
byteswapping to/from the NAND chip seems to add no value.

