From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH B 05/10] OMAP2/3 clock: add clockdomains to all remaining clocks; fix clkdm init
Date: Sat, 31 Jan 2009 14:21:53 +0000
Message-ID: <20090131142153.GK1394@n2100.arm.linux.org.uk>
References: <20090128024301.27240.39391.stgit@localhost.localdomain> <20090128024418.27240.52292.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54551 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752213AbZAaOWJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 31 Jan 2009 09:22:09 -0500
Content-Disposition: inline
In-Reply-To: <20090128024418.27240.52292.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

On Tue, Jan 27, 2009 at 07:44:21PM -0700, Paul Walmsley wrote:
> Add clockdomains for all remaining clocks without them, and warn in
> clk_register() if any are missing a clockdomain.  On OMAP2, call
> omap2_init_clk_clkdm() immediately after clk_register(), just as OMAP3
> does.  Remove omap2_init_clk_clkdm() from all of the struct clk .init
> function pointers, since the OMAP2/3 arch clock init code now calls it.

Probably the same comment as B4.
