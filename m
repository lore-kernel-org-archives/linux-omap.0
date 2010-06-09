From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] omap iommu: fixes for 2.6.35-rc1
Date: Wed, 9 Jun 2010 14:10:23 +0300
Message-ID: <20100609111023.GB15515@atomide.com>
References: <20100531122703.GD30216@atomide.com>
 <20100602.105046.39180136.Hiroshi.DOYU@nokia.com>
 <20100607111748.GM15515@atomide.com>
 <20100607.145051.71099999.Hiroshi.DOYU@nokia.com>
 <20100608113610.GS15515@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:61560 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757332Ab0FILKW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Jun 2010 07:10:22 -0400
Content-Disposition: inline
In-Reply-To: <20100608113610.GS15515@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-omap@vger.kernel.org, h-kanigeri2@ti.com, x0124230@ti.com

* Tony Lindgren <tony@atomide.com> [100608 14:30]:
> * Hiroshi DOYU <Hiroshi.DOYU@nokia.com> [100607 14:45]:
> > >  
> > >> Satish (1):
> > >>       omap iommu: Fix Memory leak
> > > 
> > > This one looks like a genuine fix :)
> > 
> > I've also updated the branch against -rc2. Please merge it if no problem.
> 
> OK, thanks for updating the series.

Well I ended up only cherry picking the memory leak one looking at
Linus' recent comments.. I've moved the two others into for-next
as they might be hard to justify as "regression fixes or
fixes to major bugs (oopses or security etc)". And we really want
to get the compile fixes in without having to wait for those.

Regards,

Tony
