From: Tony Lindgren <tony@atomide.com>
Subject: Re: FOR COMMENT: void __iomem * and similar casts are Bad News
Date: Thu, 4 Sep 2008 10:58:13 -0700
Message-ID: <20080904175810.GS23085@atomide.com>
References: <20080827220821.GE7227@flint.arm.linux.org.uk> <a0580c510809030833w6cbc7e42ye0e8f4fc49b5b046@mail.gmail.com> <20080904094655.GB10426@flint.arm.linux.org.uk> <20080904161033.GQ23085@atomide.com> <20080904161248.GC2309@flint.arm.linux.org.uk> <20080904162917.GR23085@atomide.com> <20080904170733.GD2309@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:55128 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751851AbYIDR61 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Sep 2008 13:58:27 -0400
Content-Disposition: inline
In-Reply-To: <20080904170733.GD2309@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Eduardo Valentin <edubezval@gmail.com>, linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [080904 10:07]:
> On Thu, Sep 04, 2008 at 09:29:19AM -0700, Tony Lindgren wrote:
> > That was fast :) Sounds we'll have a patch to test soon.
> 
> Of course.  In my tree.  The master branch contains the minimal fixes,
> and the devel branch contains everything.  If you want the individual
> patches, either pull the tree or grab the mboxes.

Hey looks good! I'll cherry pick them to l-o tree, then let's make
sure things work as expected.

Tony
