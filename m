From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: RFD: OMAP PRCM register access holding up PM branch submissions
Date: Thu, 12 Mar 2009 16:28:04 +0000
Message-ID: <20090312162804.GA7179@n2100.arm.linux.org.uk>
References: <87hc1y930c.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:49445 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758108AbZCLQ2U (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 12:28:20 -0400
Content-Disposition: inline
In-Reply-To: <87hc1y930c.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk

On Thu, Mar 12, 2009 at 08:25:55AM -0700, Kevin Hilman wrote:
> So, what is the path forward?  If you are not opposed to moving to the
> 'MOD + offset' approach in principle, I propose we just make a new
> attempt at converting to it.

The path forward is that I'm not going to do anything further on this
until after the next merge window[*].  I only officially spend one day
a week on TI stuff, and I've spent rather more than that over the course
of the last cycle at the expense of other work.

So it's now time that these other people who had been squeezed out get
my attention up until the next merge window.  I'm thinking of things
like highmem, MXC, and so forth.


* - I was hoping to get the entire queued contents of my omap-clks3
branch out on to linux-omap, but having encountered problems with the
shere amount of email causing the load to sky rocket resulting in the
OOM killer going crazy on my firewall, I'm not going to be able to do
that.  So, the omap-clks3 branch is currently in limbo and as such might
*not* get merged during the next window.
