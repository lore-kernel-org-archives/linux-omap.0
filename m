From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: updated git pull request for omap compile fixes, mailbox and hsmmc
Date: Mon, 19 Jan 2009 16:36:58 +0000
Message-ID: <20090119163658.GF18301@n2100.arm.linux.org.uk>
References: <20090107111744.GH27566@atomide.com> <20090107161843.GA11471@n2100.arm.linux.org.uk> <20090107175020.GU27566@atomide.com> <20090107220053.GD11471@n2100.arm.linux.org.uk> <20090108073611.GW27566@atomide.com> <20090110110524.GC28945@n2100.arm.linux.org.uk> <20090111101449.GA7684@n2100.arm.linux.org.uk> <20090112062441.GA4968@atomide.com> <20090112164329.GE6152@n2100.arm.linux.org.uk> <20090113102955.GB7344@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54430 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751544AbZASQhJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Jan 2009 11:37:09 -0500
Content-Disposition: inline
In-Reply-To: <20090113102955.GB7344@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, "Nikula Jarkko (NRC/Helsinki)" <jarkko.nikula@nokia.com>, Pierre Ossman <drzeus-list@drzeus.cx>, "Jarkko Lavinen (NMP/Helsinki)" <jarkko.lavinen@nokia.com>

On Tue, Jan 13, 2009 at 12:30:02PM +0200, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [090112 18:47]:
> > On Mon, Jan 12, 2009 at 08:24:42AM +0200, Tony Lindgren wrote:
> > > * Russell King - ARM Linux <linux@arm.linux.org.uk> [090111 12:15]:
> > > > On Sat, Jan 10, 2009 at 11:05:24AM +0000, Russell King - ARM Linux wrote:
> > > > > On Thu, Jan 08, 2009 at 09:36:12AM +0200, Tony Lindgren wrote:
> > > > > > Madhusudhan Chikkature (1):
> > > > > >       omap mmc: Add new omap hsmmc controller for 2430 and 34xx, v3
> > > > > 
> > > > > This I'd argue falls into the same category, but since its well known
> > > > > between us and Pierre who's acked it, I think it has sufficiently low
> > > > > impact that it can be accepted.
> > > > 
> > > > ... and now -rc1 is out, it's now too late for this.
> > > 
> > > Oh well. Will resubmit it later on LKML for Pierre, at least
> > > the MMC init code is mostly dealt with now.
> > 
> > Actually, as Pierre is okay with it coming via my tree, I'd prefer that
> > so I can sanely run my devel branch on the LDP.
> 
> OK, will start putting together for-next branch.

I'd like the MMC driver on its own please.
