From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 02/10] OMAP: iommu: add initial debugfs support
Date: Sun, 16 Aug 2009 21:47:32 +0100
Message-ID: <20090816204732.GA23875@n2100.arm.linux.org.uk>
References: <20090812120926.17601.85860.stgit@localhost> <20090812121324.17601.39083.stgit@localhost> <20090813092359.GS6132@n2100.arm.linux.org.uk> <20090815.150603.104063905.Hiroshi.DOYU@nokia.com> <20090816151347.GZ7278@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:33394 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755941AbZHPUrn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 16 Aug 2009 16:47:43 -0400
Content-Disposition: inline
In-Reply-To: <20090816151347.GZ7278@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Sun, Aug 16, 2009 at 06:13:55PM +0300, Tony Lindgren wrote:
> * Hiroshi DOYU <Hiroshi.DOYU@nokia.com> [090815 15:06]:
> > Hi Russell,
> > 
> > From: ext Russell King - ARM Linux <linux@arm.linux.org.uk>
> > Subject: Re: [PATCH 02/10] OMAP: iommu: add initial debugfs support
> > Date: Thu, 13 Aug 2009 11:23:59 +0200
> > 
> > > On Wed, Aug 12, 2009 at 03:13:24PM +0300, Tony Lindgren wrote:
> > > > +static DEFINE_MUTEX(iommu_debug_lock);
> > > > +static char local_buffer[SZ_4K];
> > > 
> > > I don't like this - what if the data you're sprintf'ing into this
> > > buffer overflows it?
> > 
> > Right.
> > 
> > I have attached the updated version which limits max write counts to
> > avoid the above buffer overflow.
> 
> Thanks, I've update my queue with it.

I'm not sure the patch is correct yet.  I think this update introduced
some bugs.  Consider the debug_read_* functions and consider what
happens if count = 1 but ppos != 0.
