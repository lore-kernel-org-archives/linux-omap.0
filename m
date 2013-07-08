From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/6] ARM: OMAP2+: Remove board-4430sdp.c
Date: Mon, 8 Jul 2013 02:34:11 -0700
Message-ID: <20130708093410.GT5523@atomide.com>
References: <20130517191304.468.73487.stgit@localhost>
 <20130517191751.468.89202.stgit@localhost>
 <20130520095447.GR21614@n2100.arm.linux.org.uk>
 <20130706131057.GU21614@n2100.arm.linux.org.uk>
 <20130706133627.GV21614@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:34045 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751045Ab3GHJeQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Jul 2013 05:34:16 -0400
Content-Disposition: inline
In-Reply-To: <20130706133627.GV21614@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: arm@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [130706 06:42]:
> 
> Okay, I guessed that the OMAP4430SDP was "blaze" (it's not obvious to
> use internal codenames for boards when they're known as "SDP" etc -
> especially when they have stickers on them saying that they're "SDP".)

Agreed, let's update that.
 
> With that worked out, throwing my standard printascii() hack into the
> kernel results in boot messages... up to the point where the timer is
> calibrated.  So, it looks like either interrupts, clocks, or the OMAP
> timers are non-functional with DT based kernels on the SDP board.

Hey the good news is that you've updated your build system to support
also appended dtb images, thanks for doing that!
 
> Any ideas?

Looks like you need some things updated and added to your .config.

-# CONFIG_OMAP_MUX is not set
+CONFIG_MACH_OMAP_GENERIC=y

That we should nowadays always select though.

CONFIG_REGULATOR_FIXED_VOLTAGE=y

This you will need for Ethernet.

CONFIG_PINCTRL_SINGLE=y

This is good to have, will be needed especially for for UART
wake-up events with deeper idle modes enabled once the pending
pinctrl patches are merged.

Also, can you please add these for NFSroot:

CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
CONFIG_ROOT_NFS=y

That way I can also boot test your .config on regular basis ;)

Then there's a pending patch to change drivers/i2c/busses/i2c-omap.c
to use just a regular module_init, that should remove the i2c timeout
errors as then deferred probe will work properly.

BTW, maybe add a link to your build system to www.arm.linux.org.uk
developer page too? At least I could not find a link to it.

Regards,

Tony
