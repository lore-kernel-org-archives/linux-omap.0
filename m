From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 01/11] OMAP2/3: PM: push core PM code from linux-omap
Date: Mon, 18 May 2009 22:11:07 +0100
Message-ID: <20090518211107.GA13834@n2100.arm.linux.org.uk>
References: <1242412851-16606-1-git-send-email-khilman@deeprootsystems.com> <1242412851-16606-2-git-send-email-khilman@deeprootsystems.com> <20090518133241.GH3067@n2100.arm.linux.org.uk> <878wku8hkb.fsf@deeprootsystems.com> <13B9B4C6EF24D648824FF11BE8967162038BED5CA9@dlee02.ent.ti.com> <20090518202431.GM7042@n2100.arm.linux.org.uk> <13B9B4C6EF24D648824FF11BE8967162038BED5E2B@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:44654 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752783AbZERVLT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 May 2009 17:11:19 -0400
Content-Disposition: inline
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162038BED5E2B@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jouni Hogander <jouni.hogander@nokia.com>, Paul Walmsley <paul@pwsan.com>

On Mon, May 18, 2009 at 03:47:31PM -0500, Woodruff, Richard wrote:
> The code flow is:
>         - Wakeup event
>         - ARM reboots and uses SOC mask ROM context restore helper
>         - Mask ROM code jump to restore pointers with MMU OFF.
>         - Restore code resets ARM CortexA8 state
>         -*- Trustzone SMI calls are made to restore some secure state
>         - Jump back from SRAM to C code
> 
> The dangling question to me is if any of the cpu state is needed by
> the trustzone monitor code as a precondition.  The doc's I have led
> me to believe its ok, but I've not verified this.

There shouldn't be - it would be _really_ silly if the trustzone monitor
had pre-requisits for the exception mode registers.  There's no way that
Linux's use of the exception mode registers is anywhere near the same as
other OSes, and Linux's use of the exception mode registers has changed
over time anyway.  We make no promise that we'll keep the way we're using
these registers today either.

So there are no external guarantees about what useful state the kernel
puts into these registers.  Having external code rely on some state
there would itself be broken.

There's also the problem that if there was a dependency on the insecure
exception mode registers from within the trusted environment, that'd
surely be a rather big security problem in itself.
