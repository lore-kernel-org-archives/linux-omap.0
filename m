From: Tony Lindgren <tony@atomide.com>
Subject: Re: 4430SDP boot failure
Date: Thu, 6 Jan 2011 10:25:56 -0800
Message-ID: <20110106182555.GW7771@atomide.com>
References: <20110106170805.GE1198@n2100.arm.linux.org.uk>
 <20110106180030.GA8249@n2100.arm.linux.org.uk>
 <20110106181754.GA8975@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:46934 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751686Ab1AFS0H (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Jan 2011 13:26:07 -0500
Content-Disposition: inline
In-Reply-To: <20110106181754.GA8975@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [110106 10:17]:
> On Thu, Jan 06, 2011 at 06:00:30PM +0000, Russell King - ARM Linux wrote:
> > Therefore, I believe the debugging address calculation stuff in
> > arch/arm/mach-omap2/include/mach/debug-macros.S to be rather broken,
> > causing an abort when it tries to access the serial port.
> 
> I'm sorry, I think this crap has to go.  Trying to make it fit every
> platform in one kernel is just too complicated.  It _needs_ to be
> something so damned simple that it always works without fail, every
> single time someone wants to use it.
> 
> The current code really hasn't a hope of doing that.
> 
> Yes, that means you only configure it when you're not building a multi-
> platform kernel, but that's worth giving up if in return we have something
> that is 100% reliable.
> 
> As it is, I need to invent new debugging code to debug this mess.  Sorry,
> I'm actually not going to bother - as the LL debug stuff was my debugging
> code to debug exactly these kinds of boot problems.  Someone else can have
> the pain of sorting out this breakage, and tell me when they expect OMAP
> to work again.

Something that could help with the DEBUG_LL code is to pass optional
debug UART info masked into the machine_id using the high bits..

Regards,

Tony
