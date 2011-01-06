From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: 4430SDP boot failure
Date: Thu, 6 Jan 2011 18:17:54 +0000
Message-ID: <20110106181754.GA8975@n2100.arm.linux.org.uk>
References: <20110106170805.GE1198@n2100.arm.linux.org.uk> <20110106180030.GA8249@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:45576 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752308Ab1AFSR7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Jan 2011 13:17:59 -0500
Received: from n2100.arm.linux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86])
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.72)
	(envelope-from <linux@arm.linux.org.uk>)
	id 1PauPM-0000yB-FF
	for linux-omap@vger.kernel.org; Thu, 06 Jan 2011 18:17:56 +0000
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.72)
	(envelope-from <linux@n2100.arm.linux.org.uk>)
	id 1PauPL-0002O7-1h
	for linux-omap@vger.kernel.org; Thu, 06 Jan 2011 18:17:55 +0000
Content-Disposition: inline
In-Reply-To: <20110106180030.GA8249@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

On Thu, Jan 06, 2011 at 06:00:30PM +0000, Russell King - ARM Linux wrote:
> Therefore, I believe the debugging address calculation stuff in
> arch/arm/mach-omap2/include/mach/debug-macros.S to be rather broken,
> causing an abort when it tries to access the serial port.

I'm sorry, I think this crap has to go.  Trying to make it fit every
platform in one kernel is just too complicated.  It _needs_ to be
something so damned simple that it always works without fail, every
single time someone wants to use it.

The current code really hasn't a hope of doing that.

Yes, that means you only configure it when you're not building a multi-
platform kernel, but that's worth giving up if in return we have something
that is 100% reliable.

As it is, I need to invent new debugging code to debug this mess.  Sorry,
I'm actually not going to bother - as the LL debug stuff was my debugging
code to debug exactly these kinds of boot problems.  Someone else can have
the pain of sorting out this breakage, and tell me when they expect OMAP
to work again.
