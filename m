From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: Things to do after 2.6.29 gets released
Date: Sat, 21 Mar 2009 00:38:58 +0200
Message-ID: <20090320223858.GA1864@gandalf>
References: <20090320221230.GA29546@atomide.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:46553 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751060AbZCTWjH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Mar 2009 18:39:07 -0400
Content-Disposition: inline
In-Reply-To: <20090320221230.GA29546@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Fri, Mar 20, 2009 at 03:12:31PM -0700, Tony Lindgren wrote:
> Hi all,
> 
> As there are quite a few omap patches going upstream this coming
> merge window, here are some notes on where we should go after
> 2.6.29 gets released.
> 
> The goal of course is still to get all the important omap code
> merged into the mainline kernel, and then just keep linux-omap
> around to queue up patches for the upcoming merge windows.
> 
> After 2.6.29, we'll have to make few changes to rebase more
> branches against the mainline. So I suggest following:
> 
> - We'll branch 2.6.29-omap to have something stable for next
>   few weeks
> 
> - We'll merge with mainline to start using the mainline clock code,
>   and Paul will maintain omap-clocks branch against the mainline
>   where we'll add the further patches needed. The omap-clocks branch
>   will get merged to linux-omap master branch on regular basis.
> 
> - We'll reset the PM code to mainline, and Kevin will maintain
>   the pm branch against the mainline. The pm branch will get merged
>   to l-o master branch on regular basis.
> 
> This way we will have the remaining clock patches and PM patches
> ready to go to mainline without any extra effort needed. And Paul
> and Kevin can rebase the omap-clocks and pm branches as needed.
> 
> Also, after 2.6.29, mach-omap1 should be completely in sync with
> the mainline. For mach-omap2, we still need to get some more
> board-*.c files merged after the clock and PM code. And there's
> still some code under plat-omap that needs to be cleaned up.
> And the drivers should keep getting integrated via the appropriate
> driver mailings lists.
> 
> Luckily lots of patches patches should already apply against the
> mainline kernel. So please everybody, try to make patches against
> the mainline where possible. This should cover almost all the
> board-*.c files and device drivers. I'll keep adding the core
> omap patches to the various omap-upstream* queues so they're
> ready to go to mainline kernel too.

Here's a list of drivers that are sitting in linux-omap only (* means it
was already sent to mainline):

=== Bluetooth

 drivers/bluetooth/brf6150.c               | 1050 ++++++++++++++++++++++
 drivers/bluetooth/brf6150.h               |   91 ++
 drivers/bluetooth/hci_h4p/Makefile        |    7 +
 drivers/bluetooth/hci_h4p/core.c          | 1013 +++++++++++++++++++++
 drivers/bluetooth/hci_h4p/fw-csr.c        |  141 +++
 drivers/bluetooth/hci_h4p/fw-ti.c         |   90 ++
 drivers/bluetooth/hci_h4p/fw.c            |  152 ++++
 drivers/bluetooth/hci_h4p/hci_h4p.h       |  183 ++++
 drivers/bluetooth/hci_h4p/sysfs.c         |   74 ++
 drivers/bluetooth/hci_h4p/uart.c          |  164 ++++

=== CBUS

 drivers/cbus/Kconfig                      |   89 ++
 drivers/cbus/Makefile                     |   14 +
 drivers/cbus/cbus.c                       |  293 ++++++
 drivers/cbus/cbus.h                       |   36 +
 drivers/cbus/retu-headset.c               |  355 ++++++++
 drivers/cbus/retu-pwrbutton.c             |  118 +++
 drivers/cbus/retu-rtc.c                   |  477 ++++++++++
 drivers/cbus/retu-user.c                  |  423 +++++++++
 drivers/cbus/retu-wdt.c                   |  202 +++++
 drivers/cbus/retu.c                       |  467 ++++++++++
 drivers/cbus/retu.h                       |   77 ++
 drivers/cbus/tahvo-usb.c                  |  777 ++++++++++++++++
 drivers/cbus/tahvo-user.c                 |  405 +++++++++
 drivers/cbus/tahvo.c                      |  442 +++++++++
 drivers/cbus/tahvo.h                      |   61 ++
 drivers/cbus/user_retu_tahvo.h            |   75 ++

