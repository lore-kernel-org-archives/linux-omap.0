From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 02/10] OMAP: iommu: add initial debugfs support
Date: Mon, 17 Aug 2009 07:19:13 +0300 (EEST)
Message-ID: <20090817.071913.193709350.Hiroshi.DOYU@nokia.com>
References: <20090815.150603.104063905.Hiroshi.DOYU@nokia.com>
	<20090816151347.GZ7278@atomide.com>
	<20090816204732.GA23875@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:48705 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750703AbZHQETb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Aug 2009 00:19:31 -0400
In-Reply-To: <20090816204732.GA23875@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux@arm.linux.org.uk
Cc: tony@atomide.com, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

From: ext Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 02/10] OMAP: iommu: add initial debugfs support
Date: Sun, 16 Aug 2009 22:47:32 +0200

> On Sun, Aug 16, 2009 at 06:13:55PM +0300, Tony Lindgren wrote:
> > * Hiroshi DOYU <Hiroshi.DOYU@nokia.com> [090815 15:06]:
> > > Hi Russell,
> > > 
> > > From: ext Russell King - ARM Linux <linux@arm.linux.org.uk>
> > > Subject: Re: [PATCH 02/10] OMAP: iommu: add initial debugfs support
> > > Date: Thu, 13 Aug 2009 11:23:59 +0200
> > > 
> > > > On Wed, Aug 12, 2009 at 03:13:24PM +0300, Tony Lindgren wrote:
> > > > > +static DEFINE_MUTEX(iommu_debug_lock);
> > > > > +static char local_buffer[SZ_4K];
> > > > 
> > > > I don't like this - what if the data you're sprintf'ing into this
> > > > buffer overflows it?
> > > 
> > > Right.
> > > 
> > > I have attached the updated version which limits max write counts to
> > > avoid the above buffer overflow.
> > 
> > Thanks, I've update my queue with it.
> 
> I'm not sure the patch is correct yet.  I think this update introduced
> some bugs.  Consider the debug_read_* functions and consider what
> happens if count = 1 but ppos != 0.

I think that "simple_read_from_buffer()" can take care of the above
parameter checking?
