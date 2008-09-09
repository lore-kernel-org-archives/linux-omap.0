From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 2.6.27-rc3-omap1] omap2_nand updates
Date: Mon, 8 Sep 2008 18:02:40 -0700
Message-ID: <20080909010240.GL29054@atomide.com>
References: <200808311419.05598.david-b@pacbell.net> <20080831215405.GM9887@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:51617 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754170AbYIIBCp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Sep 2008 21:02:45 -0400
Content-Disposition: inline
In-Reply-To: <20080831215405.GM9887@frodo>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: David Brownell <david-b@pacbell.net>, linux-omap@vger.kernel.org

* Felipe Balbi <me@felipebalbi.com> [080831 14:54]:
> On Sun, Aug 31, 2008 at 02:19:05PM -0700, David Brownell wrote:
> > From: David Brownell <dbrownell@users.sourceforge.net>
> > 
> > Minor updates to the OMAP{2,3} NAND driver:
> > 
> >  - Rename those buffer PIO routines as *_buf16()
> >  - Get rid of pointless LE16 data conversions; OMAP is always LE
> >  - Speed up buffer reads by switching to __raw_readsl()
> > 
> > Right now this driver only handles 16-bit NAND, but eventually it
> > should handle 8-bit too.  Moreover it may be worth using DMA...
> > 
> > Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> 
> Thanks Dave, I'll melded it up in my queue.

Pushing to linux-omap tree today.

Tony
