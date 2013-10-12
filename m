From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 6/6] omap soc changes for v3.13 merge window
Date: Fri, 11 Oct 2013 18:44:59 -0700
Message-ID: <E1VUoHS-0004gE-6x@merlin.infradead.org>
References: <pull-1381542299-305003>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1381542299-305003>
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

The following changes since commit d0e639c9e06d44e713170031fe05fb60ebe680af:

  Linux 3.12-rc4 (2013-10-06 14:00:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.13/soc-take2

for you to fetch changes up to d5da94b88efebc375bfcbab6bb0e59a6e8a6571e:

  ARM: OMAP2+: Fix build error for realtime counter init if not enabled (2013-10-11 17:28:04 -0700)

----------------------------------------------------------------
SoC related changes for omaps to support the realtime
counter on newer omaps, and to fail early for omap5 es1.0
SoCs that don't have any support merged for them in the
mainline tree.

----------------------------------------------------------------
Nishanth Menon (1):
      ARM: OMAP5: id: Remove ES1.0 support

R Sricharan (1):
      ARM: OMAP5/DRA7: realtime_counter: Configure CNTFRQ register

Sricharan R (1):
      ARM: OMAP2+: DRA7: realtime_counter: Add ratio registers for 20MHZ sys-clk frequency

Tony Lindgren (1):
      ARM: OMAP2+: Fix build error for realtime counter init if not enabled

 arch/arm/mach-omap2/id.c          |  8 ++++----
 arch/arm/mach-omap2/omap-secure.h |  4 ++++
 arch/arm/mach-omap2/omap-smp.c    |  7 +++++++
 arch/arm/mach-omap2/soc.h         |  2 --
 arch/arm/mach-omap2/timer.c       | 17 +++++++++++++++++
 5 files changed, 32 insertions(+), 6 deletions(-)
