From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 00/11] arm: omap: counter32k rework
Date: Tue, 6 Oct 2015 12:01:56 -0500
Message-ID: <1444150927-14771-1-git-send-email-balbi@ti.com>
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
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: daniel.lezcano@linaro.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, tglx@linutronix.de, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi,

the following patches de-obfuscate arch/arm/mach-omap2/timer.c
and start moving code to drivers/clocksource. So far only counter32k
has been moved over.

Note that we can't get rid of all the code (yet) because there are
still platforms relying to legacy boot and because of the strong
coupling with OMAP's hwmod layer.

This has a dependency on [1]. Boot tested with AM335x and AM437x.

[1] http://marc.info/?l=linux-omap&m=144354336924308&w=2

Here are the changes since v1:

  - removed register_persistent_clock() in favor of CLOCK_SOURCE_SUSPEND_NONSTOP
  - make dropped patch setting status=okay to 32k
  - made sure hwmod wouldn't disable 32k counter
  - rebased on v4.3-rc4

Boot logs:

  - AM437x SK:	http://hastebin.com/zuvetojaqe
  - BBB:   	http://hastebin.com/ihuponayap

Felipe Balbi (11):
  arm: omap2: timer: get rid of obfuscating macros
  arm: omap2: timer: add a gptimer argument to sync32k_timer_init()
  arm: omap2: timer: remove __omap_gptimer_init()
  arm: omap2: timer: provide generic sync32k_timer_init function
  arm: omap2: timer: move realtime_counter_init() around
  arm: omap2: timer: always call clocksource_of_init() when DT
  arm: omap2: timer: remove omap4_local_timer_init
  arm: omap2: timer: rename omap_sync32k_timer_init()
  clocksource: add TI 32.768 Hz counter driver
  arm: omap2+: select 32k clocksource driver
  arm: omap2: timer: limit hwmod usage to non-DT boots

 arch/arm/mach-omap2/Kconfig         |   1 +
 arch/arm/mach-omap2/board-generic.c |  14 ++--
 arch/arm/mach-omap2/board-ldp.c     |   2 +-
 arch/arm/mach-omap2/board-rx51.c    |   2 +-
 arch/arm/mach-omap2/common.h        |   4 +-
 arch/arm/mach-omap2/timer.c         | 141 +++++++++++++++---------------------
 drivers/clocksource/Kconfig         |   7 ++
 drivers/clocksource/Makefile        |   1 +
 drivers/clocksource/timer-ti-32k.c  | 122 +++++++++++++++++++++++++++++++
 9 files changed, 199 insertions(+), 95 deletions(-)
 create mode 100644 drivers/clocksource/timer-ti-32k.c

-- 
2.5.3
