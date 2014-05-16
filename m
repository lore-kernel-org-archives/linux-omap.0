From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: some hwmod data patches for v3.16
Date: Fri, 16 May 2014 14:23:27 -0700
Message-ID: <20140516212327.GI12881@atomide.com>
References: <alpine.DEB.2.02.1405160444200.29738@utopia.booyaka.com>
 <5375CE74.6000603@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:50133 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753737AbaEPVXc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 May 2014 17:23:32 -0400
Content-Disposition: inline
In-Reply-To: <5375CE74.6000603@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [140516 01:39]:
> Hi Paul,
> 
> On 16/05/14 07:45, Paul Walmsley wrote:
> > Hi Tony
> > 
> > The following changes since commit d1db0eea852497762cab43b905b879dfcd3b8987:
> > 
> >   Linux 3.15-rc3 (2014-04-27 19:29:27 -0700)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git for-v3.16/hwmod-a
> > 
> > for you to fetch changes up to 433480707967187a74ced38bd38edba749998013:
> > 
> >   ARM: OMAP2+: hwmod: OMAP5 DSS hwmod data (2014-05-14 12:26:10 -0600)
> > 
> > ----------------------------------------------------------------
> > First (and possibly last) set of hwmod data changes for v3.16.  This
> > set should clean up some obsolete OMAP4 hwmod data, and add OMAP5 DSS
> > support.
> 
> What about the AM43xx hwmod data I sent in the same series:
> 
> http://article.gmane.org/gmane.linux.ports.arm.omap/114192

I guess the issue there is that there's no way for Paul or much
anybody else to check it against any documentation or hardware :(

Is this just cut and paste code, or has you verified it against
the documentation and the hardare?

Anyways, pulling this set into omap-for-v3.16/soc thanks.

Regards,

Tony
