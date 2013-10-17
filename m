From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 2/2] omap changes for am43xx hwmod for v3.13 merge window
Date: Thu, 17 Oct 2013 13:00:21 -0700
Message-ID: <E1VWtkk-0000hp-89@merlin.infradead.org>
References: <pull-1382040021-802435>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1382040021-802435>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: arm@kernel.org, Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@linaro.org>, Olof Johansson <olof@lixom.net>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The following changes since commit 254f57a92987b6cde6004f58d6b847813dfb9e0e:

  ARM: OMAP5: hwmod: add missing ocp2scp hwmod data (2013-10-11 15:37:05 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.13/am43xx-hwmod-signed

for you to fetch changes up to 811e7c87340b75dce5c488d9496075b00853942b:

  Merge tag 'for-v3.13/am43xx-support' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into omap-for-v3.13/hwmod (2013-10-17 10:37:27 -0700)

----------------------------------------------------------------

Changes needed for am43xx for the hwmod data.

This will be the last new set of hwmod data for any SoC
as future SoCs will use a driver and device tree based
approach. But before that can be dealt with, we need to
first sort out the pending driver/clk issues.

Queued by Paul Walmsley <paul@pwsan.com>:

Add hwmod and PRCM data for the TI AM43xx family of SoCs.

Under normal circumstances, these patches would not be merged.
The hwmod and PRCM data should be moved out either to DT data or
to drivers/.  Also, the current implementation trades off lines
of diff by dynamically rewriting static data at runtime, which is
a bad practice - it causes future maintenance headaches.
However, after speaking with my upstream, it sounds like it's
better to merge these patches in their current state, due to long
term considerations.

Basic test logs are here:

http://www.pwsan.com/omap/testlogs/am43xx_support_v3.13/20131015213706/

Due to the lack of an AM43xx board and any available public
documentation, it's impossible for me to review or test that
platform in any meaningful way.  But at least the tests above
verify that the patches don't affect existing platforms -
particularly AM33xx.

----------------------------------------------------------------
Afzal Mohammed (7):
      ARM: OMAP2+: hwmod: AM335x/AM43x: move common data
      ARM: OMAP2+: hwmod: AM335x: runtime register update
      ARM: OMAP2+: hwmod: AM335x: remove static register offs
      ARM: OMAP2+: PRCM: AM43x definitions
      ARM: OMAP2+: hwmod: AM43x support
      ARM: OMAP2+: hwmod: AM43x operations
      ARM: OMAP2+: AM43x: PRCM kbuild

Ambresh K (3):
      ARM: OMAP2+: PM: AM43x powerdomain data
      ARM: OMAP2+: CM: AM43x clockdomain data
      ARM: OMAP2+: AM43x PRCM init

Ankur Kishore (1):
      ARM: OMAP2+: CM: cm_inst offset s16->u16

George Cherian (1):
      ARM: OMAP2+: hwmod: Add USB hwmod data for AM437x.

Sourav Poddar (1):
      ARM: OMAP2: hwmod: Add qspi data for am437x.

Tony Lindgren (1):
      Merge tag 'for-v3.13/am43xx-support' of git://git.kernel.org/.../pjw/omap-pending into omap-for-v3.13/hwmod

 arch/arm/mach-omap2/Makefile                       |    9 +-
 arch/arm/mach-omap2/clockdomain.h                  |    4 +-
 arch/arm/mach-omap2/clockdomains43xx_data.c        |  196 ++
 arch/arm/mach-omap2/cm33xx.c                       |   16 +-
 arch/arm/mach-omap2/cm33xx.h                       |   12 +-
 arch/arm/mach-omap2/cminst44xx.c                   |   29 +-
 arch/arm/mach-omap2/cminst44xx.h                   |   26 +-
 arch/arm/mach-omap2/io.c                           |    6 +
 arch/arm/mach-omap2/omap_hwmod.c                   |    8 +
 arch/arm/mach-omap2/omap_hwmod.h                   |    1 +
 .../mach-omap2/omap_hwmod_33xx_43xx_common_data.h  |  163 ++
 .../omap_hwmod_33xx_43xx_interconnect_data.c       |  643 ++++++
 .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c | 1469 +++++++++++++
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c         | 2263 ++------------------
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c         |  758 +++++++
 arch/arm/mach-omap2/powerdomain.h                  |    1 +
 arch/arm/mach-omap2/powerdomains43xx_data.c        |  136 ++
 arch/arm/mach-omap2/prcm43xx.h                     |  146 ++
 18 files changed, 3728 insertions(+), 2158 deletions(-)
 create mode 100644 arch/arm/mach-omap2/clockdomains43xx_data.c
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_33xx_43xx_common_data.h
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_33xx_43xx_interconnect_data.c
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_43xx_data.c
 create mode 100644 arch/arm/mach-omap2/powerdomains43xx_data.c
 create mode 100644 arch/arm/mach-omap2/prcm43xx.h
