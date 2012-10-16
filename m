From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 00/11] Minimum set of omap serial patches to fix merge
	window breakage
Date: Tue, 16 Oct 2012 12:20:46 +0100
Message-ID: <20121016112046.GX28061@n2100.arm.linux.org.uk>
References: <20121016101458.GZ21164@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:53267 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754213Ab2JPLUt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Oct 2012 07:20:49 -0400
Content-Disposition: inline
In-Reply-To: <20121016101458.GZ21164@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Oct 16, 2012 at 11:14:58AM +0100, Russell King - ARM Linux wrote:
> During the merge window, a series of patches from various people went in,
> allegedly fixing various problems with the OMAP serial driver.
> 
> Unfortunately, there was not a full understanding of the issues I brought
> up here back in April, and so the "fixes", while being individually
> correct, result in a worse situation with the driver than before.
> 
> Specifically, this patch:
> 
> commit 957ee7270d632245b43f6feb0e70d9a5e9ea6cf6
> Author: Vikram Pandita <vikram.pandita@ti.com>
> Date:   Thu Sep 6 15:45:37 2012 +0300
> 
>     serial: omap: fix software flow control
> 
>     Software flow control register bits were not defined correctly.
> 
>     Also clarify the IXON and IXOFF logic to reflect what userspace wants.
> 
> does what it says on the tin - it fixes the register definitions so that
> we do end up enabling the right two software flow control bits.
> 
> The down side is that there are other bugs in this area which have been
> exposed.  For example:
> 
> 1. the XON/XOFF registers aren't written to; their address is, but we will
>    not be writing to the right registers because their access rules are not
>    respected by the driver.  These are by default zero.
> 
>    This means that with hardware assisted software flow control enabled,
>    the port will now transmit an 0x00 byte for XON and XOFF events.
> 
> 2. the driver set_termios function is not called for changes in software
>    flow control settings if not accompanied by some other change.
> 
> 3. the there isn't actually a way for the hardware assisted flow control
>    to be used other than by increasing interrupt latency to cause the
>    receiver hardware FIFO to fill.  This will cause 0x00 bytes to be
>    transmitted.
> 
> There are two options to resolve this.  The first one is to revert this
> patch to bring the driver back down to the pre-merge window state.  The
> other is to apply this series of patches, which frankly I don't think
> is -rc material, even with the above regressions.
> 
> Given that the above regressions were caused by a lack of due care and
> correct process (I had declared to TI that I had investigated these
> issues back in April), I believe that the right answer is to revert at
> least commit 957ee7270d, which should re-hide these other bugs in the
> driver.

Note: these patches are not as well validated as my previous set; I
haven't even build-tested just this set, but only my full set.  YMMV.
