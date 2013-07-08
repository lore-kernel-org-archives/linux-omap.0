From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/6] ARM: OMAP2+: Remove board-4430sdp.c
Date: Mon, 8 Jul 2013 15:21:03 +0100
Message-ID: <20130708142103.GX21614@n2100.arm.linux.org.uk>
References: <20130517191304.468.73487.stgit@localhost> <20130517191751.468.89202.stgit@localhost> <20130520095447.GR21614@n2100.arm.linux.org.uk> <20130706131057.GU21614@n2100.arm.linux.org.uk> <20130706133627.GV21614@n2100.arm.linux.org.uk> <20130708093410.GT5523@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:36115 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751430Ab3GHOVQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Jul 2013 10:21:16 -0400
Content-Disposition: inline
In-Reply-To: <20130708093410.GT5523@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: arm@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Jul 08, 2013 at 02:34:11AM -0700, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [130706 06:42]:
> > 
> > Okay, I guessed that the OMAP4430SDP was "blaze" (it's not obvious to
> > use internal codenames for boards when they're known as "SDP" etc -
> > especially when they have stickers on them saying that they're "SDP".)
> 
> Agreed, let's update that.
>  
> > With that worked out, throwing my standard printascii() hack into the
> > kernel results in boot messages... up to the point where the timer is
> > calibrated.  So, it looks like either interrupts, clocks, or the OMAP
> > timers are non-functional with DT based kernels on the SDP board.
> 
> Hey the good news is that you've updated your build system to support
> also appended dtb images, thanks for doing that!

It was far from trivial - there's many places in the build process
which do things quite differently depending on whether it's a DTB
build or not.

> > Any ideas?
> 
> Looks like you need some things updated and added to your .config.
> 
> -# CONFIG_OMAP_MUX is not set
> +CONFIG_MACH_OMAP_GENERIC=y
> 
> That we should nowadays always select though.
> 
> CONFIG_REGULATOR_FIXED_VOLTAGE=y
> 
> This you will need for Ethernet.
> 
> CONFIG_PINCTRL_SINGLE=y
> 
> This is good to have, will be needed especially for for UART
> wake-up events with deeper idle modes enabled once the pending
> pinctrl patches are merged.

That probably explains why there was no output.

> Then there's a pending patch to change drivers/i2c/busses/i2c-omap.c
> to use just a regular module_init, that should remove the i2c timeout
> errors as then deferred probe will work properly.

It seems that - yet again - the mmc devices have swapped themselves.
Also looks like the nonfunctional video stuff is even more nonfunctional
than usual:

omapdss DSI error: can't get VDDS_DSI regulator
omapdss HDMI error: can't get VDDA_HDMI_DAC regulator

ASoC looks dead too:

omap-abe-twl6040 sound.10: ASoC: CPU DAI (null) not registered
omap-abe-twl6040 sound.10: snd_soc_register_card() failed: -517

> BTW, maybe add a link to your build system to www.arm.linux.org.uk
> developer page too? At least I could not find a link to it.

Hmm, I thought I had, but it looks like I never pushed the change to
the main site.  I'll do that at some point.
