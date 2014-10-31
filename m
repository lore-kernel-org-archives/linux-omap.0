From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: OMAP2+: Warn about deprecated legacy booting mode
Date: Fri, 31 Oct 2014 22:33:32 +0000
Message-ID: <20141031223332.GD12379@n2100.arm.linux.org.uk>
References: <20141027200008.GR2560@atomide.com> <20141031193057.GC12379@n2100.arm.linux.org.uk> <20141031211325.GC31454@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:51820 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756192AbaJaWdl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 31 Oct 2014 18:33:41 -0400
Content-Disposition: inline
In-Reply-To: <20141031211325.GC31454@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>

On Fri, Oct 31, 2014 at 02:13:26PM -0700, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [141031 12:32]:
> > 
> > Last night I tried enabling DT booting on the LDP.  This resulted in
> > quite a horrid mess, so I don't think you're there still.
> 
> Thanks for trying. Other than the mystery battery issue, the others
> should pretty much go away with just .config changes it seems.
> 
> > The biggest problem seems to be that the kernel does /nothing/ but
> > spit out:
> > 
> > power_supply twl4030_ac: driver failed to report `current_now' property: -850000
> > power_supply twl4030_ac: driver failed to report `current_now' property: -850000
> > twl4030_bci bci.7: battery disconnected
> > twl4030_bci bci.7: battery disconnected
> > power_supply twl4030_ac: driver failed to report `current_now' property: -850000
> > twl4030_bci bci.7: battery disconnected
> > power_supply twl4030_ac: driver failed to report `current_now' property: -850000
> > twl4030_bci bci.7: battery disconnected
> > twl4030_bci bci.7: battery disconnected
> > power_supply twl4030_ac: driver failed to report `current_now' property: -850000
> > twl4030_bci bci.7: battery disconnected
> > power_supply twl4030_ac: driver failed to report `current_now' property: -850000
> > twl4030_bci bci.7: battery disconnected
> > power_supply twl4030_ac: driver failed to report `current_now' property: -850000
> > twl4030_bci bci.7: battery disconnected
> > power_supply twl4030_ac: driver failed to report `current_now' property: -850000
> > twl4030_bci bci.7: battery disconnected
> > power_supply twl4030_ac: driver failed to report `current_now' property: -850000
> > twl4030_bci bci.7: battery disconnected
> > twl4030_bci bci.7: battery disconnected
> > 
> > Yes, the battery is disconnected, but there's absolutely no reason to keep
> > printing that damned warning time and time again.  The boot logger didn't
> > expect this, and it's logged about 16 hours of these continual messages
> > into the database... that's around 1.4GB of log!
> 
> Hmm, I thought Nishant fixed that already with commit 61a7784efd3
> "power: twl4030_charger: detect battery presence prior to enabling
> charger".
> 
> I'm not seeing these errors with twl4030_charger built in. For me it just
> bails out without a battery like it should:
> 
> twl4030_bci 48070000.i2c:twl@48:bci: Battery was not detected:-19
> 
> Nishant, any ideas on this one?
>  
> > Other errors:
> > 
> > omap_hwmod: mcbsp2_sidetone using broken dt data from mcbsp
> > omap_hwmod: mcbsp3_sidetone using broken dt data from mcbsp
> 
> This is a known issue with data for multiple devices squashed
> into one in the .dts files.
> 
> Peter, any news on fixing up this issue? I think you promised to
> look at it already a while back :)
> 
> > WARNING: CPU: 0 PID: 1 at arch/arm/mach-omap2/omap_hwmod.c:2538 _init+0xc8/0x170()
> > omap_hwmod: ssi: doesn't have mpu register target base
> > ...
> 
> Not seeing this one, is this maybe from the legacy mode boot?
> 
> > omap_hwmod: usb_host_hs: could not associate to clkdm l3_init_clkdm
> > omap_hwmod: usb_tll_hs: could not associate to clkdm l3_init_clkdm
> 
> Not seeing these either. Is this maybe from your 4430sdp instead?

This is /all/ from the 3430 LDP.

Compare these two URLs:

http://www.arm.linux.org.uk/developer/build/result.php?type=boot&idx=2891
http://www.arm.linux.org.uk/developer/build/result.php?type=boot&idx=2892

Beware - the second one will be truncated to 1MB of log (but with the
regexp extraction of errors, it's probably going to be more like 2MB.)

Both of those are booting the _exact_ same kernel binary.  The difference
between them is that the first (2891) is booted in legacy mode.  The
second (2892) is booted with omap3-ldp.dtb appended to the zImage and
wrapped in a uImage.

There is only one config file for these two boots, because as I say, it's
the exact same binary booted in legacy mode, then booted in DT mode.

config: http://www.arm.linux.org.uk/developer/build/file.php?lid=17226

> > omap_hwmod: mcbsp2: cannot be enabled for reset (3)
> 
> This I'm seeing too, will take a look at this one.
> 
> > twl4030_keypad keypad.31: OF: linux,keymap property not defined in /ocp/i2c@48070000/twl@48/keypad
> > twl4030_keypad keypad.31: Failed to build keymap
> > twl4030_keypad: probe of keypad.31 failed with error -2
> 
> I'll take a look at this one as we now have a binding for
> twl4030_keypad. Probably just missing the keymap in the .dts
> file. The gpio keys should work though.
>  
> > Digging the remaining messages out from between all the crap about the
> > battery:
> > 
> > 4809c000.mmc supply vmmc_aux not found, using dummy regulator
> > omap_hsmmc 4809c000.mmc: pins are not configured from the driver
> > 4809c000.mmc supply card-external-vcc not found, using dummy regulator
> > 480b4000.mmc supply vmmc not found, using dummy regulator
> > 480b4000.mmc supply vmmc_aux not found, using dummy regulator
> > omap_hsmmc 480b4000.mmc: pins are not configured from the driver
> > mmc0: host does not support reading read-only switch. assuming write-enable.
> > 480b4000.mmc supply card-external-vcc not found, using dummy regulator
> 
> Not seeing this with my LDP. I think you're probably missing:
> CONFIG_REGULATOR_TWL4030
> CONFIG_REGULATOR_PBIAS

As you will see from the above link, I have:

CONFIG_REGULATOR_TWL4030=y

but not REGULATOR_PBIAS - because MFD_SYSCON is not set.

> > mmc0: new high speed SD card at address 0002
> > mmcblk0: mmc0:0002 00000 971 MiB
> > omap_hsmmc 480b4000.mmc: could not set regulator OCR (-22)
> > 480ad000.mmc supply vmmc not found, using dummy regulator
> > 480ad000.mmc supply vmmc_aux not found, using dummy regulator
> > omap_hsmmc 480ad000.mmc: could not set regulator OCR (-22)
> >  mmcblk0: p1 p2
> > omap_hsmmc 480ad000.mmc: pins are not configured from the driver
> > mmcblk0: error -84 transferring data, sector 1473761, nr 32, cmd response 0x900, card status 0xb00
> > mmcblk0: retrying using single block read
> > mmcblk0: error -84 transferring data, sector 426249, nr 32, cmd response 0x900, card status 0xb00
> > mmcblk0: retrying using single block read
> > mmcblk0: error -84 transferring data, sector 1525321, nr 192, cmd response 0x900, card status 0xb00
> > mmcblk0: retrying using single block read
> > ... etc ...
> 
> I'm not seeing this one either on my LDP. I'm getting just one warning
> "multiblock reads disabled due to 35xx erratum 2.1.1.128"
> but the card works just fine here with no errors. I'd assume these go
> away with enabling the regulators above.

Or it could be that the amount of crap being spewed by the battery driver
is messing up the dodgy MMC.

> > Of course, no problems with exactly the same kernel binary image without
> > DT.  I'd summarise this as DT remains totally unusable on LDP3430.  It's
> > soo unusable that it is going to /force/ me to take it out of the nightly
> > boot test, otherwise I'm going to have to manually intervene each and
> > every morning to kill the board.
> 
> The LDP is certainly usable here with device tree based booting.
> 
> It seems you're probably missing some .config options. Care to post
> your .config somewhere? Or maybe give it a try with omap2plus_defconfig?

I'm not trying with omap2plus_defconfig as this is supposed to be a
separate build.  Given that - as I say - the /exact/ same kernel binary
works in legacy mode, it suggests that there's some pretty major
differences between what devices are supported in a legacy boot mode
and what devices are supported in DT boot mode.

> If that works, then maybe enable CONFIG_CHARGER_TWL4030=y in
> omap2plus_defconfig and see if you get the battery issue with it too?

I do have that option enabled.

I really /can't/ risk letting the platform boot again in DT mode having
just played around with some options - if it spews like it did again
last night, it'll spew for the whole day tomorrow, and I really don't
want the database filling up with another gigabyte of log.

I'll see about tweaking some of those options, but it'll have to be a
manual run sometime next week to test it.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
