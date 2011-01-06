From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Current OMAP build failures
Date: Thu, 6 Jan 2011 17:10:19 +0000
Message-ID: <20110106171019.GF1198@n2100.arm.linux.org.uk>
References: <20110106110336.GC31708@n2100.arm.linux.org.uk> <878vyyx8s4.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:34196 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752915Ab1AFRK3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Jan 2011 12:10:29 -0500
Content-Disposition: inline
In-Reply-To: <878vyyx8s4.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Jan 06, 2011 at 09:05:15AM -0800, Kevin Hilman wrote:
> Hi Russell,
> 
> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> 
> > I've observed the following issues while building 2.6.37 + my devel
> > branch.  I don't believe any of them to be due to anything in my tree,
> > so would be in 2.6.37 as well.
> 
> What defconfig are you using for these builds?

I couldn't say offhand because they're built from configs created a while
back.  I tend to just re-run the build with appropriate O= arguments to
test things.

I can send the defconfigs if it'd help.
