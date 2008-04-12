From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Pending patches
Date: Sat, 12 Apr 2008 19:41:47 +0300
Message-ID: <20080412164147.GL7338@gandalf.research.nokia.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:46813 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753069AbYDLQms (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 12 Apr 2008 12:42:48 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

Hi Tony,

You seem to have pushed most of the patches I sent but we're still
missing some of them.

Are there still any comments for those patches ? It's higly tested on my
n810 and all of them are working fine here.

Below is an output from:
$ git cherry master | cut -d+ -f2 | xargs git show --stat

commit a3b9e4f4397876d32d51f7fb3742318285a78601
Author: Daniel Stone <daniel.stone@nokia.com>
Date:   Mon Apr 7 17:07:37 2008 +0300

    I2C: LM8323: Introduce lm8323 keypad driver
    
    Introduce lm8323 keypad driver.
    
    Signed-off-by: Daniel Stone <daniel.stone@nokia.com
    
    Updated to build with recent linux-omap and new-style
    i2c driver.
    
    Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>

 arch/arm/mach-omap2/board-n800.c |   77 ++++
 arch/arm/mach-omap2/board-n810.c |    2 +
 drivers/input/keyboard/Kconfig   |    7 +
 drivers/input/keyboard/Makefile  |    1 +
 drivers/input/keyboard/lm8323.c  |  911 ++++++++++++++++++++++++++++++++++++++
 include/linux/i2c/lm8323.h       |   39 ++
 6 files changed, 1037 insertions(+), 0 deletions(-)

commit a68ff943d8e2e09e218b127142dfa99e6c618ac8
Author: Mathias Nyman <mathias.nyman@nokia.com>
Date:   Mon Apr 7 16:21:28 2008 +0300

    I2C: TSL2563: Add support for Taos tsl2563 ambient light sensor
    
    Add support for Taos tsl2563 ambient light sensor.
    
    Signed-off-by: Mathias Nyman <mathias.nyman@nokia.com>
    
    Updated to build with current linux-omap, new-style
    i2c driver and cleaned up checkpatch.pl issues.
    
    Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>

 arch/arm/mach-omap2/board-n800.c |    4 +
 drivers/i2c/chips/Kconfig        |   10 +
 drivers/i2c/chips/Makefile       |    2 +-
 drivers/i2c/chips/tsl2563.c      |  731 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 746 insertions(+), 1 deletions(-)

commit 9416f0ccc9669a0588e16f776308f8f6c9e91661
Author: Lauri Leukkunen <lauri.leukkunen@nokia.com>
Date:   Mon Apr 7 19:57:43 2008 +0300

    INPUT: TOUCHSCREEN: Introduce tsc2005 driver
    
    Introduce n810's tsc2005 driver
    
    Signed-off-by: Lauri Leukkunen <lauri.leukkunen@nokia.com>
    
    Updated to build with current linux-omap.
    
    Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>

 arch/arm/mach-omap2/board-n800.c    |   95 +++++-
 drivers/input/touchscreen/Kconfig   |    5 +
 drivers/input/touchscreen/Makefile  |    1 +
 drivers/input/touchscreen/tsc2005.c |  739 +++++++++++++++++++++++++++++++++++
 include/linux/spi/tsc2005.h         |   29 ++
 5 files changed, 865 insertions(+), 4 deletions(-)

commit 57871dcd31fa8598ae5d0d3e3979e5e6f5477ea4
Author: Mathias Nyman <mathias.nyman@nokia.com>
Date:   Tue Apr 8 13:33:04 2008 +0300

    I2C: LP5521: Introduce lp5521 LED driver
    
    Introduce n810's lp5521 LED driver.
    
    Signed-off-by: Mathias Nyman <mathias.nyman@nokia.com
    
    Updated to new style i2c driver and to build on current
    linux-omap head.
    
    Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>

 arch/arm/mach-omap2/board-n800.c |    4 +
 drivers/i2c/chips/Kconfig        |    7 +
 drivers/i2c/chips/Makefile       |    1 +
 drivers/i2c/chips/lp5521.c       |  577 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 589 insertions(+), 0 deletions(-)

commit 88573faf7d1e556376c0abb1adaf3497d814660b
Author: Felipe Balbi <felipe.balbi@nokia.com>
Date:   Tue Apr 8 15:36:32 2008 +0300

    ARM: N800: Update n800 defconfig
    
    Enables recent drivers and usb.
    
    Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>

 arch/arm/configs/n800_defconfig |  189 +++++++++++++++++++++++++++++++++++++--
 1 files changed, 182 insertions(+), 7 deletions(-)

-- 
	- Balbi
