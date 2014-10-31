From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: OMAP2+: Warn about deprecated legacy booting mode
Date: Fri, 31 Oct 2014 19:30:57 +0000
Message-ID: <20141031193057.GC12379@n2100.arm.linux.org.uk>
References: <20141027200008.GR2560@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:51699 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757338AbaJaTbJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 31 Oct 2014 15:31:09 -0400
Content-Disposition: inline
In-Reply-To: <20141027200008.GR2560@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Mon, Oct 27, 2014 at 01:00:09PM -0700, Tony Lindgren wrote:
> We're moving omaps to use device tree based booting and already have
> omap2, omap4, omap5, am335x and am437x booting in device tree only
> mode.
> 
> Only omap3 still has legacy booting still around and we really want
> to make that device tree only. So let's add a warning about deprecated
> legacy booting so we get people to upgrade their boards to use device
> tree based booting and find out about any remaining issues.
> 
> Note that for most boards we already have the .dts file and those can
> be booted with without changing the bootloader using the appended
> DTB mode.

Tony,

Last night I tried enabling DT booting on the LDP.  This resulted in
quite a horrid mess, so I don't think you're there still.

The biggest problem seems to be that the kernel does /nothing/ but
spit out:

power_supply twl4030_ac: driver failed to report `current_now' property: -850000
power_supply twl4030_ac: driver failed to report `current_now' property: -850000
twl4030_bci bci.7: battery disconnected
twl4030_bci bci.7: battery disconnected
power_supply twl4030_ac: driver failed to report `current_now' property: -850000
twl4030_bci bci.7: battery disconnected
power_supply twl4030_ac: driver failed to report `current_now' property: -850000
twl4030_bci bci.7: battery disconnected
twl4030_bci bci.7: battery disconnected
power_supply twl4030_ac: driver failed to report `current_now' property: -850000
twl4030_bci bci.7: battery disconnected
power_supply twl4030_ac: driver failed to report `current_now' property: -850000
twl4030_bci bci.7: battery disconnected
power_supply twl4030_ac: driver failed to report `current_now' property: -850000
twl4030_bci bci.7: battery disconnected
power_supply twl4030_ac: driver failed to report `current_now' property: -850000
twl4030_bci bci.7: battery disconnected
power_supply twl4030_ac: driver failed to report `current_now' property: -850000
twl4030_bci bci.7: battery disconnected
twl4030_bci bci.7: battery disconnected

Yes, the battery is disconnected, but there's absolutely no reason to keep
printing that damned warning time and time again.  The boot logger didn't
expect this, and it's logged about 16 hours of these continual messages
into the database... that's around 1.4GB of log!

Other errors:

omap_hwmod: mcbsp2_sidetone using broken dt data from mcbsp
omap_hwmod: mcbsp3_sidetone using broken dt data from mcbsp

WARNING: CPU: 0 PID: 1 at arch/arm/mach-omap2/omap_hwmod.c:2538 _init+0xc8/0x170()
omap_hwmod: ssi: doesn't have mpu register target base
...
omap_hwmod: usb_host_hs: could not associate to clkdm l3_init_clkdm
omap_hwmod: usb_tll_hs: could not associate to clkdm l3_init_clkdm
omap_hwmod: mcbsp2: cannot be enabled for reset (3)
...
twl4030_keypad keypad.31: OF: linux,keymap property not defined in /ocp/i2c@48070000/twl@48/keypad
twl4030_keypad keypad.31: Failed to build keymap
twl4030_keypad: probe of keypad.31 failed with error -2

Digging the remaining messages out from between all the crap about the
battery:

4809c000.mmc supply vmmc_aux not found, using dummy regulator
omap_hsmmc 4809c000.mmc: pins are not configured from the driver
4809c000.mmc supply card-external-vcc not found, using dummy regulator
480b4000.mmc supply vmmc not found, using dummy regulator
480b4000.mmc supply vmmc_aux not found, using dummy regulator
omap_hsmmc 480b4000.mmc: pins are not configured from the driver
mmc0: host does not support reading read-only switch. assuming write-enable.
480b4000.mmc supply card-external-vcc not found, using dummy regulator
mmc0: new high speed SD card at address 0002
mmcblk0: mmc0:0002 00000 971 MiB
omap_hsmmc 480b4000.mmc: could not set regulator OCR (-22)
480ad000.mmc supply vmmc not found, using dummy regulator
480ad000.mmc supply vmmc_aux not found, using dummy regulator
omap_hsmmc 480ad000.mmc: could not set regulator OCR (-22)
 mmcblk0: p1 p2
omap_hsmmc 480ad000.mmc: pins are not configured from the driver
mmcblk0: error -84 transferring data, sector 1473761, nr 32, cmd response 0x900, card status 0xb00
mmcblk0: retrying using single block read
mmcblk0: error -84 transferring data, sector 426249, nr 32, cmd response 0x900, card status 0xb00
mmcblk0: retrying using single block read
mmcblk0: error -84 transferring data, sector 1525321, nr 192, cmd response 0x900, card status 0xb00
mmcblk0: retrying using single block read
... etc ...

Of course, no problems with exactly the same kernel binary image without
DT.  I'd summarise this as DT remains totally unusable on LDP3430.  It's
soo unusable that it is going to /force/ me to take it out of the nightly
boot test, otherwise I'm going to have to manually intervene each and
every morning to kill the board.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
