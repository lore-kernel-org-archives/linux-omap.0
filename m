From: Felipe Balbi <balbi@ti.com>
Subject: [RFC/PATCH-v4.2-rc6 0/5] arm: am437x: use TWD/Global timers
Date: Mon, 10 Aug 2015 16:41:46 -0500
Message-ID: <1439242911-715-1-git-send-email-balbi@ti.com>
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
To: Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

with these patches AM437x devices can use TWD/global timers.

At least TWD is now used as sched_clock() which gives better latency as seen
below. Keep in mind that while I ran cyclictest to have a feel for avg latency
this test was not against an RT kernel, so results should be taken with a
grain of salt.

Also, I'm not 100% sure clock rate is correct. According to TRM, this timer
should run as MPU_CLK/2 which would be 1GHz / 2 = 500MHz, but even though
I'm using dpll_mpu_m2_ck clock, it still shows as 1000MHz.

Are there any other tests I could/should run ? BTW, I boot-tested on AM4372
with and without 'nosmp' on cmdline.

pre-patch:
T: 0 (  245) P:95 I:1000 C:   9995 Min:     24 Act:   31 Avg:   36 Max:     596

post-patch:
T: 0 (  253) P:95 I:1000 C:   9995 Min:     10 Act:   12 Avg:   14 Max:      68

Felipe Balbi (5):
  Revert "ARM: 7655/1: smp_twd: make twd_local_timer_of_register() no-op
    for nosmp"
  arm: boot: dts: am4372: add ARM timers and SCU nodes
  arm: omap2: Kconfig: select TWD and global timer on AM43xx devices
  arm: omap2: timer: simplify omap4_local_timer_init()
  arm: omap2: board-generic: use omap4_local_timer_init for AM437x

 arch/arm/boot/dts/am4372.dtsi       | 21 +++++++++++++++++++++
 arch/arm/kernel/smp_twd.c           |  4 ----
 arch/arm/mach-omap2/Kconfig         |  3 +++
 arch/arm/mach-omap2/board-generic.c |  2 +-
 arch/arm/mach-omap2/timer.c         | 16 ++++------------
 5 files changed, 29 insertions(+), 17 deletions(-)

-- 
2.5.0
