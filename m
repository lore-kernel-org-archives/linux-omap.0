From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap fixes against v4.6-rc2
Date: Fri, 8 Apr 2016 12:18:54 -0700
Message-ID: <20160408191854.GZ16484@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: arm@kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The following changes since commit 9735a22799b9214d17d3c231fe377fc852f042e9:

  Linux 4.6-rc2 (2016-04-03 09:09:40 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.6/fixes-rc2

for you to fetch changes up to 571afb4c8a4bbe88541364e7f6827340562f2736:

  ARM: OMAP: Catch callers of revision information prior to it being populated (2016-04-08 09:02:39 -0700)

----------------------------------------------------------------
Fixes for omaps against v4.6-rc2, mostly to fix suspend for beagle-x15
that broke when we added runtime based SoC revision detection earlier.

It seems suspend worked earlier as things were only partially initialized,
while now we initialize things properly for dra7. Let's also add a warning
if SoC is not properly detected to prevent similar issues later on.

Also included is a fix for dra7 sys_32k_ck clock source that is not
enabled on boot making system fall back to using emulated clock.

----------------------------------------------------------------
Keerthy (1):
      ARM: dts: dra7: Correct clock tree for sys_32k_ck

Nishanth Menon (3):
      ARM: OMAP: DRA7: wakeupgen: Skip SAR save for wakeupgen
      ARM: OMAP: DRA7: Provide proper class to omap2_set_globals_tap
      ARM: OMAP: Catch callers of revision information prior to it being populated

 arch/arm/boot/dts/dra7xx-clocks.dtsi | 18 +++++++++++++++++-
 arch/arm/mach-omap1/id.c             |  1 +
 arch/arm/mach-omap2/id.c             |  1 +
 arch/arm/mach-omap2/io.c             |  3 ++-
 arch/arm/mach-omap2/omap-wakeupgen.c |  7 +++++++
 5 files changed, 28 insertions(+), 2 deletions(-)
