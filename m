From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP2-only kernel compile broken
Date: Mon, 11 Jul 2011 01:26:50 -0700
Message-ID: <20110711082650.GN5783@atomide.com>
References: <alpine.DEB.2.00.1107091955040.15984@utopia.booyaka.com>
 <20110710095216.GN31978@legolas.emea.dhcp.ti.com>
 <alpine.DEB.2.00.1107100541110.15984@utopia.booyaka.com>
 <20110711062112.GA2680@legolas.emea.dhcp.ti.com>
 <alpine.DEB.2.00.1107110030120.18599@utopia.booyaka.com>
 <20110711064341.GF2680@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:64727 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757371Ab1GKI0x (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jul 2011 04:26:53 -0400
Content-Disposition: inline
In-Reply-To: <20110711064341.GF2680@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, hemahk@ti.com, linux-omap@vger.kernel.org

* Felipe Balbi <balbi@ti.com> [110710 23:38]:
> On Mon, Jul 11, 2011 at 12:31:30AM -0600, Paul Walmsley wrote:
> > On Mon, 11 Jul 2011, Felipe Balbi wrote:
> > 
> > > What on earth is arm-soc omap/cleanup branch ? I generally base my
> > > patches off of Linus' tags. This one in particular was based off of
> > > 3.0-rc6 (or -rc5, can't quite remember). Where is this particular branch
> > > I should base off ?
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/arm/linux-arm-soc.git 
> > 
> > This is Tony's new upstream tree.
> > 
> > Branch is 'omap/cleanup' in this case.

Please don't use those branches for basing patches unless specifically
agreed on.

> Ok, thanks for letting me know.
> 
> Tony, should we *always* base patches for you off of that tree ??

No please don't. Arnd will merge things into those branches to build
his topic specif branches for merging. Always use mainline Linux tags
where possible, or static branches in linux-omap tree that have been
specifically pointed out.

We want to keep dependencies to other trees minimal as they may pull
in other patches too. It also makes it harder to keep track of the
the omap specific code, and makes it harder to do topic specific pull
requests easily.

For example, most patches done against current devel-board should
merge fine with everything else.

Regards,

Tony
