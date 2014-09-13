From: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 0/8] arm: Convert pr_warning to pr_warn
Date: Sat, 13 Sep 2014 11:31:11 -0700
Message-ID: <cover.1410632834.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

pr_warn is used about 3:1 over pr_warning and is mixed use
in arch/arm.  Standardize on pr_warn.

Joe Perches (8):
  arm: Convert pr_warning to pr_warn
  arm: mach-davinci: Convert pr_warning to pr_warn
  arm: mach-ep93xx: Convert pr_warning to pr_warn
  arm: mach-imx: Convert pr_warning to pr_warn
  arm: mach-omap2: Convert pr_warning to pr_warn
  arm: mach-orion5x: Convert pr_warning to pr_warn
  arm: mach-pxa: Convert pr_warning to pr_warn
  arm: mach-u300: Convert pr_warning to pr_warn

 arch/arm/include/asm/syscall.h                 |  8 +--
 arch/arm/kernel/atags_parse.c                  |  2 +-
 arch/arm/kernel/hw_breakpoint.c                | 18 +++---
 arch/arm/kernel/irq.c                          |  4 +-
 arch/arm/kernel/perf_event_cpu.c               |  4 +-
 arch/arm/kernel/smp.c                          |  2 +-
 arch/arm/kernel/unwind.c                       | 24 ++++----
 arch/arm/mach-davinci/board-da830-evm.c        | 76 +++++++++++---------------
 arch/arm/mach-davinci/board-dm644x-evm.c       |  6 +-
 arch/arm/mach-davinci/board-mityomapl138.c     | 38 ++++++-------
 arch/arm/mach-davinci/board-neuros-osd2.c      |  3 +-
 arch/arm/mach-davinci/time.c                   |  6 +-
 arch/arm/mach-ep93xx/core.c                    |  4 +-
 arch/arm/mach-imx/mach-armadillo5x0.c          |  2 +-
 arch/arm/mach-imx/mach-mx31_3ds.c              |  4 +-
 arch/arm/mach-imx/mach-mx31lite.c              |  2 +-
 arch/arm/mach-imx/mach-pcm037.c                |  4 +-
 arch/arm/mach-omap2/display.c                  |  2 +-
 arch/arm/mach-omap2/hdq1w.c                    |  4 +-
 arch/arm/mach-omap2/i2c.c                      |  2 +-
 arch/arm/mach-omap2/msdi.c                     |  4 +-
 arch/arm/mach-omap2/mux.c                      |  2 +-
 arch/arm/mach-omap2/omap_hwmod.c               | 26 ++++-----
 arch/arm/mach-omap2/pdata-quirks.c             |  4 +-
 arch/arm/mach-omap2/pm34xx.c                   |  2 +-
 arch/arm/mach-omap2/smartreflex-class3.c       |  4 +-
 arch/arm/mach-omap2/sr_device.c                |  2 +-
 arch/arm/mach-omap2/vc.c                       |  2 +-
 arch/arm/mach-omap2/voltage.c                  | 22 ++++----
 arch/arm/mach-omap2/wd_timer.c                 |  4 +-
 arch/arm/mach-orion5x/dns323-setup.c           |  8 +--
 arch/arm/mach-orion5x/terastation_pro2-setup.c |  2 +-
 arch/arm/mach-orion5x/ts209-setup.c            |  2 +-
 arch/arm/mach-orion5x/ts409-setup.c            |  2 +-
 arch/arm/mach-orion5x/ts78xx-setup.c           |  4 +-
 arch/arm/mach-pxa/em-x270.c                    |  4 +-
 arch/arm/mach-pxa/gumstix.c                    |  3 +-
 arch/arm/mach-pxa/mfp-pxa2xx.c                 | 12 ++--
 arch/arm/mach-pxa/poodle.c                     |  2 +-
 arch/arm/mach-pxa/pxa3xx-ulpi.c                |  6 +-
 arch/arm/mach-pxa/raumfeld.c                   | 26 ++++-----
 arch/arm/mach-u300/dummyspichip.c              | 65 ++++++++++------------
 arch/arm/mm/idmap.c                            |  2 +-
 arch/arm/mm/mmu.c                              |  4 +-
 44 files changed, 200 insertions(+), 229 deletions(-)

-- 
1.8.1.2.459.gbcd45b4.dirty
