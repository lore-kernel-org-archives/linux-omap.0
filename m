From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 2.6.29-rc3] omap_hsmmc:  card detect irq bugfix
Date: Tue, 17 Feb 2009 22:13:59 -0800
Message-ID: <20090218061359.GN11928@atomide.com>
References: <200902041442.04033.david-b@pacbell.net> <20090218062511.5f75aba9@mjolnir.ossman.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:54260 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750984AbZBRGOG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Feb 2009 01:14:06 -0500
Content-Disposition: inline
In-Reply-To: <20090218062511.5f75aba9@mjolnir.ossman.eu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pierre Ossman <drzeus-mmc@drzeus.cx>
Cc: David Brownell <david-b@pacbell.net>, OMAP <linux-omap@vger.kernel.org>

* Pierre Ossman <drzeus-mmc@drzeus.cx> [090217 21:25]:
> On Wed, 4 Feb 2009 14:42:03 -0800
> David Brownell <david-b@pacbell.net> wrote:
> 
> > From: David Brownell <dbrownell@users.sourceforge.net>
> > 
> > Work around lockdep issue when card detect IRQ handlers run in
> > thread context ... it forces IRQF_DISABLED, which prevents all
> > access to twl4030 card detect signals.
> > 
> > Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> > ---
> 
> An ack from eiter Tony or one of the listed authors of this driver
> would be nice.

Here you are:

Acked-by: Tony Lindgren <tony@atomide.com>

Regards,

Tony
