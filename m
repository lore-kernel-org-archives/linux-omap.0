From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/2] ARM: Add inituart macro to initialize DEBUG_LL
	serial port based on the machine ID
Date: Fri, 4 Feb 2011 08:39:34 +0000
Message-ID: <20110204083934.GB15004@n2100.arm.linux.org.uk>
References: <20110204012008.26298.16341.stgit@baageli.muru.com> <20110204012207.26298.16649.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:44051 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752429Ab1BDIjr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Feb 2011 03:39:47 -0500
Content-Disposition: inline
In-Reply-To: <20110204012207.26298.16649.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Thu, Feb 03, 2011 at 05:22:07PM -0800, Tony Lindgren wrote:
> Allow machine specific init of the DEBUG_LL serial port. This is needed
> to debug kernels built with support for multiple machines compiled in
> without recompiling the kernel.
> 
> As some SoCs need to use variables to store the port address and LSR
> register configuration, we must call inituart again after clearing
> the BSS.
> 
> If variables are being used for for inituart and addruart, this setup
> won't work properly for debugging the uncompress code without patching
> arch/arm/boot/compressed/head.S for the machine in question.

Can't we just hard-configure the virtual/physical address at build
time and be done with it?

I've given up with the current state of affairs which tries to use the
platform ID to select the UART to use as it never seems to work, and I
have a couple of patches which hard-code the address at compile time -
one for the SDP4430 board and one for the LDP3430 board.

If it's complicated, then it probably won't work.  Keep it simple.
That's especially true for debugging code, otherwise you need extra
debugging code to debug why the debugging code doesn't work.
