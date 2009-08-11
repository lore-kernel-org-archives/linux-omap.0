From: Tony Lindgren <tony@atomide.com>
Subject: git pull request for omap header cleanup for upcoming 2.6.32 merge
	window
Date: Tue, 11 Aug 2009 12:28:06 +0300
Message-ID: <20090811092805.GS1938@atomide.com>
References: <20090806100614.2569.8531.stgit@localhost>
	<20090806110103.GB22623@n2100.arm.linux.org.uk>
	<20090806111105.GE2358@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="qftxBdZWiueWNAVY"
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <20090806111105.GE2358@atomide.com>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--qftxBdZWiueWNAVY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Russell,

Here's the pull request for these header clean-up patches.

Tony

--qftxBdZWiueWNAVY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="pull.txt"

The following changes since commit ed680c4ad478d0fee9740f7d029087f181346564:
  Linus Torvalds (1):
        Linux 2.6.31-rc5

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-headers

Tony Lindgren (3):
      OMAP: Remove OMAP_IO_ADDRESS, use OMAP1_IO_ADDRESS and OMAP2_IO_ADDRESS instead
      OMAP: Rename OMAP_MPUIO_BASE to OMAP1_MPUIO_BASE
      OMAP: Remove ifdefs for io.h

 arch/arm/mach-omap1/devices.c                 |    2 +-
 arch/arm/mach-omap1/io.c                      |    6 +-
 arch/arm/mach-omap1/pm.h                      |    4 +-
 arch/arm/mach-omap1/serial.c                  |    6 +-
 arch/arm/mach-omap1/sram.S                    |   12 ++--
 arch/arm/mach-omap1/time.c                    |    4 +-
 arch/arm/mach-omap2/board-4430sdp.c           |    4 +-
 arch/arm/mach-omap2/cm.h                      |    6 +-
 arch/arm/mach-omap2/omap-smp.c                |    2 +-
 arch/arm/mach-omap2/pm-debug.c                |    2 +-
 arch/arm/mach-omap2/prm.h                     |    6 +-
 arch/arm/mach-omap2/sdrc.h                    |    6 +-
 arch/arm/mach-omap2/serial.c                  |    6 +-
 arch/arm/mach-omap2/sram242x.S                |    4 +-
 arch/arm/mach-omap2/sram243x.S                |    4 +-
 arch/arm/mach-omap2/timer-gp.c                |    2 +-
 arch/arm/plat-omap/dma.c                      |    8 +-
 arch/arm/plat-omap/dmtimer.c                  |    5 +-
 arch/arm/plat-omap/gpio.c                     |   88 +++++++++++-----------
 arch/arm/plat-omap/include/mach/control.h     |   12 ++--
 arch/arm/plat-omap/include/mach/entry-macro.S |    8 +-
 arch/arm/plat-omap/include/mach/gpio.h        |    2 +-
 arch/arm/plat-omap/include/mach/io.h          |   97 ++++++++++++-------------
 arch/arm/plat-omap/include/mach/mtd-xip.h     |    2 +-
 arch/arm/plat-omap/include/mach/omap44xx.h    |    8 +-
 arch/arm/plat-omap/include/mach/sdrc.h        |    6 +-
 arch/arm/plat-omap/io.c                       |   62 +++++++++++++++-
 arch/arm/plat-omap/sram.c                     |   20 +++---
 drivers/input/keyboard/omap-keypad.c          |   22 +++---
 drivers/mtd/nand/ams-delta.c                  |    8 +-
 drivers/video/omap/dispc.c                    |    6 +-
 31 files changed, 245 insertions(+), 185 deletions(-)

--qftxBdZWiueWNAVY
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
--qftxBdZWiueWNAVY--
