From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 2/2] i2c: i2c-omap: Call request_irq with IRQF_DISABLED
Date: Thu, 12 Mar 2009 02:23:54 +0200
Message-ID: <20090312002353.GD19038@gandalf>
References: <cover.1236345858.git.Ext-Ari.Kauppi@nokia.com> <7d7e7dd1a4c64c732a21bdfcf2bd42556be708c3.1236345858.git.Ext-Ari.Kauppi@nokia.com> <20090310005222.GE19758@fluff.org.uk> <alpine.DEB.2.00.0903111741270.26959@utopia.booyaka.com> <20090311235908.GC19038@gandalf> <alpine.DEB.2.00.0903111804510.26959@utopia.booyaka.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:58452 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752592AbZCLAYI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Mar 2009 20:24:08 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.0903111804510.26959@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Felipe Balbi <me@felipebalbi.com>, Ari Kauppi <Ext-Ari.Kauppi@nokia.com>, Ben Dooks <ben@fluff.org.uk>, ben-linux@fluff.org, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org

On Wed, Mar 11, 2009 at 06:07:00PM -0600, Paul Walmsley wrote:
> Hi Felipe,
> 
> On Thu, 12 Mar 2009, Felipe Balbi wrote:
> 
> > On Wed, Mar 11, 2009 at 05:55:50PM -0600, Paul Walmsley wrote:
> > > Ben's right, there shouldn't be any need for this.  This patch could cause
> > > some unnecessary interrupt service latency.
> > 
> > That's not what Thomas Gleixner thinks. How about the possibility of
> > stack overflow ?
> 
> That sounds like a separate issue from the spurious IRQ problem that the 
> patch was intended to fix.   
> 
> I'm not familiar with the discussion on the stack overflow issue.  Could 
> you send a link?

This is the link where Ingo discusses why !IRQF_DISABLED could cause
stack overflow:

http://lkml.org/lkml/2009/3/3/71

You probably wanna take a look at the whole thread to figure out the
discussion, but basically Ingo and Peter (Zijlstra) believe
!IRQF_DISABLED is a bug and drivers needing that probably should be
using threaded irqs (which is not yet merged) or the hw is broken, and
for those an IRQF_ENABLED flag will be created and a TAINT will also be
placed.

Once that gets merged, all drivers will be forced (at some point) to
IRQF_DISABLED and those which don't want that will be moved gradually to
threaded irq.

This patch is also interesting:

http://lkml.org/lkml/2009/3/2/33

-- 
balbi
