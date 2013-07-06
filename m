From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/6] ARM: OMAP2+: Remove board-4430sdp.c
Date: Sat, 6 Jul 2013 14:10:57 +0100
Message-ID: <20130706131057.GU21614@n2100.arm.linux.org.uk>
References: <20130517191304.468.73487.stgit@localhost> <20130517191751.468.89202.stgit@localhost> <20130520095447.GR21614@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:35876 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750878Ab3GFNLM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 6 Jul 2013 09:11:12 -0400
Content-Disposition: inline
In-Reply-To: <20130520095447.GR21614@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, arm@kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, May 20, 2013 at 10:54:47AM +0100, Russell King - ARM Linux wrote:
> On Fri, May 17, 2013 at 12:17:51PM -0700, Tony Lindgren wrote:
> > We can now boot with device tree. If you don't want to update u-boot,
> > you can boot with appended DTB with the following instructions:
> > 
> > 1. Make sure you have the appended DTB support in .config
> > 
> >    CONFIG_ARM_APPENDED_DTB=y
> >    CONFIG_ARM_ATAG_DTB_COMPAT=y
> >    CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_EXTEND=y
> > 
> > 2. Build the zImage
> > 
> >    $ ARCH=arm CROSS_COMPILE=... make zImage
> > 
> > 3. Build the device tree blobs
> > 
> >    $ ARCH=arm CROSS_COMPILE=... make dtbs
> > 
> > 4. Append the dtb to zImage
> > 
> >    $ cat arch/arm/boot/zImage arch/arm/boot/dts/omap4-sdp.dtb > /tmp/appended
> > 
> > 5. Use mkimage to produce the appended device tree uImage
> > 
> >    $ mkimage -A arm -O linux -T kernel -C none -a 0x80008000 -e 0x80008000 \
> >      -n "Linux" -d /tmp/appended /tmp/uImage
> > 
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> Okay, I'm removing the 4430SDP from the boot test system once this goes
> in, because this will mean rewriting the build system to cope with this
> stuff.

Well, this doesn't work.  I've tried several things, and I think I'm
generating a correct image, but it doesn't boot.

This could be that the current Linus tip plus my stuff plus arm-soc
is broken, but as it boots on the 3430LDP I suspect that isn't the
case.

I've tried with omap4-sdp.dtb and the other omap4-sdp DTB file with no
improvement.  No idea how to even begin to debug this, as there's no
way for the decompressor to produce output, and I've no idea which
OMAP uart to use for debug output (because that information has been
removed from the kernel source.)

And... WTF is the OMAP debug uart selection in its own separate menu
from the main "choice" statement?  This is totally unnecessary complexity
and is just making things more complicated for the hell of it.  Look at
what every other platform does - they put their stuff in the main choice
statement even if they have multiple UARTs.  The hint there is that these
depend on the appropriate support being selected, so in the case of a
kernel only targetting OMAP, as things stand you'll end up with a menu
which lists the OMAP2PLUS, none, icedcc, and semihosting entries followed
by another menu to select which OMAP port you want.  That's utterly
rediculous and broken.  And just think about the two titles for the
menus:

        prompt "Kernel low-level debugging port"
vs
        prompt "Low-level debug console UART"

Oh wait, why don't I get to choose my "debug console UART" on an AT91?
Maybe AT91 should move their debug uart selection into this menu as well,
and maybe the Versatile Express options too, because they're all to do
with selecting the UART to be used.  Please... some sane *thought* would
be *really* good here.

Oh my god, you're not the only ones.  Arnd/Olof, who started this madness
and _why_ haven't you already stepped on it?  Right, I'm fixing this in
this merge window.  Everything is moving under the original choice menu
as it was intended to be.

The attempts are all on the builder website against the (disabled)
omap4430-sdp entry.
