From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/6] ARM: OMAP2+: Remove board-4430sdp.c
Date: Sat, 6 Jul 2013 14:36:27 +0100
Message-ID: <20130706133627.GV21614@n2100.arm.linux.org.uk>
References: <20130517191304.468.73487.stgit@localhost> <20130517191751.468.89202.stgit@localhost> <20130520095447.GR21614@n2100.arm.linux.org.uk> <20130706131057.GU21614@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:35881 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750827Ab3GFNgi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 6 Jul 2013 09:36:38 -0400
Content-Disposition: inline
In-Reply-To: <20130706131057.GU21614@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, arm@kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sat, Jul 06, 2013 at 02:10:57PM +0100, Russell King - ARM Linux wrote:
> Well, this doesn't work.  I've tried several things, and I think I'm
> generating a correct image, but it doesn't boot.
> 
> This could be that the current Linus tip plus my stuff plus arm-soc
> is broken, but as it boots on the 3430LDP I suspect that isn't the
> case.
> 
> I've tried with omap4-sdp.dtb and the other omap4-sdp DTB file with no
> improvement.  No idea how to even begin to debug this, as there's no
> way for the decompressor to produce output, and I've no idea which
> OMAP uart to use for debug output (because that information has been
> removed from the kernel source.)
> 
> And... WTF is the OMAP debug uart selection in its own separate menu
> from the main "choice" statement?  This is totally unnecessary complexity
> and is just making things more complicated for the hell of it.  Look at
> what every other platform does - they put their stuff in the main choice
> statement even if they have multiple UARTs.  The hint there is that these
> depend on the appropriate support being selected, so in the case of a
> kernel only targetting OMAP, as things stand you'll end up with a menu
> which lists the OMAP2PLUS, none, icedcc, and semihosting entries followed
> by another menu to select which OMAP port you want.  That's utterly
> rediculous and broken.  And just think about the two titles for the
> menus:
> 
>         prompt "Kernel low-level debugging port"
> vs
>         prompt "Low-level debug console UART"
> 
> Oh wait, why don't I get to choose my "debug console UART" on an AT91?
> Maybe AT91 should move their debug uart selection into this menu as well,
> and maybe the Versatile Express options too, because they're all to do
> with selecting the UART to be used.  Please... some sane *thought* would
> be *really* good here.
> 
> Oh my god, you're not the only ones.  Arnd/Olof, who started this madness
> and _why_ haven't you already stepped on it?  Right, I'm fixing this in
> this merge window.  Everything is moving under the original choice menu
> as it was intended to be.
> 
> The attempts are all on the builder website against the (disabled)
> omap4430-sdp entry.

Okay, I guessed that the OMAP4430SDP was "blaze" (it's not obvious to
use internal codenames for boards when they're known as "SDP" etc -
especially when they have stickers on them saying that they're "SDP".)

With that worked out, throwing my standard printascii() hack into the
kernel results in boot messages... up to the point where the timer is
calibrated.  So, it looks like either interrupts, clocks, or the OMAP
timers are non-functional with DT based kernels on the SDP board.

Any ideas?
