From: Tony Lindgren <tony@atomide.com>
Subject: Re: FOR COMMENT: void __iomem * and similar casts are Bad News
Date: Thu, 4 Sep 2008 18:07:17 -0700
Message-ID: <20080905010717.GY23085@atomide.com>
References: <20080827220821.GE7227@flint.arm.linux.org.uk> <a0580c510809030833w6cbc7e42ye0e8f4fc49b5b046@mail.gmail.com> <20080904094655.GB10426@flint.arm.linux.org.uk> <20080904161033.GQ23085@atomide.com> <20080904161248.GC2309@flint.arm.linux.org.uk> <20080904162917.GR23085@atomide.com> <20080904170733.GD2309@flint.arm.linux.org.uk> <20080904175810.GS23085@atomide.com> <20080904210129.GG2309@flint.arm.linux.org.uk> <20080904212008.GU23085@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:55194 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750955AbYIEBH0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Sep 2008 21:07:26 -0400
Content-Disposition: inline
In-Reply-To: <20080904212008.GU23085@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Eduardo Valentin <edubezval@gmail.com>, linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [080904 14:20]:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [080904 14:01]:
> > On Thu, Sep 04, 2008 at 10:58:13AM -0700, Tony Lindgren wrote:
> > > * Russell King - ARM Linux <linux@arm.linux.org.uk> [080904 10:07]:
> > > > On Thu, Sep 04, 2008 at 09:29:19AM -0700, Tony Lindgren wrote:
> > > > > That was fast :) Sounds we'll have a patch to test soon.
> > > > 
> > > > Of course.  In my tree.  The master branch contains the minimal fixes,
> > > > and the devel branch contains everything.  If you want the individual
> > > > patches, either pull the tree or grab the mboxes.
> > > 
> > > Hey looks good! I'll cherry pick them to l-o tree, then let's make
> > > sure things work as expected.
> > 
> > BTW, having an ack (or even an ok) for that last patch in the master
> > branch would be useful:
> > 
> > [ARM] omap: fix virtual vs physical address space confusions
> 
> Here you are:
> 
> Acked-by: Tony Lindgren <tony@atomide.com>
> 
> > Planning to send them off tonight.
> 
> Great.
> 
> Also, I'm about to push your devel patches to l-o tree once I get
> done transplanting them. So far things are working just fine.

Your devel patches are pushed now too to l-o. Here's my ack for the
remaining patches:

[ARM] omap: improve is_omap_port()
[SERIAL] 8250: serial8250_port_size() - omap ports are larger
[ARM] omap: remove an io_v2p() usage
[ARM] omap: allow ioremap() to use our fixed IO mappings
[ARM] omap: convert OMAP drivers to use ioremap()
[ARM] omap: convert mcbsp to use ioremap()
omap: Fix IO_ADDRESS() macros
[ARM] omap: make sure virtual mmio addresses are __iomem pointer-like

Acked-by: Tony Lindgren <tony@atomide.com>

Thanks,

Tony
