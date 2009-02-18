From: Pierre Ossman <drzeus-mmc@drzeus.cx>
Subject: Re: [patch 2.6.29-rc3] omap_hsmmc:  card detect irq bugfix
Date: Wed, 18 Feb 2009 21:26:55 +0100
Message-ID: <20090218212655.1c869422@mjolnir.ossman.eu>
References: <200902041442.04033.david-b@pacbell.net>
	<20090218062511.5f75aba9@mjolnir.ossman.eu>
	<20090218061359.GN11928@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 82-117-125-11.tcdsl.calypso.net ([82.117.125.11]:56103 "EHLO
	smtp.drzeus.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752391AbZBRU07 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Feb 2009 15:26:59 -0500
In-Reply-To: <20090218061359.GN11928@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: David Brownell <david-b@pacbell.net>, OMAP <linux-omap@vger.kernel.org>

On Tue, 17 Feb 2009 22:13:59 -0800
Tony Lindgren <tony@atomide.com> wrote:

> * Pierre Ossman <drzeus-mmc@drzeus.cx> [090217 21:25]:
> > On Wed, 4 Feb 2009 14:42:03 -0800
> > David Brownell <david-b@pacbell.net> wrote:
> > 
> > > From: David Brownell <dbrownell@users.sourceforge.net>
> > > 
> > > Work around lockdep issue when card detect IRQ handlers run in
> > > thread context ... it forces IRQF_DISABLED, which prevents all
> > > access to twl4030 card detect signals.
> > > 
> > > Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> > > ---
> > 
> > An ack from eiter Tony or one of the listed authors of this driver
> > would be nice.
> 
> Here you are:
> 
> Acked-by: Tony Lindgren <tony@atomide.com>
> 

Queued. Could you have a look at the other omap_hsmmc patches as well?
And a patch for MAINTAINERS so that I can keep track of who's baby this
is. :)

Rgds
-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  rdesktop, core developer          http://www.rdesktop.org

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.
