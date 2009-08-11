From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/9] Omap updates for upcoming 2.6.32 merge window
Date: Tue, 11 Aug 2009 12:45:07 +0300
Message-ID: <20090811094348.32577.81307.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi all,

Here are some omap patches for review. I have another series for
omap3 patches that I'll post probably on Wednesday.

Regards,

Tony

---

Eero Nurkkala (1):
      OMAP: GPIO: Avoid generating extra IRQs

Janusz Krzysztofik (1):
      OMAP1: AMS_DELTA: add modem support

Kalle Valo (5):
      OMAP2: n8x0: add n8x0_defconfig
      OMAP2: add board file for Nokia N800 and N810
      OMAP2: compile usb-tusb6010.c
      OMAP: remove OMAP_TAG_UART
      OMAP: remove OMAP_TAG_SERIAL_CONSOLE

Roger Quadros (1):
      OMAP: Remove omap boot parsing code

Tony Lindgren (1):
      OMAP2/3: Add support for flash on SDP boards


 arch/arm/configs/n8x0_defconfig          | 1104 ++++++++++++++++++++++++++++++
 arch/arm/mach-omap1/board-ams-delta.c    |   43 +
 arch/arm/mach-omap1/board-fsample.c      |    5 
 arch/arm/mach-omap1/board-generic.c      |    5 
 arch/arm/mach-omap1/board-h2.c           |    5 
 arch/arm/mach-omap1/board-h3.c           |    5 
 arch/arm/mach-omap1/board-innovator.c    |    5 
 arch/arm/mach-omap1/board-nokia770.c     |    5 
 arch/arm/mach-omap1/board-osk.c          |    5 
 arch/arm/mach-omap1/board-palmte.c       |    5 
 arch/arm/mach-omap1/board-palmtt.c       |    5 
 arch/arm/mach-omap1/board-palmz71.c      |    5 
 arch/arm/mach-omap1/board-perseus2.c     |    5 
 arch/arm/mach-omap1/board-sx1.c          |    5 
 arch/arm/mach-omap1/board-voiceblue.c    |    5 
 arch/arm/mach-omap1/serial.c             |    8 
 arch/arm/mach-omap2/Kconfig              |    9 
 arch/arm/mach-omap2/Makefile             |    5 
 arch/arm/mach-omap2/board-2430sdp.c      |    7 
 arch/arm/mach-omap2/board-3430sdp.c      |    7 
 arch/arm/mach-omap2/board-4430sdp.c      |    5 
 arch/arm/mach-omap2/board-apollon.c      |    5 
 arch/arm/mach-omap2/board-generic.c      |    5 
 arch/arm/mach-omap2/board-h4.c           |    5 
 arch/arm/mach-omap2/board-ldp.c          |    5 
 arch/arm/mach-omap2/board-n8x0.c         |  307 ++++++++
 arch/arm/mach-omap2/board-omap3beagle.c  |    5 
 arch/arm/mach-omap2/board-omap3evm.c     |    5 
 arch/arm/mach-omap2/board-omap3pandora.c |    5 
 arch/arm/mach-omap2/board-overo.c        |    5 
 arch/arm/mach-omap2/board-rx51.c         |    5 
 arch/arm/mach-omap2/board-sdp-flash.c    |   78 ++
 arch/arm/mach-omap2/board-sdp.h          |    9 
 arch/arm/mach-omap2/board-zoom2.c        |    5 
 arch/arm/mach-omap2/serial.c             |    9 
 arch/arm/plat-omap/common.c              |   88 --
 arch/arm/plat-omap/gpio.c                |   27 +
 arch/arm/plat-omap/include/mach/board.h  |    4 
 arch/arm/plat-omap/include/mach/serial.h |    4 
 39 files changed, 1642 insertions(+), 187 deletions(-)
 create mode 100644 arch/arm/configs/n8x0_defconfig
 create mode 100644 arch/arm/mach-omap2/board-n8x0.c
 create mode 100644 arch/arm/mach-omap2/board-sdp-flash.c
 create mode 100644 arch/arm/mach-omap2/board-sdp.h

-- 
Signature

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
