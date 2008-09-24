From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Temporary fix to boot OMAP1 based boards
Date: Wed, 24 Sep 2008 17:43:37 +0300
Message-ID: <20080924144335.GU5222@atomide.com>
References: <dfeb90390809240005xadef43dhb78c8ae214baab64@mail.gmail.com> <20080924071201.GE5222@atomide.com> <20080924075959.GF5222@atomide.com> <alpine.DEB.2.00.0809240202250.15312@utopia.booyaka.com> <20080924080652.GG5222@atomide.com> <alpine.DEB.2.00.0809240207480.15312@utopia.booyaka.com> <20080924083446.GH5222@atomide.com> <alpine.DEB.2.00.0809240805410.15312@utopia.booyaka.com> <20080924142728.GT5222@atomide.com> <alpine.DEB.2.00.0809240830270.15312@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:60379 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752117AbYIXOnp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Sep 2008 10:43:45 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.0809240830270.15312@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@booyaka.com>
Cc: Arun KS <arunks@mistralsolutions.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, linux-omap@vger.kernel.org

* Paul Walmsley <paul@booyaka.com> [080924 17:35]:
> On Wed, 24 Sep 2008, Tony Lindgren wrote:
> 
> > * Paul Walmsley <paul@booyaka.com> [080924 17:06]:
> > > On Wed, 24 Sep 2008, Tony Lindgren wrote:
> > > 
> > > > How about this for a quick fix? It produces now a bunch of warnings
> > > > until omap1 clock uses offsets too.
> > > 
> > > Looks good to me.  Good to see that VIRTUAL_IO_ADDRESS flag gone -- 
> > 
> > OK, pushed with a minror change. I've marked DSP addresses as IOMEM.
> 
> Are those marked as IOMEM() already in 
> arch/arm/plat-omap/include/mach/hardware.h ?

No, but they could since it does not change the offset. Marking anything
OMAP1_IO_ADDRESS would require grepping for that register naturally..

Tony
