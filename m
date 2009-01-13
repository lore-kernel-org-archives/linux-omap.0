From: Tony Lindgren <tony@atomide.com>
Subject: Re: updated git pull request for omap compile fixes, mailbox and
	hsmmc
Date: Tue, 13 Jan 2009 12:30:02 +0200
Message-ID: <20090113102955.GB7344@atomide.com>
References: <20090107111615.GG27566@atomide.com> <20090107111744.GH27566@atomide.com> <20090107161843.GA11471@n2100.arm.linux.org.uk> <20090107175020.GU27566@atomide.com> <20090107220053.GD11471@n2100.arm.linux.org.uk> <20090108073611.GW27566@atomide.com> <20090110110524.GC28945@n2100.arm.linux.org.uk> <20090111101449.GA7684@n2100.arm.linux.org.uk> <20090112062441.GA4968@atomide.com> <20090112164329.GE6152@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:56352 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752253AbZAMKaR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Jan 2009 05:30:17 -0500
Content-Disposition: inline
In-Reply-To: <20090112164329.GE6152@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, "Nikula Jarkko (NRC/Helsinki)" <jarkko.nikula@nokia.com>, Pierre Ossman <drzeus-list@drzeus.cx>, "Jarkko Lavinen (NMP/Helsinki)" <jarkko.lavinen@nokia.com>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [090112 18:47]:
> On Mon, Jan 12, 2009 at 08:24:42AM +0200, Tony Lindgren wrote:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [090111 12:15]:
> > > On Sat, Jan 10, 2009 at 11:05:24AM +0000, Russell King - ARM Linux wrote:
> > > > On Thu, Jan 08, 2009 at 09:36:12AM +0200, Tony Lindgren wrote:
> > > > > Madhusudhan Chikkature (1):
> > > > >       omap mmc: Add new omap hsmmc controller for 2430 and 34xx, v3
> > > > 
> > > > This I'd argue falls into the same category, but since its well known
> > > > between us and Pierre who's acked it, I think it has sufficiently low
> > > > impact that it can be accepted.
> > > 
> > > ... and now -rc1 is out, it's now too late for this.
> > 
> > Oh well. Will resubmit it later on LKML for Pierre, at least
> > the MMC init code is mostly dealt with now.
> 
> Actually, as Pierre is okay with it coming via my tree, I'd prefer that
> so I can sanely run my devel branch on the LDP.

OK, will start putting together for-next branch.

Tony
