From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC] Initial attempt to make ARM use LMB
Date: Thu, 8 Apr 2010 19:27:15 +0100
Message-ID: <20100408182715.GF31407@n2100.arm.linux.org.uk>
References: <20100325233248.GM24984@n2100.arm.linux.org.uk> <20100408153111.GA2598@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:57009 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758895Ab0DHS2T (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Apr 2010 14:28:19 -0400
Content-Disposition: inline
In-Reply-To: <20100408153111.GA2598@debian>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rabin Vincent <rabin@rab.in>
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

On Thu, Apr 08, 2010 at 09:02:56PM +0530, Rabin Vincent wrote:
> On Thu, Mar 25, 2010 at 11:32:48PM +0000, Russell King - ARM Linux wrote:
> > The patch below is the combined patch; individual patches can be found
> > in the arm:lmb patches on the website or the lmb branch of my git tree;
> > this should be considered unstable.
> 
> Something like the following is needed to make initrds work after this
> patch:

This to me looks like a very large patch for what is a small problem -
that is the assignment of initrd_start/initrd_size got lost along the
way.

I'd much rather have the smaller patch; keep the initrd parameters in
the physical address space for as long as possible, and only convert
them to the virtual address space once we've finished mm initialisation.
