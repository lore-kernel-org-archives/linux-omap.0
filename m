From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/2] omap non-urgent fixes for v4.1
Date: Sat, 28 Mar 2015 09:02:29 -0700
Message-ID: <8710.82059243253$1427558906@news.gmane.org>
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
To: arm@kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.1/fixes-0

for you to fetch changes up to 209431eff8afb928d72200c79153165c7d860ca0:

  ARM: DRA7: Enable Cortex A15 errata 798181 (2015-03-27 14:38:03 -0700)

----------------------------------------------------------------
Fixes for omaps that were not considered urgent enough for the -rc cycle.

This is mostly to enable errata 798181 and thermal support for dra7,
configure ocp2scp for am437x, remove dead code for OMAP4_ERRATA_I688
and fix build warnings for omap1510 only config.

----------------------------------------------------------------
Felipe Balbi (1):
      MAINTAINERS: add OMAP defconfigs under OMAP SUPPORT

Keerthy (1):
      ARM: dts: DRA7: Add bandgap and related thermal nodes

Kishon Vijay Abraham I (2):
      ARM: dts: am4372: Add "ti,am437x-ocp2scp" as compatible string for OCP2SCP
      bus: ocp2scp: SYNC2 value should be changed to 0x6

Nishanth Menon (1):
      ARM: dts: am57xx-beagle-x15: Add thermal map to include fan and tmp102

Paul Walmsley (1):
      ARM: OMAP1: PM: fix some build warnings on 1510-only Kconfigs

Praneeth Bajjuri (1):
      ARM: DRA7: Enable Cortex A15 errata 798181

Stefan Agner (1):
      ARM: OMAP2+: remove superfluous NULL pointer check

Stefan Hengelein (1):
      ARM: OMAP4: remove dead kconfig option OMAP4_ERRATA_I688

Tony Lindgren (1):
      Merge branch 'omap-for-v4.1/ocp2scp' into omap-for-v4.1/fixes-not-urgent

 .../devicetree/bindings/bus/omap-ocp2scp.txt       |  3 +-
 MAINTAINERS                                        |  2 +
 arch/arm/boot/dts/am4372.dtsi                      |  4 +-
 arch/arm/boot/dts/am57xx-beagle-x15.dts            | 49 +++++++++++++++
 arch/arm/boot/dts/dra7.dtsi                        | 23 ++++++++
 arch/arm/boot/dts/dra72x.dtsi                      |  5 ++
 arch/arm/boot/dts/dra74x.dtsi                      |  5 ++
 arch/arm/boot/dts/omap4-cpu-thermal.dtsi           |  4 +-
 arch/arm/mach-omap1/pm.c                           | 51 ++++++++--------
 arch/arm/mach-omap2/Kconfig                        | 22 +------
 arch/arm/mach-omap2/common.c                       |  1 -
 arch/arm/mach-omap2/common.h                       |  3 -
 arch/arm/mach-omap2/io.c                           |  2 -
 arch/arm/mach-omap2/mux.c                          |  2 +-
 arch/arm/mach-omap2/omap-secure.h                  |  7 ---
 arch/arm/mach-omap2/omap4-common.c                 | 69 ----------------------
 arch/arm/mach-omap2/sleep44xx.S                    |  2 -
 drivers/bus/omap-ocp2scp.c                         | 34 +++++++++++
 18 files changed, 151 insertions(+), 137 deletions(-)
