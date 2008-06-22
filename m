From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 19/21] ARM: OMAP: Introduce omap_globals and prcm access functions for multi-omap
Date: Sun, 22 Jun 2008 15:08:53 +0100
Message-ID: <20080622140853.GG21366@flint.arm.linux.org.uk>
References: <1212802253-17797-13-git-send-email-tony@atomide.com> <1212802253-17797-14-git-send-email-tony@atomide.com> <1212802253-17797-15-git-send-email-tony@atomide.com> <1212802253-17797-16-git-send-email-tony@atomide.com> <1212802253-17797-17-git-send-email-tony@atomide.com> <1212802253-17797-18-git-send-email-tony@atomide.com> <1212802253-17797-19-git-send-email-tony@atomide.com> <1212802253-17797-20-git-send-email-tony@atomide.com> <20080614090925.GP32122@flint.arm.linux.org.uk> <20080617074633.GF13078@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54222 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752566AbYFVOJH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 22 Jun 2008 10:09:07 -0400
Content-Disposition: inline
In-Reply-To: <20080617074633.GF13078@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Tue, Jun 17, 2008 at 10:46:33AM +0300, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [080614 12:09]:
> > On Fri, Jun 06, 2008 at 06:30:51PM -0700, Tony Lindgren wrote:
> > > @@ -51,7 +50,7 @@ u32 omap_ctrl_readl(u16 offset)
> > >  void omap_ctrl_writeb(u8 val, u16 offset)
> > >  {
> > >  	pr_debug("omap_ctrl_writeb: writing 0x%0x to 0x%0x\n", val,
> > > -		 (u32)OMAP_CTRL_REGADDR(offset));
> > > +		 (__force u32)OMAP_CTRL_REGADDR(offset));
> > 
> > Casting to unsigned long avoids the need for __force.  __force should be
> > used sparingly.  Alternatively, use '%p' to print a pointer.
> > 
> > Apart from that, ok.
> 
> I've actually removed the verbose debug lines, those can be patched in
> as needed. Refreshed patch following.

Ok.