=== Crypto

 drivers/crypto/omap-sha1-md5.c            |  575 ++++++++++++

=== HWMON

 drivers/hwmon/omap34xx_temp.c             |  268 ++++++
 drivers/hwmon/tsc210x_sensors.c           |  296 ++++++

=== I2C (these should vanish asap)

 drivers/i2c/chips/tsl2563.c               |  739 +++++++++++++++
 drivers/i2c/chips/twl4030-madc.c          |  528 +++++++++++
 drivers/i2c/chips/twl4030-poweroff.c      |   76 ++


=== INPUT

 drivers/input/keyboard/innovator_ps2.c    | 1279 ++++++++++++++++++++++++++
*drivers/input/keyboard/lm8323.c           |  928 +++++++++++++++++++
 drivers/input/keyboard/tsc2301_kp.c       |  475 ++++++++++
 drivers/input/keyboard/twl4030_keypad.c   |  493 ++++++++++
 drivers/input/misc/twl4030-pwrbutton.c    |  146 +++
 drivers/input/touchscreen/tsc2005.c       |  728 +++++++++++++++
 drivers/input/touchscreen/tsc210x_ts.c    |  160 ++++
 drivers/input/touchscreen/tsc2301_ts.c    |  676 ++++++++++++++

=== LEDS

*drivers/leds/leds-lp5521.c                |  724 +++++++++++++++
 drivers/leds/leds-omap-pwm.c              |  376 ++++++++
 drivers/leds/leds-omap.c                  |  129 +++

=== MFD

 drivers/mfd/twl4030-power.c               |  364 ++++++++

=== MISC (STI only)

 drivers/misc/sti/Makefile                 |    8 +
 drivers/misc/sti/sdti.c                   |  227 +++++
 drivers/misc/sti/sti-console.c            |  189 ++++
 drivers/misc/sti/sti-fifo.c               |  117 +++
 drivers/misc/sti/sti-netlink.c            |  157 ++++
 drivers/misc/sti/sti.c                    |  430 +++++++++

=== MTD

 drivers/mtd/nand/omap-hw.c                |  859 ++++++++++++++++++
 drivers/mtd/nand/omap-nand-flash.c        |  184 ++++
 drivers/mtd/nand/omap2.c                  |  755 ++++++++++++++++

=== NET

 drivers/net/irda/omap-ir.c                |  901 +++++++++++++++++++

=== POWER SUPPLY

 drivers/power/twl4030_bci_battery.c       | 1097 +++++++++++++++++++++++
 drivers/regulator/twl4030-regulator.c     |  503 +++++++++++

=== SPI

 drivers/spi/tsc210x.c                     | 1262 ++++++++++++++++++++++++++
 drivers/spi/tsc2301-core.c                |  287 ++++++

=== USB (I'm working on this)

 drivers/usb/host/ehci-omap.c              |  577 ++++++++++++
 drivers/usb/host/ehci-omap.h              |  125 +++

=== VIDEO (LCD)

 drivers/video/omap/lcd_2430sdp.c          |  199 +++++
 drivers/video/omap/lcd_ams_delta.c        |  140 +++
 drivers/video/omap/lcd_apollon.c          |  137 +++
 drivers/video/omap/lcd_ldp.c              |  200 +++++
 drivers/video/omap/lcd_mipid.c            |  617 +++++++++++++
 drivers/video/omap/lcd_omap2evm.c         |  189 ++++
 drivers/video/omap/lcd_omap3beagle.c      |  133 +++
 drivers/video/omap/lcd_omap3evm.c         |  191 ++++
 drivers/video/omap/lcd_overo.c            |  179 ++++
 drivers/video/omap/lcd_p2.c               |  340 +++++++

-- 
balbi
