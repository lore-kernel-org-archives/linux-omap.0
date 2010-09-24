From: Tim Nordell <tim.nordell@logicpd.com>
Subject: [PATCH v3 0/5] LogicPD minimal board support for LV_SOM and Torpedo
Date: Fri, 24 Sep 2010 14:58:53 -0500
Message-ID: <1285358338-3403-1-git-send-email-tim.nordell@logicpd.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tim Nordell <tim.nordell@logicpd.com>
List-Id: linux-omap@vger.kernel.org

Adding minimal board support for LogicPD's LV_SOM and Torpedo devkits.  
This mainly includes only Serial, Ethernet and SD card support for now.

This was tested (and based) against 2.6.36-rc5.

>From the prior set of patches the following is what I've changed:

 - Added in a fifth patch that configures UART1 for low level debug
   support on the LV_SOM and Torpedo

Differences from Patch v2 1/4:
 - I've removed the init_sdram() functions and have passed NULL into
   sdrc parameters for omap2_init_common_hw().  This is mainly because
   we have multiple revisions of these boards that contain different
   memory settings and since we currently don't have any code in the
   kernel for detecting which revision is being used (it is possible
   and will be done later), we will leave it up to the boot loader to
   correctly setup the memory timings.

 - Modified the description slightly in Kconfig so that the LV_SOM
   and torpedo were consistent in their naming.  Removed a couple of
   trailing spaces here as well
   
 - Fixed indentation of "vmmc", line inside omap3logic_vmmc1_supply
 
 - Removed omap3logic_map_io() and replaced with generic
   omap3_map_io().  These functions were identical and it didn't make 
   sense to have the local board one.
   
 - Removed addition of boards to omap2_defconfig, and added "default y"
   to both boards in Kconfig

Differences from Patch v2 2/4:
 - Moved comments in board_mmc_init() relating to which board was
   detected to inside each each conditional portion of code rather
   than immediately above the given code section
 
Differences from Patch v2 3/4:
 - No changes
 
Differences from Patch v2 4/4:
 - Moved the omap3torpedo_fix_pbias_voltage() out to part of the 
   omap3logic_init() function rather than being called from within
   the SMSC911x init function.  This is because there are other IRQ 
   lines that also use the pins affected by having the rail turned on
   for these GPIO pins.
   
 - Moved the comments to just inside the conditionals for lv_som 
   versus torpedo selection in board_smsc911x_init(), rather than 
   above the conditionals of each.
   
 - Removed dead code from within board_smsc911x_init().

Note: I am taking over from Jacob Tanenbaum's earlier patches that were
submitted in August.  I wasn't sure entirely what the protocol was,
so these are all signed by me.

Tim Nordell (5):
  Adding LogicPD OMAP3 board support
  ARM: OMAP3LOGIC: Adding SDMMC support
  ARM: OMAP3: Add generic smsc911x support when connected to GPMC
  ARM: OMAP3LOGIC: Added SMSC Ethernet board support
  ARM: OMAP3LOGIC: Adding low-level debug support

 arch/arm/mach-omap2/Kconfig                     |   18 ++
 arch/arm/mach-omap2/Makefile                    |    7 +
 arch/arm/mach-omap2/board-omap3logic.c          |  244 +++++++++++++++++++++++
 arch/arm/mach-omap2/gpmc-smsc911x.c             |  113 +++++++++++
 arch/arm/plat-omap/include/plat/gpmc-smsc911x.h |   35 ++++
 arch/arm/plat-omap/include/plat/uncompress.h    |    2 +
 6 files changed, 419 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-omap3logic.c
 create mode 100644 arch/arm/mach-omap2/gpmc-smsc911x.c
 create mode 100644 arch/arm/plat-omap/include/plat/gpmc-smsc911x.h
