From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: pull request (Re: [PATCH 00/14] OMAP PM fixes for .31-rc series)
Date: Wed, 05 Aug 2009 09:17:59 -0700
Message-ID: <87ab2e6xqg.fsf_-_@deeprootsystems.com>
References: <1248214120-18886-1-git-send-email-khilman@deeprootsystems.com>
	<20090721223730.GF7547@n2100.arm.linux.org.uk>
	<20090803123516.GC24334@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <20090803123516.GC24334@atomide.com> (Tony Lindgren's message of
	"Mon\, 3 Aug 2009 15\:35\:17 +0300")
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Russell,

This series was rebased against v2.6.31-rc5, and here's the pull request.

The following changes since commit ed680c4ad478d0fee9740f7d029087f181346564:
  Linus Torvalds (1):
        Linux 2.6.31-rc5

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git pm-upstream/fixes

Eero Nurkkala (1):
      OMAP: PM: CPUfreq: obey min/max settings of policy

Jouni Hogander (1):
      OMAP3: PM: Fix wrong sequence in suspend.

Kevin Hilman (11):
      OMAP2/3: PM: make PM __init calls static
      OMAP3: PM: CM_REGADDR macros using wrong name
      OMAP3: PM: Ensure PRCM interrupts are cleared at boot
      OMAP3: PM: Clear pending PRCM reset flags on init
      OMAP3: PM: prevent module wakeups from waking IVA2
      OMAP3: PM: Do not build suspend code if SUSPEND is not enabled
      OMAP4: UART: cleanup special case IRQ handling
      OMAP2/3/4: UART: Allow per-UART disabling wakeup for serial ports
      OMAP2/3/4: UART: allow in-order port traversal
      OMAP: GPIO: clear/restore level/edge detect settings on mask/unmask
      OMAP3: Overo: add missing pen-down GPIO definition

Tero Kristo (1):
      OMAP3: Fixed crash bug with serial + suspend

 arch/arm/mach-omap2/board-overo.c        |    1 +
 arch/arm/mach-omap2/cm.h                 |    6 +-
 arch/arm/mach-omap2/pm.h                 |    3 -
 arch/arm/mach-omap2/pm24xx.c             |    2 +-
 arch/arm/mach-omap2/pm34xx.c             |   51 +++++++-
 arch/arm/mach-omap2/serial.c             |  197 ++++++++++++++++++++----------
 arch/arm/plat-omap/cpu-omap.c            |    8 +-
 arch/arm/plat-omap/gpio.c                |    6 +
 arch/arm/plat-omap/include/mach/serial.h |    1 +
 9 files changed, 197 insertions(+), 78 deletions(-)

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
