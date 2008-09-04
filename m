From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: FOR COMMENT: void __iomem * and similar casts are Bad News
Date: Thu, 4 Sep 2008 22:01:29 +0100
Message-ID: <20080904210129.GG2309@flint.arm.linux.org.uk>
References: <20080827220821.GE7227@flint.arm.linux.org.uk> <a0580c510809030833w6cbc7e42ye0e8f4fc49b5b046@mail.gmail.com> <20080904094655.GB10426@flint.arm.linux.org.uk> <20080904161033.GQ23085@atomide.com> <20080904161248.GC2309@flint.arm.linux.org.uk> <20080904162917.GR23085@atomide.com> <20080904170733.GD2309@flint.arm.linux.org.uk> <20080904175810.GS23085@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:34888 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753483AbYIDVBo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Sep 2008 17:01:44 -0400
Content-Disposition: inline
In-Reply-To: <20080904175810.GS23085@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, linux-omap@vger.kernel.org

On Thu, Sep 04, 2008 at 10:58:13AM -0700, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [080904 10:07]:
> > On Thu, Sep 04, 2008 at 09:29:19AM -0700, Tony Lindgren wrote:
> > > That was fast :) Sounds we'll have a patch to test soon.
> > 
> > Of course.  In my tree.  The master branch contains the minimal fixes,
> > and the devel branch contains everything.  If you want the individual
> > patches, either pull the tree or grab the mboxes.
> 
> Hey looks good! I'll cherry pick them to l-o tree, then let's make
> sure things work as expected.

BTW, having an ack (or even an ok) for that last patch in the master
branch would be useful:

[ARM] omap: fix virtual vs physical address space confusions

Planning to send them off tonight.
