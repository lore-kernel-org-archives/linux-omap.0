From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH v4 00/11] OMAP2+: Serial: Runtime adaptation + cleanup
Date: Wed, 7 Sep 2011 18:23:22 +0530
Message-ID: <1315400013-4849-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, linux-serial@vger.kernel.org, Vishwanath Sripathy <vishwanath.bs@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Converting uart driver to adapt to pm runtime API's.
Code re-org + cleanup.
Moving some functionality from serial.c to omap-serial.c

Changes involves:
================
1.) Cleaning up certain uart calls from sram_idle func.
2.) Removed all types of uart clock handling code from serial.c
3.) Using hwmod_mux API enable wakeup capability for uart pad during
   hwmod_idle state i.e., when uart clocks are disabled we can enable
   io-pad wakeup capability for uart if mux_data is available for
   given uart. Also during during resume from idle call to uart we need
   to enable clocks back conditionally and this can be done only when io-pad
   wakeup event bit is set for uart_rx pad. So we need a hwmod API
   which can probe the uart pad and let us know whether a uart wakeup
   happened. So omap_hmwod_pad_wakeup_status API is added to meet this
   requirement.
3.) Adapted omap-serial driver to use runtime API's.
4.) Modify serial_init calls to accept certain uart parameters from board file.
5.) using prepare and resume_call to disable/enable uart_port.
    Reference to discussion why we need to use prepare and resume hooks.
	http://www.mail-archive.com/linux-omap@vger.kernel.org/msg52707.html
	http://www.mail-archive.com/linux-omap@vger.kernel.org/msg53209.html
	
Patch series is based on 3.1.0-rc4 + omap_device fixes.
>From Kevin's tree.
git://gitorious.org/khilman/linux-omap-pm.git for_3.2/omap_device

This Patch series based on Kevin's tree is hosted at:
git://gitorious.org/runtime_3-0/runtime_3-0.git rc4_uart_od

Testing updates:
----------------
3430SDP:
retention, off_mode, system_wide suspend is tested.
(earlyprintk & no_console_suspend checked)

OMAP3630 - Zoom3:
pm-retention checked with quart/omap-uart3
[Also tested with uart3 as console uart and pm-ret checked]

OMAP4430-SDP: Boot tested.
OMAP2420/2430SDP: Boot tested.

Govindraj.R (10):
  OMAP2+: hwmod: Add API to enable IO ring wakeup.
  OMAP2+: hwmod: Add API to check IO PAD wakeup status
  OMAP2+: UART: cleanup + remove certain uart calls from pm code
  OMAP2+: UART: Remove uart clock handling code from serial.c
  OMAP2+: Serial: Add default mux for all uarts.
  Serial: OMAP: Store certain reg values to port structure
  Serial: OMAP: Add runtime pm support for omap-serial driver
  Serial: OMAP2+: Move erratum handling from serial.c
  OMAP2+: Serial: Use prepare and resume calls to gate uart clocks
  OMAP: Serial: Allow UART parameters to be configured from board file.

Jon Hunter (1):
  Serial: OMAP2+: Make the RX_TIMEOUT for DMA configurable for each
    UART

 arch/arm/mach-omap2/board-3430sdp.c           |  100 +---
 arch/arm/mach-omap2/board-4430sdp.c           |    8 +-
 arch/arm/mach-omap2/board-n8x0.c              |    6 +-
 arch/arm/mach-omap2/board-omap4panda.c        |    8 +-
 arch/arm/mach-omap2/mux.c                     |   30 +
 arch/arm/mach-omap2/mux.h                     |   13 +
 arch/arm/mach-omap2/omap_hwmod.c              |   66 ++
 arch/arm/mach-omap2/pm24xx.c                  |   11 +-
 arch/arm/mach-omap2/pm34xx.c                  |   22 +-
 arch/arm/mach-omap2/serial.c                  |  922 +++++++------------------
 arch/arm/plat-omap/include/plat/omap-serial.h |   34 +-
 arch/arm/plat-omap/include/plat/omap_hwmod.h  |    1 +
 arch/arm/plat-omap/include/plat/serial.h      |   13 +-
 drivers/tty/serial/omap-serial.c              |  349 ++++++++--
 14 files changed, 717 insertions(+), 866 deletions(-)

-- 
1.7.4.1
