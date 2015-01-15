From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: OMAP 4430 SDP: rather sick with recent kernels
Date: Thu, 15 Jan 2015 10:48:32 +0000
Message-ID: <20150115104832.GT11502@n2100.arm.linux.org.uk>
References: <20141217095252.GH11502@n2100.arm.linux.org.uk>
 <20150114175132.GR11502@n2100.arm.linux.org.uk>
 <20150114190925.GP2419@atomide.com>
 <20150114231007.GS11502@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:41970 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752132AbbAOKsj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Jan 2015 05:48:39 -0500
Content-Disposition: inline
In-Reply-To: <20150114231007.GS11502@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org

On Wed, Jan 14, 2015 at 11:10:08PM +0000, Russell King - ARM Linux wrote:
> On Wed, Jan 14, 2015 at 11:09:26AM -0800, Tony Lindgren wrote:
> > This seems like it could be a similar issue to what we were seeing on
> > omap3 where the legacy IRQ mappings went wrong without using the
> > irq_domain_add_legacy(). Maybe vexpress affects NR_IRQS or something?
> > 
> > Also, I think we could now disable the legacy DMA init completely
> > except for omap2 and 3.
> 
> I've added a "cat /proc/interrupts" which should reveal whether the IRQs
> have changed between the two different builds.

Okay, both omap4 and combined kernels indicate that the legacy DMA gets
the same interrupt:

 44:          0          0  4a310000.gpio  18  DMA

so that can't be the issue as the combined kernel spits out the warning,
but the omap4 kernel doesn't.  Something else is going on which causes
this; the hint that it's got something to do with this is just a symptom
of some other problem.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
