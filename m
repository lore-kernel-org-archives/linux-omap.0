From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/5] arm: Fix init_atags_procfs() to check tag->hdr.size
Date: Sat, 19 Dec 2009 10:44:18 -0800
Message-ID: <20091219184418.GD11397@atomide.com>
References: <20091219034151.26198.26570.stgit@localhost>
 <20091219034630.26198.35713.stgit@localhost>
 <20091219090332.GA28047@n2100.arm.linux.org.uk>
 <20091219174428.GA11397@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:61197 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752992AbZLSSod (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 19 Dec 2009 13:44:33 -0500
Content-Disposition: inline
In-Reply-To: <20091219174428.GA11397@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [091219 09:43]:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [091219 01:02]:
> > On Fri, Dec 18, 2009 at 07:46:30PM -0800, Tony Lindgren wrote:
> > > The tag->hdr.size cannot be larger than XXX.
> > > Otherwise we can getsomething similar during boot:
> > > 
> > > Unable to handle kernel paging request at virtual address 61a05020
> > > ...
> > 
> > NAK.
> > 
> > Why can't people get the simple ATAG setup right?  Fix the boot loader.
> 
> In this case why can't the kernel get ATAG setup right?
> 
> This only happens when kexec rebooting multiple times in a row.
> 
> Sounds like something is not memset/kzalloc'd somewhere?

Heh. I can't reproduce this any longer. I bet it was caused by
the bug in my earlier reboot script that kept appending another
root= to the cmdline every reboot :)

Tony

